# Reuse Ledger — Multi-AI Workflow for a Five-Person Cybersecurity Hackathon

**Status:** draft v1, 2026-09-14
**Phase:** P1 deliverable (plan §2)
**Companion to:** `03_ARCHITECTURE_BLUEPRINT.md`, `04_DEVELOPMENT_PLAN.md`
**Verdict authority:** plan §4 (`04_DEVELOPMENT_PLAN.md:71-85`). This ledger expands each verdict into
the full 10-field record required by the return brief §8 (`00_RETURN_BRIEF.md:300-313`). It does not
re-decide any verdict.
**Not in scope:** building the hackathon solution; porting donor code (expected direct code copied
from prior work: zero lines — `25_QUICK_REUSE_SWEEP/SYNTHESIS.md:158`).

---

## 0. Legend and verification method

**Claim labels** (house convention, contract §2):

- `[FACT]` — executed or read directly. In this ledger, `[FACT]` means either (a) content read
  directly from the cited file, or (b) a behaviour that was executed **in the donor system** and
  recorded in the cited corpus artifact. This ledger ran no new executions; the event has not
  happened and no rehearsal for this project has run.
- `[INFERENCE]` — reasoned from cited evidence.
- `[UNPROVEN]` — designed, not tested.
- Audit-grade variants `[VERIFIED BY EXECUTION]` and `[READ]` appear only when describing what the
  cited corpus artifact itself claims.

**Validation states** (contract §2 vocabulary):

| State | Meaning |
|---|---|
| `DESIGNED` | Specified in an artifact. No check has ever exercised it. |
| `DESIGNED+CHECKED` | Specified and a defined check exists that can exercise it (the check is named). |
| `ENFORCED` | A mechanism makes the violation impossible, and that mechanism has been observed to block it. |

**Nothing in this ledger is `ENFORCED`.** No check named here has been run against this project.
Every row carries entry criteria to the next state.

**Anchor roots.** `CORPUS` = the operator's private `13_LESSONS/` audit corpus (local records;
absolute path deliberately not published). Corpus anchors below are relative to the `CORPUS` root
unless a fuller relative path is given. `BRIEF` = the return brief
(`14_HACKATHON_MULTI_AI/00_RETURN_BRIEF.md` within the same private preparation corpus). Repo
anchors (`03_ARCHITECTURE_BLUEPRINT.md`, `04_DEVELOPMENT_PLAN.md`) are relative to this
repository's root. Diagram node IDs (`S1`, `S2`, `MP`, `OB`, `DR`, `AG`, `L1`–`L5`, `REPO`, `PR`,
`CI`, `MERGE`, `ESC`, `APPR`) reference `06_ARCHITECTURE.mmd` per the shared contract §4.

**Verification method for this draft.** Read directly on 2026-09-14: repo drafts at commit
`3ea098f` (`04_DEVELOPMENT_PLAN.md:71-89` verdict table and gate; `03_ARCHITECTURE_BLUEPRINT.md`
§3–§9); `BRIEF` §8–§9; corpus files `01_FAILURE_CATALOG.md`, `02_GATES.md`,
`03_DECLARATION_PROTOCOL.md`, `05_REPO_ONTOLOGY.md`, `06_DECISION_BRIEF.md`, `08_OMP_AS_RUNTIME.md`,
`21_OMEGA_ZERO_BLUEPRINT.md`, `22_ORCA_RECONCILIATION.md`, `24_CURRENT_AGREED_PLAN_HANDOFF.md`,
`25_QUICK_REUSE_SWEEP/SYNTHESIS.md`, `26_WEDNESDAY_EXECUTION_PACKAGE/09_REUSE_LEDGER.md` and
`workers/W2_RUNTIME_TRUTH.md`, `27_ORCA_VERTICAL_SLICE_REHEARSAL/03_GIT_WORKTREE_PROOF.md`,
`05_FAILURES_AND_CORRECTIONS.md`, `review/R1_EXACT_CANDIDATE_REVIEW.md`, `review/A1_EVIDENCE_AUDIT.md`,
`28_HACKATHON_TOMORROW_CONCEPT.md`, `28_OMEGA_ZERO_EXTERNAL_RESEARCH/workers/R2_ORCHESTRATION_LIFECYCLE.md`,
`30_OMEGA_ZERO_WEDNESDAY_DELIVERY/05_B1_RUN_REGISTER.md`. Candidate count method: the 13 records
below are 1:1 with the 13 rows of plan §4, in plan order; none added, none removed.

---

## 1. Gate and filter

**Gate (plan §4, `04_DEVELOPMENT_PLAN.md:89`):** no component enters the architecture without a
ledger row. A component with no demonstrated need is **dropped, not deferred**.

**The one-line filter for every proposed component** (`05_REPO_ONTOLOGY.md:260-263`, Part 6):

> **"If I delete this, what breaks?"**
> If the answer is "a test", delete it. If the answer is "a user-visible behaviour", port it.

This filter is why the ledger records CURRENT CONSUMER for every candidate. The donor system's
dominant failure was declaring mechanisms with no consumer: 13 of 17 governance mechanisms examined
had at least one declared field with no production reader (`01_FAILURE_CATALOG.md:13`, RC-1). The
companion test for any field carried forward: *"Which file:line reads this, and what changes?"*
(`05_REPO_ONTOLOGY.md:140`).

---

## 2. Classification vocabulary

| Class | Definition |
|---|---|
| **REUSE** | The discipline, rule, or contract transfers as-is into the target workflow. Only retitling or re-instantiation for this team is allowed; no redesign. REUSE never means copying donor code — the donor's own sweep classified its worktree manager and runtime modules as reference-only or non-transplants (`25_QUICK_REUSE_SWEEP/SYNTHESIS.md:110,137-138`). |
| **ADAPT** | The shape transfers, but a structural change is required before use in the target (e.g. a role identity becomes a per-task bundle; a separate service becomes a mode on `S1`). The adaptation is named in REQUIRED REWRITE. |
| **REFERENCE ONLY** | Consulted as design input. Nothing ships. No target test exists, because no target mechanism exists. |
| **DROP** | Absent from the target architecture. A drop is a decision with a recorded cost (stated in every DROP record), not a deferral. Re-entry requires a ledger amendment backed by demonstrated need — per the standing rule "automate only friction demonstrated in rehearsal" (`BRIEF:347`; `28_HACKATHON_TOMORROW_CONCEPT.md:42`). |

---

## 3. Records

One record per candidate, in plan §4 order. Fields are the ten required by `BRIEF:300-313`, plus the
validation state required by contract §2.

