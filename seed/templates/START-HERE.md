# START-HERE - the first 30 minutes of Saturday

**Time:** 08:50. The topic drops at 09:00. Do not read anything else before 09:00.

---

## 0. If bootstrap was not run yesterday (5 min)

```bash
cd <blueprint-repo>
bash seed/bootstrap.sh
```

Five directories in `~/`, `AGENTS.md` and `CAPSULE.md` in the root of the solution repo.
Idempotent - a second run does not destroy anything.

If you do not know where the blueprint is: clone
`https://github.com/TomaszGonczar/hackathon-multi-ai-blueprint` (default branch,
no switching) and run `bash seed/bootstrap.sh`.

## 1. Your directory (2 min)

```bash
cd ~/w1-piece    # replace with your number
ls
cat check.sh
```

**Your directory is your worktree. `check.sh` is in its root.**
There is no `w1/` subdirectory - the directory is the whole thing.

## 2. Before the topic drops (10 min)

Fill in **phase 0** of your `check.sh`:

```bash
$EDITOR ~/w1-piece/check.sh
```

- change `PHASE=0` to `PHASE=1`
- fill in sections 1-3 (build, tests, does the test catch anything)
- `bash ~/w1-piece/check.sh` must exit 0

**This is your job until the topic drops.** You are not writing solution code,
because you do not know yet what you are building. An empty `check.sh` with `PHASE=0` exits 1 - that
is the goal, not a bug.

If you do not know what to put in section 3 - write a test that checks the smallest
thing your piece must do. Break it and see whether the test catches it.

## 3. The topic drops (09:00)

System-1 takes the topic and starts research. **You do not wait** - you finish `check.sh`.

## 4. Capsule ready (~09:58)

```bash
cd <solution-repo>      # where CAPSULE.md lives
cat CAPSULE.md
```

Check **your** line in section 5: do you know what you are doing and what you are waiting for?
If not - this is the only moment to say so.

## 5. Start (10:00)

```bash
cd ~/w1-piece
omp          # or claude, codex - whatever you work in
```

The first sentence to the agent:

> **Read `CAPSULE.md`. Then run `./check.sh`. Then start.**

Then: code → `./check.sh` → review → merge. Non-stop, until freeze.

---

## Three things you must know

1. **`check.sh` green = you land on `main`.** On your own. You wait only for your
   dependencies from the "Waits for" column in the capsule.
2. **Conflict in an interface file → do not touch it.** Write it down, go back to work, report
   at sync.
3. **The capsule can be wrong.** If you think *"wait, this is not what it is
   about"* - you say so immediately, not at sync. It is the most important voice in
   the system and nobody else will give it.

---

## What you do not read

Anything that `AGENTS.md` or the capsule does not point to. You have the rules in `AGENTS.md` §4.
The documents from the blueprint repo (`1-RESEARCH.md`, `2-BUILD.md`, `3-CHEATSHEET.md`) are not
part of your work.
