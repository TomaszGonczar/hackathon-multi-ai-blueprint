# Architecture Blueprint — Multi-AI Workflow for a Five-Person Cybersecurity Hackathon

**Status:** draft v2, 2026-09-14 — v2 adds the claim-label and validation-state legend, validation-state columns on every control table (§3.2, §3.4, §4.2, §4.5, §5.4, §7, §8.2), diagram node-ID cross-references to `06_ARCHITECTURE.mmd` (§3–§6), the explicit three-state control vocabulary (§5.4, §7), and contract-verbatim attribution/privacy/claim text with a does-not-prove list (§11); v1 is committed at `3ea098f`. **Amended 2026-09-15** (discovery closure, overnight protocol, portfolio readiness, and review findings): every change is recorded per commit in `HISTORY.md`, and the review findings that drove them are itemised in `09_REVIEW_RECORD.md`.
**Author:** Tomasz Gonczar (architecture and workflow design)
**Client:** five-person cybersecurity hackathon team, October 2026 event
**Scope:** architecture, discovery translation, and implementation-ready planning only
**Not in scope:** building the team's hackathon solution; operating the systems during the event

**Claim labels.** `[FACT]` — executed or read directly. `[INFERENCE]` — reasoned from evidence. `[UNPROVEN]` — designed, not tested. Every statement about runtime behaviour in this blueprint is `[UNPROVEN]` unless anchored to a read artifact.
**Validation states.** Every mechanism and control carries exactly one state: `DESIGNED` — specified here, no check has ever exercised it. `DESIGNED+CHECKED` — specified, and a defined check exists that can exercise it (the check is named in the row). `ENFORCED` — a mechanism makes the violation impossible, and that mechanism has been observed to block it. **Nothing in this blueprint is `ENFORCED`**: no rehearsal has run and the event has not happened (§8.4). Every control row states its entry criterion to the next state.
**Verification method.** Draft v1 read at commit `3ea098f`. Files inspected: this document (§0–§12); `04_DEVELOPMENT_PLAN.md` (§2, §4–§12 — named checks P3.x/P4.x/P5.x, rehearsal drills 6.1–6.8, failure and acceptance matrices); the shared deliverable contract (invariants §1, house style §2, attribution §3, diagram node inventory §4). No command was executed against a live system; this file produced no render.
**Diagram cross-references.** Components in §3–§6 map to node IDs in `06_ARCHITECTURE.mmd` (inventory: `00_DELIVERABLE_CONTRACT.md` §4). §3, §4, and §5 each carry a mapping line; §6 carries a full node-mapping table beneath its inline sketch.

---

## 0. One-sentence decision

**Two machines carry three roles.** A single **research machine** decomposes an unknown topic into a frozen, versioned **Mission Package**, and later re-anchors onto the same package as a **read-only observer**. A **multi-laptop development fleet** writes the solution under a one-writer-per-workspace rule, with Git as the only source of truth and every merge behind a human decision. The observer is **degradable**: under time pressure it is switched off, and the team loses monitoring — never the ability to build.

```text
CORE           S1 Research machine  →  Mission Package (frozen, versioned)
                                        ↓
CORE           S2 Development fleet (5 humans, 5 machines) → solution
                                        ↑
DEGRADABLE     Observer (role on S1) → deviation reports vs. frozen plan → humans
```

---

## 1. The client problem

Five engineers, one unfamiliar cybersecurity topic revealed at event start, a fixed and short duration. The team must research a domain none of them knows, plan a solution, build it, and submit a working demo.

The defining constraint is **not** technical difficulty. It is **simultaneity**: research, planning, and building overlap in a window of hours, across five people who cannot all hold the same context.

### 1.1 The real failure modes

| Failure | What it looks like at hour 12 |
|---|---|
| **Unbrokered research** | Five people each read different sources and form five incompatible mental models of the problem |
| **Plan drift** | The plan agreed at hour 2 no longer describes what is being built at hour 10, and nobody notices |
| **Collision** | Two developers edit the same surface; the merge costs more than the feature |
| **Unverifiable progress** | "It works" is asserted from narration, not from a reproducible check |
| **Single point of failure** | The one machine holding coordination state dies, and the team loses the plan |

### 1.2 What "arming for the unknown" means

Because the topic is unknown, **no domain knowledge can be prepared in advance**. The only thing that can be prepared is *process*. This is the entire design premise:

