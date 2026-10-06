# DEVPLAN.md - from Friday evening to submission

**Format:** a checklist to tick off, not a document to read. Every step has an
owner and an exit condition you can see in the terminal.

**T0** = topic announcement. **Everything before T0** is setup.

---

## Friday evening (30 min, together)

- [ ] **P1. Run the seed.** `bash seed/bootstrap.sh`
  Owner: everyone on their own laptop.
  Condition: `bash seed/verify.sh` green (10/10), ends with `OK`.

- [ ] **P2. Remote.** `git -C ~/hackathon-solution remote add origin <url>`
  Owner: one person.
  Condition: `git push origin main --dry-run` passes. **Without this, the push every 30 min
  doesn't exist, and the overnight backup doesn't exist.**

- [ ] **P3. Choose system-1.** One person, one laptop, charged.
  Owner: the team, out loud.
  Condition: who it is is written down by name.

- [ ] **P4. Check the merge order on paper - no cycle.**
  Owner: the team, 3 minutes.
  Condition: the default table from `CAPSULE.md` section 5 (w3→1,2; w4→1,2; w5→1,2,3,4)
  is acyclic. **If you change it, you don't go back to sleep until you
  have drawn the graph without a cycle.**

- [ ] **P5. Named people for the night.** Who stays on their feet.
  Owner: the team.
  Condition: written down, and if nobody can - **said out loud**, not
  silently skipped.

**Friday does NOT include:** writing a real `check.sh`, guessing the topic,
a checklist, choosing a language. `check.sh` has `PHASE=0` and that is green.

---

## Saturday 08:50 - before T0

- [ ] **S1. Seed verification on every laptop.** `bash seed/verify.sh`
  Owner: everyone.
  Condition: 10/10 green. Red = we don't start.

- [ ] **S2. Push smoke test.** `git push origin main --dry-run`
  Owner: everyone.
  Condition: passes. Doesn't pass = P2 not done, we don't go further.