### L-01 — Principal/worker separation — **ADAPT**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Orca-native fleet model: one Principal agent plus replaceable worker CLIs in four bounded task shapes (Principal / Scout / Builder / Reviewer) — `24_CURRENT_AGREED_PLAN_HANDOFF.md:23-29`; shape table `22_ORCA_RECONCILIATION.md:352-359`; model choice declared as launch configuration, not ontology — `22_ORCA_RECONCILIATION.md:361-367`. |
| 2 | CURRENT CONSUMER | Donor supervised runs. Executed by a Principal + Builder + independent Reviewer: B1 delivery (`30_OMEGA_ZERO_WEDNESDAY_DELIVERY/05_B1_RUN_REGISTER.md:45-61`) and the vertical-slice rehearsal (`27_ORCA_VERTICAL_SLICE_REHEARSAL/review/R1_EXACT_CANDIDATE_REVIEW.md`). |
| 3 | BEHAVIOR ACTUALLY PROVED | `[FACT]` The separation ran end-to-end in the donor: a Builder produced a candidate, an independent Reviewer read the exact SHA, and the Principal rejected three candidates for named defects rather than accepting completion claims (`30_OMEGA_ZERO_WEDNESDAY_DELIVERY/05_B1_RUN_REGISTER.md:45-51`; `27_ORCA_VERTICAL_SLICE_REHEARSAL/review/R1_EXACT_CANDIDATE_REVIEW.md:14-20`). `[INFERENCE]` The shape survives translation to per-task bundles, because the donor already treated model/role choice as launch configuration (`22_ORCA_RECONCILIATION.md:361-367`). `[UNPROVEN]` Anything about the hackathon fleet — no rehearsal for this project has run. |
| 4 | TARGET USE | On `S2`: a coordinating human-or-agent role interprets the frozen `MP` and dispatches bounded tasks; each task runs with a capability bundle selected for that task (`AG` → `L1`–`L5`, edges E19–E23). No permanent agent identity; no five-agents-per-human ontology (prohibited, contract §1; blueprint §4.3). |
| 5 | DEPENDENCIES | Per-participant agent CLI availability (P0.5, P2 account matrix); the `MP` as the only task input crossing the boundary; Git for workspace placement. |
| 6 | MULTI-MACHINE RISK | The coordinating role must not become a dispatch bottleneck or a single point of failure: if coordination is unavailable, lanes continue independently against the frozen package (blueprint §4.5; edge E29). |
| 7 | SECURITY / PRIVACY RISK | Workers act under their human's credentials, least privilege per person (blueprint §7). The coordinator never merges — merge authority is the `MERGE` node, one named human (D6, "never" reversed). |
| 8 | REQUIRED REWRITE | Re-express the four task shapes as a per-task menu inside the workstream template (P4.3); strip donor-runtime lifecycle vocabulary; keep the ownership/completion-evidence columns of `22_ORCA_RECONCILIATION.md:354-359` as the bundle contract. |
| 9 | TARGET TEST OR REHEARSAL | **P6 step 6.1** tabletop: every participant states what they own and what they may write, and names the bundle their next task uses — not a persona. Plus **P4.2** acceptance: two workstreams cannot claim one surface. |
| 10 | DECISION | **ADAPT** — same shape, but roles become per-task bundles, not identities (plan §4, `04_DEVELOPMENT_PLAN.md:73`). |
| — | Validation state | `DESIGNED+CHECKED` — checks P6 6.1 and P4.2 are defined in the plan; neither has run. → `ENFORCED` when: a rehearsal observes a persona-style or same-surface claim actually rejected at dispatch or by the registry. |

### L-02 — Task and result contracts — **REUSE**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Five-field task brief (TARGET / CHANGE OR QUESTION / CONSTRAINTS–DO-NOT-TOUCH / OWNERSHIP–WORKSPACE / OBSERVABLE ACCEPTANCE) and eight-field result (OUTCOME / ARTIFACT OR COMMIT / FILES MODIFIED / CHECKS ACTUALLY RUN / OBSERVED OUTPUT / FACTS / INFERENCES / UNCERTAINTIES) — `22_ORCA_RECONCILIATION.md:373-392`. Deliberately Markdown; "do not create parallel JSON schemas until executable code consumes them" — `22_ORCA_RECONCILIATION.md:394-395`. |
| 2 | CURRENT CONSUMER | Donor worker dispatches: the approved B1 task contract (`30_OMEGA_ZERO_WEDNESDAY_DELIVERY/05_B1_RUN_REGISTER.md:7`) and rehearsal worker briefs; the prior sweep classified the templates "REUSE almost verbatim" (`25_QUICK_REUSE_SWEEP/SYNTHESIS.md:33`). |
| 3 | BEHAVIOR ACTUALLY PROVED | `[FACT]` The contract was exercised in donor runs: briefs dispatched, results consumed at settlement, and defects found in candidates through the result fields (`30_OMEGA_ZERO_WEDNESDAY_DELIVERY/05_B1_RUN_REGISTER.md:45-61`). `[FACT]` The counter-evidence is also recorded: contract-shaped fields with no reader are exactly what RC-1 counted 13 of 17 times (`01_FAILURE_CATALOG.md:13`) — the Markdown contract survived because humans read it; unconsumed JSON schemas did not. `[UNPROVEN]` In the hackathon fleet. |
| 4 | TARGET USE | Every lane dispatch and every escalation message in the `S2` fleet; the CHECKS ACTUALLY RUN + OBSERVED OUTPUT fields are what flow to `PR` → `MERGE` as evidence (edge E17 "exact candidate diff + evidence"). |
| 5 | DEPENDENCIES | None beyond Git and one authoritative template file in the repo. No schema validator until code consumes one (`22_ORCA_RECONCILIATION.md:394-395`). |
| 6 | MULTI-MACHINE RISK | Template drift across five machines — mitigated by keeping the single authoritative copy in the repo (one fact, one writer: `01_FAILURE_CATALOG.md:178`). |
| 7 | SECURITY / PRIVACY RISK | The CONSTRAINTS field carries do-not-touch surfaces. No credentials in briefs, ever (plan §5 credential placement: "never in the repo; never in a prompt"). |
| 8 | REQUIRED REWRITE | Retitle field references to Mission Package vocabulary: OWNERSHIP points at `MP.task_ownership`; OBSERVABLE ACCEPTANCE points at `MP.acceptance_tests` (blueprint §3.3). |
| 9 | TARGET TEST OR REHEARSAL | **P6 step 6.2** synthetic dry run: every dispatch in the exercise carries the five-field brief, and any completion claim missing CHECKS ACTUALLY RUN or OBSERVED OUTPUT is refused at the **P4.6** merge checklist. |
| 10 | DECISION | **REUSE** — directly transferable discipline (plan §4, `04_DEVELOPMENT_PLAN.md:74`). |
| — | Validation state | `DESIGNED+CHECKED` — checks P6 6.2 + P4.6 defined; not run. → `ENFORCED` when: a rehearsal observes an evidence-less result actually refused at the merge gate. |

