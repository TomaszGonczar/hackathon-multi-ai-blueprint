# Development Plan — Multi-AI Workflow for a Five-Person Cybersecurity Hackathon

**Status:** draft v2, 2026-09-14 **Amended 2026-09-15** (discovery closure, overnight protocol, portfolio readiness, and review findings): every change is recorded per commit in `HISTORY.md`, and the review findings that drove them are itemised in `09_REVIEW_RECORD.md`.
**Companion to:** `03_ARCHITECTURE_BLUEPRINT.md`
**Purpose:** an ordered, implementation-ready plan the team can execute without another architecture session
**Not in scope:** building the hackathon solution
**Changelog:** v2 (2026-09-14) — header legend + verification method added; validation-state columns added to §2, §11, §12; `06_ARCHITECTURE.mmd` node/edge cross-references (`00_DELIVERABLE_CONTRACT.md` §4) added to §6–§11; every §12 row strengthened to a reproducible check; Q1/Q2 branching notes added to §7 and §10; §13–§14 unchanged; §15 tied to cross-artifact agreement. v1 committed at `3ea098f`.

**Verification method:** [FACT] baseline commit `3ea098f` ("Draft v1: architecture blueprint and development plan") confirmed by `git log`; working tree clean before this edit; changes verified by `git diff`. [READ] files inspected: `03_ARCHITECTURE_BLUEPRINT.md` §0–§12 (package fields §3.3, ownership §4.2, authority §7, cut order §8.2, decisions D1–D8 §9, open questions §10, completion §12), `04_DEVELOPMENT_PLAN.md` §1–§15 at `3ea098f`, and the shared deliverables contract §1–§7 (diagram inventory §4). [UNPROVEN] every mechanism in this plan: no rehearsal has run and the event has not happened.

**Claim labels** (house convention, shared with `03_ARCHITECTURE_BLUEPRINT.md`):

| Label | Meaning |
|---|---|
| `[FACT]` | Executed or read directly; anchored to a commit, file, or recorded output |
| `[INFERENCE]` | Reasoned from evidence; not executed |
| `[UNPROVEN]` | Designed, never tested |

**Validation states** (vocabulary shared across the artifacts):

| State | Meaning |
|---|---|
| `DESIGNED` | Specified in an artifact; no check has ever exercised it |
| `DESIGNED+CHECKED` | Specified and a defined, runnable check exists — the row names it; it has not been run yet |
| `ENFORCED` | A mechanism makes the violation impossible, and that mechanism has been observed to block it |

Nothing in this project is `ENFORCED`: no rehearsal has run. Every row carrying a state also carries its **entry criteria** — the observation that would upgrade it. For rows that are not enforcement mechanisms (procedures, documents, drills), `ENFORCED` is not reachable and the entry criteria name the recorded execution that would make the row evidence-backed.

Diagram node IDs (`RM`, `MP`, `OB`, `DR`, `AG`, `L1`–`L5`, `REPO`, `PR`, `CI`, `APPR`, `MERGE`, `ESC`) and edge IDs (E1–E30) cited in this plan refer to `06_ARCHITECTURE.mmd` per the frozen inventory in `00_DELIVERABLE_CONTRACT.md` §4.

---

## 1. How to read this plan

This plan builds **the workflow**, not the competition solution. It is ordered so that every phase produces an artifact the next phase consumes.

Two different clocks appear in this document and must not be confused:

| Clock | Meaning | When it runs |
|---|---|---|
| **Preparation (T-minus)** | Setup done before the event | Days to weeks before |
| **Event (T-plus)** | Execution after the topic is revealed | Hours, once only |

The **Mission Package** is the seam between them: nothing topic-specific can exist before T+0.

---

## 2. Phase overview

