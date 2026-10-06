# T2 - Ten things that will not work tomorrow morning

Each one: diagnosis + **a concrete sentence on what to do**. D01, D03, D07, D09, D10
checked live (not from reading).

---

**D01. `check.sh` cannot exist before the first line of code, and the rule demands it.**
`AGENTS.md:85-89` (*"test before code"*) is literally unexecutable: the solution
does not exist yet, so there is nothing to test, and `3-CHEATSHEET.md:23` demands a ready
`check.sh` already on Friday.
**What to do:** the seed provides `check.sh` with a phase gate - `PHASE=0` exits 1, `PHASE=1`
exits 0. The rule becomes executable: the file exists before the code, and *green*
means filled in, not accidental. **Done in `seed/templates/check.sh.example`.**

**D02. Secret with an empty staging area (`set -euo pipefail` + `grep` with exit code 1).**
`2-BUILD.md:83` uses `git diff --cached | grep ... && { exit 1; }` - with an empty
diff `grep` returns 1 and `set -e` behaves non-terminally in a pipeline.
I checked: the pattern works (0 on empty, 1 with `API_KEY=x`), **but under `set -e`
it requires that staging not be empty, or that grep be inside an `if`** - and that is a difference
nobody will guess at 3 in the morning.
**What to do:** replace with `if git diff --cached | grep ...; then exit 1; fi`.
**Done in `2-BUILD.md:83` and in the seed template.**

**D03. `./w3/check.sh` points to a directory that does not exist.**
`2-BUILD.md:43-47` does `git worktree add ~/w3-models -b w3`, so the worktree root
is `~/w3-models`. Then `./w3/check.sh` (`2-BUILD.md:27`, `CAPSULE.md:93`) is
`~/w3-models/w3/check.sh` - it does not exist. `2-BUILD.md:68` (`cd "$(dirname "$0")/.."`)
points to `~/`. I checked live: a worktree after `add` has no `w3/` inside.
**What to do:** `check.sh` lives in the **worktree root**, the invocation is `./check.sh`.
**Done: `CAPSULE.md:110`, `2-BUILD.md:22,27,66,68`, seed.**

**D04. The capsule shows one command for five pieces, the comment says per piece.**
`CAPSULE.md:88` (comment) - *"ONE COMMAND PER PIECE"*; `CAPSULE.md:93`
(example) - `./w1/check.sh && ./w2/... && echo $?`. An agent at 1:00 will not find
its piece in this chain.
**What to do:** five separate commands with a `cd` into the worktree. **Done in `CAPSULE.md`.**

**D05. The directory names are fictitious, and they have to be named on Friday.**
`2-BUILD.md:43-47` gives `w1-anomaly-detection` etc.; `3-CHEATSHEET.md:23` says to name
them on Friday, when there is no topic.
**What to do:** move the naming to **0:55**, when the capsule is being filled in.
The seed uses `w1-piece` … `w5-piece` + a `git worktree move` instruction once the
real names are known. The commands are in `seed/repo-layout.md`.

**D06. `STATE: BUILD` in a template that is loaded before the topic is announced.**
`AGENTS.md:31-35` has values for Saturday 13:00, while the states `RESEARCH`/`BRAINSTORM`/
`CHOICE` (`AGENTS.md:43-47`) are at 0:00-0:58 - the same file is loaded by the System 1 and the
System 2 agent. Copied 1:1 it leaves a session before T0 with *"full loop, code"*.
**What to do:** the seed generates `AGENTS.md` with `STATE: PREP` and a note that before
T0 you do not build. **Done in `seed/templates/AGENTS.md`.**

**D07. `research/` is invisible from the agent's worktree.**
`1-RESEARCH.md:77` says to write to `research/`, `AGENTS.md:141` says to read
`research/*.md`, `2-BUILD.md:216` runs `ls research/` at sync. But the agent works
on branch `w3` - System 1 commits `research/`, so it is not there in the agent's worktree.
Nobody wrote down which branch it lives on.
**What to do:** System 1 commits `research/` to `main` before System 2 starts
(0:55), and the agent reads it through `git show origin/main:research/01-x.md` - does not edit,
does not clone, does not leave the directory. **To be added in `CAPSULE.md` or
`AGENTS.md` - left open, because it is a team decision about branches, not about the seed.**

**D08. The Friday smoke test requires `gh` and `jq`.**
`3-CHEATSHEET.md:13-16` uses `gh api .../collaborators --jq`, `gh api .../protection`,
`git ls-remote`. `gh` + `jq` are two dependencies that are not there; `git ls-remote HEAD`
checks readability, not write access.
**What to do:** replace with `git push origin <branch> --dry-run` - this checks
permissions exactly and needs only git. Check `main` protection in the GUI.
**Not done - `3-CHEATSHEET.md` is a clock for a human, and HANDOFF §5 forbids
adding dependencies.**

**D09. `git worktree add -b w3` blows up when the branch already exists.**
This is a real idempotency bug: a colleague hooked in earlier, you run bootstrap
and get *"a branch named 'w3' already exists"*. I checked live.
**What to do:** bootstrap checks `git show-ref --verify refs/heads/$branch` and
attaches the existing branch instead of `-b`. **Done in `seed/bootstrap.sh:93-96`.**

**D10. Idempotency was broken by `git worktree list` + string match (macOS `/tmp` → `/private/tmp`).**
The first version of bootstrap checked `grep -q "^worktree $target$"` on the output of
`git worktree list --porcelain`. On macOS git resolves the path, so the pattern
never matched - the second run tried to add an existing worktree and threw
*"already exists"*. Checked live.
**What to do:** check via `[ -e "$target/.git" ]` (a worktree has a `.git` file,
not a directory). **Done in `seed/bootstrap.sh:87-91`.**

---

## Tested live, but untrue (written down so nobody repeats it)

- **Squash merge does not break `merge-base --is-ancestor`.** I checked: after
  `git merge --squash w1` the w1 commit **is still an ancestor** of main. So the waiting
  pattern from `2-BUILD.md:137` works after squashes too. No need to fix this.
