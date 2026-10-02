# REPORT.md

Hackathon Saturday 03.10, result due Friday evening. Work was done on `refactor/seed`
(from `refactor/dwa-systemy`), **merged into `main`** via PR #1-#5. Working branches
deleted. Seed verified, green.

---

## 1. Ten holes - each with an action

1. **`check.sh` cannot exist before the code, yet the rule demands it.** The seed provides a phase
   gate: `PHASE=0` exits 1, `PHASE=1` exits 0. The rule becomes feasible.
2. **The secret pattern breaks on an empty staging area.** `grep` in `&&` under
   `set -e`. Replaced with `if ... then exit 1; fi` - in `2-BUILD.md` and in the seed.
3. **`./w3/check.sh` points to a directory that does not exist.** `git worktree add
   ~/w3-models` leaves `check.sh` in the root. Fixed: `./check.sh` from the worktree.
4. **The capsule shows a `&&` chain for five pieces, yet says "one command per
   piece".** Split into five commands with `cd` to the worktree.
5. **The directory names are fictional, and they have to be named on Friday, when there is no topic.**
   Moved to 0:55, the seed provides `w1-piece`…`w5-piece` + `git worktree move`.
6. **`STATE: BUILD` in a file loaded before the topic is announced.** The seed generates
   `STATE: PREP` + the condition *"before T0 you do not build"*.
7. **`research/` is invisible from the agent's worktree** (it lives on the system-1 branch).
   Recorded in `DEVPLAN.md` B4: system-1 commits to `main` at 0:55, the agent reads
   `git show origin/main:research/...`. To be settled by the team - see §5.
8. **The Friday smoke test requires `gh` and `jq`.** The alternative `git push --dry-run`
   is in `DEVPLAN.md` P2 and `seed/VERIFY.md`. `3-CHEATSHEET.md` untouched (clock, ban
   on dependencies).
9. **`git worktree add -b w3` blows up when the branch already exists** (a colleague plugged
   in earlier). Bootstrap checks `show-ref` and attaches, no `-b`.
10. **Idempotency was broken by `git worktree list` + string match.** macOS resolves
    `/tmp` → `/private/tmp`, so the pattern never matched, the second run threw
    *"already exists"*. Replaced with `[ -e "$target/.git" ]`.

**I found 9 and 10 by testing the seed live - not from reading.**

## 2. What I simplified

Four untrue sentences in `README.md`: *"four files"* (there are five),
*"seven rules"* (there are eight), *"1 188 lines"* (it is 1 197), *"OMP is the runtime"*
(the runtime is heterogeneous - everyone brings their own coding agent).

**I removed nothing.** Reason: what looked like excess was either
**essential** (merge order, the interface rule, `check.sh`, the whole of
`AGENTS.md §4`), or **wrong** - and a wrong sentence is fixed at lower
cost than removed. Full list with rationale: `T3-SIMPLIFICATIONS.md`.

## 3. What I left despite doubts

- **`3-CHEATSHEET.md:13-16`** - `gh api` + `jq`. A real hole, but it is a clock for
  a human, and HANDOFF §5 forbids new dependencies. I passed the hole on to
  `DEVPLAN.md`/`VERIFY.md` instead of editing the clock.
- **D07 (`research/`)** - left open, because it is a team decision about branches,
  not about the seed. See §5.
- **`AGENTS.md §4` untouched.** Eight rules, each prevents a specific
  mistake. Remove one and you lose a night.
- **The contradiction documented in the original** (`archive/old-package/01_DISCOVERY_CLOSURE.md` vs
  `03 §8.2`) - HANDOFF §2 says outright: **do not fix, not yours**.

## 4. Seed: how to check that it works

```bash
bash seed/bootstrap.sh            # once, creates the repo + 5 worktrees
```

Then the 10 tests from `seed/VERIFY.md`. **Verified end-to-end in a clean
environment** (new `$HOME`, clone from GitHub), all green:

| # | Test | Result |
|---|---|---|
| 1 | bootstrap exits 0 | exit 0 |
| 2 | five directories | 5 |
| 3 | **agent context in every worktree** | 5× `AGENTS.md` + `CAPSULE.md` |
| 4 | `check.sh` executable | 5× OK |
| 5 | phase 0 exits 1 | 5× exit 1 |
| 6 | phase 1 exits 0 | exit 0 |
| 7 | secret caught (in both phases) | exit 1 |
| 8 | **order gate not falsely true** | 5× OK |
| 9 | gate unlocks after dependencies | `w1: YES`, `w2/w3: NO` |
| 10 | idempotency | no duplicate markers |

Full life cycle: bootstrap → build a real piece in `w1` → `check.sh`
green → merge `w1` to `main` → `w3`/`w4` still wait for `w2` → after the merge of
`w2` unlocked → `w5` still waits for `w3`,`w4`.

**Three bugs found by the test, not by reading:**
1. Test 7 in its first version - the phase gate aborted before checking
   secrets. Fixed.
2. **The worktree had neither `AGENTS.md` nor `CAPSULE.md`** - the context was committed
   after the worktree was created, so the agent would have loaded neither the rules nor the capsule.
   Fixed: commit the context before the worktree.
3. **The `WAITS FOR` gate was always true at the start** - every branch was an ancestor
   of `main`, so a piece with dependencies could land first.
   Fixed: a start marker on every branch.

**Manual time:** under a minute for the whole procedure. Five directories with a green
`check.sh` ready.

## 5. Questions I have no answers to

1. **On which branch does `research/` live?** `AGENTS.md:141` says to read
   `research/*.md` from the agent's worktree, but nobody wrote where system-1 commits
   it. My proposal: `main` at 0:55 + `git show origin/main:...` -
   but that **changes how system-1 works**, so it is a team decision.
2. **Can two people have the same piece number?** The seed assumes not
   (the worktree would be overwritten). But `AGENTS.md §4.1` says *"in your own directory"*,
   and the capsule defines five pieces for five people - there is no rule for a
   sixth agent (e.g. for review). The optional review sessions from `README.md:160` have
   no directory.
3. **What language will we write in?** `check.sh` is neutral, but section 3
   *"does the test catch anything"* has to be filled in with a real test, and that requires a
   language. I do not know, because the topic is not known - and should not be.

---

**Files added:** `seed/` (8 files), `DEVPLAN.md`, `T1-CONTRADICTIONS.md`,
`T2-TEN-THINGS.md`, `T3-SIMPLIFICATIONS.md`, `REPORT.md`,
`archive/old-package/README.md` - an index of the moved package, so that after the path
changes there is one place saying what these files are and why they are not instructions.
**Files changed:** `README.md`, `CAPSULE.md`, `2-BUILD.md` (fact corrections),
`AGENTS.md`, `HANDOFF.md`, `archive/README.md`, `.github/workflows/ci.yml` (paths
after moving the package).
**`main` changed solely by approved merges** (PR #1-#7). Secrets appear
nowhere.