### L-03 — One-writer-per-workspace — **REUSE**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | "One mutating agent per worktree, not one mutating agent for the whole fleet" — `22_ORCA_RECONCILIATION.md:36-39`; "exactly one mutating worker owns each worktree at a time" — `24_CURRENT_AGREED_PLAN_HANDOFF.md:82-84`. |
| 2 | CURRENT CONSUMER | Donor runtime workspace placement: every parallel mutating dispatch got a distinct worktree (`22_ORCA_RECONCILIATION.md:74-82`). |
| 3 | BEHAVIOR ACTUALLY PROVED | `[FACT]` Exercised in the donor: distinct worktrees, base checkout unchanged, porcelain-clean status before and after, no merge (`27_ORCA_VERTICAL_SLICE_REHEARSAL/03_GIT_WORKTREE_PROOF.md:46-50`). `[FACT]` The rule held because placement was per-dispatch; when placement itself erred, a worktree was created from the wrong repository context and had to be stopped and re-issued (`30_OMEGA_ZERO_WEDNESDAY_DELIVERY/05_B1_RUN_REGISTER.md:18-32`) — the rule needs correct instantiation, not just declaration. `[UNPROVEN]` Across five machines and five humans. |
| 4 | TARGET USE | The core anti-collision rule on `S2`: one lane = one human = one machine = one worktree/branch `workstream-N` (`L1`–`L5`); ownership recorded in `MP.task_ownership` (blueprint §4.2). |
| 5 | DEPENDENCIES | Repo and branch topology (P4.1); ownership registry (P4.2); shared Git remote (`REPO`). |
| 6 | MULTI-MACHINE RISK | Same-surface claims across machines are the primary collision mode; the registry is the single arbiter; an unresolved claim escalates to `ESC` (edge E27 "same-surface claim (any lane)"). |
| 7 | SECURITY / PRIVACY RISK | Low. Prevents accidental writes to protected or frozen surfaces. It is an anti-collision rule, **not** a security control — see L-08. |
| 8 | REQUIRED REWRITE | None to the rule. Instantiate the registry (one row per workstream) at P4.2, after blueprint §10 Q1 (one team or five) is answered. |
| 9 | TARGET TEST OR REHEARSAL | **P4.8** collision test: two machines attempt the same surface; the rule prevents it — observable as the second writer being refused or escalated before any commit lands. Re-run as **P6 step 6.3** drill with the observer reporting the violation. |
| 10 | DECISION | **REUSE** — core anti-collision rule (plan §4, `04_DEVELOPMENT_PLAN.md:75`). |
| — | Validation state | `DESIGNED+CHECKED` — check P4.8 defined; not run. → `ENFORCED` when: P4.8/6.3 executed and a real same-surface attempt is observed blocked. |

### L-04 — Independent review of exact candidate — **REUSE**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | "Candidate changes are reviewed as exact commits or diffs, never accepted from prose alone" — `24_CURRENT_AGREED_PLAN_HANDOFF.md:86`; Reviewer task shape — `22_ORCA_RECONCILIATION.md:359`; salvage scenarios 6–7 (reviewer differs from author; reviewer reads the exact commit/diff) — `25_QUICK_REUSE_SWEEP/SYNTHESIS.md:126-127`. |
| 2 | CURRENT CONSUMER | Donor Reviewer role plus human acceptance; executed once end-to-end in the vertical-slice rehearsal (`27_ORCA_VERTICAL_SLICE_REHEARSAL/review/R1_EXACT_CANDIDATE_REVIEW.md`). |
| 3 | BEHAVIOR ACTUALLY PROVED | `[FACT]` `[VERIFIED BY EXECUTION]` in the donor: the reviewer confirmed candidate SHA `4a9fbc0…`, one-commit ancestry from base `839fc9f…`, the exact changed-path set (`src/normalizer.py` only), and ran the prescribed tests to exit 0 (`27_ORCA_VERTICAL_SLICE_REHEARSAL/review/R1_EXACT_CANDIDATE_REVIEW.md:14-20,53-59,88`). `[FACT]` Limitation observed in the same run: the reviewer was *instructed* read-only but not capability-fenced; no `readOnly` enforcement field existed (`27_ORCA_VERTICAL_SLICE_REHEARSAL/05_FAILURES_AND_CORRECTIONS.md:8`; `review/A1_EVIDENCE_AUDIT.md:254-258`). Independence held by observation, not by mechanism. `[UNPROVEN]` In the hackathon GitHub flow. |
| 4 | TARGET USE | Every `PR` is reviewed as an exact diff (edge E17) before the human `MERGE` decision; reviewer is never the author. |
| 5 | DEPENDENCIES | GitHub PRs (`PR`); CI results attached to the PR (E15/E16); named merge owner (P0.7). |
| 6 | MULTI-MACHINE RISK | Review must reference commit SHAs on the shared remote, never machine-local state — `REPO` is the shared identity for candidates. |
| 7 | SECURITY / PRIVACY RISK | Do not repeat the donor gap: reviewer read access must not imply write access. Where credentials can be scoped, scope them; where they cannot, state the limit plainly (blueprint §7 enforcement principle). |
| 8 | REQUIRED REWRITE | None to the discipline. Encode it in the P4.6 merge checklist: the review record names base SHA, candidate SHA, changed paths, and commands run with output. |
| 9 | TARGET TEST OR REHEARSAL | **P6** rehearsal: one lane's candidate is reviewed by a different human-or-agent from the exact diff, and the **P4.6** merge checklist refuses any review that cites prose instead of a SHA. |
| 10 | DECISION | **REUSE** — review a commit, never a prose summary (plan §4, `04_DEVELOPMENT_PLAN.md:76`). |
| — | Validation state | `DESIGNED+CHECKED` — check P4.6 + P6 defined; not run. → `ENFORCED` when: a rehearsal observes a prose-only review actually refused at the merge gate. |

