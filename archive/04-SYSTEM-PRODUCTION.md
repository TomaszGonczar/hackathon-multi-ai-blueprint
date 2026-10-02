# 04 - Production system

**Goal:** five people, five agents, one repo, zero collisions, one test per workstream
and one human at the merge. In 20 hours, with 8 hours of sleep in the middle.

**Scope:** hour 1.5 → submission.

---

## Four elements of the system

Everything else is configuration. There are four:

1. **Spec** - four sections, written by the agent, asking the human
2. **Test** - one command per workstream, returning 0 or 1
3. **Worktree** - one per person, collisions structurally impossible
4. **Merge** - a human, always, with a review in a fresh context

Order matters: **without a test, the rest makes no sense.** (D3)

---

## 1. Spec - four sections, not eleven fields

The previous version had a ten-field "Mission Package" (`AUDIT.md` §2 point 2),
written on the assumption that every field must have a reader. A correct observation, the wrong
tool - because the fields were never connected to anything and nobody noticed.

Recommendation from the documentation ([pattern B2](01-PATTERNS.md)):

> *"The most useful specs are **self-contained**: they **name the files and interfaces
> involved**, **state what is out of scope**, and **end with an end-to-end verification
> step** that proves the feature works."*

Four sections. The rest is chatter, not a document:

```markdown
# SPEC: workstream-3 - anomaly detection in the auth log

## What
One sentence. It can be refuted.

## Where
I write in: src/detect/           I don't touch: src/api/, migrations/, other workstreams' SPEC.md
Interface I consume:             auth.events (given: timestamp, user, ip, action)
Interface I deliver:             detect.anomalies(Window) -> [Anomaly]

## What we are NOT doing
- UI for this (someone else)
- ML models (too much data, too little time)
- Retries and backoff (we have no real traffic)
- Anything not needed for the green test below

## How we check
./w3/check.sh    →  exit 0 = done, exit != 0 = not done
```

The **"What we are NOT doing"** section is the one most often skipped and it saves the most time.
Without it the agent will **always** try to fix the neighboring code. That is not
overreach - it is correct behavior for an agent given an incomplete assignment.

**Who writes it:** the agent, asking you via `AskUserQuestion`. **Not you** - you have no
idea how to implement it, and your answer will be a guess.
**Which session implements:** **a new, clean one.** The one that wrote the spec does not implement.
A clean context means it implements what the spec says - not what it remembers
from the conversation.

---

## 2. Test - the one thing without which nothing works

The mechanism without it looks like this ([pattern B1](01-PATTERNS.md)):

> *"Without a check it can run, 'looks done' is the only signal available, and **you become
> the verification loop: every mistake waits for you to notice.**"*

```bash
#!/usr/bin/env bash
# ./w3/check.sh - exit 0 = done
set -euo pipefail
cd "$(dirname "$0")/.."

echo "== 1. does the code compile =="
python -m compileall -q src/detect/ || exit 1

echo "== 2. do the unit tests pass =="
pytest tests/test_detect.py -q || exit 1

echo "== 3. does it catch an attack at all =="
python -m demo.replay tests/fixtures/bruteforce.log | grep -q "ANOMALY" || {
  echo "FAIL: attack from the fixture not detected - the test checks nothing"
  exit 1
}

echo "== 4. are there no secrets =="
git diff --cached | grep -nEi '(password|api[_-]?key|token)[[:space:]]*=[[:space:]]*["'"'"']?[A-Za-z0-9]{16,}' && exit 1

echo "OK"
```

**Three things this script does that a simpler one won't:**

1. **Point 3 checks that the test catches something.** A fixture with a real attack must raise
   an alarm. If it doesn't, the test is green and worthless. This is a known failure
   mode ("a green exit code that scanned nothing is not proof") and you now
   have a safeguard against it in three lines.
2. **Point 4 scans what you are about to commit.** It always works, and requires nobody
   to remember.