| Phase | When | Owner | Produces | Gate | Validation state |
|---|---|---|---|---|---|
| **P0 — Discovery closure** | T-14 to T-7 | Architect + team | Closed questions, signed scope | Team sign-off | `DESIGNED+CHECKED` — check: §3 per-task acceptance column; entry: filled answer register, every answer sourced, executed at prep time |
| **P1 — Reuse ledger** | T-10 to T-7 | Architect | `02_REUSE_LEDGER.md` | Every candidate classified | `DESIGNED+CHECKED` — check: §4 gate + 10-field record; entry: ledger filled and every blueprint §3–§5 component classified |
| **P2 — Environment inventory** | T-7 to T-3 | Team | Machine/account matrix | All five machines reachable | `DESIGNED+CHECKED` — check: §5 gate (self-report by command, authenticated call); entry: recorded output for all five machines |
| **P3 — Core setup: research machine** | T-5 to T-2 | Architect + 1 engineer | Working S1 | Dry-run produces a synthetic package | `DESIGNED+CHECKED` — check: §6 synthetic dry run + anti-cheerleader test; entry: dry-run package read cold and acted on by a second person (§9 6.2) |
| **P4 — Core setup: development fleet** | T-5 to T-2 | Architect + team | Repo, ownership, merge rule | Two-machine collision test passes | `DESIGNED+CHECKED` — check: P4.8 collision test; entry: collision drill run and result recorded (§9 6.3) |
| **P5 — Observer setup (tier 2)** | T-3 to T-1 | Architect + 1 engineer | Read-only observer | Credential proven write-incapable | `DESIGNED+CHECKED` — check: P5.1 write attempt fails by execution; entry: executed refusal recorded; if the token cannot be scoped, the claim is downgraded per §8 — never softened |
| **P6 — Rehearsal** | T-2 to T-1 | Whole team | Rehearsal record | Tabletop + dry run pass or corrections recorded | `DESIGNED+CHECKED` — check: §9 steps 6.1–6.8 with pass conditions; entry: rehearsal record exists, including what failed |
| **P7 — Event-day startup** | T+0 | Team | Running system | Startup checklist complete | `DESIGNED+CHECKED` — check: `05_IMPLEMENTATION_CHECKLIST.md` §4 ES-01–ES-09 define an observable completion per startup step; entry: startup sequence run end-to-end in rehearsal (P6.1 + T1 drills) and recorded |
| **P8 — Event operation** | T+0 to T+end | Team | Solution + evidence | Submission | `DESIGNED+CHECKED` — check: `05_IMPLEMENTATION_CHECKLIST.md` §5 DC-01–DC-16 define an observable completion per cycle, including the overnight rows (pause declaration, push-before-offline, handover, overnight staffing); entry: one full cycle plus one declared pause/resume run in rehearsal and recorded |
| **P9 — Teardown** | T+end | Team | Post-event record | Portfolio sanitization | `DESIGNED` — sanitization procedure not yet concrete; entry: a defined inspection (no participant names, repo contents, credentials, or organizer material in anything released) run before release |

**P0–P2 are non-negotiable.** P3–P4 are core. P5 is degradable. P6 is what makes the rest credible.

---

## 3. P0 — Discovery closure

**Goal:** close the open questions in blueprint §10 that block design.

| Task | Owner | Input | Output | Acceptance |
|---|---|---|---|---|
| P0.1 Confirm team structure | Architect + team | Organizer material | Answer to Q1 | Written, with source |
| P0.2 Confirm duration and prep rules | Architect | Organizer material | Answers Q2, Q11 | Exact hours and rules stated |
| P0.3 Extract success criteria verbatim | Architect | Organizer material | Q3 | Quoted, not paraphrased |
| P0.4 Inventory machines and OS | Team | Each participant | Q4, Q5 | Five rows, each verified by its owner |
| P0.5 Inventory accounts and tools | Team | Each participant | Q7, Q12 | Per-person capability list |
| P0.6 Confirm GitHub capabilities | Architect | GitHub org | Q8, Q9 | Actions/webhooks/protection status known |
| P0.7 Name the merge owner | Team | Team decision | Q10 | One named human |
| P0.8 Confirm portfolio permission | Architect | Team + organizers | Q13 | Explicit written consent |

**Gate:** every question has a written answer with an owner. Unanswered questions are recorded as assumptions with a stated fallback — never silently defaulted.

**Why this is a real phase:** a preflight that leaves the launch and evidence rules implicit produces its NO-GO at the worst possible moment — the first execution step, with the clock already running. Writing them down before anything runs is the entire point of the phase.

---

## 4. P1 — Reuse ledger

**Goal:** decide what transfers from prior work, and refuse to import accumulated coupling — start from an examined position rather than from scratch, without carrying forward mechanisms whose cost has never been justified.

Classify every candidate as `REUSE` / `ADAPT` / `REFERENCE ONLY` / `DROP`.

| Candidate from prior work | Decision | Reason |
|---|---|---|
| Principal/worker separation | **ADAPT** | Same shape, but roles become per-task bundles, not identities |
| Task and result contracts | **REUSE** | Directly transferable discipline |
| One-writer-per-workspace | **REUSE** | Core anti-collision rule |
| Independent review of exact candidate | **REUSE** | Review a commit, never a prose summary |
| Evidence-before-completion | **REUSE** | A worker's "done" is a claim, not proof |
| Read-only observer with read-only credential | **ADAPT** | Becomes a mode on S1, not a separate service |
| Git worktree isolation | **REUSE** | Cooperative concurrency |
| Worktree as *security* containment | **DROP** | Explicitly falsified in rehearsal: it is not a sandbox |
| Heartbeat/watchdog protocol | **DROP for v1** | Cost without demonstrated need at this scale |
| Full deterministic gates suite | **REFERENCE ONLY** | Design input; too heavy to port under event time |
| Hosted vector search / embeddings | **DROP** | No evidence of need; topic is unknown |
| Custom dispatcher / scheduler | **DROP** | Explicitly a non-goal |
| Semantic GitHub judge | **DROP** | Places opaque judgement where evidence is required |