### L-05 — Evidence-before-completion — **REUSE**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Donor skill `verification-before-completion`, distilled to its five-line operational core: identify what proves the claim; run it fresh; read the complete result and exit status; state success only when the evidence supports it; otherwise report the actual state — `25_QUICK_REUSE_SWEEP/SYNTHESIS.md:43-57`. |
| 2 | CURRENT CONSUMER | Donor worker instructions and the Principal's settlement check; executed at B1 (`30_OMEGA_ZERO_WEDNESDAY_DELIVERY/05_B1_RUN_REGISTER.md:45-61`). |
| 3 | BEHAVIOR ACTUALLY PROVED | `[FACT]` Exercised in the donor: completion claims were refused three times for named defects; a worker's completion claim emitted after context exhaustion was explicitly not accepted; the Principal independently re-ran 15 tests and checked Git facts rather than trusting the report (`30_OMEGA_ZERO_WEDNESDAY_DELIVERY/05_B1_RUN_REGISTER.md:45-61`). `[FACT]` The failure it defends against is catalogued: "tiny green tests can be over-read" (`27_ORCA_VERTICAL_SLICE_REHEARSAL/05_FAILURES_AND_CORRECTIONS.md:12`) and the plan's own failure row "'It works' asserted" (`04_DEVELOPMENT_PLAN.md:212`). `[UNPROVEN]` Under hackathon time pressure. |
| 4 | TARGET USE | Every lane's "done": a worker completion event is a claim, not acceptance (`BRIEF:341`, hypothesis 6). Merge evidence = reproducible command + output (`CI` node label: "reproducible commands, not narration"; blueprint §7: "a green exit code that scanned nothing is not evidence"). |
| 5 | DEPENDENCIES | Repo-defined check commands runnable from a clean checkout on any machine; result-contract fields CHECKS ACTUALLY RUN / OBSERVED OUTPUT (L-02). |
| 6 | MULTI-MACHINE RISK | Evidence must be machine-independent: command + output committed to the PR, never "works on my machine" narration. |
| 7 | SECURITY / PRIVACY RISK | Redact evidence tails before sharing beyond the team (donor positive pattern: bounded, redacted evidence tails — `01_FAILURE_CATALOG.md:245`). |
| 8 | REQUIRED REWRITE | Keep one authority: a single short section in the fleet's root instructions, not duplicated per lane or per document — "do not put the same wording in both places" (`25_QUICK_REUSE_SWEEP/SYNTHESIS.md:56-57`). Note: the prior Wednesday ledger recorded this item as "ADAPT AFTER DOGFOOD" (`26_WEDNESDAY_EXECUTION_PACKAGE/09_REUSE_LEDGER.md:8`); plan §4 says REUSE. The verdict stands as the operator's decision; the distillation requirement is carried in this field. |
| 9 | TARGET TEST OR REHEARSAL | **P6 steps 6.2/6.3**: a completion claim with empty CHECKS ACTUALLY RUN is refused at the **P4.6** merge gate; and a check that scanned nothing fails rather than passes (salvage scenario 1, `25_QUICK_REUSE_SWEEP/SYNTHESIS.md:120-121`). |
| 10 | DECISION | **REUSE** — a worker's "done" is a claim, not proof (plan §4, `04_DEVELOPMENT_PLAN.md:77`). |
| — | Validation state | `DESIGNED+CHECKED` — checks P6 6.2/6.3 + P4.6 defined; not run. → `ENFORCED` when: a rehearsal observes an unevidenced completion claim actually refused. |

### L-06 — Read-only observer with read-only credential — **ADAPT**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Observer concept for this engagement — `28_HACKATHON_TOMORROW_CONCEPT.md:9-10`; the enforcement lesson it must absorb: "instruction is not enforcement" — `27_ORCA_VERTICAL_SLICE_REHEARSAL/05_FAILURES_AND_CORRECTIONS.md:8`; design in blueprint §5, decision D7 (`03_ARCHITECTURE_BLUEPRINT.md:322`). |
| 2 | CURRENT CONSUMER | **None.** The donor's earlier "Orca Observer" experiment was archived, out of scope (`21_OMEGA_ZERO_BLUEPRINT.md:905`). The only prior material this component consumes is the fencing failure lesson, not running code. |
| 3 | BEHAVIOR ACTUALLY PROVED | `[UNPROVEN]` The observer has never run anywhere, in any system. `[FACT]` The donor proved the negative that shapes this design: an agent *instructed* read-only was not capability-fenced, no `readOnly` field existed in receipts, and "malicious or mistaken mutation was not mechanically impossible" (`27_ORCA_VERTICAL_SLICE_REHEARSAL/05_FAILURES_AND_CORRECTIONS.md:8`; `review/A1_EVIDENCE_AUDIT.md:254-258`). `[INFERENCE]` A GitHub credential scoped read-only makes writes fail at the credential level; this is standard platform behaviour but has not been executed for this project — P5.1 exists precisely to execute it. |
| 4 | TARGET USE | Observer mode on `S1` (`OB` node, degradable tier 2): watch `REPO`/`PR`/`CI` events through a read-only credential (E24), emit deviation reports against `MP` vN (`DR` node, E25), feed `ESC` with facts and risks, never assessment (E26). Output schema has observation fields only — no assessment field (blueprint §8.3 anti-cheerleader mitigation). |
| 5 | DEPENDENCIES | GitHub org capabilities unknown until P0.6 / blueprint §10 Q9 (Actions, Apps, webhooks, branch protection); a long-lived process on `S1`; the frozen `MP` as the deviation baseline. |
| 6 | MULTI-MACHINE RISK | Tier 2 by design: if the observer or `S1` is lost, the fleet keeps building (E29; blueprint §4.5). Observer outage is itself visible (E30; P5.6). |
| 7 | SECURITY / PRIVACY RISK | Load-bearing. If the credential cannot be scoped read-only, the claim is downgraded and stated as a limitation — never softened into "we told it not to write" (contract §1; blueprint §7; plan §8, `04_DEVELOPMENT_PLAN.md:155`). Alerts and reports carry no private repository content into portfolio material (P9 sanitization). |
| 8 | REQUIRED REWRITE | Full re-implementation as a mode on `S1`, not a separate service (D1: one fewer failure domain, no baseline-transfer bug class). New artifacts: watch set (P5.2), deviation schema (P5.3), bounded alert cadence (P5.4), ask-anytime path (P5.5), outage visibility (P5.6). |
| 9 | TARGET TEST OR REHEARSAL | **P5.1** — a write attempt through the observer credential **fails, proven by execution** (the load-bearing test, `04_DEVELOPMENT_PLAN.md:148,155`); **P5.3** — schema check: no assessment field exists; **P6 step 6.5** — observer-off drill: team continues building and the loss is visible. |
| 10 | DECISION | **ADAPT** — becomes a mode on S1, not a separate service (plan §4, `04_DEVELOPMENT_PLAN.md:78`). |
| — | Validation state | `DESIGNED+CHECKED` — check P5.1 is defined, concrete, and executable before the event; not run. → `ENFORCED` when: P5.1 executed and an actual write attempt through the scoped credential is observed to fail. Until then the honest phrasing is "contractually read-only; no write path observed" — never "security-enforced". |

