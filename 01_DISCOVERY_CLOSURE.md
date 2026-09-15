# Discovery Closure — Open Questions, Answers, and Remaining Gaps

**Status:** open register, first answers recorded 2026-09-15
**Authority:** the operator (architecture and scope), the five-person team (operating facts), the
organizers (event rules). No answer in this file is invented by the architect.
**Companion artifacts:** `03_ARCHITECTURE_BLUEPRINT.md` §10 (the questions) ·
`04_DEVELOPMENT_PLAN.md` §3 P0 and §14 · `05_IMPLEMENTATION_CHECKLIST.md` T7-01/T7-02
**Closure mechanism:** T-7 (checklist §2, item T7-01). Every question below closes there, in
writing, with an owner and a source — or is recorded as an assumption with a named fallback. It is
never silently defaulted.

**Claim labels.** `[FACT]` — stated directly by its authority, quoted or paraphrased without
addition. `[INFERENCE]` — reasoned from evidence. `[UNVERIFIED]` — asserted but not yet confirmed by
the authority that owns it. `[UNPROVEN]` — designed, not tested.
**Question status vocabulary.** `ANSWERED` — closed by its authority, with a source and date.
`PARTIAL` — part of the answer is fixed and the rest is still open; both are named. `OPEN` — no
answer from its authority yet; the artifacts already hold the branch that does not depend on it.
**Verification method.** Written 2026-09-15 against the working tree at commit `64e33a5`; the
question rows were read from `03_ARCHITECTURE_BLUEPRINT.md` §10 and the answers were supplied by the
operator in session on 2026-09-15. No organizer material was consulted — none exists in this repo.

---

## 1. The register

| # | Question | Status | Answer | Source and date | Answer authority | Affects | Closes at |
|---|---|---|---|---|---|---|---|
| Q1 | One five-person team, or five separate teams? | **ANSWERED** | **One five-person team**, five machines, research concentrated on one machine. The five-separate-teams branch in the plan is closed. `[FACT — operator, 2026-09-15]` | Operator decision, 2026-09-15 | Operator (scope) | Blueprint §4.2; plan §7, §14; checklist registry | Closed |
| Q2 | Exact dates, duration, and preparation rules? | **PARTIAL** | **Fixed:** duration is **24 hours or more** — the expected shape is a two-day event, with part of the team working overnight. Therefore the short-event branch is closed and the full cadence applies. **Still open:** exact start/stop times, submission deadline, preparation rules, and whether all five machines are present for the second day. `[FACT — operator report of a team contact, 2026-09-15]` `[UNVERIFIED — second-hand; organizer confirmation pending]` | Operator report, 2026-09-15 | Organizers (partial: operator relay) | Blueprint §8.2; plan §10, §11, §14; checklist §10 | T7-01 |
| Q3 | How is success judged, in the organizers' words? | OPEN | — | — | Organizers | Blueprint §3.3 `acceptance_tests` | T7-01 |
| Q4 | Machine OS and hardware across the five? | OPEN | — | — | Team | Blueprint §7 tooling placement | T7-01 |
| Q5 | All machines on one network during the event? | OPEN | — | — | Team / venue | Blueprint §4.5; plan §5 | T7-01 |
| Q6 | Which machine may host long-lived state? | OPEN | — | — | Team | Blueprint §5.1; plan P5.7 | T7-01 |
| Q7 | Which AI accounts, CLIs, and API keys exist per participant? | OPEN | — | — | Team | Blueprint §4.3 | T7-01 |
| Q8 | One repository or several? | OPEN | — | — | Team | Blueprint §4.2 | T7-01 |
| Q9 | Are Actions, Apps, webhooks, and branch protection available? | OPEN | — | — | Organizers / GitHub org | Blueprint §5.3; plan P5.1 | T7-01 |
| Q10 | Who owns final integration and merge? | OPEN | — | — | Team | Blueprint §7; plan P4.6 | T7-01 |
| Q11 | Is the topic revealed before or at the event? | OPEN | — | — | Organizers | Blueprint §3 research runway | T7-01 |
| Q12 | Which external services are permitted? | OPEN | — | — | Organizers | Blueprint §3.4 degraded modes | T7-01 |
| Q13 | What may be captured for the portfolio? | OPEN | — | — | Team + organizers | Blueprint §11 | T7-10 |
| Q14 | Who executes this plan after delivery? | **ANSWERED** | **The five-person team.** The operator designed the architecture and workflow and does not participate in the event or in the solution. `[FACT — operator, 2026-09-15]` | Operator decision, 2026-09-15 | Operator (scope) | Plan §2 owners column, §3–§10 | Closed |

**Why this register is 14 questions and not more.** The engagement's question list includes
operating facts that do not change any artifact (which machines support remote execution, where
observer notifications appear, and similar). Blueprint §10 distilled it to the fourteen that
actually move a section, and named the section for each. The remainder are handled as P2 inventory
items in the checklist, not as architecture blockers. `[FACT — blueprint §10 preamble; plan §5]`

