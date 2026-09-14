# Development Plan — Multi-AI Workflow for a Five-Person Cybersecurity Hackathon

**Status:** draft v1, 2026-09-14
**Companion to:** `03_ARCHITECTURE_BLUEPRINT.md`
**Purpose:** an ordered, implementation-ready plan the team can execute without another architecture session
**Not in scope:** building the hackathon solution

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

| Phase | When | Owner | Produces | Gate |
|---|---|---|---|---|
| **P0 — Discovery closure** | T-14 to T-7 | Architect + team | Closed questions, signed scope | Team sign-off |
| **P1 — Reuse ledger** | T-10 to T-7 | Architect | `REUSE_LEDGER.md` | Every candidate classified |
| **P2 — Environment inventory** | T-7 to T-3 | Team | Machine/account matrix | All five machines reachable |
| **P3 — Core setup: research machine** | T-5 to T-2 | Architect + 1 engineer | Working S1 | Dry-run produces a synthetic package |
| **P4 — Core setup: development fleet** | T-5 to T-2 | Architect + team | Repo, ownership, merge rule | Two-machine collision test passes |
| **P5 — Observer setup (tier 2)** | T-3 to T-1 | Architect + 1 engineer | Read-only observer | Credential proven write-incapable |
| **P6 — Rehearsal** | T-2 to T-1 | Whole team | Rehearsal record | Tabletop + dry run pass or corrections recorded |
| **P7 — Event-day startup** | T+0 | Team | Running system | Startup checklist complete |
| **P8 — Event operation** | T+0 to T+end | Team | Solution + evidence | Submission |
| **P9 — Teardown** | T+end | Team | Post-event record | Portfolio sanitization |

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

**Why this is a real phase:** the sibling rehearsal `27_ORCA_VERTICAL_SLICE_REHEARSAL` failed its own preflight (NO-GO) precisely because launch and evidence rules were implicit. The correction was to make them explicit *before* execution. Same pattern here.

---

## 4. P1 — Reuse ledger

**Goal:** decide what transfers from prior work, and refuse to import accumulated coupling. The return brief calls this "avoid starting from scratch without importing accumulated mistakes."

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
| P3.6 Approval gate | Architect | Human approval step | Package cannot enter development without a recorded approval |
| P3.7 Degraded modes | Architect | Behaviour table | Offline test: last frozen package still served |

**Gate:** a synthetic dry run produces a package a second person can read and act on without asking the author anything.

**Explicit test — the anti-cheerleader check:** feed the system a plan that is objectively wrong and verify the observer reports deviation rather than defending it (§7, P5.4).

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

**Gate:** two machines can work concurrently without collision, demonstrated, not asserted.

---

## 8. P5 — Observer (tier 2, degradable)

| Task | Owner | Output | Acceptance |
|---|---|---|---|
| P5.1 Read-only credential | Architect | Scoped token | A write attempt through this token **fails** — proven by execution |
| P5.2 Watch set definition | Architect | Event list | Which GitHub events matter, and why |
| P5.3 Deviation model | Architect | Output schema | Schema has observation fields only — no assessment field |
| P5.4 Reporting cadence | Architect | Bound | Alerts on deviation, failure, conflict, stall only |
| P5.5 Ask-anytime path | Architect | Query flow | Any team member can ask "where are we?" and get a package-versioned answer |
| P5.6 Outage visibility | Architect | Failure behaviour | Observer down is itself visible, not silently absent |

**P5.1 is the load-bearing test.** If the credential cannot be scoped to read-only, the claim in blueprint §7 is downgraded and stated as a limitation. It is never softened into "we told it not to write."

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

**Rationale, from the sibling project:** a determinism suite that has never been observed to fail is not evidence. Same principle — a workflow drill that has never failed has proven nothing.

---

## 10. P7–P9 — Event operation

### P7 Startup
Machine health → credentials present → repository reachable → roles announced → observer status stated aloud (on/off) → start.

### P8 Operation

| Cadence | Action | Owner |
|---|---|---|
| Continuous | Observer reports deviation vs. frozen package | Observer |
| On escalation trigger | Human decision | Named human |
| On scope change | Numbered amendment | Approver |
| Continuous | Research on demand | S1 research mode |
| At integration points | Human merge, in order | Merge owner |

### P9 Teardown
Stop observer → release credentials → archive evidence → **sanitize before anything reaches a portfolio** → confirm no participant, repository, or organizer material is exposed.

---

## 11. Failure matrix

| Failure | Detection | Response | Fallback |
|---|---|---|---|
| Topic harder than expected | Research returns few sourced findings | Widen sub-questions; mark unknowns explicitly | Build against what is known; state unknowns in the demo |
| S1 machine lost | Observer and research both stop | Adopt from a second machine using the frozen package in Git | Read package locally; continue |
| Provider outage | Research stalls | Second provider or manual browser research | Proceed with frozen findings |
| Fleet collision | Observer reports same-surface writes | Stop both; reassign per ownership rule | Serialize the two workstreams |
| Plan diverges from reality | Observer reports deviation | Human decides: amend or accept | Continue against frozen package, accepting known drift |
| CI unavailable | No automated check result | Manual verification by a second person | Weaker evidence, stated as such |
| Observer down | Missing reports | Team notices on the next ask | Continue without monitoring |
| Time running out | Clock | Apply cut order (blueprint §8.2) | Ship the P0 set only |
| "It works" asserted | No reproducible check | Demand the command and its output | Treat as unverified |

---

## 12. Acceptance matrix

| Requirement | Observable acceptance | Phase |
|---|---|---|
| Ambiguity converted to explicit requirements | Blueprint §10 closed with owners | P0 |
| No component without demonstrated need | Every component has a reuse-ledger row | P1 |
| Environment known, not assumed | Machines observed by command | P2 |
| Research produces structure, not answers | Package validates; unknowns explicit | P3 |
| Provenance mandatory | Every claim sourced or `[unverified]` | P3 |
| Contradictions preserved | Deliberate contradiction survives synthesis | P3 |
| Package frozen and amendable | Silent edit impossible | P3 |
| One writer per surface | Collision drill passes | P4 |
| Human-only merge | No AI merge path exists | P4 |
| Observer cannot write | Write attempt fails by credential | P5 |
| Observer reports facts, not judgements | Output schema lacks an assessment field | P5 |
| Degradation is visible | Observer-off drill leaves loss visible | P6 |
| Design survives scrutiny | Adversarial review findings resolved | P6 |
| Handoff needs no second meeting | A new reader answers blueprint §12 unaided | P6 |

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
- importing Omega V3 components wholesale;
- any claim that multi-agent agreement equals truth;
- publishing participant, sponsor, repository, or credential information.

---

## 14. Open questions carried from the blueprint

Blueprint §10, questions 1–14, remain the plan's inputs. Two of them change this document structurally and must be answered at P0:

- **Q1 (one team or five?)** — determines whether P4 is one fleet with five workstreams or five coordinated teams. The plan holds either shape; the ownership registry is written after this answer.
- **Q2 (exact duration)** — determines whether the cut order in blueprint §8.2 drops P1 or P2 items. A short event drops observer automation entirely and keeps manual Git reads.

No phase beyond P0 starts before these two are answered.

---

## 15. Completion criterion

The plan is executable when another engineer or supervised AI fleet can begin implementation from this document and the blueprint **without another architecture session**, and when every phase above has an owner and an observable acceptance condition.

It is **not** complete when the documents exist. It is complete when the P6 rehearsal passes or its failures are recorded as corrections.