### L-07 — Git worktree isolation — **REUSE**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Worktree-per-mutating-task placement — `22_ORCA_RECONCILIATION.md:74-82`; "worktrees/clones manage cooperative concurrency, not hostile-code containment" — `BRIEF:344` (hypothesis 9); `24_CURRENT_AGREED_PLAN_HANDOFF.md:83-85`. |
| 2 | CURRENT CONSUMER | Donor runtime placement for parallel builders; Git ancestry and isolation verified by execution (`27_ORCA_VERTICAL_SLICE_REHEARSAL/03_GIT_WORKTREE_PROOF.md:7-11`). |
| 3 | BEHAVIOR ACTUALLY PROVED | `[FACT]` `[VERIFIED BY EXECUTION]` in the donor: `git worktree list --porcelain` confirmed the created checkout; the candidate was exactly one commit beyond base; base remained at its commit with empty porcelain status; no merge occurred (`22_ORCA_RECONCILIATION.md:74-79`; `27_ORCA_VERTICAL_SLICE_REHEARSAL/03_GIT_WORKTREE_PROOF.md:46-50`). `[FACT]` Lineage caveat recorded: the runtime reported `parentWorktreeId: null` — Git separation proven, placement-lineage metadata absent; claims were narrowed accordingly (`27_ORCA_VERTICAL_SLICE_REHEARSAL/05_FAILURES_AND_CORRECTIONS.md:7`). `[UNPROVEN]` Five concurrent lanes across five machines — the donor proved one machine, one candidate. |
| 4 | TARGET USE | Each lane owns its branch/worktree `workstream-N` (`L1`–`L5`); cooperative concurrency with the base checkout untouched; after machine loss, work is reassignable from Git state alone (blueprint §4.5; E29). |
| 5 | DEPENDENCIES | Git remote (`REPO`); branch topology P4.1; workstream template P4.3. REUSE covers the **rule**, not donor code: the donor worktree manager itself is a non-transplant — the supervising runtime owns worktree lifecycle (`25_QUICK_REUSE_SWEEP/SYNTHESIS.md:110,137-138`). |
| 6 | MULTI-MACHINE RISK | Placement error is the observed failure mode (wrong repository context — `30_OMEGA_ZERO_WEDNESDAY_DELIVERY/05_B1_RUN_REGISTER.md:18-32`); the P4.3 template must name the exact remote and branch so a workstream is created in one documented step. |
| 7 | SECURITY / PRIVACY RISK | None **as containment** — a worktree is a concurrency boundary, not a sandbox (`22_ORCA_RECONCILIATION.md:81-82`). See L-08. |
| 8 | REQUIRED REWRITE | A one-page workstream-creation template (P4.3). No code. |
| 9 | TARGET TEST OR REHEARSAL | **P4.3** acceptance: a new workstream is created in one documented step. **P4.8** collision test. **P6 step 6.4** disconnection drill: kill one machine mid-task; work is reassignable from Git state alone. |
| 10 | DECISION | **REUSE** — cooperative concurrency (plan §4, `04_DEVELOPMENT_PLAN.md:79`). |
| — | Validation state | `DESIGNED+CHECKED` — checks P4.3/P4.8/6.4 defined; not run. → `ENFORCED` when: P4.8 and 6.4 executed with the base observably unchanged and reassignment demonstrated from Git state. |

### L-08 — Worktree as *security* containment — **DROP**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | The belief that a Git worktree fences untrusted or mistaken code — falsified in the donor reconciliation: "This proves workspace creation and Git identity … It does not prove security containment; a Git worktree is a concurrency boundary, not a hostile-code sandbox" (`22_ORCA_RECONCILIATION.md:81-82`); host containment belongs to sandbox/OS/container (`22_ORCA_RECONCILIATION.md:161`; `24_CURRENT_AGREED_PLAN_HANDOFF.md:167`). |
| 2 | CURRENT CONSUMER | No honest consumer. The donor rehearsal came close to claiming it: the reviewer was instructed read-only with no fence, and "no machine event proves 'no push' universally … the process had host access under the current permission model" (`27_ORCA_VERTICAL_SLICE_REHEARSAL/05_FAILURES_AND_CORRECTIONS.md:8,11`). |
| 3 | BEHAVIOR ACTUALLY PROVED | `[FACT]` Falsified by execution and audit in the donor: mutation was not mechanically impossible; absence of a push was an observation over bounded logs, not containment; the correction pattern was "narrow the claim to the evidence actually observed" (`27_ORCA_VERTICAL_SLICE_REHEARSAL/05_FAILURES_AND_CORRECTIONS.md:8,11,14-16`; `review/A1_EVIDENCE_AUDIT.md:254-258`). The KEEP row "worktrees are not security isolation" was carried forward as a lesson (`22_ORCA_RECONCILIATION.md:134`). |
| 4 | TARGET USE | None. The event's containment needs are met by credential scoping (L-06, P5.1) and branch protection (P4.1) — not by filesystem adjacency. |
| 5 | DEPENDENCIES | n/a — absent component. |
| 6 | MULTI-MACHINE RISK | The risk this DROP prevents: a lane running untrusted code "in its own worktree" and calling that safe, across five machines with no mechanism to contradict the claim. |
| 7 | SECURITY / PRIVACY RISK | This row **is** the security decision: claiming worktree containment would be a false security claim. Threat model at the event is five cooperative humans and their own agents, not hostile code; if hostile third-party code ever must run, containment is an OS/container mechanism — out of scope for v1 and re-entry is by amendment only. |
| 8 | REQUIRED REWRITE | None — absence. |
| 9 | TARGET TEST OR REHEARSAL / DROP COST | **Drop cost: none at this event.** No capability is lost; the only thing lost is a false sense of security. No plan task depends on worktree containment. If rehearsal or the event introduces execution of hostile code, containment returns via a ledger amendment naming a real mechanism (container/OS sandbox), never a worktree. |
| 10 | DECISION | **DROP** — explicitly falsified in rehearsal: it is not a sandbox (plan §4, `04_DEVELOPMENT_PLAN.md:80`). |
| — | Validation state | `DESIGNED` (absence by decision; nothing to exercise). → `DESIGNED+CHECKED` when: **P6 step 6.7** adversarial review has run and confirmed no design element silently relies on worktree containment. If one does, the element is corrected — the DROP is not revisited. |

