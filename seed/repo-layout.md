# repo-layout.md - directory, branch and worktree structure

---

## Worktree = piece

Each person has **one directory, one branch, one `check.sh`**. The directory is a
worktree - a full checkout of the repo, not a linked subdirectory.

```text
~/w1-piece/       branch: w1     ← waits for: -
~/w2-piece/       branch: w2     ← waits for: -
~/w3-piece/       branch: w3     ← waits for: w1, w2
~/w4-piece/       branch: w4     ← waits for: w1, w2
~/w5-piece/       branch: w5     ← waits for: w1, w2, w3, w4
```

The "Waits for" column is in `CAPSULE.md` section 5. **It is the order of landing on
`main`, read by machine.** The one above is the seed's default; if the team
changes the split, it writes that into the capsule, not here.

**A cycle = deadlock.** If `w3` waits for `w5` and `w5` for `w3` - the machine waits
forever and knows nothing about it. Before you start, check on paper that
these five can be ordered without a cycle.

---

## Root vs working directory

```text
~/w1-piece/                ← you work HERE (cwd)
├── .git                   ← a file, not a directory - a pointer to ~/hackathon-solution/.git
├── check.sh               ← in the worktree root, you call ./check.sh
└── <your files>
```

**`check.sh` is in the worktree root.** There is no `~/w1-piece/w1/check.sh`. Someone
looking for a subdirectory will not find one - that is the point, because it removes the ambiguity
between the directory and the piece.

---

## Solution repo

```text
~/hackathon-solution/
├── .git/                  ← all branches, the whole history
├── AGENTS.md              ← loaded at the start of every session
├── CAPSULE.md             ← filled in on Saturday by system-1
└── main                   ← merge target
```

**`AGENTS.md` and `CAPSULE.md` live in the root of the solution repo**, not in the worktree and
not in the blueprint repo. Your agent loads them from here, because this is its cwd.

It is the same file for all five - only system-1 edits it (until
T+1:00) or a human (at sync and freeze).

---

## Branch → main relation

```text
w1 ──merge──► main
w2 ──merge──► main
w3 ──merge──► main   (only when w1 and w2 are on main)
w4 ──merge──► main   (only when w1 and w2 are on main)
w5 ──merge──► main   (only when w1, w2, w3 and w4 are on main)
```

The merge is performed **by the agent, in its loop** - there is no bot, no cron,
no hook. The rule is in `AGENTS.md` §4.4.

**Every branch has a marker at the start** (`seed: wN-piece marker`). Without it
all branches would be ancestors of `main` (they start from the same commit), so the
`git merge-base --is-ancestor` gate would say the piece is **already**
merged - and a piece with dependencies would land on `main` first, breaking the
order. The marker fixes that: until the piece lands, the gate says `NO`.

### How to check whether your dependencies are already on main

```bash
git fetch origin main
for dep in 1 2; do
  git merge-base --is-ancestor origin/w$dep origin/main || {
    echo "waiting for w$dep - back to work"
  }
done
```

`git merge-base --is-ancestor` works on **commits**, not on names. If the
merge into main was squashed, this test passes anyway - verified.

### If there is no remote repo

Everything above works locally, just without `origin/`. Then replace `git fetch origin main`
with nothing, and `origin/main` with `main`. **Pushing every 30 minutes still applies** -
it requires adding a remote (`git remote add origin <url>`), otherwise your backup does not
exist.

---

## Names

The directory name is a signal the agent reads before it opens a file. `w1/` says
nothing. `w1-anomaly-detection/` says everything.

That is why the seed uses neutral `w1-piece` … `w5-piece` **at the start**. On
Saturday, when the capsule is filled in (~0:55), system-1 writes the real names into
section 5, and you rename the directories:

```bash
git -C ~/hackathon-solution worktree move ~/w1-piece ~/w1-anomaly-detection
git -C ~/hackathon-solution branch -m w1 w1-anomaly-detection
```

Do it **before** anyone writes a line of code. After that the branch name is in
the history and changing it costs.

If you change the directory name, `AGENTS.md §4.1` does not need updating -
the rule says *"cd ~/w<N>-<name>"*, not a specific name.

---

## What is not here

- **No `src/` or `tests/` subdirectory imposed from above.** You choose the language and
  structure on Saturday.
- **No network requirement.** Bootstrap and `check.sh` work offline.
- **No imposed remote.** You add one if you want to push.