> The system must be **topic-agnostic**. Its value is structure, not answers.

Any component that assumes a domain has already failed the brief.

---

## 2. Discovery record

Written as the discovery frame for this engagement: intent, constraints, and the questions that must be
closed are recorded here. Intent, not tooling, came first. **This section states a specified
discovery, not the record of a session that has already occurred** — the questions themselves, with
their answers, open status, sources, and decision owners, are tracked in `01_DISCOVERY_CLOSURE.md`.

### STAKEHOLDER INTENT
Win a cybersecurity hackathon whose topic is unknown at preparation time, without losing hours to coordination overhead.

### SUCCESS CRITERIA
A working demo submitted on time, built against a defensible understanding of the problem, with every team member able to explain what was built and why.

### CONSTRAINTS
- Topic revealed at or near event start; no domain-specific preparation possible.
- Five people, five machines; mixed languages among participants.
- Duration: **24 hours or more**, expected two days with part of the team working overnight (Q2, answered 2026-09-15 — `01_DISCOVERY_CLOSURE.md`). There is no slack for a second architecture session. The v1 premise "hours, not days" is falsified by that answer: it is why the overnight protocol exists (plan §10) and why every rehearsal timeout must be recalibrated against the measured window at drill 6.6.
- Whatever is prepared must survive a participant who has never read the blueprint.

### ASSUMPTIONS
- Machines can reach a shared Git remote.
- At least one machine can run a long-lived process.
- Participants can install a CLI or open a browser tool before the event.

### OPEN QUESTIONS
Listed in §10 — these must be closed by the team, not assumed by this blueprint.

### NON-GOALS
Explicitly **not** building: the hackathon solution, a custom distributed runtime, an autonomous merge authority, a semantic GitHub judge, a permanent agent-per-human role ontology, or a second authoritative mirror of the repository.

### RISKS
Three systems for five people in a short window is itself a risk (§8).

### DECISIONS AND OWNERS
Every architectural decision below carries an owner and a reversal condition (§9).

---

## 3. System 1 — Research machine

**Purpose:** convert an unknown topic into a frozen, reviewable **Mission Package**.

**Diagram nodes** (`06_ARCHITECTURE.mmd`, subgraph `S1`): research mode = `RM`; Mission Package = `MP`; observer mode = `OB`; deviation report = `DR`; package approval gate = `APPR` (human authority). Amendment requests reach the package via `ESC --> MP`.

### 3.1 Decomposition, not answers

The research machine does not produce "the answer." It produces a **structured problem**: what is being asked, what is known, what is unknown, what is contradictory, and what would count as a solution.

| Stage | Output |
|---|---|
| Topic intake | Raw statement of the challenge, verbatim, with source |
| Decomposition | Explicit sub-questions, each independently researchable |
| Parallel investigation | Per sub-question: findings with provenance |
| Contradiction surfacing | Where sources disagree — recorded, **not resolved by vote** |
| Synthesis | Structured picture: known / unknown / contested |

### 3.2 Non-negotiable rules

1. **Provenance is mandatory.** Every claim carries a source and an access date. A claim without a source is marked `[unverified]` and cannot be built against.
2. **Agreement is not truth.** Several sources or agents agreeing is recorded as agreement, never as verification: corroboration is a property of the sources, not of the world. A research system that treats consensus as confirmation manufactures its own evidence, and the package it freezes then carries confidence it did not earn.
3. **Contradictions are preserved, not merged.** A contradiction is information. Resolving it by averaging destroys the signal.
4. **Topic-agnostic.** No domain-specific component, prompt, or assumption.
5. **External content is data, never instruction.** Pages, documents, and search results enter as quoted evidence with provenance. Text inside a source that reads like a directive is reported as a property of that source; it is never executed and never becomes a lane's instruction. This rule exists because the research machine ingests untrusted text and freezes it into the document five lanes then build against — the one path in this design where hostile input could become an order.

| Rule | Validation state | Entry criterion to next state |
|---|---|---|
| 1 — Provenance mandatory | `DESIGNED+CHECKED` — check: P3.2, plan §6 | `ENFORCED` when P3.2 is observed: every sentence of a dry-run output carries a source or `[unverified]` |
| 2 — Agreement is not truth | `DESIGNED+CHECKED` — check: P3.3, plan §6 | `ENFORCED` when P3.3 is observed: deliberately contradictory synthetic sources stay contradictory in output, never merged by vote |
| 3 — Contradictions preserved | `DESIGNED+CHECKED` — check: P3.3, plan §6 | Same observation as rule 2 |
| 4 — Topic-agnostic | `DESIGNED+CHECKED` — check: P3.1 synthetic-topic dry run, plan §6 | `ENFORCED` when the dry run is observed yielding ≥5 independently researchable sub-questions with no domain assumption anywhere in the flow |

