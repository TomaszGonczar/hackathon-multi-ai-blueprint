# 07 — Failure and Rehearsal Plan

**Status:** draft v1, 2026-09-14
**Author:** Tomasz Gonczar (architecture and workflow design)
**Companion to:** `03_ARCHITECTURE_BLUEPRINT.md`, `04_DEVELOPMENT_PLAN.md`
**Purpose:** present the project's own gaps as evidence of method — every mechanism carries a
validation state with written rationale and entry criteria to the next state; every gap is a
recorded FINDING, not a confession.

---

## 0. Legend and verification method

**Claim labels** (house style, contract §2):

| Label | Meaning |
|---|---|
| `[FACT]` | Executed or read directly from the named source |
| `[INFERENCE]` | Reasoned from evidence; the reasoning is stated |
| `[UNPROVEN]` | Designed, not tested |

**Validation states** (contract §2; DOE/TRL convention — every level assignment carries a written
rationale and the entry criteria for the next level):

| State | Meaning |
|---|---|
| `DESIGNED` | Specified in an artifact. No check has ever exercised it. |
| `DESIGNED+CHECKED` | Specified and a defined check exists that can exercise it (the check is named). Defined ≠ executed; where the check has never run, the row says so. |
| `ENFORCED` | A mechanism makes the violation impossible, and that mechanism has been observed to block it. |

**Nothing in this project is `ENFORCED`.** No row in this document claims otherwise.

**Verification-method line.** Repository `hackathon-multi-ai-blueprint` inspected at commit
`3ea098f` (drafts of 03 and 04). Files read in full for this artifact:
`03_ARCHITECTURE_BLUEPRINT.md` (§0–§12), `04_DEVELOPMENT_PLAN.md` (§1–§15), the shared
deliverable contract, and the operator's own evidence corpus:
`13_LESSONS/01_FAILURE_CATALOG.md`, `13_LESSONS/03_DECLARATION_PROTOCOL.md`,
`13_LESSONS/27_ORCA_VERTICAL_SLICE_REHEARSAL/05_FAILURES_AND_CORRECTIONS.md`.
**No rehearsal has been run, because the event has not occurred** (October 2026). Nothing in this
document reports an executed test of the hackathon workflow. Where prior executions are cited
(`dSearch`, the Orca vertical-slice rehearsal, the Omega v3 archaeology), they are executions of
*sibling* projects, anchored to their source files, and they are the reason specific rules exist
here — not evidence that this design works.

Diagram cross-references use the node IDs of `06_ARCHITECTURE.mmd` (contract §4): `RM` research
mode, `MP` Mission Package, `OB` observer, `DR` deviation report, `L1`–`L5` lanes, `REPO`/`PR`/`CI`,
`APPR` approval gate, `MERGE` merge owner, `ESC` escalation; edges `E24`–`E30` for observe/fail paths.

Privacy: no participant names anywhere in this file; humans are "human 1"–"human 5". Every example
is synthetic and labelled synthetic.

---

## 1. Validation ledger

One row per mechanism across the whole design. Columns: mechanism | where declared | state |
rationale for the state | entry criteria to the next state | phase or drill that produces it.
Counts: **11 rows — 4 `DESIGNED`, 7 `DESIGNED+CHECKED`, 0 `ENFORCED`.**

| # | Mechanism | Declared at | State | Rationale for this state | Entry criteria to next state | Produced by |
|---|---|---|---|---|---|---|
| V1 | Mission Package freeze (immutable on approval) | Blueprint §3.3; plan §6 P3.5/P3.6 | `DESIGNED+CHECKED` | A specific exercisable check is defined: P3.5 "an edit creates a numbered amendment; silent edit is impossible" and P3.6 "package cannot enter development without a recorded approval". The check has never been executed; the generator does not exist yet. | `ENFORCED` when, in drill 6.2, an attempted silent edit of the frozen `MP` is observed to be rejected or to emit a numbered amendment, with the approval record present. | P3; drill 6.2 |
| V2 | Amendment protocol (numbered, reasoned, approver) | Blueprint §3.3 freeze semantics, §4.2; plan P3.5 | `DESIGNED` | Specified in prose only. No drill exercises the amendment flow end-to-end; 6.2 approves a first version but is not required to amend it. | `DESIGNED+CHECKED` when drill 6.2 (or an injected fault in 6.3) includes a forced amendment step with a defined pass condition; `ENFORCED` when an amendment is observed to be the *only* path that changes a frozen package. | P3; event |
| V3 | One writer per workspace | Blueprint §4.2; plan §7 P4.2, P4.8 | `DESIGNED+CHECKED` | Check defined: P4.8 collision test — "two machines attempt the same surface; the rule prevents it". Never executed; no repo topology exists yet. | `ENFORCED` when, in drill 6.3, the second writer is observed to be blocked (branch protection or ownership registry) or the violation is observed to be caught and reported, with Git state as evidence. | P4; drill 6.3 |
| V4 | Human-only merge (no AI merge authority) | Blueprint §4.2, §7; plan P4.6 | `DESIGNED+CHECKED` | Check defined: P4.6 audit — "no AI merge path exists" (enumerate every credential with merge rights; confirm each is held by a named human; confirm protection blocks direct push). An inspection, not yet run, because no credentials are provisioned. | `ENFORCED` when the audit has been executed *and* a negative test is observed: a merge attempt through a non-human-held credential fails at `MERGE`/`REPO`. | P4 |
| V5 | Observer read-only by credential | Blueprint §5.4, §7, D7; plan §8 P5.1 | `DESIGNED+CHECKED` | Check defined and named load-bearing: P5.1 "a write attempt through this token **fails** — proven by execution". Not executed; the token does not exist. This is the row the whole `OB` claim rests on. | `ENFORCED` when P5.1 has run and the failing write attempt's command and output are recorded verbatim in the rehearsal record. If scoping is unavailable (D7 reversal), the claim is downgraded in writing — never softened into "we told it not to write". | P5 |
| V6 | Observer no-assessment-field schema | Blueprint §5.5, §8.3; plan P5.3 | `DESIGNED` | The schema artifact does not exist yet, so even the trivial inspection ("does any field accept an assessment?") has nothing to run against. The anti-cheerleader mitigation is currently a shape promise. | `DESIGNED+CHECKED` when P5.3 produces the `DR` schema and inspection confirms observation-only fields; `ENFORCED` when a `DR` payload containing assessment-shaped content is observed to be rejected by validation during drill 6.5. | P5; drill 6.5 |
| V7 | Degraded modes (no internet / provider outage / machine loss) | Blueprint §3.4, §4.5; plan P3.7; plan §11 failure matrix | `DESIGNED+CHECKED` | Checks defined: P3.7 offline test ("last frozen package still served") and drill 6.4 (kill one machine; reassign from Git state alone). Neither executed. The machine-loss path is partial: 6.4 kills a lane machine, not `S1` itself. | `ENFORCED` when 6.4 is run and reassignment from `REPO` state alone is observed within the drill timeout, and the P3.7 offline test is observed to serve the frozen `MP`. | P3/P4; drills 6.4, 6.5 |
| V8 | Cut order under time pressure | Blueprint §8.1–8.2 | `DESIGNED` | The cut order is a table. No drill exercises an actual cut; 6.6 measures whether setup fits the window but does not force a P1/P2 amputation. A cut order never executed is a wish list with priorities. | `DESIGNED+CHECKED` when drill 6.6 defines the forced-cut step as a check with a pass condition; `ENFORCED` when a real cut decision is observed under a real timeout, with the record naming what was cut and what was lost. | Drill 6.6; event |
| V9 | Provenance rule (every claim sourced or `[unverified]`) | Blueprint §3.2 rule 1; plan P3.2 | `DESIGNED+CHECKED` | Check defined: P3.2 acceptance — "every output sentence carries a source or `[unverified]`", inspectable on the 6.2 dry-run package. Inspection only; no mechanism yet *prevents* an unsourced sentence. | `ENFORCED` when the package generator or its validator is observed to reject a package containing an unsourced, unlabelled claim. | P3; drill 6.2 |
| V10 | Contradiction preservation (never merged, never resolved by vote) | Blueprint §3.1, §3.2 rule 3; plan P3.3 | `DESIGNED+CHECKED` | Check defined: P3.3 — "deliberately contradictory synthetic sources stay contradictory in output". A falsifiable test with synthetic inputs; never run. | `ENFORCED` when the synthesis step is observed to preserve an injected contradiction through to the frozen `MP` `evidence` field, with the contradiction still visible in the rendered package. | P3; drill 6.2 |
| V11 | Escalation triggers (interface wrong / test unsatisfiable / same-surface claim / drift) | Blueprint §4.4; plan P4.7; diagram `E27`→`ESC` | `DESIGNED` | Triggers are documented and each names the human it summons (P4.7 acceptance), but no drill injects a trigger and observes the summons. A documented trigger that has never fired is prose. | `DESIGNED+CHECKED` when drill 6.3 adds an injected "interface wrong" fault with a defined pass condition; `ENFORCED` when a fired trigger is observed to stop work and reach the named human inside the drill. | P4; drills 6.3, 6.7 |