**For each `REUSE`/`ADAPT` item, record:** source, behaviour actually proved, target use, dependencies, multi-machine risk, security risk, required rewrite, target test, decision.

**Gate:** no component enters the architecture without a ledger row. A component with no demonstrated need is dropped, not deferred.

---

## 5. P2 — Environment inventory

| Task | Output | Acceptance |
|---|---|---|
| Machine matrix | OS, CPU, RAM, disk, network per machine | Each machine self-reports via a command, not by description |
| Account matrix | AI accounts, CLIs, keys per participant | Verified by an actual authenticated call |
| Network map | Which machines can reach which | Tested, not assumed |
| Repository topology | One repo or several; who has what permission | Confirmed against the real org |
| Credential placement | Where each secret lives | Never in the repo; never in a prompt |

**Gate:** every machine has been observed, not described. "It should work" is not an acceptance state.

---

## 6. P3 — Core: research machine

**Goal:** S1 can take a topic and produce an approved, frozen Mission Package.

| Task | Owner | Output | Acceptance |
|---|---|---|---|
| P3.1 Sub-question decomposition | Architect | Prompt/template | A synthetic topic yields ≥5 independently researchable sub-questions |
| P3.2 Research loop with provenance | Architect | Working flow | Every output sentence carries a source or `[unverified]` |
| P3.3 Contradiction surfacing | Architect | Report section | Deliberately contradictory synthetic sources stay contradictory in output |
| P3.4 Mission Package generator | Architect | Schema + renderer | Package validates against schema; every required field present |
| P3.5 Freeze and amendment protocol | Architect | Protocol doc | An edit creates a numbered amendment; silent edit is impossible |
| P3.6 Approval gate | Architect | Human approval step | Package cannot enter development without a recorded approval; the approval record names the organizer criterion each `acceptance_tests` entry serves (P3.9 trace) |
| P3.7 Degraded modes | Architect | Behaviour table | Offline test: last frozen package still served |
| P3.8 Untrusted-input boundary | Architect | Research rule + test | A synthetic source set containing instruction-shaped text yields an `evidence` entry that quotes it with provenance and **zero** lane instructions derived from it; the package marks it as a source property |
| P3.9 Rubric trace | Architect + team | Trace table | Every `acceptance_tests` entry names the organizer criterion it serves (Q3, `01_DISCOVERY_CLOSURE.md`); entries with no criterion are either justified in writing or deleted |

**Gate:** a synthetic dry run produces a package a second person can read and act on without asking the author anything.

**Explicit test — the anti-cheerleader check:** feed the system a plan that is objectively wrong and verify the observer reports deviation rather than defending it (schema: P5.3; exercised at drill 6.5; scored at §12 row "Observer reports facts, not judgements").

**Diagram cross-references (`06_ARCHITECTURE.mmd`; inventory: `00_DELIVERABLE_CONTRACT.md` §4):** P3.4 produces node `MP` ("Mission Package vN — frozen · versioned") and implements E1 `RM --> MP` ("sourced findings + contradictions"). P3.5 keeps `MP` immutable; changes re-enter `MP` only via E28 `ESC --> MP` ("numbered amendment request"). P3.6 implements `APPR` with E2 `MP --> APPR` ("package vN for approval") and E3 `APPR --> MP` ("approval record"); only an approved `MP` crosses the boundary to the fleet on E4–E8 `MP --> L1..L5`. P3.7's degraded serving of the last frozen package underpins E29 ("degraded: adopt frozen package locally if S1 lost", any lane; drawn `REPO --> L5` in the rendered diagram per the contract's collision fallback, "(any lane)" wording kept).

---

## 7. P4 — Core: development fleet

| Task | Owner | Output | Acceptance |
|---|---|---|---|
| P4.1 Repository and branch topology | Architect | Repo config | Protected integration branch; no direct pushes |
| P4.2 Ownership registry | Architect | One row per workstream | Two workstreams cannot claim one surface |
| P4.3 Workstream templates | Architect | Branch/worktree template | A new workstream is created in one documented step |
| P4.4 Interface contract template | Architect | Template | Interface frozen before parallel work begins |
| P4.5 Integration order | Architect | Ordered list | Every workstream has a defined position |
| P4.6 Merge procedure | Architect | Checklist | Human-only; no AI merge path exists |
| P4.7 Escalation path | Architect | Documented triggers | Each trigger names the human it summons |
| P4.8 Collision test | Team | Test result | Two machines attempt the same surface; the rule prevents it |
| P4.9 One reproducible CI command | Architect | CI configuration | One command runs on every PR against the integration candidate and its output is recorded; observed runnable on a synthetic PR |