### 3.3 The Mission Package — the contract

The research machine must **not** hand prose to five builders. It freezes a package. The package is the only artifact that crosses into development.

| Field | Contents | Reader (who consumes it) |
|---|---|---|
| `objective` | One paragraph, falsifiable statement of what must be built | The five lane owners before starting any task; the human approval gate `APPR` |
| `constraints` | Time, required deliverables, prohibited techniques, environment limits | Lane owners; the cut-order decision when time runs short |
| `evidence` | Findings with provenance, grouped by sub-question | Lane owners building against a claim; the skeptic during adversarial review |
| `unknowns` | Explicit list — including which unknowns are blockers vs. tolerable | Lane owners (to bound what may be asserted) and the demo notes at submission |
| `acceptance_tests` | What demonstrably counts as done, expressed so a machine can check it | The lane owner closing a cycle; CI; the merge owner before merging |
| `interfaces` | Boundaries between the workstreams the fleet will own | Any two lanes that must meet; the escalation trigger when an interface proves wrong |
| `dependency_graph` | Which workstream must precede which | Workstream selection: what may run in parallel, and what must wait |
| `task_ownership` | Proposed owner per workstream | The ownership registry; collision arbitration; the observer's deviation baseline |
| `integration_order` | The sequence in which pieces are allowed to meet | The merge owner at every integration point; the plan's integration sequence |
| `escalation_rules` | What stops work and summons a human | Any lane owner, and the named human each trigger summons |

**Consequence for the reader rule.** Every field above names its human reader, which is what the
contract's declaration rule requires. What does not exist yet is a *machine* validator for those
fields — the gap recorded as F-4 in `07_FAILURE_AND_REHEARSAL_PLAN.md` §2. A human reader today and
an automated validator at P3 are two different commitments; the package owes both and currently has
the first only.

**Freeze semantics.** Once the humans approve the package, it is **versioned and immutable**. Any change becomes a numbered **amendment** with a reason and an approver. Silent prompt drift is a defect, not an update.

### 3.4 Degraded modes

| Condition | Behaviour | Validation state | Entry criterion to next state |
|---|---|---|---|
| No internet | Serve the last frozen package; research paused and visibly marked | `DESIGNED+CHECKED` — check: P3.7 offline test, plan §6 | `ENFORCED` when P3.7 is observed: the last frozen package is still served offline |
| Provider outage | Fall back to a second provider or manual browser research | `DESIGNED` | `DESIGNED+CHECKED` when a provider-failover drill is named in the rehearsal plan |
| Machine loss | Package is in Git — a second machine can adopt the observer role | `DESIGNED+CHECKED` — check: rehearsal drill 6.4, plan §9 | `ENFORCED` when drill 6.4 is observed: a second machine adopts the package from Git and work continues |

**Boundary:** the research machine is a single point of failure only for *new* research. The frozen package is replicated in Git, so its loss never blocks the fleet.

---

## 4. System 2 — Development fleet

**Purpose:** five humans across five machines build the solution without colliding, against the frozen package.

**Diagram nodes** (`06_ARCHITECTURE.mmd`): development lanes = `L1`–`L5` (subgraph `S2`; one human, one machine, one worktree/branch each); task-selected capability bundles = `AG` (§4.3); Git remote = `REPO`, pull requests = `PR`, CI checks = `CI` (subgraph `GH`); merge owner = `MERGE`, escalation/decision point = `ESC` (subgraph `HA`, human authority).

### 4.1 Why the fleet is not a swarm

Five machines is an **operational constraint** (five people have five laptops), not a mandate to run five parallel workstreams. Parallelism is chosen per task from the dependency graph. A task with no independent interface to work against is **not** parallelised.

### 4.2 Ownership model