- [ ] **S3. Phase 0 `check.sh`.** `cd ~/wN-piece && $EDITOR check.sh`
  Owner: everyone.
  Condition: `./check.sh` exits 1 with a message about phase 0 (that's the goal).
  **We don't fill in sections 1-3** - we don't know yet what we're building.

---

## Saturday T0 - T+0:35 (research)

- [ ] **R1. System-1: 5 sessions in parallel, each to `research/NN-name.md`.**
  Owner: system-1.
  Condition: 5 files in `research/`, each has the sections *Established / Inconsistent /
  Could not establish / Further* (template in `1-RESEARCH.md:91-105`).

- [ ] **R2. The rest: we don't wait.** Everyone finishes phase 0 of `check.sh`.
  Owner: the other four.
  Condition: `./check.sh` in every directory exits 1 (phase 0) - **this is the only
  moment when 1 is a correct result.**

---

## Saturday T+0:35 - T+0:58 (brainstorm and choice)

- [ ] **B1. System-1: 3 sessions (pragmatist, skeptic, outsider), in parallel.**
  Owner: system-1.
  Condition: 3 proposals on the table.

- [ ] **B2. THE TEAM CHOOSES out loud.** 5 minutes.
  Owner: everyone.
  Condition: **one name chosen**. No choice = we don't start. This is the gate.

- [ ] **B3. System-1 fills in the capsule.** `CAPSULE.md`, 6 sections.
  Owner: system-1.
  Condition: section 5 filled in - **five pieces with the "Waits for" column** and the list of
  interface files. Without that column the machine stands still at night and asks a human.

- [ ] **B4. System-1 commits `research/` and `CAPSULE.md` to `main`.**
  Owner: system-1.
  Condition: `git show origin/main:research/01-x.md` works from the agent's worktree.
  See D07 - without this nobody will read the research.

- [ ] **B5. Everyone renames their directories, if the capsule gives names.**
  Owner: everyone.
  Condition: `git worktree move` + `git branch -m` done **before anyone
  writes a line of code**. Commands in `seed/repo-layout.md`.

- [ ] **B6. Everyone fills in sections 1-3 in `check.sh`, `PHASE=1`.**
  Owner: everyone.
  Condition: `./check.sh` exits 0 and **the test catches something** (break the piece, check).

---

## Saturday T+1:00 - FREEZE (non-stop build)

Every agent's loop, without end:

1. `./check.sh` green
2. review in a fresh context (`AGENTS.md` §4.5)
3. are my dependencies on `main`? (`git merge-base --is-ancestor`)
   - no → **wait, go back to work**, check again in 10 min
   - yes → merge to `main` yourself
4. push every 30 min, always before sleep

- [ ] **F1. FREEZE - 4 h before the deadline.** Announced by the lead, out loud.
  Owner: lead.
  Condition: **every piece has a green test or CUT**. Nothing in between.
  CUT = dropped from `main`, not *"we'll finish in the morning"*.

- [ ] **F2. Only demo-blocking defects.** Each with a one-sentence reason in the PR.
  Owner: lead approves.
  Condition: new features rejected without discussion.

---

## After FREEZE

- [ ] **W1. Full test on `main`.** Demo rehearsal ONCE, against the clock.
  Owner: everyone.
  Condition: the demo passes or the specific gap is written down.

- [ ] **W2. Instructions test - 2 h before the deadline.**
  Someone who **BUILT NOTHING** clones the repo and runs the quickstart.
  Owner: one person, not a builder.
  Condition: it runs without asking anyone anything.

- [ ] **W3. Submission - 1.5 h before the deadline.**
  Owner: a human.
  Condition: confirmation saved (link, ID, timestamp).

---

## Contingency plan - "we didn't manage to plant the seeds"

**Symptom:** Saturday 08:50, `bootstrap.sh` doesn't work or VERIFY is red.

**We don't fix the seed. The seed is for us, not for the result.**

1. **Manual minimum (10 min):**
   ```bash
   git clone <repo> ~/hackathon-solution && cd ~/hackathon-solution
   git worktree add ~/w1-piece -b w1
   git worktree add ~/w2-piece -b w2
   git worktree add ~/w3-piece -b w3
   git worktree add ~/w4-piece -b w4
   git worktree add ~/w5-piece -b w5
   ```
2. **Capsule by hand:** copy `seed/templates/CAPSULE.md` to the repo root,
   fill in section 5 out loud. The rest can wait.
3. **`check.sh` by hand:** one file with `set -euo pipefail` and `exit 1`. A red
   test is better than none.
4. **The rule stays:** the merge order must be acyclic before anyone
   starts. Even from memory.

**If there isn't even that:** everyone works in their own directory on their own branch,
merge by hand at the end. You lose the night, but you don't lose the result.

---

## If the topic is different than expected

**This is not a failure. This is the main risk and it has its own section in the capsule (§4).**

1. **Someone says *"wait, that's not what this is about"* → you say so immediately.**
   Not at sync, not after finishing the piece. `AGENTS.md` §4.8 and `3-CHEATSHEET.md:128-129`
   say that this is the most important voice in the system and nobody else will raise it.

2. **Capsule §4 says what we don't know.** If that concern is missing there, add it.
   This is the only place where system-1 can warn you in advance.

3. **Hard rule:** **you don't change the choice after T+1:00.** System-1 stays silent after
   the choice (`1-RESEARCH.md:7`). A doubt about the *choice* is a team decision at
   **sync**, not an individual change of direction. A change of direction by one person
   = five different models of the problem = exactly the failure mode this system is meant
   to eliminate.

4. **The technology doesn't fit:** the capsule didn't foresee it - you write it in
   section 4 of the capsule and **keep going with what there is**. You don't change the language
   or framework without agreement at sync.

5. **A piece in the capsule turns out to be impossible:** you report it at sync, the lead
   changes section 5, you move to the nearest feasible piece.
   **You don't invent a split yourselves** - that breaks "Waits for" and creates a cycle.

---

## What is not here (and why)

- **It doesn't repeat `3-CHEATSHEET.md`.** That is the clock (when), this is the order of work (what, who,
  exit condition). They overlap only at FREEZE and submission, because those are the points
  of contact.
- **There is no review-bot role.** Review is done by an agent in a fresh context, with the
  command from `AGENTS.md` §4.5.
- **There is no model selection.** Everyone uses their own coding agent - OMP, Claude Code,
  Codex. The seed doesn't assume that.
- **There is no programming language.** The choice is made on Saturday, `check.sh` is neutral.