Reading the ledger: the `DESIGNED+CHECKED` rows are *not* half-proven. Each names a check that
exists on paper and has never run. The gap between this table and an all-`ENFORCED` table is
exactly the P3–P6 workload, and each row says which drill closes it.

---

## 2. Three-state control table

Security-assessment vocabulary applied to every declared rule of the design:

- **declared** — the rule exists in an artifact; nothing evidences or enforces it.
- **declared+evidenced** — a defined check or measured precedent exists and is named; not executed here.
- **enforced+automated-check** — a mechanism blocks violation and has been observed blocking it.
  **No row carries this class. The class is empty.**

**Why this table exists — the operator's own measured precedent.** `[FACT]` The Omega v3
archaeology (`01_FAILURE_CATALOG.md`, RC-1, census table) found **13 of 17 governance mechanisms
with at least one declared field and no production consumer** — HITL gates declared
`enforced_by:"human"` with zero non-test callers; a spend cap whose only reader was a validator;
`validate_tool_call` imported by the dispatcher and never called. The declarations looked like
controls in documentation. The root cause recorded there: "a declaration is cheap and feels like
progress; wiring it is expensive and invisible." Every rule below is currently in exactly RC-1's
shape — declared, consumer not yet built — and this table records that as a set of numbered
FINDINGs *before* merge, instead of discovering it by archaeology months later. A
declared-not-enforced row is a FINDING, not a confession: it is the typed, visible form of the gap
(`03_DECLARATION_PROTOCOL.md`: an absence has no shape; `DECLARED_ONLY` + reason does).

| Rule (contract §1 / blueprint) | Class | Consumer or check | FINDING |
|---|---|---|---|
| Topic-agnostic everywhere (D8) | declared | None. No scan exists for domain-specific assumptions in components or prompts. | **F-1:** a domain-specific component could pass every current review. Check that should exist: the 6.7 adversarial review sweep, with "any domain assumption" on its hunt list. |
| Mission Package is the only cross-boundary artifact (D2) | declared | Readers named (`L1`–`L5` via edges `E4`–`E8`); no boundary mechanism prevents prose from crossing anyway. | **F-2:** nothing blocks a human pasting research prose into a lane chat. Mitigation is cultural until P3 produces the package as the only readable handoff. |
| Human owns merge (D6) | declared+evidenced | Check defined: P4.6 audit + protection config; never run (V4). | **F-3:** until the audit executes, "no AI merge path exists" is `[UNPROVEN]`. |
| One writer per workspace (D5) | declared+evidenced | Check defined: P4.8 collision test; never run (V3). | — (tracked as V3) |
| Facts require sources | declared+evidenced | Check defined: P3.2 inspection; never run (V9). | — (tracked as V9) |
| Agreement is not truth | declared+evidenced | Measured external precedent: `dSearch` — 261 corroborated URLs, 38 correct, precision 0.1456 `[FACT]` (blueprint §3.2 rule 2). Check defined: P3.3 contradiction test (V10). | — (the precedent is why the rule exists; see catch ledger C1) |
| Degrade visibly | declared+evidenced | Checks defined: P3.7 offline test, drills 6.4/6.5 (V7); every failure-matrix row in plan §11 has a named fallback. | — (tracked as V7) |
| Every field names its reader | declared | This artifact package *is* the reader-naming exercise; no gate fails a field with no reader. | **F-4:** every `MP` field (blueprint §3.3) currently has **zero production consumers** — the system is unbuilt. This is RC-1's exact shape, logged deliberately. Entry out: P3.4 generator + schema validator become the first consumers; then each field must name its reader in the package schema or carry a `DECLARED_ONLY`-style reason. |
| Scope cut is explicit | declared | The cut-order table exists (blueprint §8.2); no check exercises a cut (V8). | **F-5:** an unexercised cut order may be uncuttable — e.g. if P0 items turn out to depend on a P1 item. Drill 6.6's forced-cut step is the entry criterion. |
| Instruction is not enforcement (D7) | declared+evidenced | Check defined: P5.1 write-attempt execution test (V5); precedent: `27_ORCA_VERTICAL_SLICE_REHEARSAL` instructed-read-only finding `[FACT]` (catch ledger C2). | — (tracked as V5; the whole rule exists because the precedent was measured) |
| Credentials: per person, least privilege, never in repo or prompt | declared | None. No secret-scan or prompt-hygiene check is defined anywhere in 03/04/05. | **F-6:** a leaked token in a prompt or commit would be caught only by accident. Check that should exist: a secret scan in P2 (credential placement audit) and a pre-commit scan at `REPO`. Owner: architect, before P5. |