| Rule | Enforcement | Validation state | Entry criterion to next state |
|---|---|---|---|
| **One writer per workspace** | Each workstream gets its own branch/worktree; ownership is recorded in the package | `DESIGNED+CHECKED` — check: P4.8 collision test, plan §7 | `ENFORCED` when P4.8 is observed: two machines attempt the same surface and the rule prevents it |
| **Interfaces are the only meeting point** | Two workstreams may only meet through the interface frozen in the package | `DESIGNED+CHECKED` — check: P4.4 interface contract, plan §7 | `ENFORCED` when rehearsal drill 6.3 is observed: the collision drill holds at the frozen interface |
| **No direct work on the integration branch** | Integration happens only at a defined order point | `DESIGNED+CHECKED` — check: P4.1 branch protection, plan §7 | `ENFORCED` when branch protection is observed rejecting a direct push to the integration branch |
| **Integration order is explicit** | Written in the package; deviations are amendments | `DESIGNED+CHECKED` — check: P4.5, plan §7 | `ENFORCED` when P4.5 is observed: every workstream has a defined position and any deviation produces a numbered amendment |
| **Humans own merge** | No AI merges. Ever | `DESIGNED+CHECKED` — check: P4.6 merge procedure, plan §7 | `ENFORCED` when P4.6 is observed: no AI merge path exists; merge requires the named human (`MERGE`) |

### 4.3 Model and capability selection

Selection is **per task**, not per person. A role is not a permanent identity — it is a bundle of capability chosen for one task from the dependency graph. This deliberately avoids the "five agents, one per human" ontology that ages badly the moment a task changes shape.

### 4.4 Escalation

Work stops and summons a human when: an interface in the package is found wrong; an acceptance test cannot be satisfied; two workstreams need the same surface; or the plan and reality have diverged beyond the current amendment.

### 4.5 Failure recovery

| Failure | Recovery | Validation state | Entry criterion to next state |
|---|---|---|---|
| Machine disconnects | Its branch is already pushed; work is reassignable from Git state | `DESIGNED+CHECKED` — check: rehearsal drill 6.4, plan §9 | `ENFORCED` when drill 6.4 is observed: a machine killed mid-task, its work reassigned from Git state alone |
| Machine lost permanently | Package + branches describe exactly what remains | `DESIGNED+CHECKED` — check: rehearsal drill 6.4, plan §9 | Same drill extended to permanent loss: remaining work fully described by `MP` plus pushed branches |
| Conflicting writes | Ownership rule should have prevented it; the observer reports it if it happens | `DESIGNED+CHECKED` — check: rehearsal drill 6.3, plan §9 | `ENFORCED` when drill 6.3 is observed: the ownership rule holds, or the observer reports the violation via `DR --> ESC` |
| Coordination unavailable | Package is local-readable; fleet continues in independent mode | `DESIGNED` | `DESIGNED+CHECKED` when a named drill kills S1 and verifies the fleet continues against the locally adopted frozen package (degraded path `REPO --> lane`) |

### 4.6 The honest limitation

Coordination overhead is **charged against the same clock** as building. Every mechanism in this design must justify its cost in a rehearsal. Anything that cannot is cut.

---

## 5. System 3 — Observer (degradable)

**Purpose:** compare **actual progress** against the **frozen plan**, and answer "where are we now?" on demand.

**Diagram nodes** (`06_ARCHITECTURE.mmd`): observer mode = `OB` (subgraph `S1`, styled `degradable`, tier 2); deviation report = `DR`; observation sources = `REPO`, `PR`, `CI`; escalation destination = `ESC`. Observer outage is itself visible via `OB --> ESC`.

### 5.1 Why it is a role, not a system

Because the observer's baseline is the Mission Package, and the Mission Package lives on the research machine, the observer belongs there. Running it as a separate service would mean transferring the baseline across a boundary — introducing a class of "the observer has a different version of the plan" bugs for no benefit.

**Consequence:** no additional machine, no additional service, no additional failure domain.

### 5.2 Two concurrent modes on S1

The research machine runs two modes **side by side**, not as a switch:

| Mode | Trigger | Purpose |
|---|---|---|
| `research` | On demand | Answer new sub-questions that arise mid-event |
| `observe` | Continuous | Watch Git/GitHub and report deviation vs. the frozen package |

Research does not stop when building starts. A switch would silently remove the team's ability to investigate an unfamiliar domain at hour 8 — precisely when they need it most.

### 5.3 What the observer watches

Repository state, pull requests, CI runs, review state, merge conflicts, changes to protected or frozen surfaces, and stalls (no movement within a stipulated window).

