# 2 - BUILD

**Input:** [`CAPSULE.md`](CAPSULE.md) filled in. Nothing else.
**Output:** the solution on `main`, tested by someone who built nothing.
**Who:** five people, five laptops, OMP on each. Optionally additional sessions
for review.
**Loop:** **non-stop.** The machine lands work on `main`, waits for modules, resolves
 mechanical conflicts and never blocks the team with a question.
> **The operating rules are in [`AGENTS.md`](AGENTS.md) §4.** This file is the rationale
> - *why* a rule is the way it is. If the two disagree,
> **`AGENTS.md` wins**, because it is the one in the agent's context.

**Not here:** your own harness, orchestration, hooks, configuration, merge bot.
**OMP is the runtime. Merge is a rule in the agent's loop, not a separate program.**

---

## Start: 20 seconds per person

```bash
cd ~/w3-piece       # your own directory, your own worktree - this is also your piece
omp                 # or: claude, codex - whatever you work in
```

First sentence to the agent:

> **Read `CAPSULE.md`. Then run `./check.sh`. Then start.**

The order matters: **test before the first line of code.** An agent that writes the
code first and only then checks the test burns context and half the night
fixing what it should have got right the first time.

If `check.sh` doesn't exist - **don't start.** Write it, or ask someone
who can. It's 15 minutes that save two hours.

---

## Directories: collision is impossible, because there is no surface

```bash
# once, at the start
git clone <repo> && cd repo
git worktree add ~/w1-anomaly-detection -b w1
git worktree add ~/w2-api             -b w2
git worktree add ~/w3-models          -b w3
git worktree add ~/w4-reporting       -b w4
git worktree add ~/w5-demo            -b w5
```

Five directories, five branches, zero shared files. Nobody can write into someone else's
directory - not because you forbade it, but because it isn't there.

**Name the directories so the name shows what's inside.** A directory name is a signal
the agent reads before it opens a file - folders and file names are information
to it, not cosmetics.
([source](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents))

`w1/` says nothing. `w1-anomaly-detection/` says everything.

---

## Test: the one thing without which this doesn't work

```bash
#!/usr/bin/env bash
# ./check.sh - exit 0 = done. Lives in the root of your worktree.
set -euo pipefail
cd "$(dirname "$0")"     # check.sh lives in the root of your worktree

echo "== 1. compiles =="
python -m compileall -q src/models/ || exit 1

echo "== 2. unit tests =="
pytest tests/test_models.py -q || exit 1

echo "== 3. DOES IT CATCH ANYTHING =="
python -m demo.replay tests/fixtures/attack.log | grep -q "ALERT" || {
  echo "FAIL: test did not detect the attack from the fixture - the test checks nothing"
  exit 1
}

echo "== 4. no secrets =="
if git diff --cached | grep -nEi '(api[_-]?key|password)[[:space:]]*='; then
  echo "FAIL: secret"; exit 1
fi

echo OK
```

Three things a simpler script won't do:

1. **Step 3 checks that the test catches something.** A green, worthless test is worse
   than no test - it gives false calm.
2. **Step 4 always runs**, nobody has to remember it.
3. **`set -euo pipefail` + `exit 1` everywhere.** Without that, a script that has too few
   checks returns 0.

**Before the start:** deliberately break one piece and make sure `check.sh`
notices. If it doesn't - the test is broken.

### The rule

> **No green `check.sh` - the piece doesn't start.**
>
> **Green `check.sh` and green review - the piece lands on `main`.**

Tell the agent this outright: *"don't finish until `./w3/check.sh` exits 0,
then review, then land on `main` yourself"*.

The mechanism this exists for:

> *"Without a check it can run, 'looks done' is the only signal available, and **you
> become the verification loop: every mistake waits for you to notice.**"*
> - [Claude Code](https://code.claude.com/docs/en/best-practices)

---

## Merge: the machine, non-stop

**This is the core of the system. Read it before you start.**

There is one rule and the agent gets it in its instructions at the start. There is no bot, no
script, no cron - **every agent does it itself, in its own loop**, right after
a green test.

### Waits for other modules

The table in the capsule has a **"Waits for"** column. That is the order of landing on `main`
and it is read literally.

Piece 4 waits for 1 and 2. Meaning: `w4` does not land on `main` until `w1` and `w2`
are there. **It doesn't ask about it.** It checks, doesn't land, goes back to work on its own
piece, checks again after a while.

```bash
# what the agent does instead of asking
git fetch origin main
for dep in 1 2; do
  git merge-base --is-ancestor origin/w$dep origin/main || {
    echo "waiting for w$dep - back to work"
    sleep 600; continue 2
  }
done
```

**It waits indefinitely and doesn't get in the way.** That is the whole point: piece 4 lands in
the second the last of its dependencies lands - even if it's three
in the morning, and even if you're asleep.

**Check on paper that these five pieces can be arranged without a cycle.** A cycle is a
deadlock: the machine waits forever and knows nothing about it. It is the only mistake
that in this design costs the whole night.

### Conflicts

| Type of conflict | What the machine does |
|---|---|
| **Mechanical** - imports, ordering, different lines in the same file | **resolves it itself** and lands |
| **In an interface file** - a file listed in the capsule as shared | **does NOT resolve it.** Records it, doesn't touch it, goes back to work, reports at sync |

The boundary is written in the capsule and the agent doesn't invent it. Thanks to that the machine never
silently resolves a conflict that changes the contract between pieces.

### What the machine **never** does

- doesn't land with a red `check.sh`
- doesn't land if review reported a correctness gap
- doesn't touch interface files
- doesn't land on `main` before its dependencies
- doesn't stop other pieces

**The loop doesn't stop.** If your piece can't land, you keep doing
your work and land later.

---

## Review: fresh context

**This is where we spend the bet.** We have compute. It's worth it.

```bash
git diff main...w3 | claude -p "Review this diff against CAPSULE.md in this repo.
Report only gaps that affect correctness or the stated capsule.
Ignore style, naming, refactoring preferences.
If it works, say so - do not invent problems."
```

Why this works better than a review in the same session:

> *"**A fresh context improves code review since Claude won't be biased toward code it
> just wrote.**"*
> *"A reviewer running in a fresh subagent context **sees only the diff and the criteria
> you give it, not the reasoning that produced the change**."*
> - [Claude Code](https://code.claude.com/docs/en/best-practices)

The sentence after "If it works, say so" **is mandatory.** Without it the reviewer will return
remarks because it was asked to, and you will chase them, building abstractions for things
that can't happen.

**A third, "malicious" agent** - *"what would break if someone attacked this"* - catches
what the other two won't notice. In a security project this third session is worth more
than anywhere else.

**The order is rigid:** merge waits for review. Never the other way round.

---

## Two moments when a human steps in

Not "human in the loop". Two points, the rest is machine.

### Sync - every 2 hours, 5 minutes standing

A human steps in to see the state, not to do anything:

```bash
git log --oneline main | head -20     # what landed
ls research/                          # what research pulled out
```

- who is stuck waiting and **why** (critical - someone waiting for no reason is a dead
  piece, not a sleeping one)
- who reported a conflict in an interface file
- whether anything in the capsule needs to be added

**This is the only place where the team can deliberately change the merge order.**
Three minutes, on paper, and an entry in the capsule table.

### Freeze - 4 hours before the deadline

It gets hard here: **every piece ends on a green test or is marked
CUT.** Nothing in between. Cut = dropped from `main`, not "we'll finish in the morning".

After freeze, **only demo-blocking defects** go in, each with a one-sentence
reason in the PR.

### Accountability

Here is a boundary that can't be automated, and it's worth saying out loud
before the start:

> **The machine can land everything. It cannot say what you submit.**

The 1979 IBM slide that Simon Willison quotes doesn't change because merge
is automatic: *"A computer can never be held accountable. Therefore a computer
must never make a management decision."* The only question is **where** the human
steps in - and the answer is: where it's decided what matters, not where
code is moved around. That's why two moments, not a gate at every merge.

---

## What a piece does when it's stuck

There is no situation in which the team stands still. Every agent:

1. **Records the facts** - what, when, which command, what result
2. **Flags it in the channel** with one line, e.g. `w3: waiting for w1 and w2, `check.sh` green
3. **Goes back to work on what it can** - fixes, writes tests, finishes up
4. **Asks only when** one of two things: a conflict in an interface file or
   the capsule turned out to be wrong

The last point - the capsule can misunderstand the topic and **no mechanism will
detect it.** If someone says *"wait, that's not what this is about"* - that is the
most important voice in the whole system and it must not be ignored. That is why it is the
only question that goes to a human immediately, not to sync.

---

## What is **not** here

- **A merge bot.** Merge is a rule in the agent's loop, not a separate program.
- **Your own harness.** OMP is already there. No orchestration, no hooks,
  no configuration.
- **Memory and session resumption.** Two days. A new session reads the capsule and has everything.
- **State validation, registries, premortems.** A claim without a command doesn't exist -
  and that is the whole rule of evidence.
- **Nine roles.** Two names. The rest is a function on the side.
