# 3 - CHEAT SHEET

For printing. The rest is in [`1-RESEARCH.md`](1-RESEARCH.md) and
[`2-BUILD.md`](2-BUILD.md).

---

## Friday - 30 minutes

So that on Saturday you don't waste an hour on setup.

```bash
gh api repos/<org>/<repo>/collaborators --jq '.[].login'   # who can write
gh api repos/<org>/<repo>/branches/main/protection        # is main protected
git ls-remote <repo> HEAD                                  # push works
claude -p "come up with 3 questions about this codebase"   # the agent works
```

To do with the team, 15 minutes:

- [ ] **System-1** chosen - one person, one laptop, charged
- [ ] **Capsule** printed empty - on Saturday you fill it in live
- [ ] **One `check.sh`** written and tested
- [ ] **Five directories** tentatively named
- [ ] **Merge order** tentatively on paper - **no cycle**

The last item is new and important: with machine merges the order must exist
**before** system 2 starts, otherwise the machine will stall in the night and won't know
why. See the "Waits for" column in [`CAPSULE.md`](CAPSULE.md).

**What Friday does not include:** a junk register, a checklist, a phase plan, an architecture
review, model selection. That is work for the days. Doing it = on Saturday you build
a process instead of a solution.

---

## Four numbers

Written in the capsule, printed, **said out loud at the start.**

| What | How much | Why |
|---|---|---|
| **Push every** | 30 min and always before sleep | that's what you lose when the laptop dies |
| **Team sync every** | 2 h, 5 min standing | the human steps in here - the only place |
| **Freeze how many hours before the deadline** | 4 h | the second moment the human steps in |
| **Submission how many minutes before the deadline** | 90 | buffer for a broken form |

---

## Saturday

```
TIME   WHAT                                      WHO
───────────────────────────────────────────────────────────────
-1:00  Setup on site: clones, logs, test        everyone
       on an empty project.                      ── STOP: 45 min ──

 0:00  TOPIC
       → system 1 starts research                system-1
       → rest: FINISH their own check.sh         other 4
                                                  piece
 0:35  system 1 → brainstorm (3 in parallel)     system-1

 0:48  TEAM CHOOSES an option, out loud          everyone (5 min)

 0:55  system 1 writes into the capsule          system-1
       brief: "we are building X, pieces like so"
                                                  everyone (5 min)

 1:00  >>> SYSTEM 2 STARTS <<<
       each: read capsule → check.sh → code      each solo

       ┌─ loop, non-stop ──────────────────────
       │ code → check.sh → review → MERGE YOURSELF
       │        │
       │        ├ dependencies not on main → WAIT, go back to work
       │        ├ mechanical conflict → resolve it yourself, land
       │        └ interface conflict → RECORD, go back, report
       │
       └─ every 2 h: SYNC, 5 min - the human steps in here

 4 h    >>> FREEZE <<<                           everyone
       lead announces out loud
       each: green test or CUT - nothing in between
                                                  (the human steps
                                                   in a second time)

 3 h    full test on main                        everyone
       demo rehearsal ONCE, against the clock

 2 h    INSTRUCTIONS TEST
       someone who BUILT NOTHING clones the
       repo and runs the quickstart

 1.5h  submission + confirmation                 human

 0:00  STOP
```

**A note on 0:00-0:55:** system 1 works, the others don't wait - they do the `check.sh`
of their pieces. It's the only time anything is wasted, and that is why it is planned.

**A note on the loop:** the machine lands work on its own all night. The human steps in
**twice** - at sync and at freeze. Not at every merge. That is a
conscious compromise: automation takes over execution, the human stays accountable for
what you submit.

---

## Night

- **shifts, not sequence.** Someone sleeps, someone works. Not "everyone until 6".
- **Before sleep: push.** No exceptions. It can't be mechanized - and with machine
  merges there is no human who would notice you didn't do it.
- **Someone stays on their feet, by name.** Not to merge - the machine merges.
  So that someone notices that two pieces have been waiting for three hours.
- **If nobody can stay - say so out loud.** Night sync skipped,
  not "cancelled". Silence is worse than a skipped step.

---

## Thirty seconds of knowledge

1. **Green `check.sh` and green review = land on `main`.** Yourself, without asking.
2. **You wait for dependencies - you wait.** Don't ask, don't block, go back to work.
3. **Conflict in an interface file - don't touch it.** Record it and go back to work.
4. **Push every 30 minutes and before sleep.** Nobody will check except you.
5. **The capsule may be wrong and nothing will detect it.** If someone sees it - that is
   the most important voice in the system. Immediately, not at sync.

---

## What we don't do

- **We don't read `archive/`.** It's an audit of the old version. A curiosity, not instructions.
- **We don't build a junk register, a 77-point checklist or 18 constants.**
- **We don't trust a capsule that is 8 pages long.** If it doesn't fit on an A4 sheet,
  it is not a capsule.
- **We don't leave a cycle in the merge order.** Cycle = the machine waits forever.
- **We don't stop the team.** If your piece is stuck, you do what you can
  and land later.

---

## One sentence

> **System 1 researches for an hour and offers three options, you choose out loud, system 1
> records the choice in one file, five machines build from it in their directories
> and land on `main` themselves, waiting for modules, and you step in twice - at sync
> and at freeze.**