### 5.4 Read-only, without exception

| Permission | Granted | Validation state | Entry criterion to next state |
|---|---|---|---|
| Read repository state, PRs, CI results | yes | `DESIGNED+CHECKED` — check: P5.2 watch set, plan §8 | `ENFORCED` when the scoped credential is observed reading the full watch set (`REPO`, `PR`, `CI` events) |
| Post alerts to the team channel | yes | `DESIGNED` | `DESIGNED+CHECKED` when the P5.4 cadence bound is exercised in a rehearsal drill and alert noise stays within it |
| Comment on PRs | yes (advisory only) | `DESIGNED` | `DESIGNED+CHECKED` when a check confirms PR comments carry observation fields only (P5.3 schema — no assessment field) |
| Commit, push, merge, approve, or change protection | no — never | `DESIGNED+CHECKED` — check: P5.1, plan §8 | `ENFORCED` when P5.1 is observed: a write attempt through the observer token **fails**, blocked by credential scope |

The observer **reports facts and risks**. It does not judge semantic correctness and does not merge. This rule must be enforced by credentials, not by instruction — see §7.

**Control vocabulary, applied.** States per the header legend; the observer row above is `DESIGNED+CHECKED` with P5.1 as its named check. The full statement of the vocabulary, the pre-committed downgrade phrasing, and the single entry criterion to `ENFORCED` live in §7 — one statement, one place.

### 5.5 Reporting discipline

- **Facts, not opinions.** "Lane 3 has not moved in 4 hours; the plan allotted 2" — not "Lane 3 is behind schedule."
- **No defending its own plan.** The same machine authored the package and now measures against it. It must report deviation, never rationalise the plan. This is a real risk (§8) with a designed mitigation: the observer's output schema has no field for assessment, only for observation.
- **Deviation is relative to a version.** Every report names the package version it measured against.

### 5.6 Noise control

An observer that alerts constantly is switched off within an hour — the failure mode that kills monitoring systems. Alerts are bounded: only deviation from the plan, CI failures, conflicts, and stalls. Everything else is available on request, not pushed. **Stall alerts never fire for a lane whose owner has declared a pause** (declaration path: `04_DEVELOPMENT_PLAN.md` §10; checklist DC-15). The exception exists because an event of 24 hours or more includes deliberate sleep, and a stall rule that cannot tell sleep from silence produces exactly the noise that gets monitoring muted — see the overnight protocol added at Q2 resolution (`01_DISCOVERY_CLOSURE.md` Q2).

### 5.7 Degradation

**The observer is tier 2.** Under time pressure it is switched off and the team loses monitoring, not capability. This is stated in the blueprint because the alternative — a design where monitoring is load-bearing — would collapse at exactly the moment it is needed.

---

## 6. Data flow

**Provenance of the v1 inline sketch (superseded).** The v1 sketch is not reproduced; `06_ARCHITECTURE.mmd` is the only diagram. The table below records how v1 sketch nodes translate to canonical node IDs.

| Inline sketch node | Canonical node ID | Meaning |
|---|---|---|
| `R` | `RM` | Research mode (subgraph `S1`) |
| `MP` | `MP` | Mission Package vN — frozen, versioned |
| `O` | `OB` | Observer mode — read-only, `degradable` (tier 2), on `S1` |
| `DEV_REPORT` | `DR` | Deviation report — observation fields only, no assessment field |
| `L1`, `L2`, `L3` | `L1`–`L5` | Development lanes — the canonical diagram shows all five, one human · one machine · one worktree/branch each |
| `INT` | `PR` → `MERGE` | Integration is not a node: candidates meet as pull requests (`PR`) and are integrated only by the human merge owner (`MERGE`) |
| `H` | `APPR`, `MERGE`, `ESC` | Human authority (subgraph `HA`): package approval gate, merge owner, escalation/decision point |
| `GIT` | `REPO` | Git remote — repo and branches (subgraph `GH`, with `PR` and `CI`) |

The canonical diagram additionally carries `AG` (task-selected capability bundles, §4.3), `CI` (CI checks), and the explicit failure/escalation edges the sketch omits: `ESC --> MP` (numbered amendment request), `REPO --> lane` (degraded: adopt the frozen package locally if S1 is lost), `OB --> ESC` (observer outage is itself visible), and lane `--> ESC` (escalation triggers, §4.4).

---

## 7. Authority and security boundaries

