# T1 - Read with a critic

Agreed with the operator (2026-10-02): **the runtime is heterogeneous.** Every team
member brings their own coding agent (OMP / Claude Code / Codex / whatever),
the operating format is **session first**. `claude` in the corpus is an example, not a requirement.
This session (Atria, Friday evening, `HANDOFF.md`) is the *project's System 1 applied to
the project itself* - the executor of T1-T6, not a participant in Saturday's hackathon.

Read: `README.md`, `AGENTS.md`, `CAPSULE.md`, `1-RESEARCH.md`,
`2-BUILD.md`, `3-CHEATSHEET.md` (1197 lines in total).

---

## Hard contradictions

**S1. What piece 4 waits for - the only example in the system does not match.**
`CAPSULE.md:76` (row 4 in the template) says **Waits for: 1**.
`CAPSULE.md:65` (the comment above the table) and `2-BUILD.md:129` say **w4 waits for 1 and 2**.
The template the team fills in on Saturday shows a value inconsistent with the example
that all the other documents explain. This is the column the machine reads literally.

**S2. What the runtime is.**
`README.md:275` and `AGENTS.md:136-137` say *"OMP is the runtime"*.
`2-BUILD.md:14` repeats the same, and four lines lower (`2-BUILD.md:22`, `:27`)
it gives literal `claude` commands; so do `AGENTS.md:110` (review) and `3-CHEATSHEET.md:16`
(the Friday smoke test). The words say one thing, the command another. Per the agreement with the operator:
the target form is *"your coding agent"* with `claude -p` as the example.

**S3. "Four files" vs its own table.**
`README.md:9` claims *"This one has four files"* with a link `#files`. The section the
link leads to (`README.md:231-242`) lists **five** (AGENTS, CAPSULE,
1-RESEARCH, 2-BUILD, 3-CHEATSHEET), and `README.md:124-125` describes `HANDOFF.md` on top of that.

**S4. "Seven rules" vs eight rules.**
`README.md:253` says *"seven rules from `AGENTS.md` §4"*.
`AGENTS.md` §4 has **eight** - items 1-8 on lines 81, 85, 91, 95, 108, 117,
120, 125. The eighth ("the capsule can be wrong") is, per `3-CHEATSHEET.md:128-129`, one of the five
things you have to know - so it is not something to throw out.

**S5. The line count does not match the files.**
`README.md:248` says *"811 → 1 188 lines"*. The actual sum of the six files is **1197**
(`wc -l`). A difference of 9 - probably counted before a small edit. Immaterial,
but untrue.

---

## Overlapping responsibilities / ambiguities

**S6. Where the agent's cwd is and where `check.sh` lives - three different answers.**
- `AGENTS.md:82` - `cd ~/w<N>-<name>`, then `./<yours>/check.sh` (`AGENTS.md:86`)
- `2-BUILD.md:21` + `:27` - `cd ~/w3-models`, then `./w3/check.sh`
- `CAPSULE.md:93` - `./w1/check.sh` invoked from the repo root

So the working directory is the worktree, and `check.sh` lives in the piece's subdirectory
inside the worktree. Then `AGENTS.md:81-83` *"in your own directory, never outside it"* is
ambiguous: the worktree (`~/w3-models`) or the piece (`~/w3-models/w3/`)? For someone who
does not know git, this is a decision that cannot be made from the document.

**S7. RESEARCH time: the state machine does not describe what 4/5 of the team is doing.**
`AGENTS.md:44` and `:68` (state `RESEARCH`) - *"you ask System 1"*, *"you do not write the
solution's code"*.
`1-RESEARCH.md:5-6` and `3-CHEATSHEET.md:60-61` - in the same 0:00-0:35 window the other
four **finish writing their `check.sh`**. `AGENTS.md` does not list this work in any
state; the only one that mentions it is `PREP` (`AGENTS.md:67`), i.e. Friday.

**S8. `research/` - it does not say which repo it lives in.**
`1-RESEARCH.md:77` tells System 1 to write to `research/NN-name.md`.
`AGENTS.md:167` tells the building agents to read `research/*.md`.
`2-BUILD.md:216` runs `ls research/` at sync.
Agents work in worktrees on separate branches - if `research/` exists only
where System 1 committed it (i.e. on `main`), an agent in a worktree will not see it,
because its branch diverged from that commit. [INFERENCE - not stated explicitly.]

**S9. "One command per piece" vs the example.**
`CAPSULE.md:88` (comment) - *"ONE COMMAND PER PIECE"*.
`CAPSULE.md:93` (example) - a single chain `./w1/check.sh && ./w2/... && echo $?`,
i.e. one command for **everything**; `AGENTS.md §4.3` uses per-piece
(`./<yours>/check.sh`). Two different things described by the same sentence. Minor, but it is
the first command the team will type.

---

## Checked and NOT contradictory

- `AGENTS.md:6` (*"the only exception is described in §2"*) - `AGENTS.md:37` does
  describe the exception (the `STATE` block). Consistent.
- `AGENTS.md:172-173` (*"§4 wins"*) and `2-BUILD.md:9-11` say the same thing in both
  directions - consistent on the precedence of `AGENTS.md`.
- Who edits `STATE`: `AGENTS.md:53-59` and `README.md:215-217` say the same thing.
- `AGENTS.md:170` (*"3-CHEATSHEET never"*) and `3-CHEATSHEET.md:3` (*"for printing"*) - consistent.
- The line counts next to the files in `README.md:233-242` (196, 114, 177, 275, 150) - consistent
  with the actual state.