3. **`set -euo pipefail` + `exit 1` everywhere.** Without that, a script with too few
   checks returns 0. A green that means nothing is worse than no test -
   because it gives false peace of mind.

**A rule worth saying out loud before the start:**

> **No green `check.sh` - the workstream does not start.**

Not "we'll try", not "later". If the command doesn't exist, the agent doesn't know when it
is finished, you don't know whether it works, and both of you are guessing. This is the most expensive single
change you can make for free.

**Rule for preliminary tests:** before you write `check.sh`, deliberately break your code
and make sure `check.sh` notices. A test that passes on broken code
is not a test.

---

## 3. Worktree - collision is impossible, because it is structure

```bash
# Once, at the start, everyone on their own laptop:
git clone <repo> && cd repo
git worktree add ~/w1 -b w1-detection
git worktree add ~/w2 -b w2-api
# ...
```

Five directories, five branches, zero shared surface to write to. Nobody can
write into someone else's directory - not because you forbade it, but because it isn't there.

**This is not "one person per surface". It is the absence of a surface for conflict.**
The previous version designed this rule from scratch, called it the most important one and
added 19 checklist items to enforce it by hand. The tool has it built in
([pattern B3](01-PATTERNS.md)).

**Name directories and branches so that the content is visible from the name.** This is not
aesthetics - the name is a signal the agent reads before it opens a file
([pattern C3](01-PATTERNS.md)):

- `w1/` `w2/` - says nothing
- `w1-anomaly-detection/` - says everything, without opening anything

**Push:** every 30 minutes and always before sleep. Record it as an alias in `.gitconfig`
or as an instruction in `CLAUDE.md`. It cannot be mechanized - it stays as text
and one reminder out loud every time someone steps away from the laptop.

---

## 4. Merge - a human, review in a fresh context

### Why a human

Not "because AI shouldn't". A harder justification - an IBM slide from 1979, quoted by
Simon Willison:

> *"**A computer can never be held accountable. Therefore a computer must never make a
> management decision.**"*

Merge is a management decision: what goes into the main branch, in what order, what
gets dropped. A machine does not have that. The previous version wrote "no AI merges, ever" five times
in five files - hitting the mark, only without a justification you can repeat
to a team at 4 a.m.

**The merge owner is one person. But the fallback must be named at the start**,
not at the moment when that person falls asleep at 3:00. "Whoever happens to be available" is not a
fallback, it is the absence of a plan.

### Why review