| Subject | Owner | Boundary | Validation state | Entry criterion to next state |
|---|---|---|---|---|
| Mission Package content | Research machine | Humans approve; AI does not authorise its own scope | `DESIGNED+CHECKED` — check: P3.6 approval gate, plan §6 | `ENFORCED` when P3.6 is observed: a package cannot enter development without a recorded human approval (`APPR`) |
| Scope changes | Humans | Only via numbered amendment | `DESIGNED+CHECKED` — check: P3.5 freeze/amendment protocol, plan §6 | `ENFORCED` when P3.5 is observed: an edit creates a numbered amendment and a silent edit is impossible |
| Code authorship | Individual developer | One writer per workspace | `DESIGNED+CHECKED` — check: P4.8 collision test, plan §7 | `ENFORCED` when P4.8 is observed: two machines attempt one surface and the rule prevents it |
| Merge | **Human** | No AI merge authority, ever | `DESIGNED+CHECKED` — check: P4.6 merge procedure, plan §7 | `ENFORCED` when P4.6 is observed: no AI merge path exists and `MERGE` requires the named human |
| Repository truth | Git remote | No second authoritative database | `DESIGNED` | `DESIGNED+CHECKED` when the reuse-ledger gate (plan §4) is observed rejecting any component that mirrors `REPO` into a second store |
| Check evidence | Reproducible command | A green exit code that scanned nothing is not evidence | `DESIGNED` | `DESIGNED+CHECKED` when one reproducible CI command (`CI`) is defined per merge candidate and its output is recorded at P8 |
| Observer permissions | Read-only credentials | Enforced by token scope, not by instruction | `DESIGNED+CHECKED` — check: P5.1, plan §8 (write attempt fails by credential) | `ENFORCED` when P5.1 is observed blocking a real write attempt through the scoped token; "enforced by token scope" names the intended mechanism, not an observed one |
| Credentials | Per person, least privilege | Never in the repository, never in prompts | `DESIGNED+CHECKED` — check: P2 credential placement, plan §5 | `ENFORCED` when the P2 inventory is observed: every secret's location verified, none in the repo or in a prompt |

**The enforcement principle:** an instruction in a prompt is not a control. A role described as read-only is read-only only when something makes mutation impossible; where that mechanism cannot be configured, the claim is narrowed in writing rather than upgraded in prose.

Applied here: the observer is read-only because its **credential cannot write**. If that cannot be configured, the claim is downgraded and stated as such.

**Three-state control vocabulary.** Every control above carries exactly one state (header legend): `DESIGNED`, `DESIGNED+CHECKED`, `ENFORCED`. **No row is `ENFORCED`.** An instruction in a prompt is not a control, and a mechanism nobody has watched block anything is not enforcement yet — it is a design with a named check. The observer's read-only boundary is `DESIGNED+CHECKED` with **P5.1 — write attempt fails by credential** (`04_DEVELOPMENT_PLAN.md` §8) as the named check; observing P5.1 block a real write is the single entry criterion to `ENFORCED`. Where the Boundary column says "enforced by token scope," it names the intended mechanism, not an observed one (§8.4).

---

## 8. Risks and the scope cut

### 8.1 The honest risk

**Two systems, three roles, and a checklist is already a lot for five people in a short event.** This blueprint deliberately does not add a third service. The table below is the explicit cut order, and it is part of the deliverable, not an admission.

### 8.2 Cut order

Cut priorities sit in a namespace of their own — **C0 — never cut**, **C1 — cut under pressure**, **C2 — cut first** — distinct from the plan phases `P0`–`P9` (`04_DEVELOPMENT_PLAN.md` §2).