### L-09 — Heartbeat/watchdog protocol — **DROP for v1**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Donor `core/watchdog.py` (235 lines) inside 2,058 lines of process-supervision machinery (`06_DECISION_BRIEF.md:44,77`); heartbeat-as-liveness design history — "Omega's heartbeat-as-liveness was a documented mistake" (`08_OMP_AS_RUNTIME.md:179`); lifecycle invariants from primary-source research (`28_OMEGA_ZERO_EXTERNAL_RESEARCH/workers/R2_ORCHESTRATION_LIFECYCLE.md:17,111`). |
| 2 | CURRENT CONSUMER | In the donor, the supervising runtime owns lifecycle; the watchdog was delegated/dropped (`21_OMEGA_ZERO_BLUEPRINT.md:848`; `24_CURRENT_AGREED_PLAN_HANDOFF.md:67` bans rebuilding one). |
| 3 | BEHAVIOR ACTUALLY PROVED | `[FACT]` A heartbeat detects suspected loss, never semantic progress or correctness — established from primary sources and recorded as an invariant ("a missed heartbeat may trigger inspection … only a coordinator decision … can settle the attempt", `28_OMEGA_ZERO_EXTERNAL_RESEARCH/workers/R2_ORCHESTRATION_LIFECYCLE.md:17,163`). `[INFERENCE]` No demonstrated need at five humans × five machines: each human sees their own machine, and stalls are surfaced by the observer's bounded stall alert (P5.4) — a watch item, not a protocol. `[UNPROVEN]` Whether the absence is felt during the event; that is what P6 6.4/6.6 measure. |
| 4 | TARGET USE | None in v1. Stall detection = observer stall alerts (P5.4, `DR`/E26 path) + documented human escalation triggers (P4.7, `ESC`). |
| 5 | DEPENDENCIES | n/a — absent component. |
| 6 | MULTI-MACHINE RISK | A silently hung lane burns event clock. Mitigation without a protocol: the disconnection drill proves work is reassignable from Git state (P6 6.4), and the stall window is chosen at P5.4. |
| 7 | SECURITY / PRIVACY RISK | A heartbeat channel would become a second lifecycle truth source beside Git — the parallel-truth failure class (RC-5: `handoff.json` with no external reader, non-atomic writes — `01_FAILURE_CATALOG.md:159`; `05_REPO_ONTOLOGY.md:256`). |
| 8 | REQUIRED REWRITE | None — absence. |
| 9 | TARGET TEST OR REHEARSAL / DROP COST | **Drop cost: detection latency.** A hung lane is found by human noticing plus observer stall alerts instead of an automatic protocol; the latency equals the stall window set at P5.4. If rehearsal (**P6 steps 6.4, 6.6**) shows stalls going undetected, automation returns by amendment under the rule "automate only friction demonstrated in rehearsal" (`BRIEF:347`; `28_HACKATHON_TOMORROW_CONCEPT.md:42`) — with the R2 invariant intact: liveness signals trigger inspection, never settlement. |
| 10 | DECISION | **DROP for v1** — cost without demonstrated need at this scale (plan §4, `04_DEVELOPMENT_PLAN.md:81`). |
| — | Validation state | `DESIGNED` (absence by decision). → `DESIGNED+CHECKED` when: P6 6.4/6.6 have run and the rehearsal record states whether stalls were detected without a protocol. If not detected, the amendment path in field 9 opens. |

### L-10 — Full deterministic gates suite — **REFERENCE ONLY**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Five runnable detectors built from real donor defects, with recorded outputs against Omega at `3ceb7be`: G-1 declaration consumption (14 TIER-1 orphans), G-3 phantom paths (42), G-4 injected prose contradictions (2), G-5/6 test-quality asserts (11 + 3), G-7 absolute paths (29) — `02_GATES.md:5-18`; scripts at `13_LESSONS/gates/`. |
| 2 | CURRENT CONSUMER | The Omega rebuild's audit tooling (`05_REPO_ONTOLOGY.md:93-94`); not any hackathon artifact. |
| 3 | BEHAVIOR ACTUALLY PROVED | `[FACT]` The gates run and catch real defects — every number above is recorded tool output, each gate verified on a synthetic clean fixture as well as on the donor (`02_GATES.md:3,18`). `[FACT]` The suite's own warning: "Do not add more gates than these until one of them fails to catch something real" — gates accumulated faster than they were enforced is how 13 of 17 mechanisms went unconsumed (`02_GATES.md:211`; `01_FAILURE_CATALOG.md:13`). `[INFERENCE]` Porting the suite under event time costs more than it returns for a repository that will live for hours. |
| 4 | TARGET USE | Design input only. Three ideas are consumed by this architecture without shipping any detector: (a) every field names its reader (contract §1; `05_REPO_ONTOLOGY.md:140`); (b) the declaration-protocol habit — a declared thing names what enforces it or is deleted (`03_DECLARATION_PROTOCOL.md:9,35`); (c) one CI check with a reproducible command (`CI` node; cut order keeps "automated CI beyond one check" as cuttable, blueprint §8.2). |
| 5 | DEPENDENCIES | n/a for reference use. |
| 6 | MULTI-MACHINE RISK | None — nothing runs across machines. |
| 7 | SECURITY / PRIVACY RISK | G-7's lesson applies to portfolio sanitization: no absolute user paths, run IDs, terminal IDs, or secret-shaped config in anything published (`02_GATES.md:146-150`; `25_QUICK_REUSE_SWEEP/SYNTHESIS.md:149`; plan §10 P9). |
| 8 | REQUIRED REWRITE | None — consulted, not ported. |
| 9 | TARGET TEST OR REHEARSAL | No target mechanism, so no target test. Reference consumption is observable at **P1**: this row and blueprint §7 cite the gate ideas while the plan ships no detector. If the team later demonstrates a need (e.g. **P6 step 6.7** surfaces doc/code drift), a gate enters via a ledger amendment with its own row and check — not by silent adoption. |
| 10 | DECISION | **REFERENCE ONLY** — design input; too heavy to port under event time (plan §4, `04_DEVELOPMENT_PLAN.md:82`). |
| — | Validation state | `DESIGNED` (reference consumed; no mechanism in the target to exercise). → `DESIGNED+CHECKED` only via amendment: if a gate is ever ported, the new row names its runnable check. |