**Gate:** two machines can work concurrently without collision, demonstrated, not asserted.

**Diagram cross-references (`06_ARCHITECTURE.mmd`):** P4.1 implements `REPO` ("Git remote — repo · branches") with E9–E13 `L1..L5 --> REPO` ("branch push `workstream-N`") and receives E18 `MERGE --> REPO`. P4.2 populates lanes `L1`–`L5` ("human N · machine N · worktree/branch `workstream-N`"); the package reaches them on E4–E8 `MP --> L1..L5` — the only artifact crossing the boundary. P4.3 creates those lane worktrees/branches; per-task capability bundles arrive on E19–E23 (`AG --> lanes`; rendered as one collapsed edge `AG --> L1`, "per-task bundle — every lane, selected per task", per the contract's named hairball fallback). P4.4's interface contract is the `MP.interfaces` field (blueprint §3.3) — the frozen meeting point between lanes. P4.5's order is `MP.integration_order`, executed at E18. P4.6 implements `PR` and `MERGE`: E14 `REPO --> PR`, E15 `PR --> CI`, E16 `CI --> PR`, E17 `PR --> MERGE` ("exact candidate diff + evidence"), E18 `MERGE --> REPO` ("human merge, integration order"). P4.7 implements `ESC` with E27 `L3 --> ESC` (any lane: interface wrong · acceptance test unsatisfiable · same-surface claim) and E28 `ESC --> MP`. P4.8 exercises the same-surface branch of E27.

**Q1 — resolved 2026-09-15: one five-person team.** `[FACT — operator decision, 2026-09-15; `01_DISCOVERY_CLOSURE.md` Q1]` One fleet with up to five workstreams (lanes `L1`–`L5`), one `REPO`, and the ownership registry (P4.2) mapping each surface to one of the five named members — written after the members are named at T7-02. The five-separate-teams branch is closed and is not carried forward; it stays visible here and in `01_DISCOVERY_CLOSURE.md`, per the house rule that a closed branch is recorded rather than deleted silently.

---

## 8. P5 — Observer (tier 2, degradable)

| Task | Owner | Output | Acceptance |
|---|---|---|---|
| P5.1 Read-only credential | Architect | Scoped token | A write attempt through this token **fails** — proven by execution |
| P5.2 Watch set definition | Architect | Event list | Which GitHub events matter, and why |
| P5.3 Deviation model | Architect | Output schema | Schema has observation fields only — no assessment field |
| P5.4 Reporting cadence | Architect | Bound | Alerts on deviation, failure, conflict, stall only — and never a stall alert for a lane whose owner has declared a pause (P8 pause declaration); a muted observer is a declared state, never a silent one (blueprint §5.6) |
| P5.5 Ask-anytime path | Architect | Query flow | Any team member can ask "where are we?" and get a package-versioned answer |
| P5.6 Outage visibility | Architect | Failure behaviour | Observer down is itself visible, not silently absent |
| P5.7 Observer runtime on S1 | Architect | Start/stop procedure for the long-lived observer process | Observer starts on S1 by one documented command, emits its first heartbeat within `<report-cadence>`, and stops on command with zero reports after the stop timestamp |

**P5.1 is the load-bearing test.** If the credential cannot be scoped to read-only, the claim in blueprint §7 is downgraded and stated as a limitation. It is never softened into "we told it not to write."

**P5.7 runtime cross-reference:** P5.7 starts and stops the `OB` process on `S1`; a missing heartbeat surfaces on E30 `OB --> ESC` ("observer outage is itself visible").

**Diagram cross-references (`06_ARCHITECTURE.mmd`):** P5.1 scopes the credential carried on E24 `REPO --> OB` ("repo/PR/CI events — read-only credential"); `OB` carries the `degradable` class (tier 2). P5.2's watch set is exactly the events arriving on E24. P5.3 is the `DR` node ("deviation report — observation fields only, no assessment field"), fed by E25 `OB --> DR` ("deviation vs package vN"). P5.4 bounds when `OB` emits on E25/E26. P5.5's ask-anytime answer is versioned against `MP`. P5.6 implements E30 `OB --> ESC` ("observer outage is itself visible"). Human judgement is reached only via E26 `DR --> ESC` ("facts + risks, never assessment").

---

## 9. P6 — Rehearsal

**Goal:** the only thing that converts a design into a claim.

| Step | Method | Pass condition |
|---|---|---|
| 6.1 Tabletop walkthrough | Whole team, no tooling | Every participant can state what they own and what they may write |
| 6.2 Synthetic topic dry run | S1 only | A package is produced and approved in bounded time |
| 6.3 Two-machine collision drill | Two participants | Ownership rule holds; observer reports if violated |
| 6.4 Disconnection drill | Kill one machine mid-task | Work is reassignable from Git state alone |
| 6.5 Observer-off drill | Disable observer | Team continues building; loss is visible |
| 6.6 Time-box check | Whole team | Setup fits inside the stated preparation window |
| 6.7 Adversarial review | Architect + one skeptic | Contradictions across blueprint/plan/checklist recorded |
| 6.8 Correction pass | Architect | Every found contradiction resolved in the artifacts, not in someone's head |

**Gate:** the rehearsal record exists, including what failed. A rehearsal that found nothing is treated as insufficient, not as a pass.

**Rationale:** a check that has never been observed to fail is not evidence, and a workflow drill that has never failed has proven nothing — a drill in which nothing can go wrong tests nothing. The gate above therefore rests on the recorded failure, not on the green result.

**Diagram cross-references (`06_ARCHITECTURE.mmd`):** 6.2 exercises E1–E3 (`RM --> MP --> APPR --> MP`). 6.3 exercises E27 (same-surface escalation) against the ownership rule behind E4–E8. 6.4 exercises E29 (degraded local adoption of the frozen package). 6.5 exercises E30 (observer outage is itself visible).

---

## 10. P7–P9 — Event operation

### P7 Startup
Machine health → credentials present → repository reachable → roles announced → observer status stated aloud (on/off) → start. (Observer status is the state of node `OB`; announcing it at startup is the human-side complement of E30 "observer outage is itself visible".)

### P8 Operation

| Cadence | Action | Owner | Diagram |
|---|---|---|---|
| Continuous | Observer reports deviation vs. frozen package | Observer | E24 `REPO --> OB`, E25 `OB --> DR`; escalates on E26 `DR --> ESC` |
| On escalation trigger | Human decision | Named human | E27 `lane --> ESC`; decision recorded at `ESC` |
| On scope change | Numbered amendment | Approver | E28 `ESC --> MP`; re-approval via E2 `MP --> APPR` and E3 `APPR --> MP` |
| Continuous | Research on demand | S1 research mode | E1 `RM --> MP`; reaches lanes on E4–E8 only after approval |
| At integration points | Human merge, in order | Merge owner | E14–E17 (`REPO --> PR`, `PR --> CI`, `CI --> PR`, `PR --> MERGE`), then E18 `MERGE --> REPO` |
| Per shift (lane resume after a pause) | Handover recorded: branch state, open blockers, next action | Lane owners | E9–E13 (`lane --> REPO`; the push precedes the handover) |
| On lane pause / resume | Pause declared with a resume-by time in the event log; the observer excludes declared-paused lanes from stall alerts; resume clears the declaration | Lane owner declares; `<s1-operator>` confirms | No diagram edge — the declaration is an event-log record, not an artifact flow; the stall alert it suppresses travels E25–E26 |
| Before any machine goes offline (sleep, power-down, disconnect) | Branch pushed and local state stated; only then may the machine go offline | Lane owner | E9–E13 (`lane --> REPO`) |
| Overnight (each night window) | Exactly one named awake human owns the escalation channel; if none is awake, the alert set is reduced and the reduction announced | `<team-lead>` | E26/E30 — the reduction is a declared degraded state, subject to the same visibility rule as an observer outage |

**Q2 — resolved in part, 2026-09-15: duration is 24 hours or more; the expected shape is two days with part of the team working overnight.** `[FACT — operator report of a team contact, 2026-09-15]` `[UNVERIFIED — second-hand; organizer confirmation pending]` Consequences, applied: the short-event branch is closed — the observer is not cut for duration reasons and continuous mode stays ON by default; the cut order in blueprint §8.2 is therefore driven by **pressure, not duration**; and the four overnight rows above become live requirements rather than options. Still open: exact start/stop times, submission deadline, preparation rules — these set `<freeze-threshold>` and `<submission-buffer>` at T7-09 and change no structure. See `01_DISCOVERY_CLOSURE.md` Q2, and the "Time running out" row in §11.

**Time and cost budget — the frame, with the numbers owed at T7-09.** Every other cost in this design is named; the event's own budget was not, and an unmodelled budget is how coordination silently eats the clock (`07_FAILURE_AND_REHEARSAL_PLAN.md` §3 PM-3). The frame is fixed now so the numbers have somewhere to land:

| Budget line | Owner | Value | Filled at |
|---|---|---|---|
| Event window (start, stop, submission deadline) | `<team-lead>` | `<event-window>` | T7-09, from organizer material |
| Package approval (research freeze → `APPR`) | `<architect>` | `<approval-budget>` | T7-09; measured at drill 6.2 |
| Startup sequence ES-01…ES-09 | `<team-lead>` | `<startup-budget>` | T7-09; measured at drill 6.1 |
| Per-cycle coordination overhead (sync, triage, handover) | `<team-lead>` | `<cycle-overhead-budget>` | T7-09; measured across one full rehearsal cycle |
| Triage load on the observer's reports | `<s1-operator>` | `<triage-budget>` | T7-09; measured at drill 6.5 |
| **C0 floor** — the never-cut set must fit inside the event window | `<team-lead>` | `<c0-floor-target>` | Drill 6.6 is the measurement, and it now has a target to hit rather than only a duration to report |

Drill 6.6 recalibrates the §9 step timeouts against these values; until it runs, every timeout in `07` §6 is an estimate and is labelled as one.

### P9 Teardown
Stop observer → release credentials → archive evidence → **sanitize before anything reaches a portfolio** → confirm no participant, repository, or organizer material is exposed.

---

## 11. Failure matrix

| Failure | Detection | Response | Fallback | Response state | Fallback state |
|---|---|---|---|---|---|
| Topic harder than expected | Research returns few sourced findings (E1 `RM --> MP` carries little) | Widen sub-questions; mark unknowns explicitly (`MP.unknowns`) | Build against what is known; state unknowns in the demo | `DESIGNED` — no drill exercises the widening; entry: 6.2 dry run fed a synthetic sparse-source topic, widening recorded | `DESIGNED` — entry: 6.2 output shows `MP.unknowns` driving the stated demo scope |
| S1 machine lost | Observer and research both stop | Adopt from a second machine using the frozen package in Git | Read package locally; continue (E29, drawn `REPO --> L5` per the contract collision fallback; any lane) | `DESIGNED+CHECKED` — check: §9 6.4; entry: drill run, adoption from Git state alone recorded | `DESIGNED+CHECKED` — check: §9 6.4; entry: drill run, local-read continuation recorded |
| Provider outage | Research stalls | Second provider or manual browser research | Proceed with frozen findings | `DESIGNED` — entry: 6.2 extended with a provider-kill step, fallback exercised and recorded | `DESIGNED` — entry: same drill shows work proceeding against the frozen `MP` |
| Fleet collision | Observer reports same-surface writes (E25 `OB --> DR`) | Stop both; reassign per ownership rule (E27 `lane --> ESC`) | Serialize the two workstreams | `DESIGNED+CHECKED` — check: §9 6.3; entry: drill run, second claim refused and recorded | `DESIGNED` — entry: 6.3 extended to exercise serialization after a detected collision |
| Plan diverges from reality | Observer reports deviation (E25, escalated on E26 `DR --> ESC`) | Human decides: amend or accept (amendment via E28 `ESC --> MP`) | Continue against frozen package, accepting known drift | `DESIGNED+CHECKED` — check: §6 anti-cheerleader test (deviation reported, not defended); entry: one amend-or-accept decision recorded at 6.2/6.7 | `DESIGNED` — entry: P3.5 protocol defines a drift-acceptance record and a drill produces one |
| CI unavailable | No automated check result (E15/E16 `PR <--> CI` silent) | Manual verification by a second person | Weaker evidence, stated as such | `DESIGNED` — entry: drill disables CI, manual verification produces a recorded command + output at E17 | `DESIGNED` — entry: same drill records the evidence downgrade statement on the PR |
| Observer down | Missing reports | Team notices on the next ask | Continue without monitoring | `DESIGNED+CHECKED` — check: §9 6.5 (loss visible); entry: drill run, detection lag recorded | `DESIGNED+CHECKED` — check: §9 6.5 ("team continues building"); entry: drill run, continued building recorded |
| Time running out | Clock | Apply cut order (blueprint §8.2; duration branch — see the Q2 note in §10) | Ship only the never-cut set (cut priority C0, never cut) | `DESIGNED` — entry: a tabletop step invokes the cut order at a simulated clock mark and records which rows were cut | `DESIGNED` — entry: same tabletop records the C0-only ship decision |
| "It works" asserted | No reproducible check | Demand the command and its output | Treat as unverified | `DESIGNED+CHECKED` — check: §12 matrix (every row names a reproducible check); entry: one claim refused without command output during rehearsal, recorded | `DESIGNED+CHECKED` — check: claim-label vocabulary (`[UNPROVEN]`); entry: rehearsal record labels the claim `[UNPROVEN]` |
| Lane dark overnight (work unpushed) | No push or heartbeat from the lane | If a pause was declared → expected; no action until the resume-by time. If undeclared → observer stall alert, then a reachability check | Reassign from `REPO` state alone; the push-before-offline rule (DC-14) is what bounds the loss to time rather than work | `DESIGNED+CHECKED` — check: DC-14 (push before offline) | `DESIGNED+CHECKED` — check: §9 drill 6.4 extended to an offline lane |
| Declared-paused lane reported as a stall | Observer emits a stall alert for a lane holding an active pause declaration | Treat it as a defect in the cadence rule, never in the lane: suppress the alert and correct the rule before the next night window | The declaration suppresses the alert; the false positive is logged against P5.4 — an observer that cries wolf gets muted (blueprint §5.6) | `DESIGNED` — entry: one declared pause observed producing zero stall alerts in rehearsal | `DESIGNED` — entry: same drill records the suppressed alert and the rule correction |
| Overnight escalation unstaffed | A trigger fires in the night window with no awake owner | Reduce the alert set immediately and announce the reduction (the E30 visibility rule) | Alerts queue to the morning sync; the reduction is a declared degraded state, and the night's exposure is named in the event log rather than assumed away | `DESIGNED` — entry: one night window run in rehearsal with the staffing rule exercised | `DESIGNED` — entry: same drill records the announced reduction |

---

## 12. Acceptance matrix

| Requirement | Observable acceptance — reproducible check | Phase | Validation state | Entry criteria to next state |
|---|---|---|---|---|
| Ambiguity converted to explicit requirements | Blueprint §10 closed with owners: all 14 blueprint §10 rows have a written answer, an owner, and a source citation; unanswered questions appear as assumptions with named fallbacks. Procedure: read the filled §3 answer register; count answers lacking a source — must be 0 | P0 | `DESIGNED+CHECKED` — check: §3 acceptance column | Register filled at prep time and inspected; `ENFORCED` not reachable (document property) |
| No component without demonstrated need | Every component has a reuse-ledger row: each component named in blueprint §3–§5 appears in the P1 ledger classified `REUSE`/`ADAPT`/`REFERENCE ONLY`/`DROP`. Procedure: diff the blueprint component list against ledger rows; components without a row = 0 | P1 | `DESIGNED+CHECKED` — check: §4 gate | Ledger filled and the diff observed empty |
| Environment known, not assumed | Machines observed by command: each of the five machines self-reports OS/CPU/RAM/disk by recorded command output (e.g. `uname -a`, `sysctl -n hw.ncpu`, `df -h`; exact commands per OS fixed by the P2 matrix after Q4); each AI account proves access with one authenticated call whose result is recorded. Procedure: inspect the matrix — five rows of command output, zero rows of description | P2 | `DESIGNED+CHECKED` — check: §5 gate | Recorded outputs for all five machines plus authenticated-call results inspected |
| Research produces structure, not answers | Package validates; unknowns explicit: run the P3.4 schema validator against the synthetic dry-run package — exit 0; all ten fields present (`objective`, `constraints`, `evidence`, `unknowns`, `acceptance_tests`, `interfaces`, `dependency_graph`, `task_ownership`, `integration_order`, `escalation_rules`); `unknowns` non-empty with the blocker/tolerable split | P3 | `DESIGNED+CHECKED` — check: §6 gate dry run | Validator run on the 6.2 dry-run package, exit code recorded |
| Provenance mandatory | Every claim sourced or `[unverified]`: run the provenance counter over the package `evidence` field — claims lacking a source or the `[unverified]` tag = 0. Command: the P3.2 check script over the dry-run package, output recorded | P3 | `DESIGNED+CHECKED` — check: P3.2 acceptance | Counter run on the 6.2 package with zero untagged claims |
| Contradictions preserved | Deliberate contradiction survives synthesis: run the P3.3 test — two synthetic sources asserting opposite facts are fed in; the output lists both with a contradiction marker; neither is dropped or reconciled | P3 | `DESIGNED+CHECKED` — check: P3.3 acceptance | P3.3 test run during 6.2 with both sources visible in the output |
| Package frozen and amendable | Silent edit impossible: after approval, attempt a direct edit of a package field (P3.5 protocol drill) — the attempt is refused or produces a numbered amendment record with reason and approver; count of silent edits = 0 | P3 | `DESIGNED+CHECKED` — check: P3.5 acceptance | Amendment drill run on the synthetic package, amendment number observed |
| One writer per surface | Collision drill passes: two machines simultaneously claim the same surface in the ownership registry (P4.8 / §9 6.3) — the second claim is refused by the registry rule; both attempts and the refusal are recorded | P4 | `DESIGNED+CHECKED` — check: P4.8 | `ENFORCED` when the drill has run and the rule was observed refusing the second claim |
| Human-only merge | No AI merge path exists: if branch protection is available (blueprint §10 Q8/Q9), inspect the protection rules on the integration branch (e.g. `gh api repos/<org>/<repo>/branches/<integration>/protection`) showing required review, and attempt one merge with an agent credential — refusal (403) recorded; if protection is unavailable, the downgrade and the compensating manual rule are recorded per blueprint §7 — the claim is narrowed, never softened | P4 | `DESIGNED+CHECKED` — check: P4.1 + P4.6 acceptance | `ENFORCED` when an agent-credential merge attempt has been observed refused by the remote during rehearsal |
| Observer cannot write | Write attempt fails by credential: with the observer token, execute one write against the repo (e.g. `git push` over the token's remote, or one write API call) — refusal expected; command and output recorded (P5.1). If the token cannot be scoped read-only, the blueprint §7 claim is downgraded and stated | P5 | `DESIGNED+CHECKED` — check: P5.1 | `ENFORCED` when the executed write attempt has been observed refused by credential scope |
| Observer reports facts, not judgements | Output schema lacks an assessment field: inspect the P5.3 deviation schema — observation fields only (deviation magnitude, timestamp, package version); no assessment/judgement field exists. Then run the anti-cheerleader test (§6): an objectively wrong plan is fed in and the report states the deviation without defending the plan | P5 | `DESIGNED+CHECKED` — check: P5.3 + §6 anti-cheerleader test | Schema inspection recorded and anti-cheerleader output produced during rehearsal |
| Degradation is visible | Observer-off drill leaves loss visible: disable the observer (§9 6.5); at the next "where are we?" ask within one cadence interval the answer states "observer off since <time>" explicitly; detection lag recorded; the team continues building | P6 | `DESIGNED+CHECKED` — check: §9 6.5 | Drill run with the loss visible in the recorded answer |
| Overnight operation is covered, not assumed | A lane pauses and resumes with a recorded handover; the observer emits no stall alert for the declared pause; a lane that goes offline has its branch already pushed, with the command and output recorded | P8 | `DESIGNED` | One declared pause/resume and one offline-lane recovery run in rehearsal (drill 6.4 extended) and recorded |
| Design survives scrutiny | Adversarial review findings resolved: 6.7 produces a numbered findings list; 6.8 records, per finding, the artifact edit that resolved it; open findings at the gate = 0 | P6 | `DESIGNED+CHECKED` — check: §9 6.7–6.8 | Findings list plus resolving edits inspected at the P6 gate |
| Handoff needs no second meeting | A new reader answers blueprint §12 unaided: a reader who never spoke to the author answers the eight blueprint §12 questions from the artifacts alone; every unanswered question is an artifact defect, fixed in 6.8 and re-asked | P6 | `DESIGNED+CHECKED` — check: §9 6.7–6.8 + blueprint §12 question list | Cold read run with the answer sheet recorded |

---

## 13. Non-goals

Explicitly **not** in this plan:

- building the hackathon solution;
- a custom distributed runtime, scheduler, or message bus;
- an autonomous merge authority;
- a semantic GitHub judge;
- a permanent agent-per-human role ontology;
- a second authoritative mirror of the repository;
- dashboards built for appearance;
- importing prior-work components wholesale;
- any claim that multi-agent agreement equals truth;
- publishing participant, sponsor, repository, or credential information.

---

## 14. Open questions carried from the blueprint

Blueprint §10, questions 1–14, remain the plan's inputs. Two of them change this document structurally and must be answered at P0:

- **Q1 (one team or five?) — ANSWERED 2026-09-15: one five-person team.** One fleet, up to five workstreams (lanes `L1`–`L5`), one registry mapped to the five named members; the five-teams branch is closed (`01_DISCOVERY_CLOSURE.md` Q1). P4's shape no longer waits on this answer.
- **Q2 (exact duration) — PARTIAL 2026-09-15: 24 hours or more, expected two days with overnight work.** The short-event branch is closed, the cut order becomes pressure-driven, and the overnight rows in §10 are live requirements. Exact hours, deadline, and preparation rules remain open, recorded at T7-09; they set `<freeze-threshold>` and `<submission-buffer>` but change no structure (`01_DISCOVERY_CLOSURE.md` Q2).

**P0 gate status (2026-09-15):** Q1 is answered and Q2 is answered in the part that changes structure, so P1 onward may start. The remaining half of Q2 is a constants question, not a shape question; the other twelve questions (eleven open, one partial) close at T7-01 (blueprint §10; `01_DISCOVERY_CLOSURE.md` §1).

---

## 15. Completion criterion

The plan is executable when another engineer or supervised AI fleet can begin implementation from this document and the blueprint **without another architecture session**, and when every phase above has an owner and an observable acceptance condition.

It is **not** complete when the documents exist. It is complete when the P6 rehearsal passes or its failures are recorded as corrections.

Completion also requires artifact agreement: this plan, `03_ARCHITECTURE_BLUEPRINT.md`, `05_IMPLEMENTATION_CHECKLIST.md`, and `06_ARCHITECTURE.mmd` must agree — same phases and gates, same ten Mission Package fields, same authority rules, and the same diagram semantics (contract §4 node IDs and edges E1–E30 cited above); a disagreement between any two of them is a defect to fix before completion is claimed.