| Priority | Component | If cut, what is lost | Validation state | Entry criterion to next state |
|---|---|---|---|---|
| **C0 — never cut** | Mission Package + frozen baseline (`MP`) | The fleet builds against nothing | `DESIGNED+CHECKED` — check: P3 synthetic dry run, plan §6 | `ENFORCED` when the dry run is observed producing an approved, frozen package |
| **C0 — never cut** | One-writer-per-workspace (`L1`–`L5`) | Collisions consume the clock | `DESIGNED+CHECKED` — check: P4.8 collision test, plan §7 | `ENFORCED` when P4.8 is observed preventing same-surface writes |
| **C0 — never cut** | Human merge authority (`MERGE`) | Unrecoverable integration damage | `DESIGNED+CHECKED` — check: P4.6, plan §7 | `ENFORCED` when P4.6 is observed: no AI merge path exists |
| **C1 — cut under pressure** | Observer continuous mode (`OB`) | Loses monitoring; on-demand Git reads remain | `DESIGNED+CHECKED` — check: rehearsal drill 6.5, plan §9 | `ENFORCED` when drill 6.5 is observed: observer off, team still building, the loss visible |
| **C1 — cut under pressure** | Checklist items marked optional | Slower restart; nothing breaks | `DESIGNED` | `DESIGNED+CHECKED` when `05_IMPLEMENTATION_CHECKLIST.md` names a check per optional item |
| **C1 — cut under pressure** | Role collapse on `S1` and at `MERGE` | One human holds two roles (observer operator folded into a lane owner; merge owner folded into the team lead). Costs attention at the worst moment, and makes the merge rule's addressee less available — never the authority itself | `DESIGNED` | `DESIGNED+CHECKED` when T7-02 records the collapsed assignment and the merge-alternate path (`P0.7`) is named alongside it |
| **C2 — cut first** | Parallel workstreams | Slower, but sequential still ships | `DESIGNED+CHECKED` — check: rehearsal drill 6.6 time-box, plan §9 | `ENFORCED` when drill 6.6 is observed: the parallel setup fits inside the preparation window |
| **C2 — cut first** | Automated CI beyond one check (`CI`) | Manual verification, weaker evidence | `DESIGNED` | `DESIGNED+CHECKED` when one CI command is defined and observed runnable on a PR |

**Duration provisionally resolved in part, 2026-09-15.** Q2 is reported as **24 hours or more**, expected two days with overnight work (`01_DISCOVERY_CLOSURE.md` Q2). Consequences for this table: overnight mechanisms are specified and ready, but the short-event cut rules remain an active fallback branch rather than permanently closed. If official organizer rules establish a shorter sprint (≤18 hours), continuous observer mode is cut to C1 by duration alone. The four overnight mechanisms are defined in `04_DEVELOPMENT_PLAN.md` §10, with failure rows in its §11, checklist items DC-14–DC-16, ledger row V12, and premortem entry PM-12.

### 8.3 The cheerleader risk

The research machine authors the plan and later measures progress against it. A system grading its own homework will rationalise. **Mitigation:** the observer's output schema contains observation fields only — deviation magnitude, timestamp, package version. There is no field in which to argue that the plan is still fine. Assessment belongs to humans alone.

### 8.4 Unvalidated assumptions

No rehearsal has occurred, because the event has not happened. The blueprint therefore makes no claim that any mechanism is *proven*. The rehearsal plan (§9 of the development plan) is the test, and its result is expected to correct this document.

---

## 9. Decisions and reversal conditions

| # | Decision | Why | Reverse if |
|---|---|---|---|
| D1 | Observer is a role on S1, not a separate system | Baseline lives with the plan; one fewer failure domain | Research load saturates S1 during the event |
| D2 | Mission Package is the only cross-boundary artifact | Removes prose drift and version skew | Fleet needs richer context than the package carries |
| D3 | Package is frozen and amended, never silently edited | Makes plan drift visible | Amendments become so frequent the freeze loses meaning |
| D4 | Research and observe run concurrently | Research does not stop at build start | Machine cannot sustain both (observer role is halted to C1; research remains on demand) |
| D5 | One writer per workspace | Collisions cost more than parallelism saves | Workstreams prove genuinely independent |
| D6 | Human owns every merge | Integration damage is unrecoverable under time pressure | Never |
| D7 | Observer read-only by credential | Instruction is not enforcement | Credential scoping unavailable — then state the limit |
| D8 | Topic-agnostic everywhere | The topic is unknown by definition | Never |

### Discarded alternatives

| Alternative | Why rejected |
|---|---|
| Three independent systems | Adds a failure domain and a baseline-transfer bug class for no capability gain |
| Autonomous AI merge | No recovery path under time pressure; destroys the audit trail |
| Semantic GitHub judge | Would place an opaque judgement where auditable evidence is required; a judgement that cannot be audited is not evidence |
| Permanent five-agent-per-human ontology | Ages badly the moment task shapes change |
| Custom distributed runtime | Massive cost, no evidence of need before rehearsal |
| Dashboard for appearance | Cost with no operational consumer |
| Internal goal-broker service | The frozen package plus numbered amendments already broker the goal; a service adds a failure domain and a second truth store |
| Goal-transfer database | A versioned file in Git carries the same capability; a database adds skew and migration burden for one writer and five readers |
| Message bus | Coordination events are Git events plus human cadence; a bus adds an unconsumed lifecycle plane (plan §13) |