### L-11 — Hosted vector search / embeddings — **DROP**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Donor corpus utilities `pipelines/embeddings.py`, `book_index.py`, `library.py`, `extract_epub.py` over a 1.8 GB in-repo corpus (`05_REPO_ONTOLOGY.md:18-19,192`); already dropped from the donor fleet (`21_OMEGA_ZERO_BLUEPRINT.md:912`). |
| 2 | CURRENT CONSUMER | None in any current fleet. In the donor the consumer was the book corpus itself — a consumer that does not exist here. The related search stack was consumer-free even there: `ensemble_search` had no in-repo caller, and the one boundary that existed stripped provenance (`01_FAILURE_CATALOG.md:155-157`; `05_REPO_ONTOLOGY.md:186`). |
| 3 | BEHAVIOR ACTUALLY PROVED | `[FACT]` No demonstrated need: the topic is unknown until T+0, so nothing can be pre-indexed — no domain knowledge can be prepared in advance (blueprint §1.2). `[FACT]` The donor sweep's standing rule: "Existence and quality are not sufficient reasons to include them" (`25_QUICK_REUSE_SWEEP/SYNTHESIS.md:98-99`). `[INFERENCE]` Research-mode retrieval over live sources with mandatory provenance (P3.2) covers the event's need; an index would add a second truth store beside `MP` and `REPO`. |
| 4 | TARGET USE | None. |
| 5 | DEPENDENCIES | n/a — absent component. |
| 6 | MULTI-MACHINE RISK | A hosted index is shared state across five machines — a second authoritative store, prohibited (contract §1: no mirroring into a second authoritative database). |
| 7 | SECURITY / PRIVACY RISK | Uploading team research or repository content to a third-party embedding service before organizer permission rules are known (blueprint §10 Q12/Q13) is a privacy breach waiting to happen. |
| 8 | REQUIRED REWRITE | None — absence. |
| 9 | TARGET TEST OR REHEARSAL / DROP COST | **Drop cost: none demonstrated.** No plan task depends on vector retrieval. If the revealed topic ships a document corpus too large to read directly, the fallback is mechanical search and human reading; adding hosted search mid-event requires an amendment **and** an explicit permissions answer (Q12). The check that would surface such a need is the **P6 step 6.2** synthetic dry run and, at the event, P3 research-loop throughput. |
| 10 | DECISION | **DROP** — no evidence of need; topic is unknown (plan §4, `04_DEVELOPMENT_PLAN.md:83`). |
| — | Validation state | `DESIGNED` (absence by decision). → `DESIGNED+CHECKED` when: the P3 dry run (executed at P6 6.2) has run and its record states whether retrieval without embeddings was sufficient. |

### L-12 — Custom dispatcher / scheduler — **DROP**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Donor `core/dispatcher.py`: 1,549 lines, 23 methods, 12 outward edges — the repo's convergence hub (`05_REPO_ONTOLOGY.md:14,26`). |
| 2 | CURRENT CONSUMER | Prohibited by every current authority: "Do not create a custom dispatcher, scheduler, task database, message bus, watchdog, or runtime" (`24_CURRENT_AGREED_PLAN_HANDOFF.md:67`); REJECT row — duplicates the lifecycle plane and creates split-brain settlement (`28_OMEGA_ZERO_EXTERNAL_RESEARCH/workers/R2_ORCHESTRATION_LIFECYCLE.md:118`); prohibited list (contract §1); plan §13 non-goals. |
| 3 | BEHAVIOR ACTUALLY PROVED | `[FACT]` In the donor, the hub **caused** the enforcement gap: wiring anything meant touching a 1,549-line god module, so declarations accumulated instead — "the architecture caused the enforcement gap" (`05_REPO_ONTOLOGY.md:26`); its call-time validator was imported and never called (`01_FAILURE_CATALOG.md:22`). `[INFERENCE]` For five lanes, the scheduling data already exists in `MP.dependency_graph` + `MP.integration_order`, consumed by humans at the merge gate (E18 "human merge, integration order"); Git plus supervised agent tooling carries the rest — the runtime boundary in the diagram is labelled "existing tooling; no custom scheduler, no message bus" (`RUNTIME` subgraph, contract §4). |
| 4 | TARGET USE | None. Coordination = Git + supervised agents + human cadence (P8 operation table). |
| 5 | DEPENDENCIES | n/a — absent component. |
| 6 | MULTI-MACHINE RISK | A custom dispatcher would be a single point of failure and a second lifecycle truth across five machines — the duplicated-writer / parallel-truth failure classes (`01_FAILURE_CATALOG.md:159,170-178`). |
| 7 | SECURITY / PRIVACY RISK | A scheduler holding task state holds a mirror of the work — a second authoritative database beside `REPO` (prohibited, contract §1). |
| 8 | REQUIRED REWRITE | None — absence. |
| 9 | TARGET TEST OR REHEARSAL / DROP COST | **Drop cost: none at this scale.** Process supervision is what existing tooling already does; what remains — judging whether work is acceptable — was never the dispatcher's to own (`06_DECISION_BRIEF.md:119-122`; `26_WEDNESDAY_EXECUTION_PACKAGE/workers/W2_RUNTIME_TRUTH.md:14-16`). If coordination friction appears, the fix is a documented human cadence, tested at **P6 step 6.6** (time-box check: setup fits the preparation window) — not a scheduler. |
| 10 | DECISION | **DROP** — explicitly a non-goal (plan §4, `04_DEVELOPMENT_PLAN.md:84`). |
| — | Validation state | `DESIGNED` (absence by decision). → `DESIGNED+CHECKED` when: P6 6.7 adversarial review has run and confirmed no artifact silently requires a scheduler. |

### L-13 — Semantic GitHub judge — **DROP**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | The idea of an AI component adjudicating semantic correctness of PRs/CI. Rejected in blueprint §9 discarded alternatives (`03_ARCHITECTURE_BLUEPRINT.md:331`); the falsifying measurement comes from the sibling project dSearch: provider overlap as a trust signal was falsified (`21_OMEGA_ZERO_BLUEPRINT.md:893`) — 261 corroborated URLs, 38 correct, precision 0.1456 (`03_ARCHITECTURE_BLUEPRINT.md:105`; contract §1). |
| 2 | CURRENT CONSUMER | None; prohibited (contract §1; plan §13, `04_DEVELOPMENT_PLAN.md:244`). |
| 3 | BEHAVIOR ACTUALLY PROVED | `[FACT]` The donor ecosystem measured agreement-as-truth and it failed at precision 0.1456 (anchors in field 1). `[FACT]` The runtime itself is explicitly not a semantic judge: it knows a worker ended, not whether the work is acceptable — "that judgement is your product", and it belongs to humans plus exact checks (`06_DECISION_BRIEF.md:119-122`; `26_WEDNESDAY_EXECUTION_PACKAGE/workers/W2_RUNTIME_TRUTH.md:14-16`). `[INFERENCE]` A judge attached to GitHub would place opaque judgement exactly where the design requires auditable evidence (E17: "exact candidate diff + evidence"). |
| 4 | TARGET USE | None. PR assessment = `CI` results (E15/E16) + independent human-or-agent review of the exact diff (L-04) + the human `MERGE` decision. The observer reports facts and risks, never assessment (`DR` node label; E26) — a semantic judge is the failure mode L-06's schema is built to exclude. |
| 5 | DEPENDENCIES | n/a — absent component. |
| 6 | MULTI-MACHINE RISK | A judge's verdicts would become a de-facto coordination signal across lanes — agreement masquerading as truth (contract §1: "agreement is not truth"). |
| 7 | SECURITY / PRIVACY RISK | A semantic judge reading all PR content concentrates private repository material in one non-human decision point; a wrong verdict at merge time is unrecoverable under event clock — the reason D6 ("human owns every merge", reverse-if: never) exists (`03_ARCHITECTURE_BLUEPRINT.md:321`). |
| 8 | REQUIRED REWRITE | None — absence. |
| 9 | TARGET TEST OR REHEARSAL / DROP COST | **Drop cost: none.** Semantic acceptance was never automatable on the available evidence; humans read exact diffs anyway (L-04). The only thing forgone is an impressive-looking component — and building components for portfolio appearance is itself prohibited (contract §1). Standing check: **P6 step 6.7** adversarial review confirms no artifact smuggles assessment language into the observer's outputs (reinforced by P5.3's no-assessment-field schema check). |
| 10 | DECISION | **DROP** — places opaque judgement where evidence is required (plan §4, `04_DEVELOPMENT_PLAN.md:85`). |
| — | Validation state | `DESIGNED` (absence by decision). → `DESIGNED+CHECKED` when: P5.3 schema check and P6 6.7 review have run and confirmed no assessment path exists. Re-entry is not anticipated: D6 is "never reversed" and the falsification stands; only a contract change, not a ledger amendment, could reopen this. |

