# Seed - what it is and how to run it

**One command that creates the whole hackathon environment:**

```bash
bash seed/bootstrap.sh
```

This creates the solution repo and five worktrees - one per person. Each has its
own `check.sh`. Everything merges to `main` from every worktree.

**No questions for a human.** Every element has a default value:

| Element | Default |
|---|---|
| Repo | `~/hackathon-solution` (argument: `bash seed/bootstrap.sh /path`) |
| Directory names | `~/w1-piece` … `~/w5-piece` |
| Branch per directory | `w1` … `w5` |
| Target merge branch | `main` |
| `STATE` in `AGENTS.md` | `PREP` - to be changed by a human |
| Secrets, accounts, network | **not required** |

---

## What you get

```text
~/hackathon-solution/        ← solution repo, main
├── AGENTS.md                ← agent context (loaded at session start)
├── CAPSULE.md               ← template, filled in by system-1 on Saturday
└── .git

~/w1-piece/                  ← worktree + branch w1 + check.sh
~/w2-piece/                  ← worktree + branch w2 + check.sh
~/w3-piece/                  ← worktree + branch w3 + check.sh
~/w4-piece/                  ← worktree + branch w4 + check.sh
~/w5-piece/                  ← worktree + branch w5 + check.sh
```

Every directory has `check.sh` in its **root**. You call `./check.sh` from the
worktree directory. There is no `w1/` subdirectory inside - the directory is the whole thing.

---

## When to run it

**Friday evening**, once. Check the result with the commands from
[`VERIFY.md`](VERIFY.md) - it takes 5 minutes and must be green before you sleep.

Saturday morning: if something is off, run it again. **It is idempotent** -
the second run does not destroy directories, does not overwrite a filled-in capsule or
a modified `check.sh`.

---

## What this seed does not do

- **It does not come up with a topic.** The capsule is an empty template.
- **It does not set up a remote repo.** If you want to push, add `git remote add
  origin <url>` in `~/hackathon-solution`. Without it the work is local - and
  `check.sh` works anyway.
- **It does not install tools.** It requires `git`. You choose the language and framework on
  Saturday, `check.sh` is language-neutral.
- **It does not create branch protection.** If `main` is to be protected, do it
  manually in the GitHub interface.

---

## Reading order on Saturday

1. `seed/templates/START-HERE.md` - the first 30 minutes
2. `CAPSULE.md` - once system-1 has filled it in (~09:58)
3. `AGENTS.md` §4 - the rules that always apply

The files `1-RESEARCH.md`, `2-BUILD.md`, `3-CHEATSHEET.md` are in [`playbook/`](../playbook/README.md). The first
two are read **when you want to understand why**, the third is the clock for the human.
They are not needed to start.

---

## If something went wrong

| Symptom | Fix |
|---|---|
| `FAIL: 'git' not found in PATH` | install git |
| `fatal: a branch named 'w1' already exists` | old version. Bootstrap now attaches an existing branch instead of failing - update the seed |
| The `~/w1-piece` directory exists but has no `check.sh` | `cp seed/templates/check.sh.example ~/w1-piece/check.sh && chmod +x ~/w1-piece/check.sh` |
| I want a different directory name | edit `PIECES=(...)` at the top of `bootstrap.sh` **before** the first run |
| I want to delete everything and start over | `git -C ~/hackathon-solution worktree prune` and delete the directories manually. **Do not run bootstrap to clean up** - it does not delete |