Summary: **11 rules — 6 declared+evidenced, 5 declared, 0 enforced+automated-check; 6 open
FINDINGs (F-1 … F-6).** Each FINDING names the check whose absence it records and where that check
should be added. None is scheduled to close before P3–P6; all are scheduled to close *by* P6 at
the latest, which is the point of naming them now.

---

## 3. Premortem record

Method: prospective hindsight, per Gary Klein's premortem ("Performing a Project Premortem,"
*Harvard Business Review*). The exercise: **it is the evening after the October event, and the run
failed.** Write the postmortem now, before the fact, and attach to each reason the mitigation that
already exists and where it lives. Eleven reasons, ordered by how uncomfortable they are, not by
likelihood. None is generic; each names the mechanism it attacks.

| # | The run failed because… | Why credible | Mitigation | Lives at | Remaining exposure |
|---|---|---|---|---|---|
| PM-1 | `S1` died at hour 8 and new research died with it — the team needed one more sourced answer about an unfamiliar domain and no machine could produce it. | Single machine, long-lived process, event-day stress; blueprint itself concedes S1 is "a single point of failure only for *new* research" (§3.4). `[INFERENCE]` | Frozen `MP` replicated in Git; any second machine adopts the package locally (`E29`); provider-outage fallback to manual browser research. | Blueprint §3.4, §4.5; plan §11 rows 2–3; diagram `E29` | Research *state* (mid-investigation context in `RM`) is not replicated. Adoption recovers the package, not the search. A cold restart of new research is the designed floor. |
| PM-2 | `OB` spent the event defending its own package — deviations were reported late, framed small, or not at all. | The same machine authored `MP` and measures against it; blueprint §8.3 names this cheerleader risk outright. `[INFERENCE]` | `DR` schema has observation fields only — no field in which to argue the plan is fine; assessment belongs to humans (`ESC`). | Blueprint §5.5, §8.3; plan P5.3; ledger V6 | Schema shape cannot stop **selection bias**: an observer that under-reports which deviations it looks for is schema-clean and still a cheerleader. No check exists against omission (see §7, row 3). |
| PM-3 | Coordination overhead ate the clock: package approval consumed three of twelve hours, and the cut order was invoked so late it saved nothing. | Blueprint §4.6 states the honest limitation: coordination is "charged against the same clock as building". Five people, hours not days (blueprint §2). `[INFERENCE]` | Explicit cut order with priorities P0/P1/P2; observer is tier-2 degradable — monitoring is never load-bearing; 6.6 time-box drill measures setup against the real window. | Blueprint §8.2, §5.7; plan §9 step 6.6 | The cut order has never been exercised (V8, F-5). Under real pressure the team may discover a P0 item silently depends on a P1 item. |
| PM-4 | The package was frozen at hour 2 against a misread topic, and the team built the wrong thing for six hours. | The topic is unknown by definition; `APPR` is a human gate on a same-day read of an unfamiliar domain. `[INFERENCE]` | Amendment protocol: any change is a numbered amendment with reason and approver; escalation trigger "plan and reality have diverged"; `objective` field must be falsifiable, which makes a misread at least statable. | Blueprint §3.3, §4.4; plan P3.5 | The deepest exposure in the design: `OB`'s baseline **is the thing that may be wrong**. Deviation-vs-package cannot detect a package that deviates from reality. Detection rests entirely on humans noticing — which is why the escalation trigger names a human, not a threshold. |
| PM-5 | Five people showed up who had never read the blueprint, and the process survived exactly zero of them. | Discovery constraint: "whatever is prepared must survive a participant who has never read the blueprint" (blueprint §2). Rehearsal attendance is voluntary. `[INFERENCE]` | Drill 6.1 pass condition is per-participant recall of ownership and write scope, unaided; the implementation checklist (05) is written to be executable without the blueprint; handoff acceptance: "a new reader answers blueprint §12 unaided" (plan §12). | Plan §9 step 6.1, §12; blueprint §12; artifact 05 | 6.1 tests the people who *attend* the rehearsal. For a skipper, the only mitigation is that the P0 artifacts are short enough to be read cold at T+0 — itself `[UNPROVEN]`. |
| PM-6 | The observer alerted constantly, was muted within the hour, and the team flew blind while believing it was monitored. | Blueprint §5.6 names this as "the failure mode that kills monitoring systems". `[INFERENCE]` | Alert set is bounded by rule: deviation, CI failure, conflict, stall — everything else pull, not push; observer status is stated aloud at startup (plan P7), so mute is a declared state, not a silent one. | Blueprint §5.6; plan P5.4, P7; drill 6.5 | The bound is untested. "Stall" needs a window, and the window value does not exist yet — an unstipulated window means either noise or silence. Owner: architect, at P5.2. |
| PM-7 | The read-only credential turned out to be unscopable, and the decision surfaced at T-1 instead of T-3. | GitHub org capabilities are an open question (Q9); fine-grained scoping depends on org settings the team does not control. `[INFERENCE]` | P5 is scheduled T-3→T-1 precisely so this surfaces early; D7's reversal condition is pre-committed: "credential scoping unavailable — then state the limit"; downgrade language agreed in advance: "contractually read-only; no write path observed". | Blueprint §9 D7; plan §8 P5.1; ledger V5 | If unscoped, there is no mechanical barrier between `OB` and `REPO` writes — only the credential's absence from any write path and the honesty of the claim. |
| PM-8 | An interface frozen in `MP` was wrong; two lanes met at integration and the merge cost more than the feature. | Interfaces are frozen before parallel work begins (plan P4.4) against an unknown topic; blueprint §1.1 lists collision as a top failure mode. `[INFERENCE]` | Escalation trigger "an interface in the package is found wrong" stops work and summons a human (`E27`→`ESC`); `integration_order` sequences meetings; human merge at defined points only. | Blueprint §4.2, §4.4; plan P4.4–P4.7; diagram `E27`, `E18` | Interface correctness is not checkable before the topic exists. The trigger shortens the distance to detection; it cannot prevent the first wrong freeze. |
| PM-9 | Q1 and Q2 were never answered, and the plan silently kept the wrong shape — five coordinated teams were run as one five-workstream fleet (or the reverse), and the ownership registry described a team that did not exist. | Both questions are open at authoring time; plan §14 concedes they "change this document structurally". `[FACT — the questions are open]` | Hard gate: "no phase beyond P0 starts before these two are answered" (plan §14); P0 gate requires every question answered in writing with an owner, or recorded as an assumption with a fallback — never silently defaulted (plan §3). | Plan §3, §14; blueprint §10 | The gate is procedural. Nothing mechanically prevents P1 work from starting; the enforcement is the architect refusing, which is discipline, not a control (see F-class honesty in §2). |
| PM-10 | The rehearsal was skipped or ran as theater — everything passed, nothing was learned — and the team arrived at T+0 with an unrehearsed process. | Prep windows compress; a rehearsal that inconveniences nobody tests nothing. The plan already predicts this: "a workflow drill that has never failed has proven nothing" (plan §9). `[FACT — the rationale is quoted from the plan]` | The found-nothing gate: a rehearsal that found nothing is treated as insufficient, not as a pass; 6.7 requires a *named skeptic* whose job is to find contradictions; every drill in §6 below has a timeout and a failure-recording instruction. | Plan §9 gate; §6 of this document | The gate can be satisfied cosmetatically — a trivial "found" contradiction closes it. The defense is that drill failures must ship evidence artifacts (§6), which are inspectable. |
| PM-11 | These six artifacts disagreed with each other — a node ID, a phase name, a field name — and the team followed the stale one. | The package was authored by distributed workers in parallel waves under a shared contract (contract §5). Cross-artifact drift is this architecture's *own* predicted failure mode, applied to itself. `[FACT — the authoring mode]` `[INFERENCE — the risk]` | Interfaces frozen before parallel work (contract §4 node/edge inventory; same pattern as plan P4.4); coordinator agreement sweep at wave 4 before commit; drill 6.7 re-hunts contradictions across all artifacts; 6.8 resolves them in the artifacts, "not in someone's head". | Contract §4–§5; plan §9 steps 6.7–6.8; §9 of this document | The sweep is manual and runs once. Drift introduced *after* the sweep (e.g. by event-day amendments to the artifacts themselves) has no check. |

