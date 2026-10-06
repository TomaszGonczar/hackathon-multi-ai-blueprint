# VERIFY.md - how to check that the seed works

**Time:** 10 minutes on a clean machine. The timer starts at the command in
section 1.

**Goal:** five worktrees, each of which has the agent context and `check.sh`,
and the merge-order gate actually blocks dependent pieces.

**One command for all ten checks:** `bash seed/verify.sh` (after `bootstrap.sh`). It runs
the checks below, prints PASS/FAIL for each, changes nothing, and exits 0 only if all ten
pass. CI runs it on every push, plus cases that must fail. The sections below explain each check.

---

## 1. One command (30 s)

```bash
bash seed/bootstrap.sh
```

The section at the end of the output is the verification checklist. Everything below repeats it
step by step.

## 2. Five directories (30 s)

```bash
ls -d ~/w1-piece ~/w2-piece ~/w3-piece ~/w4-piece ~/w5-piece
```

Expected: five lines. Any one missing = FAIL.

## 3. The agent context is INSIDE every worktree (1 min)

This is not cosmetic. The agent works with the worktree as its working directory - if
`AGENTS.md` and `CAPSULE.md` are not on its branch, it will load neither the rules nor the
capsule, and the whole "the capsule is the only wire" mechanism silently does not work.

```bash
for n in w1-piece w2-piece w3-piece w4-piece w5-piece; do
  printf "%s: " "$n"; ls ~/$n/AGENTS.md ~/$n/CAPSULE.md 2>/dev/null | wc -l
done
```

Expected: `2` five times. Any `0` or `1` = FAIL.

## 4. `check.sh` exists and is executable (30 s)

```bash
for n in w1-piece w2-piece w3-piece w4-piece w5-piece; do
  [ -x ~/$n/check.sh ] && echo "$n: OK" || echo "$n: FAIL"
done
```

## 5. Phase 0 exits 1 (1 min)

A `check.sh` that always exits 0 is not a test.

```bash
for n in w1-piece w2-piece w3-piece w4-piece w5-piece; do
  bash ~/$n/check.sh >/dev/null 2>&1; printf "%s -> %s\n" "$n" "$?"
done
```

Expected: `-> 1` five times, with a message about phase 0.

## 6. After filling in, exits 0 (1 min)

```bash
# NOTE: on macOS `sed -i` without an argument fails ("bad flag in substitute
# command"). The `.bak` form works on both macOS (BSD) and Linux (GNU).
sed -i.bak 's/PHASE=0/PHASE=1/' ~/w1-piece/check.sh && rm -f ~/w1-piece/check.sh.bak
bash ~/w1-piece/check.sh; echo "exit=$?"     # expected: 0
sed -i.bak 's/PHASE=1/PHASE=0/' ~/w1-piece/check.sh && rm -f ~/w1-piece/check.sh.bak
```

(Opening the file in an editor and changing `PHASE=0` to `PHASE=1` is also fine -
it is one word.)

Sections 1-3 are still empty `echo`s, which is why it passes. This step checks that the
**phase gate works both ways**.

## 7. Secrets gate (1 min)

```bash
cd ~/w1-piece
echo "API_KEY=supersecret" > test-secret.txt
git add test-secret.txt
bash ./check.sh; echo "exit=$?"     # expected: 1 AND the line "FAIL: secret in staged diff"
git reset -q test-secret.txt && rm test-secret.txt
```

It works **in both phases** - a secret in phase 0 is still a secret.

**Read the message, not just the exit code.** In phase 0 `check.sh` exits 1 anyway, so
`exit=1` alone does not show the secret was caught - only `FAIL: secret in staged diff` does.
`verify.sh` checks the message, in phase 0 and in phase 1.

## 8. The merge-order gate is NOT vacuously true (2 min)

This is the most important test after number 3. All branches are created right after
`main`, so without a start marker every one of them is an **ancestor** of `main` -
and `git merge-base --is-ancestor` reports every piece as "already merged".
A piece with dependencies could then land first.

```bash
cd ~/hackathon-solution
for b in w1 w2 w3 w4 w5; do
  if git merge-base --is-ancestor $b main; then echo "$b: WRONG (looks merged)"; else echo "$b: OK"; fi
done
```

Expected: **`OK` five times**. Any `WRONG` = FAIL - the merge order does not
work.

## 9. The gate unlocks after the dependency is merged (2 min)

Simulation: merge `w1` and check that `w3` is still waiting, but `w1` is already there.

```bash
cd ~/w1-piece
git add -A && git -c user.name=t -c user.email=t@t commit -qm "w1" --allow-empty
cd ~/hackathon-solution
git merge --no-ff -q w1 -m "merge w1"
git merge-base --is-ancestor w1 main && echo "w1: YES (correct)"
git merge-base --is-ancestor w2 main || echo "w2: NO  <- w3/w4 still waiting (correct)"
git merge-base --is-ancestor w3 main || echo "w3: NO  <- correct"
```

Expected: `w1: YES`, `w2: NO`, `w3: NO`.

## 10. Idempotency (1 min)

```bash
bash seed/bootstrap.sh
```

Expected: the same five directories, capsule untouched, the message
*"worktree exists (skipping)"*, and **no duplicate markers**:

```bash
cd ~/hackathon-solution
git log --format=%s w1 | grep -c "seed: w1-piece marker"   # expected: 1
```

---

## Result

| # | Test | Passes when |
|---|---|---|
| 1 | `bootstrap.sh` exits 0 | no `FAIL:` in the output |
| 2 | 5 directories | `ls -d` returns 5 |
| 3 | agent context in the worktree | 5x `2` (AGENTS.md + CAPSULE.md) |
| 4 | `check.sh` executable | 5x OK |
| 5 | phase 0 exits 1 | 5x exit 1 |
| 6 | phase 1 exits 0 | exit 0 |
| 7 | secret caught (both phases) | exit 1 + `FAIL: secret` message |
| 8 | gate not vacuously true | 5x OK |
| 9 | gate unlocks after dependencies | `w1: YES`, `w2: NO` |
| 10 | idempotency | no duplicate markers |

**All green = the seed works. Red = you do not start the hackathon.**

Checked end-to-end on a clean `$HOME`: bootstrap → build a real piece
in `w1` → `check.sh` green → merge `w1` to `main` → `w3`/`w4` still wait for
`w2` → after merging `w2` they unlock, `w5` still waits for `w3`,`w4`.

---

## If something is red

| Symptom | Fix |
|---|---|
| no `AGENTS.md` in the worktree | the branch was created before the context commit - delete the directory and run bootstrap again |
| the gate says `WRONG` at the start | no start marker on the branch - delete the directory and run bootstrap again |
| `fatal: a branch named 'w3' already exists` | old version of the seed - update it |
| the directory exists but is not a worktree | `git -C ~/hackathon-solution worktree prune`, then bootstrap |
| `check.sh` in phase 0 exits 0 | `grep PHASE ~/w1-piece/check.sh` - it must be `PHASE=0` |

---

## What this test does NOT check

- **It does not check that you can write a good test.** You do that on Saturday.
- **It does not check that the capsule is filled in.** It is an empty template -
  system-1 fills it in on Saturday after the choice.
- **It does not check permissions for the remote.** For that use `git push origin main --dry-run`
  after adding the remote.
- **It does not check the language or framework.** `check.sh` is neutral.