> *"**A fresh context improves code review since Claude won't be biased toward code it just
> wrote.**"*
> *"A reviewer running in a fresh subagent context **sees only the diff and the criteria you
> give it, not the reasoning that produced the change**."*
> - [Claude Code](https://code.claude.com/docs/en/best-practices)

One command, zero configuration, works from minute zero:

```bash
git diff main...w1 | claude -p "Review this diff against SPEC.md in this repo.
Report only gaps that affect correctness or the stated spec.
Ignore style, naming, and refactoring preferences.
If it works, say so - do not invent problems."
```

**The last sentence is mandatory.** Without it you will get a report full of remarks, because
the reviewer was asked for a report. Quote:

> *"A reviewer prompted to find gaps will **usually report some, even when the work is
> sound**… chasing every finding leads to over-engineering."*

**This is the whole replacement for the observer.** Comparison:

| | Old observer | Fresh reviewer at merge |
|---|---|---|
| Cost | a continuous process + read-only token + a laptop that can't be allowed to sleep | ~2 minutes, only when there is something to merge |
| Who judges | the same laptop that wrote the plan | a different session, doesn't see the plan |
| What it reports | deviations from the frozen plan | gaps in the diff relative to the spec |
| Idle window | has to exist as a number, otherwise noise or silence | doesn't exist - there is a merge or there isn't |
| When it works | all the time, including when nobody reads it | when somebody actually reads |

The old observer had three unsolvable problems described in `AUDIT.md` §4. All
three disappear along with the process, because **there is no process that could fail silently.**

**A caveat worth saying out loud:** this review is **the first thing to
cut**, exactly as the observer was. If on Friday you say you won't make it
- you skip the review, the green test remains. The cut order is explicit up front, not
at the moment of panic.

---

## Repo - structure is context

```
repo/
├── CLAUDE.md              ← up to 200 lines. Shorter = better followed.
├── BRIEF.md               ← frozen, with numbered amendments
├── SPEC-w1.md             ← 4 sections
├── SPEC-w2.md
├── ...
├── research/              ← research files, not summaries
├── w1/  w2/  w3/  w4/  w5/    ← code, one directory per person
│   └── check.sh
└── .claude/
    ├── settings.json      ← hooks (see below)
    └── rules/             ← rules loaded only for matching files
```

**Directory names are a signal.** `w1/` says nothing. `w1-anomaly-detection/` says
everything to the agent before it opens a file. This is context engineering, not aesthetics.

**Hooks for three duties** (D5). Deterministic, unlike text
in `CLAUDE.md`:

```jsonc
// .claude/settings.json
{
  "hooks": {
    "PreToolUse": [{ "matcher": "Bash", "hooks": [
      {"command": "grep -qE 'api[_-]?key|password' && echo 'STOP: secret in command' && exit 2"}
    ]}],
    "Stop": [{ "hooks": [
      {"command": "bash w1/check.sh || echo 'NOT READY - test did not pass' && exit 2"}
    ]}]
  }
}
```

The `Stop` hook blocks the end of a turn until the test passes. This is the executable
version of the rule "no green test - no result" - and at the same time it is
exactly what the previous version was looking for across 776 lines of its own census.

**Census on demand, not with your own code:**

```bash
claude -p "/doctor prompt-audit"
```

It looks for contradictions, nonexistent references and instructions written for older
models. The previous in-house census compared identifiers, not the content of sentences - which is why
it let through the live contradiction described in `AUDIT.md` §3.1. This command does exactly what
that one was meant to do.

---

## One person's work loop

```bash
# 1. enter your directory (clean context)
cd ~/w1-anomaly-detection && claude

# 2. "implement SPEC-w1.md" - the agent reads the spec, doesn't remember the conversation

# 3. the agent works, runs ./check.sh, fixes, until it passes

# 4. commit + push
git add -A && git commit -m "w1: <what>" && git push

# 5. review + merge (human)
git checkout main && git merge --no-ff w1
```

**Commit frequency:** after every green test, not at the end of the day. The reason
is literal: if the laptop dies at 4:00, you lose an hour of work instead of twelve.
Pushing before sleep is **the same rule, only more important** - because after waking up the laptop
is off and a push can no longer help.

**When to stop and ask:**

- the interface from `SPEC.md` turned out to be wrong
- the test can't be done without touching someone else's directory
- `check.sh` doesn't exist, and it should

Each of these questions **costs 5 minutes to raise and saves two hours of quietly
bad code.** This is not overzealousness, it is arithmetic.

---

## What this system does **not** do

- **It doesn't make sure you build what is in the brief.** The brief may
  misunderstand the topic. Nothing will detect that - the previous observer didn't either, and that was its
  documented, unsolved problem. **You do that, by reading `BRIEF.md` out
  loud in 15 minutes.** If that is the only moment when someone stops and says
  "wait, that's not it" - then it is the most important one in the whole system.
- **It doesn't say whether going for it was a good decision.** The system is correct regardless of
  whether you win. That is a separate matter, and shouldn't be mixed up with "did it work".
- **It doesn't replace knowing what you are building.** If someone doesn't understand the domain,
  a green test only tells them that the code does what the spec said. Not that it is a good
  design. **That takes a person who understands the topic - and that is why the brief
  must read in 15 minutes out loud, not in 5 minutes on a screen.**