---

## 4. Summary

Count method: 1:1 against plan §4 rows (`04_DEVELOPMENT_PLAN.md:73-85`), in order. 13 candidates =
5 REUSE + 2 ADAPT + 1 REFERENCE ONLY + 5 DROP (one of the five scoped "for v1"). None added, none
removed, none re-decided.

| ID | Candidate | Verdict (plan §4) | Validation state | Target check → phase | Load-bearing evidence |
|---|---|---|---|---|---|
| L-01 | Principal/worker separation | **ADAPT** | DESIGNED+CHECKED | P6 6.1; P4.2 | `30…/05_B1_RUN_REGISTER.md:45-61` |
| L-02 | Task and result contracts | **REUSE** | DESIGNED+CHECKED | P6 6.2; P4.6 | `22_ORCA_RECONCILIATION.md:373-395` |
| L-03 | One-writer-per-workspace | **REUSE** | DESIGNED+CHECKED | P4.8; P6 6.3 | `27…/03_GIT_WORKTREE_PROOF.md:46-50` |
| L-04 | Independent review of exact candidate | **REUSE** | DESIGNED+CHECKED | P4.6; P6 | `27…/review/R1_EXACT_CANDIDATE_REVIEW.md:14-20,88` |
| L-05 | Evidence-before-completion | **REUSE** | DESIGNED+CHECKED | P6 6.2/6.3; P4.6 | `30…/05_B1_RUN_REGISTER.md:45-61` |
| L-06 | Read-only observer + read-only credential | **ADAPT** | DESIGNED+CHECKED | P5.1; P5.3; P6 6.5 | `27…/05_FAILURES_AND_CORRECTIONS.md:8` |
| L-07 | Git worktree isolation | **REUSE** | DESIGNED+CHECKED | P4.3; P4.8; P6 6.4 | `27…/03_GIT_WORKTREE_PROOF.md:46-54` |
| L-08 | Worktree as *security* containment | **DROP** | DESIGNED | P6 6.7 (review confirms absence) | `27…/05_FAILURES_AND_CORRECTIONS.md:8,11` |
| L-09 | Heartbeat/watchdog protocol | **DROP for v1** | DESIGNED | P6 6.4/6.6 | `08_OMP_AS_RUNTIME.md:179`; `R2_ORCHESTRATION_LIFECYCLE.md:17` |
| L-10 | Full deterministic gates suite | **REFERENCE ONLY** | DESIGNED | none (reference consumed at P1) | `02_GATES.md:10-18,211` |
| L-11 | Hosted vector search / embeddings | **DROP** | DESIGNED | P6 6.2 (need would surface here) | `01_FAILURE_CATALOG.md:155-157`; `21_OMEGA_ZERO_BLUEPRINT.md:912` |
| L-12 | Custom dispatcher / scheduler | **DROP** | DESIGNED | P6 6.6/6.7 | `05_REPO_ONTOLOGY.md:14,26`; `01_FAILURE_CATALOG.md:22` |
| L-13 | Semantic GitHub judge | **DROP** | DESIGNED | P5.3; P6 6.7 | `03_ARCHITECTURE_BLUEPRINT.md:105,331`; `21_OMEGA_ZERO_BLUEPRINT.md:893` |

Rows anchored to executed donor evidence (`13_LESSONS` corpus): L-01 through L-13 — every record's
BEHAVIOR ACTUALLY PROVED field cites at least one corpus artifact. The three load-bearing evidence
rows named in the tasking are used as follows: RC-1, 13 of 17 mechanisms declared without a
production consumer (`01_FAILURE_CATALOG.md:13`) → the gate in §1 and records L-02, L-09, L-12;
RC-5, `ensemble_search` with no in-repo caller and `ToolPort` stripping provenance
(`01_FAILURE_CATALOG.md:155-157`) → L-11 and the CURRENT CONSUMER discipline throughout; the
falsification of worktree-as-containment (`27_ORCA_VERTICAL_SLICE_REHEARSAL/05_FAILURES_AND_CORRECTIONS.md:8,11`;
`22_ORCA_RECONCILIATION.md:81-82`) → L-08, and the credential-not-instruction rule in L-06.

---

## 5. What this ledger does NOT prove

- **The event has not happened.** No row describes behaviour observed at a hackathon.
- **No rehearsal for this project has run.** Every target check named above (P4.x, P5.x, P6 6.1–6.8)
  is defined but unexecuted. Therefore **no row in this ledger is `ENFORCED`**, and no row will be
  until its named check is executed and observed to block a real violation.
- **Donor evidence does not transfer automatically.** `[FACT]` rows cite executions in prior
  systems, at smaller scale (one machine, one candidate, one reviewer). Five humans across five
  machines is untested territory for every REUSE row; the P6 rehearsal exists to find where the
  transfer breaks.
- **A DROP is not proof the dropped component is worthless.** It records absence of demonstrated
  need **for this event**, with a cost statement and an amendment path. L-10 in particular cites a
  suite whose detectors demonstrably work (`02_GATES.md:10-18`); it is reference-only here because
  of event-time cost, not because of doubt about the tooling.
- **No semantic correctness, no hackathon outcome, no claim that monitoring improves delivery.**
  The observer rows (L-06) describe a designed, degradable reporting role; nothing here shows it
  helps the team win or even finish.
- **Classification verdicts belong to the operator.** This ledger records and grounds the plan §4
  decisions; where prior artifacts used a different label for the same item (noted in L-05), the
  plan §4 verdict stands and the tension is reported, not silently resolved.

**Privacy:** no participant names, no repository contents, no credentials, no sponsor or organizer
material, and no topic-specific detail appear in this ledger. Every example is synthetic.