---

## 10. Open questions — must be closed by the team

These are **not** architectural gaps; they are facts only the team and organizers possess. The architecture is written to survive either answer, and the affected section is named.

| # | Question | Affects |
|---|---|---|
| 1 | One five-person team, or five separate teams? | §4.2 ownership model |
| 2 | Exact dates, duration, and preparation rules? | §8.2 cut order |
| 3 | How is success judged, in the organizers' words? | §3.3 `acceptance_tests` |
| 4 | Machine OS and hardware across the five? | §7 tooling placement |
| 5 | All machines on one network during the event? | §4.5 recovery |
| 6 | Which machine may host long-lived state? | §5.1 observer placement |
| 7 | Which AI accounts, CLIs, and API keys exist per participant? | §4.3 selection |
| 8 | One repository or several? | §4.2 ownership |
| 9 | Are Actions, Apps, webhooks, and branch protection available? | §5.3 observer capability |
| 10 | Who owns final integration and merge? | §7 authority |
| 11 | Is the topic revealed before or at the event? | §3 research runway |
| 12 | Which external services are permitted? | §3.4 degraded modes |
| 13 | What may be captured for the portfolio? | §11 |
| 14 | Who executes this plan after delivery? | Development plan §2 (owners column) and §3–§10 in full, including §9 rehearsal |

**Resolution status (2026-09-15).** Q1 (one team or five) is ANSWERED — one five-person team; Q14 (who executes) is ANSWERED by the operator — the five-person team, with the operator not participating; Q2 (duration) is PARTIAL — 24 hours or more with overnight work, exact hours still open. The remaining eleven questions are OPEN and close at T7-01. The full register, with each answer's source, date, authority, and affected section, is `01_DISCOVERY_CLOSURE.md`; this table stays as the question list, and the register is where answers accumulate.

---

## 11. Portfolio and privacy boundary

**The claim, stated exactly** (usable only once all artifacts exist and agree):

> The operator designed and documented an implementation-ready multi-AI workflow for a five-person
> cybersecurity team facing an unknown hackathon topic: a research machine that freezes an approved
> Mission Package, a multi-laptop development fleet under one-writer ownership, and a read-only,
> degradable observer. Deliverables: architecture blueprint, A–Z development plan, implementation
> checklist, and a version-controlled diagram.

**Scope of the discovery, stated exactly:** discovery is specified rather than completed. Stakeholder
intent, constraints, assumptions, non-goals, risks, and decision owners are explicit. Of the
fourteen architecture-blocking questions, two are answered, one is answered in part, and eleven
remain open, tracked with sources and dates in `01_DISCOVERY_CLOSURE.md` (counted by the register's
own status column: 2 `ANSWERED`, 1 `PARTIAL`, 11 `OPEN`).

**Attribution, stated exactly:**

> The operator designed the architecture and workflow. The operator did not build, deploy, or test these systems, and did not participate in the hackathon solution. The five-person team owns implementation of the hackathon solution. No hackathon outcome or semantic correctness is claimed.

**Privacy:** no participant names, no repository contents, no credentials, no sponsor or organizer material, no topic-specific detail that could disadvantage the team's October event. Any example in any artifact is synthetic and must be labelled synthetic.

**What this does not prove:** no hackathon outcome; no semantic correctness of the team's solution; no proof that any mechanism held under real time pressure; no rehearsal evidence (none exists yet); no claim that monitoring improves delivery.

**What this demonstrates:** translating an ambiguous, high-pressure external mission into explicit requirements, authority boundaries, failure modes, and a handoff another engineer can execute without a second architecture meeting.

---

## 12. Completion criterion

This blueprint is complete when a senior engineer who has never spoken to the author can answer, without another meeting:

- what starts the system, and on which machine;
- what each human and each AI role may read, write, execute, and approve;
- exactly what crosses from research into development;
- how two developers are prevented from owning the same surface;
- how GitHub is observed without the observer gaining write authority;
- how a failed or disconnected machine is replaced;
- what evidence permits integration, and who decides;
- what the team does when time runs short.