Premortem discipline note: PM-1 through PM-11 are reasons *this design* fails, not reasons
hackathons fail in general. Each names the specific mechanism that breaks and the specific artifact
line that was supposed to hold it.

---

## 4. Catch ledger

What the design process already caught, in aerospace escape-distance framing: **where the defect
should have been caught, where it actually was caught, and how far it traveled before anyone
stopped it.** Escape distance is the cost measure — a defect caught at design costs a sentence;
caught in production, an archaeology round.

| # | Catch | Should have been caught at | Actually caught at | Escape distance | What it produced here | Label and anchor |
|---|---|---|---|---|---|---|
| C1 | **Agreement-as-truth.** Corroboration by multiple sources was treated as verification. Measured: 261 corroborated URLs, 38 correct — precision **0.1456**. | Design of the corroboration feature, before shipping it as the product's differentiator. | Post-hoc precision measurement in the sibling project `dSearch`, after the claim was in production. | Shipped product → measurement. Full escape. | Blueprint §3.2 rule 2 and the contract invariant "agreement is not truth"; P3.3 contradiction-preservation test (V10); the rejected "semantic GitHub judge" alternative (blueprint §9) cites this measurement by name. | `[FACT]` blueprint §3.2; contract §1 |
| C2 | **Instructed read-only is not enforced read-only.** A reviewer role was told to be read-only; no capability fence existed — "no `readOnly` enforcement field exists in the receipt". | Design of the reviewer role: the receipt schema was the moment to require an enforcement field. | The vertical-slice rehearsal's own findings pass — one rehearsal of escape, caught before the claim reached a portfolio. | Spec → rehearsal. One phase. | Blueprint §7: enforcement by credential, not instruction; D7 with a pre-committed downgrade; P5.1 execution test ("a write attempt through this token fails — proven by execution"); ledger V5. | `[FACT]` `27_ORCA_VERTICAL_SLICE_REHEARSAL/05_FAILURES_AND_CORRECTIONS.md`, finding row 4 ("Reviewer was instructed read-only but not capability-fenced") |
| C3 | **Declaration without consumer.** 13 of 17 governance mechanisms in Omega v3 had at least one declared field with no production reader; documentation cited them as controls. | PR merge time — one declaration-protocol header line per field (`_enforced_by` / `_status` / `_skip_reason`), ~30 seconds each. | Archaeology, months later, at commit `3ceb7be` — the most expensive possible catch. | Merge → shipped system → archaeology. Maximum escape. | The three-state control table (§2 of this document) and its 6 FINDINGs; the contract invariant "every field names its reader"; F-4 logging the Mission Package's current zero-consumer state *as the same shape, caught before merge this time*. | `[FACT]` `01_FAILURE_CATALOG.md` RC-1 (census table); `03_DECLARATION_PROTOCOL.md` |
| C4 | **Implicit evidence rules.** The sibling rehearsal's preflight returned NO-GO before the first build step because launch and evidence rules were implicit in the spec. | Spec authoring: evidence fields (model, effort, SHA, receipt) should have been explicit on the page. | The rehearsal's own preflight gate — caught before any execution wasted effort. | Spec → preflight. Zero escape into execution. | Plan §3 makes P0 a real phase with exactly this rationale quoted ("the sibling rehearsal … failed its own preflight (NO-GO) precisely because launch and evidence rules were implicit"); every drill in §6 below ships a defined evidence artifact. | `[FACT]` `27_ORCA_VERTICAL_SLICE_REHEARSAL/05_FAILURES_AND_CORRECTIONS.md`, finding row 2; plan §3 |
| C5 | **Worktree as security containment.** Git worktrees were assumed to sandbox a worker. They do not. | Containment design, before it was listed as a control. | The rehearsal — "explicitly falsified in rehearsal: it is not a sandbox". | Design → rehearsal. One phase. | Reuse ledger marks it **DROP** (plan §4); worktree isolation survives only as cooperative concurrency (REUSE), never as a security claim; no artifact here claims containment. | `[FACT]` plan §4 reuse-ledger row "Worktree as *security* containment — DROP" |
| C6 | **Cross-artifact drift in distributed authoring.** Six artifacts written by parallel workers under one contract will drift at the seams — node IDs, phase names, counts. | Now: at design of the authoring process itself, before the workers wrote anything. | Pre-emptively, by construction: the contract froze the shared inventory (node IDs, field names, phase IDs, validation vocabulary) *before* the parallel wave, and scheduled the agreement sweep after it. | Zero escape **if the sweep runs**. The catch is only as real as wave 4. | Contract §4 frozen inventory; contract §5 one-writer-per-file map; sweep owned by the coordinator; drill 6.7 re-hunts drift independently; PM-11 records the residual. | `[INFERENCE]` (risk) + `[FACT]` (the authoring mode and the scheduled sweep, contract §5) |

