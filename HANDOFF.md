# CAPSULE HANDOFF - new OMP session

> **STATUS: CLOSED (2026-10-02).** Tasks T1-T6 done; the result is on
> `main` (PR #1-#5). The working branches `refactor/dwa-systemy` and `refactor/seed`
> were **deleted after the merge**. From now on this file is **a record of the assignment, not instructions** -
> the commands in §6 are historical. Current state: `README.md` and `seed/`.

> This file is the first thing you read. It contains everything you need
> to get started. Do not ask about anything that is not here - a question about something I did not
> describe is information in itself, so write it down in §6 of the report.

**Time:** Friday evening, 30.09→02.10. **Hackathon: tomorrow, Saturday 03.10.**
This is not a week-long task. It is a task for **tonight**, with the result
ready for tomorrow morning.

---

## 1. What you are doing

**System 1** of this project, applied to the project itself.

You get a repo with a finished hackathon blueprint. Your task:

> **Find the holes, simplify whatever can be simplified, and leave the thing closest to the
> development plan - so that your buddy tomorrow morning can, with a single command
> from Claude Code Pro, create the repositories and start working.**

You are not designing the architecture. It already exists and is settled. **Your task
is the holes and the passability**, not the shape.

### What you do NOT do (this matters more than the task list)

- **You do not rebuild the architecture.** Two systems, the capsule, machine merge -
  these are settled. If you think it is wrong, write it in §6 of the report with an argument
  and move on. Do not edit those files without a reason.
- **You do not write new process rules.** The project went through three rounds of
  simplification: 3 391 → 1 246 → 1 188 lines. Every further rule is suspect
  by default. The question is: *does this line prevent a specific mistake?*
- **You do not add files unless they follow from the task.** Everything you add
  needs a one-sentence justification in the report.
- **Do not assume something is broken just because you do not understand it.** If you could not
  make sense of something - write it as a question, not as a verdict.

---

## 2. State of affairs - do not rediscover this

Everything below **is verified** and does not need to be checked again.

**Repo:** `https://github.com/TomaszGonczar/hackathon-multi-ai-blueprint`
**Working branch:** `refactor/dwa-systemy` - *deleted after the merge; all the work is on `main`.*
**`main` was untouched during the work** - it changed only through the approved merge.

### What is done

| Item | State | Evidence |
|---|---|---|
| Audit of the original package (10 files, 3 391 lines) | done | `archive/AUDIT.md` |
| Refactor into two systems | done | commit `9ac2fb4` |
| 60-min research + machine merge | done | commit `e36df9a` |
| `AGENTS.md` as the system's context and state | done | commit `b57cc84` |
| `atria` provider in OMP | works, tested | `~/.omp/agent/models.yml` |

### Known holes in the original (documented, **do not fix them**)

1. **A live contradiction.** `01_DISCOVERY_CLOSURE.md` and `04 §14` say "short-event
   branch is closed", `03 §8.2` and `04 §10` say "active reserve branch".
   The review register (`09_REVIEW_RECORD` F-05) declares this as fixed.
   Fixed in 2 of 4 places. → `archive/AUDIT.md` §3.1
2. **Three checklist items break the format of that checklist**, and CI was extended
   with an exception for them instead of a fix. → `archive/AUDIT.md` §3.2
3. **Nothing in the original was executed.** 0 `ENFORCED`, 0 dress rehearsals.

These three are **documented and deliberately left**, because they concern files we
do not touch. They are not your task. *(The original's files were later moved to
`archive/old-package/`.)*

### Decisions already made - do not go back to them

| # | Decision | State |
|---|---|---|
| 1 | Observer removed, replaced by review in a fresh context | closed |
| 2 | 60-min research, 5 sessions | closed |
| 3 | The machine merges; the human steps in 2× (sync, freeze) | closed |
| 4 | One wire: `CAPSULE.md` | closed |
| 5 | No memory - the system lives 2 days | closed |
| 6 | OMP as the runtime, no meta-harness | closed |
| 7 | Rules in `AGENTS.md §4`, the rest is justification | closed |

---

## 3. Your bet - this changes the priorities

Your buddy has **2× Claude Pro (x20) and 1× ChatGPT (x10)**. The project rests on the bet
that **strong models and plenty of tokens are obtainable and are meant to be spent**. Most of what
looks like sensible saving is a mistake.

**Tokens are not the narrow resource. The narrow resources are:**
- attention (who reads, who decides)
- the context of a single session
- collisions
- synthesis

Your model has 256K of context. The whole corpus of this repo is ~7 200 words, i.e.
**~20K tokens** - you have room for thirty times more than is here. You can
read everything at once and do not need to remember anything between sessions.

---

## 4. Tasks - do them in order

### T1 · Read with a critic, not with notes

Read `README.md`, `AGENTS.md`, `CAPSULE.md`, `1-RESEARCH.md`, `2-BUILD.md`,
`3-CHEATSHEET.md`. Note every place where **the files say different things or blur
responsibility.**

Pass criterion: a list of sentences of the form *"file X says A, file Y says B"*, with line
numbers. Empty means the corpus is consistent - and that is also a result, write it down.

### T2 · Ten things that will not work tomorrow morning

This is the **main result of your work.** At 8 am the team has 15 minutes and one terminal
window. Find ten things that will break in that window.

Candidates to check (but look for your own too):
- whether the capsule can be filled in within 10 minutes by 5 people who **do not know** the topic
- whether `check.sh` can be written without knowing the solution (and there is no solution yet)
- whether the worktree directories collide with a way of working in which people do not know git well
- whether anything requires a token, an account or a network that it is **not known** they have
- whether the "waits for" order can be determined before the solution is known
- whether anything assumes an agent will do something on its own, and nobody checks it

Pass criterion: ten items, each with **a concrete sentence on what to do**,
not with a diagnosis.

### T3 · Simplify what does not defend the idea

Mandate: **suspect by default**. For every element, answer:
*does this prevent a specific mistake I have seen, or does it only look like
it does?*

Remove or simplify whatever answers "only looks like". **Do not remove:**
- the machine merge order (without it the loop stalls at night)
- the rule about interfaces (without it the machine will resolve a conflict silently)
- `check.sh` (without it there is no loop)
- `AGENTS.md` (the agent does not know what situation it is in)

Pass criterion: a list of removed/simplified things **with one sentence of
rationale for each**. A list of what was left is also a result - say what you visited
and left alone.

### T4 · Development plan - the thing closest to the plan

Write `DEVPLAN.md`: what exactly to do **from tomorrow 8:00 until submission**, in order,
with roles. It is meant to be a list that can be ticked off, not a document to read.

Requirements:
- starts from Friday evening, because that is the same day
- every step has an owner and a pass condition that can be seen
- **there is a contingency plan** for the variant "we did not manage to plant the seeds"
- says outright what happens if the topic turns out different than assumed
- **does not repeat `3-CHEATSHEET.md`** - that is a clock for a human, `DEVPLAN.md` is the order
  of work with assignments

Pass criterion: a reader who was not present at any conversation carries this out
on Saturday morning without asking anyone.

### T5 · Seed - this is the most important result

Prepare `seed/`, from which **Claude Code Pro x20 in auto mode will create the
repositories tomorrow morning with one command.**

This is a hard constraint that decides the form:

> The bot must work **without asking a human.** If the seed requires a question,
> the bot will stop at the worst possible moment - the first minute of the hackathon.
> **Every element of the seed must have a default value and work without intervention.**

The seed must contain:

```text
seed/
├── SEED.md              ← what this is, how to run it, one command
├── bootstrap.sh         ← idempotent: can be run 2× without harm
├── repo-layout.md       ← directory structure, branch names, worktrees
├── templates/
│   ├── AGENTS.md        ← with STATE: BUILD, ready to paste
│   ├── CAPSULE.md       ← template with a header and 6 blocks
│   ├── check.sh.example ← a working pattern, exit 0/1
│   └── START-HERE.md    ← what to read, in what order, the first 30 min
└── VERIFY.md            ← how to check that the seed worked, before the hackathon starts
```

Requirements for `bootstrap.sh`:
- **idempotent** - running it a second time does not destroy existing directories
- creates the repo and 5 worktrees, each with `check.sh`
- copies `AGENTS.md` and `CAPSULE.md` into the root directory of the **solution repo**
  (that is where the agent loads them - not into the blueprint repository)
- **requires no secret** or token that the rest does not require
- prints a verification checklist at the end
- ends with `exit 0` or `exit 1` - never "half and half"

**Pass criterion of `VERIFY.md`:** someone on a clean machine, without your help,
runs `bash seed/bootstrap.sh`, does the test, and within **10 minutes** has five working
directories with a green `check.sh`. Write down exactly this command and exactly this time.

### T6 · Report - `REPORT.md`

At most 150 lines. Five sections, one paragraph each:
1. **Ten holes** - from T2, each with an action
2. **What you simplified** - from T3, with rationale
3. **What you left despite doubts** - and why
4. **Seed: how to check that it works** - from T5
5. **Questions I have no answer to** - one to three

**The report must be short.** If it does not fit in 150 lines, the task is not
done - it means you are writing about the process instead of the result.

---

## 5 · What is not allowed

- **Do not commit anything to `main`.** All the work on `refactor/seed` - a new branch
  from `refactor/dwa-systemy`. *(Historical: after the approved merge everything is
  on `main`, the branches deleted.)*
- **Do not delete `archive/` (including `archive/old-package/`) or `LICENSE`.**
  That is someone else's work and evidence. `AGENTS.md` says they are not to be read, and that is fine.
- **Do not paste any secrets.** There are no keys in this repo. The Atria key lives
  in `~/.omp/agent/models.yml` and in the macOS keychain - **never copy it** and do not
  show it in the task or in a commit.
- **Do not change `AGENTS.md §4`** (operating rules) without a reason described in T3.
- **Do not write Polish in `seed/bootstrap.sh`** - code, technical comments in
  English, documents in Polish. A bot reads differently than a human.

---

## 6 · How to start, literally

```bash
git clone https://github.com/TomaszGonczar/hackathon-multi-ai-blueprint
cd hackathon-multi-ai-blueprint
```

Then read this file again and start with **T1**.

The questions I have no answers to are in `REPORT.md` §5. Do not block yourself on
any of them - **T2, T3 and T5 can be done independently.**

---

## 7 · What I will get

Write to `REPORT.md` in the worktree. Do not wait for the end - after each task add
a section, so that an interruption of the work does not cost the result.

Most important, in order:
1. **a working and verified seed** (T5)
2. **a list of holes with actions** (T2)
3. **`DEVPLAN.md`** (T4)
4. simplifications (T3), report (T6)

If you run out of time and do only one thing - do **T5**. The rest is valuable,
but the seed is what nothing runs tomorrow morning without.