---

## 2. What the answers changed

**Q1 — one team.** The five-separate-teams branch is closed. The live shape: one fleet, one
`REPO`, up to five workstreams, one ownership registry mapping each surface to one of the five
members. Plan §7 and §14 carry the resolution; the ownership registry is written at P0 against the
named members (T7-02), not against teams.

**Q2 — duration ≥ 24 h, with overnight work.** This is the substantive change. The plan was written
for a single continuous block of hours; an overnight event introduces four operating conditions
that the artifacts did not carry. All four are now defined once, in `04_DEVELOPMENT_PLAN.md` §10
(P8 Operation), with failure rows in §11, an acceptance row in §12, checklist items DC-14–DC-16,
validation-ledger row V12, and premortem entry PM-12:

1. **Pause declaration.** A lane whose owner stops — to sleep, to eat, to leave — declares a pause
   with a resume-by time in the event log. The observer's stall rule does not apply to a
   declared-paused lane. Without this, an overnight event produces exactly the failure blueprint
   §5.6 warns about: an observer that alerts on deliberately sleeping owners gets muted within the
   hour, and the team spends the second day believing it is monitored.
2. **Push before offline.** No lane goes offline with unpushed work. The branch is pushed before the
   machine sleeps or the owner disconnects, so a machine that does not come back costs time, not
   work. `[INFERENCE — follows from blueprint §4.5 recovery, which already assumes the branch is
   pushed]`
3. **Shift handover.** On resume, the incoming owner states branch state, open blockers, and the
   next action, and the handover is recorded. Overnight work means the person who resumes is often
   not the person who paused.
4. **Overnight escalation staffing.** The escalation channel has exactly one named awake human for
   the night window. If nobody is awake, the alert set is reduced and the reduction is announced —
   a declared degraded state, not a silent gap (the `E30` visibility rule applied to staffing rather
   than to the observer process).

**What the partial answer leaves standing.** The exact hours, the submission deadline, and the
preparation rules are still organizer facts. Nothing in the artifacts depends on them beyond the
`<freeze-threshold>` and `<submission-buffer>` constants, which are recorded at T7-09 and remain
marked TBD until then.

---

## 3. Remaining gaps and why three of them are load-bearing

**Eleven questions are still open, one is answered in part, and two are answered** (counted by status in the §1 register: 11 rows marked `OPEN`, 1 marked `PARTIAL`, 2 marked `ANSWERED`). Three of the open ones can invalidate a design claim rather than merely
parameterise it, and they should be closed first:

| Question | Why it is load-bearing | What happens if it stays open |
|---|---|---|
| **Q9** — Actions / Apps / webhooks / branch protection | D7's whole claim is that the observer is read-only **because its credential cannot write**. If the org cannot issue a read-scoped credential, the claim is downgraded in writing (pre-committed phrasing: "contractually read-only; no write path observed"). | The observer runs with a stated limitation, or is cut as tier 2. The claim is never softened into "we told it not to write". |
| **Q10** — who owns merge | D6 has no reversal condition: a human merges, always. With no named human, the merge rule has no addressee at integration points. | The first integration point becomes an ad-hoc decision under time pressure — the failure mode D6 exists to prevent. |
| **Q6** — which machine may host long-lived state | The observer and the research mode both run on `S1`; an overnight event requires a machine that stays awake and reachable for 24 h or more. | The observer either cannot run overnight or runs on a machine that sleeps, which converts a designed monitoring function into an intermittent one — visible (E30), but weaker than designed. |

The remaining ten questions parameterise the design without invalidating it: OS and hardware
(Q4), network topology (Q5), per-participant accounts (Q7), repository count (Q8), topic timing
(Q11), permitted services (Q12), portfolio consent (Q13), and the organizer's success criteria (Q3),
plus the still-open half of Q2.

**How each closes.** T7-01 (checklist §2) requires a written answer with an owner per question, or
an assumption with a named fallback — the P0 gate from plan §3. Q13 closes through T7-10, which
requires explicit written consent before any capture. Q8 and Q10 close against the ownership
registry written at T7-02.

---

## 4. Privacy and scope of this file

This register carries question text and answers only. It publishes no participant names, no
organizer material, no repository contents, and no credentials — every answer above is either a
design decision by the operator or, in the case of Q2, a relayed statement with no identifying
detail.

## 5. What this file does not prove

The answers are **design inputs, not validated facts.** An answered question changes what the
artifacts specify; it does not make any mechanism work, and it does not upgrade any validation
state. Nothing in this package is `ENFORCED` — no rehearsal has run and the event has not happened.
Q2's answer is second-hand and remains `[UNVERIFIED]` until an organizer states it directly.