Reading the ledger: C1 and C3 escaped fully and were paid for with archaeology. C2, C4, C5 were
caught one phase downstream. C6 is the attempt to catch at zero distance — design-time — and §9
records honestly that its check (the sweep) is manual and unexecuted as of this writing.

---

## 5. Decision log with missing-data entries

Every decision from blueprint §9 D1–D8, with the data that was **absent** when it was made, the
assumption that stands in for the data (GitLab postmortem convention: name the assumption that
turned out to be wrong — pre-naming it makes the wrong-turn cheap to spot), what data would change
the call, and where that data will come from. All 14 open questions (blueprint §10, plan §14) were
open at authoring time; the two structural ones (Q1, Q2) are called out under the decisions they
feed.

| # | Decision | Missing data at decision time | Assumption made in its absence (the thing that is wrong if the decision is wrong) | What data would change the call | Reversal condition (blueprint §9) | Where the data comes from |
|---|---|---|---|---|---|---|
| D1 | Observer is a role on `S1`, not a separate system | Any measurement of `S1` sustaining `RM` + `OB` concurrently under event load; Q6 (which machine may host long-lived state) unanswered. | "One machine can run research and observation concurrently for the event duration without either starving." | A load measurement showing research latency degrading while `OB` polls; or Q6 answered "no machine qualifies". | Research load saturates S1 during the event. | P3/P5 setup measurements; drills 6.2 + 6.5 run concurrently, timed. |
| D2 | Mission Package is the only cross-boundary artifact | What context builders actually need mid-build — unknowable before the topic exists; no prior event data for this team. | "The ten package fields carry everything the fleet needs; any prose crossing the boundary adds drift exceeding its value." | Repeated, specific fleet requests for context the package cannot carry (not preference — demonstrated need, logged per plan §4's ledger discipline). | Fleet needs richer context than the package carries. | Drill 6.2 (second-person readability gate) and the event itself. |
| D3 | Package is frozen and amended, never silently edited | Expected amendment rate — zero historical data on how often a same-day frozen plan survives contact with an unknown topic. | "Amendments will be rare enough that the freeze carries meaning; the numbered-amendment overhead is affordable per event." | Amendment count per hour during rehearsal or event exceeding the point where the team stops reading amendment numbers. | Amendments become so frequent the freeze loses meaning. | Event log; the amendment records themselves are the counter. |
| D4 | Research and observe run concurrently | Same capacity data as D1; plus no measurement of the switch's hidden cost. | "Silently losing research ability at build-start is worse than the concurrency cost — the team needs `RM` most at hour 8 in an unfamiliar domain." | Observed resource starvation of either mode on the actual `S1` hardware. | Machine cannot sustain both. | Drills 6.2/6.5 with both modes live. |
| D5 | One writer per workspace | Q1 (one team or five separate teams) unanswered; the dependency graph's shape is topic-dependent and the topic is unknown. | "Workstreams will share surfaces often enough that collision cost exceeds parallelism gain; ownership boundaries will be statable per surface." | A frozen `dependency_graph` in which workstreams are genuinely disjoint at the surface level. | Workstreams prove genuinely independent. | P0 (Q1 answer) + the `MP` `dependency_graph` field at 6.2. |
| D6 | Human owns every merge | No data was missing for the value decision (it is not reversible — "Never"). The **operational** assumption is the exposed part: | "The named merge owner is available at every integration point for the event duration." | Nothing reverses D6. If the owner becomes a bottleneck or unreachable, the decision holds and the fallback activates: a named alternate from P0.7. | Never. | P0.7 names the human; the event tests availability; integration_order sequences the demand. |
| D7 | Observer read-only by credential | Q9 unanswered: whether GitHub Apps / fine-grained tokens / branch protection are available in the team's org at all. | "A write-incapable credential can be provisioned for `OB` in the team's actual GitHub org." | A P0.6 finding that the org cannot issue read-scoped tokens → the claim is downgraded in writing, the observer either runs with a stated limitation or is cut (tier 2 — cutting is sanctioned). | Credential scoping unavailable — then state the limit. | P0.6 (org capability check) + P5.1 (execution test). |
| D8 | Topic-agnostic everywhere | The topic itself — missing by definition until T+0, and no amount of preparation can supply it. | "Process structure transfers across domains; nothing in the design encodes a domain bet." This is the design premise, not a finding. | Nothing obtainable in advance. If the October topic reveals a structural bet (e.g. a field in `MP` that only makes sense for one domain class), it is an F-1-class defect found late. | Never. | None possible pre-event; 6.7 adversarial review hunts domain assumptions as the last available check. |

**Open questions as standing missing-data entries.** Blueprint §10 lists Q1–Q14; the blueprint's
claim that "the architecture is written to survive either answer, and the affected section is
named" is itself `[UNPROVEN]` until P0 closes them — surviving-either-answer is a property that can
only be demonstrated by the answers arriving. The affected-section mapping is already recorded
(blueprint §10 table) and is not repeated here. Plan §14 elevates two to structural:

- **Q1 (one team or five?)** — feeds D5 and the ownership registry (P4.2). Wrong assumption: that
  the fleet shape is knowable before the answer. It is not; the registry is deliberately written
  *after* P0.
- **Q2 (exact duration and prep rules)** — feeds the cut order (blueprint §8.2) and every drill
  timeout in §6 below. Wrong assumption: that the timeouts chosen here transfer to the real window.
  Drill 6.6 is the recalibration step; until it runs, the §6 timeouts are `[INFERENCE]` from
  "hours, not days".

Per plan §3's gate: any question still unanswered at the end of P0 is recorded as an assumption
with a stated fallback — never silently defaulted. This section is where those records land.

---

## 6. Rehearsal plan — drills 6.1 through 6.8

Plan §9 defines eight rehearsal steps. Expanded here into executable drill definitions: trigger,
procedure, observable pass condition, evidence artifact, timeout, and what to record on failure.

**The gate, restated and binding:** *a rehearsal that found nothing is treated as insufficient, not
as a pass* (plan §9). A drill whose record contains zero findings is re-run or re-scoped — the
rationale is the plan's own: "a workflow drill that has never failed has proven nothing." Timeouts
below are `[INFERENCE]` from the Q2-unanswered prep window (see §5); drill 6.6 recalibrates them
against the real window.

### 6.1 Tabletop walkthrough

- **Trigger:** start of P6 (T-2), whole team present, no tooling running.
- **Procedure:** the architect reads a synthetic topic statement (labelled synthetic). Each of the
  five participants states, unaided by any document: (a) what they own, (b) which branch/worktree
  they may write, (c) what artifact crosses from research to them, (d) who they escalate to and on
  what trigger, (e) what they do if `S1` is lost.
- **Pass condition (observable):** every participant states all five items correctly, without
  opening a file. One miss = fail.
- **Evidence artifact:** a dated sheet with five rows (one per participant, role-pseudonymised —
  no names), each holding the five stated answers.
- **Timeout:** 60 minutes.
- **Record on failure:** which of the five items the participant could not state. Each miss is a
  defect in artifact 05 (the checklist) or in the one-page summary — fix the document, not the
  person; log a §7 row.

### 6.2 Synthetic topic dry run

- **Trigger:** P3 acceptance met (research machine produces a validating package).
- **Procedure:** feed a synthetic topic (labelled synthetic) to `RM`; produce `MP` v1; run human
  approval at `APPR` with a recorded approval; then attempt (i) a silent edit of the frozen
  package and (ii) a proper numbered amendment. A second person — not the author — reads the
  package and states what they would build first.
- **Pass condition (observable):** package validates against schema with all ten fields present;
  approval record exists; the silent edit is rejected or converted to a numbered amendment; the
  second person acts without asking the author anything (plan §6 gate).
- **Evidence artifact:** package v1 file, the approval record, the amendment record (or the
  rejection output of the silent-edit attempt), and the second reader's written "first task"
  statement.
- **Timeout:** 120 minutes.
- **Record on failure:** which field was missing/unusable, whether the silent edit succeeded (a V1
  `ENFORCED` blocker), and every question the second reader had to ask — each question is a
  package-schema defect. Log a §7 row.

### 6.3 Two-machine collision drill

- **Trigger:** P4 acceptance met (repo topology, ownership registry, merge procedure exist).
- **Procedure:** humans 1 and 2 both attempt a write to the same declared surface on their own
  machines (`L1`, `L2`). Observe which layer stops the second writer: ownership registry, branch
  protection, or nothing. Then inject a synthetic "interface wrong" fault into a lane and observe
  whether the escalation trigger (`E27`) reaches the named human via `ESC`.
- **Pass condition (observable):** the second writer is blocked mechanically, or the violation is
  detected and reported before merge; the injected trigger summons the named human inside the
  drill.
- **Evidence artifact:** Git state showing the blocked/second write attempt (branch log or
  protection rejection output), plus a timestamped escalation record: fault injected → human
  reached.
- **Timeout:** 30 minutes.
- **Record on failure:** which layer missed — registry, protection, observer, or the human's
  response — and whether the miss was silent. A silent miss is worse than a slow catch; say which
  it was. Log a §7 row (this drill feeds V3, V11 toward `ENFORCED`).

### 6.4 Disconnection drill

- **Trigger:** after 6.3 passes, mid-task, unannounced to the affected participant.
- **Procedure:** kill one lane machine (power off or network-drop) while its owner is mid-task.
  The team reassigns the work using `REPO` state alone — no access to the dead machine, no oral
  transfer from its owner.
- **Pass condition (observable):** reassignment completes and the new owner pushes a commit within
  the timeout, using only what Git held.
- **Evidence artifact:** three timestamps — kill time, reassignment decision time, first commit
  from the new owner — plus the commit SHA.
- **Timeout:** 30 minutes.
- **Record on failure:** every piece of state that existed **only** on the dead machine (unpushed
  commits, local notes, environment config). Each item is a replication gap with a named fix
  (push cadence, environment inventory row in P2). Log a §7 row (feeds V7).

### 6.5 Observer-off drill

- **Trigger:** after P5 acceptance (observer running with its scoped credential).
- **Procedure:** disable `OB` without announcing it. Wait. Then run the P7 startup ritual's
  observer-status step and confirm the outage becomes a stated state. Verify the team keeps
  building throughout and that the absence of `DR` reports is *noticed*, not silently absorbed.
- **Pass condition (observable):** building never pauses due to the outage; the outage is stated
  aloud (or in channel) by a human within the drill window — "observer down is itself visible, not
  silently absent" (plan P5.6; diagram `E30`).
- **Evidence artifact:** drill log with two timestamps: disable time and first human notice of the
  missing reports.
- **Timeout:** 30 minutes of observed operation.
- **Record on failure:** whether anyone noticed, and how late. If nobody noticed within the
  timeout, record the honest finding: the observer's absence is currently invisible, and P5.6 is
  `DESIGNED`, not `DESIGNED+CHECKED`, in fact as well as on paper. Log a §7 row.

### 6.6 Time-box check

- **Trigger:** near the end of the preparation window (T-1), with Q2 answered.
- **Procedure:** time the full P7 startup sequence (machine health → credentials → repo reachable
  → roles announced → observer status) and the package-approval path end-to-end. Compare the sum
  against the real event window. If the total does not fit with margin, **execute a real cut**
  against blueprint §8.2 — actually disable the cut item, do not just nominate it — and re-time.
- **Pass condition (observable):** startup + approval fit inside the stated window with margin, or
  a cut was executed and the post-cut total fits. The cut record names what was cut and what was
  lost, in the §8.2 table's own vocabulary.
- **Evidence artifact:** a timing table (per-step start/end, wall-clock) and, if triggered, the cut
  record.
- **Timeout:** one preparation session; the drill measures the timeout rather than owning one.
- **Record on failure:** which step overran and by how much. An overrunning P0 step is an
  architecture defect (the process is too heavy for the window — blueprint §8.1's honest risk
  becoming true); an overrunning P1/P2 step is a cut-order candidate. Recalibrate every §6
  timeout in this document against the measured window. Log a §7 row (feeds V8, F-5).

### 6.7 Adversarial review

- **Trigger:** after drills 6.1–6.6 have records.
- **Procedure:** the architect plus one **named skeptic** (a participant instructed that finding
  contradictions *is* the task, and that a clean report is a failed review) read 03/04/05/06/07/08
  against each other. Hunt list: node IDs vs diagram (`06_ARCHITECTURE.mmd`), phase names (P0–P9),
  decision IDs (D1–D8), Mission Package field names, counts that appear in more than one artifact,
  validation states that disagree with evidence, any domain-specific assumption (F-1).
- **Pass condition (observable):** at least one contradiction found and recorded. Zero findings =
  insufficient (the §6 gate); re-run with a different skeptic or a narrower hunt list.
- **Evidence artifact:** a numbered contradiction list: claim A (file, §N), claim B (file, §N),
  why they cannot both hold.
- **Timeout:** 90 minutes.
- **Record on failure:** if the skeptic finds nothing, record that the review is unresolved — do
  not mark it passed. An unreviewed package goes to the event carrying PM-11. Log a §7 row.

### 6.8 Correction pass

- **Trigger:** any finding from 6.1–6.7.
- **Procedure:** resolve every recorded contradiction and drill failure **in the artifacts** —
  plan §9's own words: "not in someone's head". Each correction names the file, the section, and
  the change; corrections to shared interfaces (node IDs, field names) go through the coordinator,
  per the one-writer rule this package was authored under.
- **Pass condition (observable):** zero open findings; every finding closed by a diff in a named
  file. A finding closed by discussion is not closed.
- **Evidence artifact:** a correction log: finding → file:§ → resolution → who approved it.
- **Timeout:** 60 minutes.
- **Record on failure:** any finding that could not be resolved becomes a **remaining limit** with
  a named owner and a decision date — it is copied verbatim into §7's Remaining-limit column and
  must appear in the event-day risk briefing. An unresolved finding that is not carried forward is
  the RC-4 additive-trap shape: the concept survives because deleting it from every surface is
  tedious (`01_FAILURE_CATALOG.md` RC-4).

**Rehearsal completion criterion** (plan §15): the plan is complete not when documents exist but
when P6 passes *or its failures are recorded as corrections*. This section exists to make the
second branch as executable as the first.

---

## 7. Failures and corrections

Table shape per `27_ORCA_VERTICAL_SLICE_REHEARSAL/05_FAILURES_AND_CORRECTIONS.md`: Finding |
Evidence | Correction | Remaining limit. Seeded with the known remaining limits as of commit
`3ea098f`; drill findings append rows, they do not replace these.

| Finding | Evidence | Correction | Remaining limit |
|---|---|---|---|
| No mechanism in this design has ever been exercised | No rehearsal has run; the event has not occurred (blueprint §8.4: "the blueprint therefore makes no claim that any mechanism is *proven*") | Drills 6.1–6.8 defined in §6 with pass conditions, evidence artifacts, timeouts, and failure-recording instructions; the validation ledger (§1) names which drill upgrades which row | Drills test the preparation window, not event pressure. The event is single-shot: there is no second attempt in which a corrected mechanism gets exercised under real load. |
| "Observer is read-only" currently describes a credential that does not exist | Blueprint §7 requires enforcement by credential; P5.1 defines the execution test; no token has been provisioned; Q9 (org capabilities) is open | P5.1 scheduled T-3→T-1 as the load-bearing test; downgrade language pre-committed: "contractually read-only; no write path observed" — never "security-enforced" (contract §2 rule 7) | If credential scoping proves unavailable (D7 reversal), no mechanical barrier exists between `OB` and writes to `REPO`. The claim shrinks to instruction plus absence-of-write-path, stated as such. |
| The anti-cheerleader mitigation is schema shape only | Blueprint §8.3 removes any assessment field from `DR`; no check exists against biased *selection* of what `OB` looks at | Drill 6.5 observes report content against the drill's known injected deviations; P5.3 schema inspection is V6's entry criterion | An observer that under-reports by omission is schema-clean. Selection bias in what gets watched has no detection mechanism in this design; it is mitigated only by humans asking "where are we?" on demand (P5.5) and comparing against raw Git state. |
| Every Mission Package field has zero production consumers | The system is unbuilt; fields are declared in blueprint §3.3; this is RC-1's exact shape (`01_FAILURE_CATALOG.md`: 13 of 17 mechanisms declared without consumer) | Logged as F-4 before merge rather than found by archaeology; contract invariant "every field names its reader"; P3.4 generator + schema validator are the scheduled first consumers | Until P3 runs, the only consumer of the package design is this artifact package itself — documentation reading documentation. The declaration protocol's statuses (`ENFORCED` / `DECLARED_ONLY` / `RESERVED`) should be applied to the schema when it is written; that application does not exist yet. |
| The cut order has never been executed | Blueprint §8.2 is a table; no drill forces an actual cut (V8, F-5) | Drill 6.6 now includes a forced-cut step: if the time-box overruns, a P1/P2 item is actually disabled and the post-cut total re-timed | Event-day cutting happens under a load no rehearsal can simulate, and PM-3's exposure stands: a P0 item may prove to depend on a cut P1 item. |
| This package was authored by distributed workers under a frozen contract | Contract §5 ownership map: six files, six owners, waves 1–4; cross-artifact drift is the architecture's own predicted failure mode applied to itself (PM-11) | Coordinator agreement sweep at wave 4 before commit; drill 6.7 independently re-hunts contradictions across all six artifacts; 6.8 resolves them in the artifacts | The sweep is manual and runs once. Post-sweep drift — including event-day amendments to these artifacts — has no check. |
| Every §6 drill timeout is an estimate | Q2 (exact duration) is open at authoring time; timeouts were inferred from "hours, not days" (blueprint §2) | Drill 6.6 recalibrates all §6 timeouts against the measured window and records the calibration | Until 6.6 runs, a drill could be mis-timed in either direction: too loose (proves nothing about event speed) or too tight (fails mechanisms that would have held). |

The correction pattern is the sibling rehearsal's, kept deliberately: **narrow the claim to the
evidence actually observed.** No prompt instruction, no schema shape, no green drill, and no
document is promoted into a security or semantic guarantee.

---

## 8. Positive patterns

What this design got right, with evidence (house-style requirement, contract §2 rule 6). These are
patterns to preserve deliberately — the failure catalog's own lesson is that the defects above were
*findable* because the honest structures existed.

| Pattern | Evidence | Why it matters |
|---|---|---|
| Validation states with entry criteria, borrowed from DOE/TRL | Contract §2; §1 of this document: all 11 rows carry rationale + next-state criteria | "Unrehearsed" reads as method, not apology. A reader can see exactly what observation would upgrade any claim. |
| The reuse ledger drops falsified things instead of re-listing them | Plan §4: "Worktree as *security* containment — **DROP** — explicitly falsified in rehearsal"; heartbeat protocol "DROP for v1 — cost without demonstrated need" | A ledger that only says REUSE is marketing. The DROP rows are why the REUSE rows are credible. |
| The found-nothing gate | Plan §9: "A rehearsal that found nothing is treated as insufficient, not as a pass"; carried into §6 here and into 6.7's skeptic instruction | Kills rehearsal-as-theater at the rule level, before anyone is tempted. Mirrors the sibling lesson: "a defined gate you don't run is a decision you didn't make." |
| Cut order shipped as a deliverable, not an admission | Blueprint §8.1: the cut table "is part of the deliverable, not an admission" | Under time pressure, the decision is already made and written. The team executes a cut instead of debating one. |
| Every decision carries a named reversal condition, including two "Never"s | Blueprint §9 D1–D8; D6 and D8 reverse "Never" — and §5 of this document still names D6's exposed operational assumption | A decision without a reversal condition is a belief. The two "Never"s are the only places this design takes a stand without data, and both are marked as such. |
| Every failure-matrix row has a named fallback | Plan §11: nine failures, each with detection, response, and fallback columns filled — including "weaker evidence, stated as such" for CI loss | "Degrade visibly" is structural, not aspirational: there is no row where the fallback cell is empty. |
| Downgrade language pre-committed before the test that needs it | D7: "then state the limit"; P5.1: "never softened into 'we told it not to write'"; contract §2 rule 7 | The wording of an honest limitation is hardest to choose *after* the limitation is found. Choosing it in advance removes the incentive to soften. |
| Anti-RC-1 invariant at contract level | Contract §1: "Every field names its reader. No declared-but-unconsumed fields." | The operator's most expensive measured lesson (C3) became a design invariant of the next project instead of a warning in a postmortem nobody reads. |
| Premortem executed before the event, not after | §3 of this document: 11 named failure reasons with mitigations and locations, written while the failure is still hypothetical | Prospective hindsight is cheap now and unobtainable in October. PM-4's "baseline may be the wrong thing" is visible as a design exposure now; post-event it would only be a regret. |

---

## 9. Meta-lessons — producing this package

Lessons about the authoring process itself, which is the same architecture this package describes,
applied to itself.

1. **These artifacts were authored by distributed workers under a frozen contract.** Six files,
   six single-writer owners, three waves, a coordinator holding merge and commit authority
   (contract §5). That is `MP`-freeze, one-writer-per-workspace, human-only-merge, and
   numbered-amendment — run on documents instead of code, with the shared contract playing the
   Mission Package role. `[FACT]`
2. **The risk this authoring mode carries is cross-artifact drift** — the failure mode the
   architecture predicts for the fleet, occurring in the artifacts that describe it. Node IDs,
   phase numbers, field names, and counts exist in more than one file; workers cannot see each
   other's files while writing. `[INFERENCE]`
3. **The mitigation is the agreement sweep** — the coordinator's wave-4 pass before commit
   (contract §5), plus drill 6.7 as an independent re-check at rehearsal time. The sweep is
   manual, runs once, and has not run as of this writing; PM-11 and §7 record that as a remaining
   limit rather than claiming it closed. `[FACT]`
4. **Freezing interfaces before parallel work is what made the parallel authoring safe.** The
   contract's node/edge inventory (§4), field names, phase IDs P0–P9, decision IDs D1–D8, and the
   validation vocabulary were fixed *before* any worker started — the same sequencing plan P4.4
   demands of interfaces and code. Workers consumed the inventory; none renegotiated it. Where a
   worker needed a change, the contract's own rule applied: report it, do not edit a file you do
   not own. `[FACT]`
5. **Workers skipped project-wide validation by design; the coordinator runs it once.** Mid-flight
   validation against siblings' half-finished files produces phantom failures — the documentation
   analogue of running the test suite against another writer's worktree. This is one-writer
   discipline extended to checks, and it means *no artifact in this package has been validated
   against its siblings yet*. That is stated plainly instead of being discovered by a reader.
   `[FACT]`
6. **Honest labeling is the load-bearing practice, and it compounds.** The reason this document
   could cite RC-1, the rehearsal's instructed-read-only finding, and `dSearch`'s precision
   measurement as design inputs is that those projects labeled their dormant and falsified parts
   accurately at the time (`PROPOSAL`, `WARN-ONLY`, the narrowed rehearsal claims). The failure
   catalog's own emphasis: "this honesty is why it was countable." Every `DESIGNED` row, every
   FINDING, and every remaining limit in this file is an investment in the next audit's ability to
   count. `[FACT — the quoted pattern; INFERENCE — the compounding claim]`
7. **A premortem written by the same mind that wrote the design is weaker than one written by a
   skeptic with skin in the game.** §3 is the architect arguing against himself; 6.7 exists because
   that argument needs an adversary to be trustworthy. This is recorded here so that a reader does
   not over-read §3's completeness. `[INFERENCE]`

---

## 10. Tone statement, attribution, and what this does not prove

This document owns its gaps directly. It contains no hedging, no rote apology, and no softened
claim: every mechanism that has not been exercised is labelled `DESIGNED` or `DESIGNED+CHECKED`
with the reason; every rule without a consumer is a numbered FINDING; every remaining limit has an
owner or a named drill. The gaps are the deliverable — a design that cannot state its own failure
modes has not finished designing.

**Attribution (verbatim, contract §3):**

> The operator designed the architecture and workflow. The operator did not build, deploy, or test
> these systems, and did not participate in the hackathon solution. The five-person team owns
> implementation of the hackathon solution. No hackathon outcome or semantic correctness is claimed.

**Privacy (verbatim, contract §3):** no participant names, no repository contents, no credentials,
no sponsor or organizer material, no topic-specific detail that could disadvantage the team's
October event. Any example in any artifact is synthetic and must be labelled synthetic.

**Does-not-prove list (verbatim, contract §3):** no hackathon outcome; no semantic correctness of
the team's solution; no proof that any mechanism held under real time pressure; no rehearsal
evidence (none exists yet); no claim that monitoring improves delivery.

The portfolio claim itself (contract §3) is **withheld from this document**: it is usable only once
all artifacts exist and agree, and the agreement sweep (wave 4) had not run when this file was
written.

**Numbered, verifiable follow-ups** — each is checkable by a third party against the named
artifact:

1. Run P5.1: attempt a write through the observer token; record the exact command and its failing
   output verbatim in the rehearsal record. Until that output exists, every "read-only" statement
   in every artifact remains `[UNPROVEN]`. (Owner: architect, P5, T-3→T-1.)
2. Execute drills 6.1–6.8 in order before T-1; produce each drill's evidence artifact; re-run any
   drill whose record contains zero findings. (Owner: whole team, P6.)
3. Close Q1 and Q2 in writing at P0; verify no P1+ work started before closure — plan §14's gate
   is procedural, so the check is the P0 record itself. (Owner: architect + team, P0.)
4. When the P3.4 package schema exists, apply the declaration protocol to every field: name its
   reader, or mark it `DECLARED_ONLY` with a reason. Re-audit F-4 and §2 at that point. (Owner:
   architect, P3.)
5. Run the wave-4 cross-artifact agreement sweep before the coordinator commits; then re-hunt at
   6.7 independently — the sweep being manual and once-run is a recorded limit, not a control.
   (Owner: coordinator, wave 4.)
6. Define the stall-detection window for `OB` at P5.2 — PM-6's exposure (an unstipulated window
   means noise or silence) closes only when a number exists. (Owner: architect, P5.)
