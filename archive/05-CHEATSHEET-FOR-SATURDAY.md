# 05 - Cheat sheet for Saturday

For printing. One page per person. The rest is in [`03`](03-SYSTEM-RESEARCH.md)
and [`04`](04-SYSTEM-PRODUCTION.md).

---

## Friday evening - 30 minutes

Thirteen things. All reversible. We do them only so we don't waste Saturday
on setup.

```bash
# 1. who has the right to write to the repo - D5
gh api repos/<org>/<repo>/collaborators --jq '.[].login'          # → list
gh api repos/<org>/<repo>/branches/main/protection               # → 403? main is not protected

# 2. the account and push work
git ls-remote <repo> HEAD && echo OK

# 3. the agent works
claude -p "come up with and print 3 questions about my codebase"  # → if it doesn't answer, don't go

# 4. one working check.sh exists (D3) - for ONE workstream only, the rest on Saturday
mkdir -p w1 && printf '#!/usr/bin/env bash\necho OK\n' > w1/check.sh && chmod +x w1/check.sh
bash w1/check.sh && echo "CHECK WORKS"
```

To do **by hand**, 15 minutes with the team:

- [ ] **Brain** chosen - one person, one laptop, charged, plugged in
- [ ] **Merge-owner** chosen + **fallback** chosen (not "someone who can")
- [ ] **Boundaries of the 5 workstreams** drawn on a sheet of paper (D2) - five directories, zero
      shared files
- [ ] **One `check.sh` written and tested** (D3)
- [ ] **D-number** written into `CLAUDE.md` and **printed**
- [ ] `CLAUDE.md` under 200 lines

**What Friday does NOT include:** a junk register, a checklist, a phase plan, an architecture
review, a second diagram, choosing models per role. That is days of work.
Doing it on Friday means that on Saturday you are building a system, not a solution.

---

## Six numbers

Written into `CLAUDE.md`, printed, **said out loud at the start**. Proposals
to be refuted - they are not truths, they are starting values.

| # | What | Proposal | Why that much |
|---|---|---|---|
| 1 | Push every | **30 min** and always before sleep | that is what you lose when the laptop dies |
| 2 | Team sync every | **2 h**, 5 min standing | less = people going the wrong way, more = talking |
| 3 | **Freeze** how many hours before the deadline | **4 h** | full test + demo rehearsal + package |
| 4 | Review every | **PR** | ~2 min, not worth cutting first |
| 5 | Night sync | **every night, 1 designated person** | someone has to take questions |
| 6 | Submission how many minutes before the deadline | **90 min** | buffer for a broken form / organizer's channel |

**If any of them makes no sense in your scenario - say so now, not on Saturday.**

---

## Saturday

```
TIME   WHAT HAPPENS                                   WHO
─────────────────────────────────────────────────────────────────────────────
-1:00  Setup on site. Clones, logins, one test        everyone
       on an empty project. NOT research.
                                                    ─── STOP. 60 min on it ───

 0:00  TOPIC ANNOUNCED
       → Brain starts research (limit 90 min)         Brain
       → everyone does setup, tests, CLI, clones       the other 4
                                                    ─── IN PARALLEL ───

 1:30  BRIEF v1 read OUT LOUD, 15 minutes
       question to the team: "if we had half the
       time, what do we cut?" → we write it into BRIEF
       lead approves → FROZEN
                                                    everyone (standing/sitting)

 1:45  Everyone takes their workstream from the spec.
       Makes check.sh for theirs before writing
       A SINGLE LINE of code.
                                                    everyone solo

 2:00  >>> LOOP, until freeze <<<

       you work → ./check.sh → commit → push
       you open a PR → review (2 min) → merge-owner
       every 2 h: 5 min standing
                                                    everyone + merge-owner

 4 h    >>> FREEZE <<<
       lead announces out loud
       everyone finishes on a green test or is
       marked CUT - nothing in between
                                                    everyone

 3 h    full test on main
       demo rehearsal ONCE, against the clock
                                                    everyone

 2 h    package: link to the frozen SHA + instructions
       >>> INSTRUCTIONS TEST: someone who built
       nothing clones and runs it <<<
                                                    1 person (the one who
                                                    did NOT build)

 1.5h  submission + confirmation (screenshot/mail/something)
                                                    merge-owner

 0:00  STOP
```

---

## Night

- **shifts, not order.** Someone sleeps, someone works. Not "everyone sleeps until 6".
- **Before sleep: push.** No exceptions. This is the only rule that cannot be
  mechanized and the only one that really protects the work.
- **One person on their feet, by name.** Takes questions. Someone has to.
- **If nobody can stay - say it out loud.** Then the night sync is
  skipped, not "cancelled". Silence is worse than a skipped step.

---

## Four situations in which you will stop

Not a failure plan. A **stopping** plan. Because each of these situations costs more
than 5 minutes of reporting and less than two hours of quiet bad code.

| Situation | What to do |
|---|---|
| **The brief is wrong** - "wait, this is not the task" | STOP. This is the only moment when anyone can see it. Don't wait for certainty. |
| **The test cannot be written** | STOP. A workstream without a test is guessing. Ask for help, not for "I'll try". |
| **You have to touch someone else's directory** | STOP. Either share the directory or change the interface in the spec (numbered amendment). |
| **I don't know if this works** | STOP. Run `check.sh`. If it doesn't exist - write it. Now. |

---

## What we don't do

- **We don't read 348 KB.** The previous version of the documentation - [`AUDIT.md`](AUDIT.md)
  says why. If someone wants to, let them read it on Saturday. Nobody will.
- **We don't build a junk register, a 77-point checklist or 18 constants.** That is
  two days of work. Doing it on Saturday = swapping 24 hours of building for 24 hours
  of describing the building.
- **We don't build a second diagram.** There is one, simple, next to it.
- **We don't trust a brief that is 8 pages long.** If it doesn't fit on an A4 sheet,
  it is not a brief.
- **We don't merge "because it's late".** After freeze only defects that block the demo get in,
  each with a one-sentence reason in the PR. No exceptions - this is the only rule that
  is written in five files so that there is one.
- **We don't let the merge-owner disappear at 4:00.** The fallback named on Friday,
  not in shock.

---

## One sentence

> **One document, one person per piece of code, one test that says "it works",
> one person at the merge, and clear notice that review can be skipped.**

Everything else in this repo is the justification for this sentence and the questions we don't
answer for you.
