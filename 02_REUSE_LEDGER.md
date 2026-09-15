# Reuse Ledger — Multi-AI Workflow for a Five-Person Cybersecurity Hackathon

**Status:** draft v2, 2026-09-15
**Phase:** P1 deliverable (`04_DEVELOPMENT_PLAN.md` §2)
**Companion to:** `03_ARCHITECTURE_BLUEPRINT.md`, `04_DEVELOPMENT_PLAN.md`
**Verdict authority:** plan §4 (`04_DEVELOPMENT_PLAN.md` §4). This ledger expands each verdict into
the full 10-field record required by the engagement brief. It does not re-decide any verdict.
**Not in scope:** building the hackathon solution; porting prior code (expected code copied from
prior work: zero lines — the transfer here is discipline and shape, not source;
`04_DEVELOPMENT_PLAN.md` §13 non-goals).

---

## 0. Legend and verification method

**Claim labels** (house convention, `00_DELIVERABLE_CONTRACT.md` §2):

- `[FACT]` — read directly from a cited file in this repository, or stated as the operator's own
  prior-work experience and marked as such (`[FACT — operator experience]`). Prior-work experience
  is provenance for a design decision; it is not evidence about this design.
- `[INFERENCE]` — reasoned from cited evidence.
- `[UNPROVEN]` — designed, not tested.

**Validation states** (contract §2 vocabulary):

| State | Meaning |
|---|---|
| `DESIGNED` | Specified in an artifact. No check has ever exercised it. |
| `DESIGNED+CHECKED` | Specified and a defined check exists that can exercise it (the check is named). |
| `ENFORCED` | A mechanism makes the violation impossible, and that mechanism has been observed to block it. |

**Nothing in this ledger is `ENFORCED`.** No check named here has been run against this project.
Every row carries entry criteria to the next state.

**Anchor roots.** File references are relative to this repository's root. A numbered short form
(`02`–`08`) means the file in this repository carrying that number prefix — e.g. `04` =
`04_DEVELOPMENT_PLAN.md`, `07` = `07_FAILURE_AND_REHEARSAL_PLAN.md`. `contract §N` resolves to
`00_DELIVERABLE_CONTRACT.md` §N. Diagram node and
edge IDs (`S1`, `S2`, `RM`, `MP`, `OB`, `DR`, `AG`, `L1`–`L5`, `REPO`, `PR`, `CI`, `MERGE`, `ESC`,
`APPR`) reference `06_ARCHITECTURE.mmd` per the frozen inventory (contract §4).

**Verification method for this draft.** Read directly on 2026-09-15 at commit `531830a`:
`04_DEVELOPMENT_PLAN.md` §4 (verdict table and gate), §5–§13 (P2–P9 tasks, failure matrix,
acceptance matrix, non-goals); `03_ARCHITECTURE_BLUEPRINT.md` §3.3 (Mission Package fields), §4.2,
§4.4–§4.5, §5, §7, §8.2–§8.3, §9 (D1–D8), §10 (Q1–Q14); `05_IMPLEMENTATION_CHECKLIST.md` §5
(per-cycle items) and §9 (every check must be observable); `07_FAILURE_AND_REHEARSAL_PLAN.md` §1
(validation ledger), §2 (three-state control table), §3 (premortem), §4 (catch ledger), §6 (drills
6.1–6.8), §9 (meta-lessons); `00_DELIVERABLE_CONTRACT.md` §1–§5; `01_DISCOVERY_CLOSURE.md` Q1–Q2.
This ledger ran no executions of its own: the event has not happened and no rehearsal has run.
Candidate count method: the 13 records below are 1:1 with the 13 rows of plan §4, in plan order;
none added, none removed.

**Package-level audit.** This file was authored under the one-writer-per-file rule it applies to the
fleet (contract §5) and was audited with the rest of the package: a mechanical cross-artifact census
(node/edge IDs, the ten-field schema, cut order, `D1`–`D8`, the phase index, the validation states —
contract §5) plus an independent adversarial review (23 findings, all recorded and fixed — contract
§5; `07_FAILURE_AND_REHEARSAL_PLAN.md` §9). The census's findings — a cut-priority/phase-ID namespace
collision (cut priorities `P0`–`P2` against phases `P0`–`P9`), an absolute path, an emoji, and one
decision-text divergence — were fixed. None of them changed a verdict in §3.

---

## 1. Gate and filter

**Gate (plan §4, `04_DEVELOPMENT_PLAN.md` §4):** no component enters the architecture without a
ledger row. A component with no demonstrated need is **dropped, not deferred**.

**The one-line filter for every proposed component** (operator practice, carried into this
engagement):

> **"If I delete this, what breaks?"**
> If the answer is "a test", delete it. If the answer is "a user-visible behaviour", port it.

This filter is why the ledger records CURRENT CONSUMER for every candidate, and it is the same rule
the contract states as an invariant: **"A declaration is cheap and feels like progress; wiring it is
expensive and invisible. Every declared field names the reader that consumes it, or it is deleted"**
(contract §1). The failure class this defends against — declarations with no production reader,
cited in documentation as if they were controls — is treated as a catch, not an assumption, in this
package: it is a catch-ledger row in `07_FAILURE_AND_REHEARSAL_PLAN.md` §4 and a FINDING in its §2
three-state control table. The companion test for any field carried forward: *which file reads this,
and what changes?*

---

## 2. Classification vocabulary

| Class | Definition |
|---|---|
| **REUSE** | The discipline, rule, or contract transfers as-is into the target workflow. Only retitling or re-instantiation for this team is allowed; no redesign. REUSE never means copying prior code: the transfer is discipline and shape, so where a prior component was machinery rather than discipline it is not transplanted (see L-07, L-12). |
| **ADAPT** | The shape transfers, but a structural change is required before use in the target (e.g. a role identity becomes a per-task bundle; a separate service becomes a mode on `S1`). The adaptation is named in REQUIRED REWRITE. |
| **REFERENCE ONLY** | Consulted as design input. Nothing ships. No target test exists, because no target mechanism exists. |
| **DROP** | Absent from the target architecture. A drop is a decision with a recorded cost (stated in every DROP record), not a deferral. Re-entry requires a ledger amendment backed by demonstrated need, under the standing rule **automate only friction demonstrated in rehearsal** — consistent with the plan §4 gate. |

---

## 3. Records

One record per candidate, in plan §4 order. Fields are the ten required fields of this ledger's
schema, plus the validation state required by contract §2. Nine of the ten are the fields itemised
in plan §4 (`04_DEVELOPMENT_PLAN.md` §4); CURRENT CONSUMER is this ledger's addition, required by
the gate and filter in §1.

Every record now stands on two kinds of ground only: this repository's own artifacts (a named
section per citation), and the operator's prior-work experience recorded as experience. No record
rests on evidence produced in a prior system as proof about this design; field 3 says per record
what that means and which in-repo check would produce the missing evidence.

### L-01 — Principal/worker separation — **ADAPT**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Prior-work pattern: **one principal agent plus replaceable worker CLIs in four bounded task shapes** (principal / scout / builder / reviewer), with the model and the role treated as launch configuration for a task rather than a permanent identity. `[FACT — operator experience, prior supervised-agent work]` |
| 2 | CURRENT CONSUMER | **None yet** — nothing in this project has been built or run. The intended consumer is the `S2` dispatch path: the ownership registry (`04_DEVELOPMENT_PLAN.md` §7, P4.2) and the workstream template (P4.3). Recorded here as design, not operation. |
| 3 | BEHAVIOUR PROVED TO DATE | `[UNPROVEN]` Nothing is proved for this project: no rehearsal has run and the event has not happened. The in-repo check that would prove it is **P6 step 6.1** — every participant states what they own and what they may write, unaided (`04_DEVELOPMENT_PLAN.md` §9; `07_FAILURE_AND_REHEARSAL_PLAN.md` §6.1) — together with **P4.2** (two workstreams cannot claim one surface; `04_DEVELOPMENT_PLAN.md` §7). `[FACT]` The shape is a design decision resting on the operator's prior supervised-agent experience; that experience is not evidence here. |
| 4 | TARGET USE | On `S2`: a coordinating human-or-agent role interprets the frozen `MP` and dispatches bounded tasks; each task runs with a capability bundle selected for that task (`AG` → `L1`–`L5`, edges E19–E23, contract §4). No permanent agent identity; the permanent agent-per-human role ontology is prohibited (contract §1; `03_ARCHITECTURE_BLUEPRINT.md` §4.3). |
| 5 | DEPENDENCIES | Per-participant agent CLI availability (`04_DEVELOPMENT_PLAN.md` §5 account matrix); the `MP` as the only task input crossing the boundary (contract §1); Git for workspace placement (`04_DEVELOPMENT_PLAN.md` §7, P4.1). |
| 6 | MULTI-MACHINE RISK | The coordinating role must not become a dispatch bottleneck or a single point of failure: if coordination is unavailable, lanes continue independently against the frozen package (`03_ARCHITECTURE_BLUEPRINT.md` §4.5; edge E29, contract §4). |
| 7 | SECURITY / PRIVACY RISK | Workers act under their human's credentials, least privilege per person (`03_ARCHITECTURE_BLUEPRINT.md` §7). The coordinator never merges — merge authority is the `MERGE` node, one named human (D6, "never reversed"; `03_ARCHITECTURE_BLUEPRINT.md` §9). |
| 8 | REQUIRED REWRITE | Re-express the four task shapes as a per-task menu inside the workstream template (`04_DEVELOPMENT_PLAN.md` §7, P4.3); drop prior-runtime lifecycle vocabulary; keep the ownership and completion-evidence columns of the task/result contract as the bundle contract (`03_ARCHITECTURE_BLUEPRINT.md` §4.3; L-02). |
| 9 | TARGET TEST OR REHEARSAL | **P6 step 6.1** tabletop: every participant states what they own and what they may write, and names the bundle their next task uses — not a persona. Plus **P4.2** acceptance: two workstreams cannot claim one surface (`04_DEVELOPMENT_PLAN.md` §9, §7). |
| 10 | DECISION | **ADAPT** — same shape, but roles become per-task bundles, not identities (plan §4, `04_DEVELOPMENT_PLAN.md` §4). |
| — | Validation state | `DESIGNED+CHECKED` — checks P6 6.1 and P4.2 are defined in the plan; neither has run. → `ENFORCED` when: a rehearsal observes a persona-style or same-surface claim actually rejected at dispatch or by the registry. |

### L-02 — Task and result contracts — **REUSE**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Prior-work pattern: a **five-field task brief** (target / change-or-question / constraints–do-not-touch / ownership–workspace / observable acceptance) and an **eight-field result** (outcome / artifact or commit / files modified / checks actually run / observed output / facts / inferences / uncertainties). `[FACT — operator experience, prior supervised-agent work]` Deliberately human-readable text rather than a parallel machine schema until executable code consumes one: a schema nobody reads is the declaration failure class this package names in `07_FAILURE_AND_REHEARSAL_PLAN.md` §4. |
| 2 | CURRENT CONSUMER | **None yet** in this project. Intended consumer: every lane dispatch and every escalation message in the `S2` fleet — the workstream template and escalation path (`04_DEVELOPMENT_PLAN.md` §7, P4.3/P4.7; `03_ARCHITECTURE_BLUEPRINT.md` §4.4). |
| 3 | BEHAVIOUR PROVED TO DATE | `[UNPROVEN]` Nothing is proved: no dispatch has ever been made in this project. The checks that would prove it are **P6 step 6.2** (every dispatch in the exercise carries the five-field brief; `04_DEVELOPMENT_PLAN.md` §9) and the **P4.6** merge checklist refusing a completion claim missing CHECKS ACTUALLY RUN or OBSERVED OUTPUT (`04_DEVELOPMENT_PLAN.md` §7). `[FACT]` The contract is carried from prior-work experience at smaller scale (one machine, one candidate); transfer to five lanes is untested. |
| 4 | TARGET USE | Every lane dispatch and every escalation message in the `S2` fleet; the CHECKS ACTUALLY RUN + OBSERVED OUTPUT fields are what flow to `PR` → `MERGE` as evidence (edge E17 "exact candidate diff + evidence", contract §4). |
| 5 | DEPENDENCIES | None beyond Git and one authoritative template file in the repository. No schema validator until code consumes one (`04_DEVELOPMENT_PLAN.md` §7, P4.3). |
| 6 | MULTI-MACHINE RISK | Template drift across five machines — mitigated by keeping the single authoritative copy in the repository, the same one-fact-one-writer rule this package applied to its own authoring (contract §5). |
| 7 | SECURITY / PRIVACY RISK | The CONSTRAINTS field carries do-not-touch surfaces. No credentials in briefs, ever (`04_DEVELOPMENT_PLAN.md` §5 credential placement: "Never in the repo; never in a prompt"). |
| 8 | REQUIRED REWRITE | Retitle field references to Mission Package vocabulary: OWNERSHIP points at `MP.task_ownership`; OBSERVABLE ACCEPTANCE points at `MP.acceptance_tests` (`03_ARCHITECTURE_BLUEPRINT.md` §3.3). |
| 9 | TARGET TEST OR REHEARSAL | **P6 step 6.2** synthetic dry run: every dispatch in the exercise carries the five-field brief, and any completion claim missing CHECKS ACTUALLY RUN or OBSERVED OUTPUT is refused at the **P4.6** merge checklist (`04_DEVELOPMENT_PLAN.md` §9, §7). |
| 10 | DECISION | **REUSE** — directly transferable discipline (plan §4, `04_DEVELOPMENT_PLAN.md` §4). |
| — | Validation state | `DESIGNED+CHECKED` — checks P6 6.2 + P4.6 defined; not run. → `ENFORCED` when: a rehearsal observes an evidence-less result actually refused at the merge gate. |

### L-03 — One-writer-per-workspace — **REUSE**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Prior-work pattern: **one mutating agent per worktree, never one mutating agent for the whole fleet** — exactly one mutating worker owns a worktree at a time. `[FACT — operator experience, prior supervised-agent work]` |
| 2 | CURRENT CONSUMER | **None yet**. Intended consumer: the anti-collision rule on `S2`, instantiated by the ownership registry (`04_DEVELOPMENT_PLAN.md` §7, P4.2) and the branch topology (P4.1); stated as a rule in `03_ARCHITECTURE_BLUEPRINT.md` §4.2. |
| 3 | BEHAVIOUR PROVED TO DATE | `[UNPROVEN]` Nothing is proved: no fleet, no registry, no concurrent write has existed in this project. The check that would prove it is **P4.8** — two machines attempt the same surface and the rule prevents it (`04_DEVELOPMENT_PLAN.md` §7), re-run as a drill with the observer reporting the violation (**P6 step 6.3**, `04_DEVELOPMENT_PLAN.md` §9; `07_FAILURE_AND_REHEARSAL_PLAN.md` §6.3). `[FACT]` The rule held in prior work only where placement was per-dispatch; when placement itself erred, the workspace had to be stopped and re-issued — so the rule needs correct instantiation, not just declaration. That is prior-work experience and it is why P4.3 (one documented step) is a named requirement here (`04_DEVELOPMENT_PLAN.md` §7). |
| 4 | TARGET USE | The core anti-collision rule on `S2`: one lane = one human = one machine = one worktree/branch `workstream-N` (`L1`–`L5`); ownership recorded in `MP.task_ownership` (`03_ARCHITECTURE_BLUEPRINT.md` §4.2, §3.3). |
| 5 | DEPENDENCIES | Repository and branch topology (P4.1); ownership registry (P4.2); shared Git remote (`REPO`). |
| 6 | MULTI-MACHINE RISK | Same-surface claims across machines are the primary collision mode; the registry is the single arbiter; an unresolved claim escalates to `ESC` (edge E27 "same-surface claim (any lane)", contract §4). |
| 7 | SECURITY / PRIVACY RISK | Low. Prevents accidental writes to protected or frozen surfaces. It is an anti-collision rule, **not** a security control — see L-08. |
| 8 | REQUIRED REWRITE | None to the rule. Instantiate the registry (one row per workstream) at P4.2, after Q1 was answered as one five-person team (`01_DISCOVERY_CLOSURE.md` Q1; `04_DEVELOPMENT_PLAN.md` §7). |
| 9 | TARGET TEST OR REHEARSAL | **P4.8** collision test: two machines attempt the same surface; the rule prevents it — observable as the second writer being refused or escalated before any commit lands. Re-run as **P6 step 6.3** drill with the observer reporting the violation (`04_DEVELOPMENT_PLAN.md` §7, §9). |
| 10 | DECISION | **REUSE** — core anti-collision rule (plan §4, `04_DEVELOPMENT_PLAN.md` §4). |
| — | Validation state | `DESIGNED+CHECKED` — check P4.8 defined; not run. → `ENFORCED` when: P4.8/6.3 executed and a real same-surface attempt is observed blocked. |

### L-04 — Independent review of exact candidate — **REUSE**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Prior-work pattern: **a candidate is reviewed as an exact commit or diff and never accepted from prose**; the reviewer is a different role from the author and reads the exact commit. `[FACT — operator experience, prior supervised-agent work]` |
| 2 | CURRENT CONSUMER | **None yet**. Intended consumer: the `PR` → `MERGE` path — the merge procedure and checklist (`04_DEVELOPMENT_PLAN.md` §7, P4.6) and the human merge decision (`03_ARCHITECTURE_BLUEPRINT.md` §4.2). |
| 3 | BEHAVIOUR PROVED TO DATE | `[UNPROVEN]` Nothing is proved: no candidate, no PR, and no review has existed in this project. The in-repo checks that would prove it are **P4.6** — the review record names base SHA, candidate SHA, changed paths, and commands run with output, and any review citing prose instead of a SHA is refused (`04_DEVELOPMENT_PLAN.md` §7) — exercised during **P6** (`04_DEVELOPMENT_PLAN.md` §9). `[FACT]` The honesty limit carried from prior work: a reviewer *instructed* read-only was not capability-fenced, so independence held by observation, not mechanism. Here that is not restated in prose but converted into an executable test — **P5.1** — and a pre-committed downgrade (`04_DEVELOPMENT_PLAN.md` §8; contract §2 rule 7). |
| 4 | TARGET USE | Every `PR` is reviewed as an exact diff (edge E17, contract §4) before the human `MERGE` decision; the reviewer is never the author. |
| 5 | DEPENDENCIES | GitHub pull requests (`PR`); CI results attached to the PR (edges E15/E16); a named merge owner (`04_DEVELOPMENT_PLAN.md` §3, P0.7). |
| 6 | MULTI-MACHINE RISK | Review must reference commit SHAs on the shared remote, never machine-local state — `REPO` is the shared identity for candidates. |
| 7 | SECURITY / PRIVACY RISK | Reviewer read access must not imply write access. Where credentials can be scoped, scope them; where they cannot, state the limit plainly — the contract's enforcement principle stated as an invariant: **"An instruction in a prompt is not a control. A role described as read-only is read-only only when something makes mutation impossible; where that mechanism cannot be configured, the claim is narrowed in writing rather than upgraded in prose"** (contract §1; `03_ARCHITECTURE_BLUEPRINT.md` §7). |
| 8 | REQUIRED REWRITE | None to the discipline. Encode it in the P4.6 merge checklist: the review record names base SHA, candidate SHA, changed paths, and commands run with output (`04_DEVELOPMENT_PLAN.md` §7). |
| 9 | TARGET TEST OR REHEARSAL | **P6** rehearsal: one lane's candidate is reviewed by a different human-or-agent from the exact diff, and the **P4.6** merge checklist refuses any review that cites prose instead of a SHA (`04_DEVELOPMENT_PLAN.md` §9, §7). |
| 10 | DECISION | **REUSE** — review a commit, never a prose summary (plan §4, `04_DEVELOPMENT_PLAN.md` §4). |
| — | Validation state | `DESIGNED+CHECKED` — check P4.6 + P6 defined; not run. → `ENFORCED` when: a rehearsal observes a prose-only review actually refused at the merge gate. |

### L-05 — Evidence-before-completion — **REUSE**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Prior-work pattern: a **verification-before-completion discipline**, distilled to five operational lines — identify what proves the claim; run it fresh; read the complete result and exit status; state success only when the evidence supports it; otherwise report the actual state. `[FACT — operator experience, prior supervised-agent work]` |
| 2 | CURRENT CONSUMER | **None yet**. Intended consumer: every lane's completion event and the merge gate — acceptance matrix rows "It works asserted" and "One writer per surface" (`04_DEVELOPMENT_PLAN.md` §11 failure matrix, §12 acceptance matrix). |
| 3 | BEHAVIOUR PROVED TO DATE | `[UNPROVEN]` Nothing is proved: no completion claim has been made or refused in this project. The checks that would prove it are **P6 steps 6.2/6.3** — a completion claim with empty CHECKS ACTUALLY RUN is refused at the **P4.6** merge gate (`04_DEVELOPMENT_PLAN.md` §9, §7). `[FACT]` The failure it defends against is already recorded in this repository: the plan's failure-matrix row "'It works' asserted" with the response "Demand the command and its output" (`04_DEVELOPMENT_PLAN.md` §11), and the standing finding that no mechanism in this design has been exercised (`07_FAILURE_AND_REHEARSAL_PLAN.md` §7). |
| 4 | TARGET USE | Every lane's "done". The contract states the rule as an invariant: **"A worker's completion event is not acceptance. A green exit code that scanned nothing is not evidence"** (contract §1; `03_ARCHITECTURE_BLUEPRINT.md` §7). Merge evidence = reproducible command + output (`CI` node label: "reproducible commands, not narration"; `00_DELIVERABLE_CONTRACT.md` §4). |
| 5 | DEPENDENCIES | Repository-defined check commands runnable from a clean checkout on any machine; result-contract fields CHECKS ACTUALLY RUN / OBSERVED OUTPUT (L-02). |
| 6 | MULTI-MACHINE RISK | Evidence must be machine-independent: command + output committed to the PR, never "works on my machine" narration. |
| 7 | SECURITY / PRIVACY RISK | Redact evidence tails before sharing beyond the team (`03_ARCHITECTURE_BLUEPRINT.md` §11 portfolio and privacy boundary; `04_DEVELOPMENT_PLAN.md` §10 P9). |
| 8 | REQUIRED REWRITE | Keep one authority: a single short section in the fleet's root instructions, not duplicated per lane or per document — the prior-work lesson that the same wording in two places drifts apart. Prior work carried this item under a different label (adapt after first use); plan §4 records it as REUSE, and that verdict stands — the distillation requirement in this field is where that tension is carried, reported rather than silently resolved. |
| 9 | TARGET TEST OR REHEARSAL | **P6 steps 6.2/6.3**: a completion claim with empty CHECKS ACTUALLY RUN is refused at the **P4.6** merge gate; and a check that scanned nothing fails rather than passes — the gate that every check must be observable (`05_IMPLEMENTATION_CHECKLIST.md` §9) and the acceptance-matrix requirement that each row names a reproducible check (`04_DEVELOPMENT_PLAN.md` §12). |
| 10 | DECISION | **REUSE** — a worker's "done" is a claim, not proof (plan §4, `04_DEVELOPMENT_PLAN.md` §4). |
| — | Validation state | `DESIGNED+CHECKED` — checks P6 6.2/6.3 + P4.6 defined; not run. → `ENFORCED` when: a rehearsal observes an unevidenced completion claim actually refused. |

### L-06 — Read-only observer with read-only credential — **ADAPT**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Two prior-work inputs, both operator experience: the **observer concept for this engagement**, and the enforcement lesson it must absorb — an agent instructed read-only is not capability-fenced, so **instruction is not enforcement**. `[FACT — operator experience]` The design is `03_ARCHITECTURE_BLUEPRINT.md` §5 with decision D7 (§9). |
| 2 | CURRENT CONSUMER | **None** — no observer process exists in this project. The only prior material this component consumes is the fencing lesson, not running code. |
| 3 | BEHAVIOUR PROVED TO DATE | `[UNPROVEN]` The observer has never run anywhere, in any system. `[FACT]` This repository records that state explicitly: the validation ledger's observer row is `DESIGNED+CHECKED` with a named, unexecuted check (`07_FAILURE_AND_REHEARSAL_PLAN.md` §1), and its failures table carries the standing limit "observer is read-only currently describes a credential that does not exist" (§7). The in-repo check that would prove it is **P5.1** — a write attempt through the scoped credential fails, proven by execution (`04_DEVELOPMENT_PLAN.md` §8); the anti-cheerleader check (`03_ARCHITECTURE_BLUEPRINT.md` §8.3; `04_DEVELOPMENT_PLAN.md` §6) is its companion. `[INFERENCE]` A credential scoped read-only makes writes fail at the credential level; this is platform behaviour and has not been executed for this project. |
| 4 | TARGET USE | Observer mode on `S1` (`OB` node, degradable tier 2): watch `REPO`/`PR`/`CI` events through a read-only credential (E24), emit deviation reports against `MP` vN (`DR` node, E25), feed `ESC` with facts and risks, never assessment (E26). Output schema has observation fields only — no assessment field (`03_ARCHITECTURE_BLUEPRINT.md` §8.3 anti-cheerleader mitigation). |
| 5 | DEPENDENCIES | GitHub org capabilities unknown until P0.6 / `03_ARCHITECTURE_BLUEPRINT.md` §10 Q9 (Actions, Apps, webhooks, branch protection); a long-lived process on `S1`; the frozen `MP` as the deviation baseline. |
| 6 | MULTI-MACHINE RISK | Tier 2 by design: if the observer or `S1` is lost, the fleet keeps building (E29; `03_ARCHITECTURE_BLUEPRINT.md` §4.5). Observer outage is itself visible (E30; `04_DEVELOPMENT_PLAN.md` §8, P5.6). |
| 7 | SECURITY / PRIVACY RISK | Load-bearing. If the credential cannot be scoped read-only, the claim is downgraded and stated as a limitation — never softened into "we told it not to write" (`04_DEVELOPMENT_PLAN.md` §8, P5.1; contract §2 rule 7; `03_ARCHITECTURE_BLUEPRINT.md` §7). Alerts and reports carry no private repository content into portfolio material (`04_DEVELOPMENT_PLAN.md` §10 P9). |
| 8 | REQUIRED REWRITE | Full re-implementation as a mode on `S1`, not a separate service (D1: one fewer failure domain, no baseline-transfer bug class; `03_ARCHITECTURE_BLUEPRINT.md` §9). New artifacts: watch set (P5.2), deviation schema (P5.3), bounded alert cadence (P5.4), ask-anytime path (P5.5), outage visibility (P5.6) — `04_DEVELOPMENT_PLAN.md` §8. |
| 9 | TARGET TEST OR REHEARSAL | **P5.1** — a write attempt through the observer credential **fails, proven by execution** (the load-bearing test, `04_DEVELOPMENT_PLAN.md` §8); **P5.3** — schema check: no assessment field exists; **P6 step 6.5** — observer-off drill: team continues building and the loss is visible (`04_DEVELOPMENT_PLAN.md` §9). |
| 10 | DECISION | **ADAPT** — becomes a mode on S1, not a separate service (plan §4, `04_DEVELOPMENT_PLAN.md` §4). |
| — | Validation state | `DESIGNED+CHECKED` — check P5.1 is defined, concrete, and executable before the event; not run. → `ENFORCED` when: P5.1 executed and an actual write attempt through the scoped credential is observed to fail. Until then the honest phrasing is "contractually read-only; no write path observed" — never "security-enforced". |

### L-07 — Git worktree isolation — **REUSE**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Prior-work pattern: **worktree-per-mutating-task placement**, with the recorded limit that worktrees manage cooperative concurrency, not hostile-code containment. `[FACT — operator experience, prior supervised-agent work]` |
| 2 | CURRENT CONSUMER | **None yet**. Intended consumer: every lane's workspace — branch topology and workstream template (`04_DEVELOPMENT_PLAN.md` §7, P4.1/P4.3; `03_ARCHITECTURE_BLUEPRINT.md` §4.2). |
| 3 | BEHAVIOUR PROVED TO DATE | `[UNPROVEN]` Nothing is proved: no worktree exists in this project and no lane has run. The checks that would prove it are **P4.3** — a new workstream is created in one documented step — and **P4.8 / P6 step 6.4** — the collision test and the disconnection drill, where work is reassignable from Git state alone (`04_DEVELOPMENT_PLAN.md` §7, §9; `07_FAILURE_AND_REHEARSAL_PLAN.md` §6.4). `[FACT]` Prior work proved this at one machine and one candidate; five concurrent lanes across five machines is untested territory, and the lineage caveat from that work applies here — a claim about placement is narrowed to what Git state actually shows (contract §2 rule 6, downgrade language only). |
| 4 | TARGET USE | Each lane owns its branch/worktree `workstream-N` (`L1`–`L5`); cooperative concurrency with the base checkout untouched; after machine loss, work is reassignable from Git state alone (`03_ARCHITECTURE_BLUEPRINT.md` §4.5; E29, contract §4). |
| 5 | DEPENDENCIES | Git remote (`REPO`); branch topology P4.1; workstream template P4.3. REUSE covers the **rule**, not prior machinery: no worktree manager is transplanted, because a supervising runtime owns worktree lifecycle (see L-12; `04_DEVELOPMENT_PLAN.md` §13 non-goals). |
| 6 | MULTI-MACHINE RISK | Placement error is the known failure mode from prior work — a workspace created from the wrong repository context — so the P4.3 template must name the exact remote and branch, making creation one documented step (`04_DEVELOPMENT_PLAN.md` §7). |
| 7 | SECURITY / PRIVACY RISK | None **as containment** — a worktree is a concurrency boundary, not a sandbox. See L-08. |
| 8 | REQUIRED REWRITE | A one-page workstream-creation template (P4.3). No code. |
| 9 | TARGET TEST OR REHEARSAL | **P4.3** acceptance: a new workstream is created in one documented step. **P4.8** collision test. **P6 step 6.4** disconnection drill: kill one machine mid-task; work is reassignable from Git state alone (`04_DEVELOPMENT_PLAN.md` §7, §9). |
| 10 | DECISION | **REUSE** — cooperative concurrency (plan §4, `04_DEVELOPMENT_PLAN.md` §4). |
| — | Validation state | `DESIGNED+CHECKED` — checks P4.3/P4.8/6.4 defined; not run. → `ENFORCED` when: P4.8 and 6.4 executed with the base observably unchanged and reassignment demonstrated from Git state. |

### L-08 — Worktree as *security* containment — **DROP**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Prior-work pattern, **falsified in that work**: the belief that a Git worktree fences untrusted or mistaken code. Workspace creation and Git identity were proven; security containment was not — a worktree is a concurrency boundary, not a hostile-code sandbox. `[FACT — operator experience: the falsification is the operator's own finding, not a measurement reproduced here]` Host containment belongs to a sandbox, OS, or container. |
| 2 | CURRENT CONSUMER | No honest consumer. Recorded in this project as a rejected claim: no artifact here asserts containment (plan §4 DROP row, `04_DEVELOPMENT_PLAN.md` §4; `03_ARCHITECTURE_BLUEPRINT.md` §7). |
| 3 | BEHAVIOUR PROVED TO DATE | `[UNPROVEN]` There is nothing to prove for this row — it records an absence by decision. `[FACT]` The confirmation this package can actually run is **P6 step 6.7** adversarial review: no design element silently relies on worktree containment (`04_DEVELOPMENT_PLAN.md` §9; `07_FAILURE_AND_REHEARSAL_PLAN.md` §6.7); that check has not run. `[FACT]` The prior correction pattern — narrow the claim to the evidence actually observed, rather than promoting a bounded observation into a guarantee — is why this DROP exists and is now a package-wide rule (contract §2 rule 6). |
| 4 | TARGET USE | None. The event's containment needs are met by credential scoping (L-06, P5.1) and branch protection (P4.1) — not by filesystem adjacency (`04_DEVELOPMENT_PLAN.md` §7, §8). |
| 5 | DEPENDENCIES | n/a — absent component. |
| 6 | MULTI-MACHINE RISK | The risk this DROP prevents: a lane running untrusted code "in its own worktree" and calling that safe, across five machines with no mechanism to contradict the claim. |
| 7 | SECURITY / PRIVACY RISK | This row **is** the security decision: claiming worktree containment would be a false security claim. The threat model at the event is five cooperative humans and their own agents, not hostile code; if hostile third-party code ever must run, containment is an OS/container mechanism — out of scope for v1 (`04_DEVELOPMENT_PLAN.md` §13 non-goals) and re-entry is by amendment only. |
| 8 | REQUIRED REWRITE | None — absence. |
| 9 | TARGET TEST OR REHEARSAL / DROP COST | **Drop cost: none at this event.** No capability is lost; the only thing lost is a false sense of security. No plan task depends on worktree containment. If rehearsal or the event introduces execution of hostile code, containment returns via a ledger amendment naming a real mechanism (container/OS sandbox), never a worktree. |
| 10 | DECISION | **DROP** — falsified by prior work and kept as a decision: it is not a sandbox (plan §4, `04_DEVELOPMENT_PLAN.md` §4). |
| — | Validation state | `DESIGNED` (absence by decision; nothing to exercise). → `DESIGNED+CHECKED` when: **P6 step 6.7** adversarial review has run and confirmed no design element silently relies on worktree containment. If one does, the element is corrected — the DROP is not revisited. |

### L-09 — Heartbeat/watchdog protocol — **DROP for v1**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Prior-work pattern: a **hand-built watchdog inside a process-supervision layer**, plus the operator's recorded lesson that **heartbeat-as-liveness was a documented mistake** — a missed heartbeat detects suspected loss, never semantic progress or correctness. `[FACT — operator experience, prior supervised-agent work]` |
| 2 | CURRENT CONSUMER | **None** in this project. In the prior runtime, lifecycle belonged to the supervising tooling rather than to a hand-built watchdog; this design adopts the same boundary — existing tooling carries supervision, nothing custom is built (contract §1 prohibited list, §4 `RUNTIME` boundary; `04_DEVELOPMENT_PLAN.md` §13 non-goals). |
| 3 | BEHAVIOUR PROVED TO DATE | `[UNPROVEN]` Nothing is proved: no watchdog and no fleet exist here, and the drift this row predicts has not been observed. The checks that would prove the absence is safe are **P6 steps 6.4/6.6** — work reassignable from Git state alone, and setup fitting the preparation window (`04_DEVELOPMENT_PLAN.md` §9; `07_FAILURE_AND_REHEARSAL_PLAN.md` §6.4, §6.6). `[INFERENCE]` No demonstrated need at five humans × five machines: each human sees their own machine, and stalls are surfaced by the observer's bounded stall alert (`04_DEVELOPMENT_PLAN.md` §8, P5.4) — a watch item, not a protocol. The stall-alert path's own exposure — a rule that would fire on a deliberately sleeping lane — is recorded in `07_FAILURE_AND_REHEARSAL_PLAN.md` §3 (premortem) and bounded by the per-cycle items in `05_IMPLEMENTATION_CHECKLIST.md` §5. |
| 4 | TARGET USE | None in v1. Stall detection = observer stall alerts (P5.4, `DR`/E26 path) + documented human escalation triggers (P4.7, `ESC`) — `04_DEVELOPMENT_PLAN.md` §8, §7. |
| 5 | DEPENDENCIES | n/a — absent component. |
| 6 | MULTI-MACHINE RISK | A silently hung lane burns event clock. Mitigation without a protocol: the disconnection drill proves work is reassignable from Git state (P6 6.4), and the stall window is chosen at P5.4. |
| 7 | SECURITY / PRIVACY RISK | A heartbeat channel would become a second lifecycle truth source beside Git — the parallel-truth failure class the contract prohibits: no second authoritative store or mirror of the repository (contract §1; `04_DEVELOPMENT_PLAN.md` §13 non-goals). |
| 8 | REQUIRED REWRITE | None — absence. |
| 9 | TARGET TEST OR REHEARSAL / DROP COST | **Drop cost: detection latency.** A hung lane is found by human noticing plus observer stall alerts instead of an automatic protocol; the latency equals the stall window set at P5.4. If rehearsal (**P6 steps 6.4, 6.6**) shows stalls going undetected, automation returns by amendment under the standing rule **automate only friction demonstrated in rehearsal** — with the liveness invariant intact: liveness signals trigger inspection, never settlement. Both rehearsal gates state the rule this rests on: a drill that found nothing is insufficient, not a pass (`04_DEVELOPMENT_PLAN.md` §9; `07_FAILURE_AND_REHEARSAL_PLAN.md` §6). |
| 10 | DECISION | **DROP for v1** — cost without demonstrated need at this scale (plan §4, `04_DEVELOPMENT_PLAN.md` §4). |
| — | Validation state | `DESIGNED` (absence by decision). → `DESIGNED+CHECKED` when: P6 6.4/6.6 have run and the rehearsal record states whether stalls were detected without a protocol. If not detected, the amendment path in field 9 opens. |

### L-10 — Full deterministic gates suite — **REFERENCE ONLY**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Prior-work pattern: a **small suite of runnable detectors built from real defects** found in the operator's own systems, each detector a script with recorded output against a known-bad fixture and a synthetic clean fixture. `[FACT — operator experience, prior audited systems]` |
| 2 | CURRENT CONSUMER | **None** in this project — reference only. The prior consumers were the operator's own audit work on those systems; no hackathon artifact consumes the suite (`04_DEVELOPMENT_PLAN.md` §4, REFERENCE ONLY row). |
| 3 | BEHAVIOUR PROVED TO DATE | `[UNPROVEN]` for this project — no detector ships, so there is nothing here to exercise. The checks that would surface a need are the **P6 step 6.7** adversarial review (document/code drift across the artifact set) and the **P6 step 6.2** dry run (`04_DEVELOPMENT_PLAN.md` §9; `07_FAILURE_AND_REHEARSAL_PLAN.md` §6.7). `[FACT]` The suite's detectors caught real defects in the operator's prior work; that is experience, not evidence about this package. `[FACT]` The suite's own standing caution is carried into this design as a rule rather than a tool: do not add gates faster than they are enforced — the failure class recorded in `07_FAILURE_AND_REHEARSAL_PLAN.md` §4 (catch ledger) and §2 (control table). |
| 4 | TARGET USE | Design input only. Three ideas are consumed by this architecture without shipping any detector: (a) every field names its reader (contract §1; P-C wording); (b) a declared thing names what enforces it or is deleted — the declaration habit, operationalised as the three-state control table (`07_FAILURE_AND_REHEARSAL_PLAN.md` §2); (c) one CI check with a reproducible command (`CI` node; `04_DEVELOPMENT_PLAN.md` §7, P4.9; cut order keeps "automated CI beyond one check" as cuttable, `03_ARCHITECTURE_BLUEPRINT.md` §8.2). |
| 5 | DEPENDENCIES | n/a for reference use. |
| 6 | MULTI-MACHINE RISK | None — nothing runs across machines. |
| 7 | SECURITY / PRIVACY RISK | The suite's absolute-path lesson applies to portfolio sanitization: no absolute user paths, run IDs, terminal IDs, or secret-shaped config in anything published (`03_ARCHITECTURE_BLUEPRINT.md` §11; `04_DEVELOPMENT_PLAN.md` §10 P9). |
| 8 | REQUIRED REWRITE | None — consulted, not ported. |
| 9 | TARGET TEST OR REHEARSAL | No target mechanism, so no target test. Reference consumption is observable at **P1**: this row and `03_ARCHITECTURE_BLUEPRINT.md` §7 consume the gate ideas while the plan ships no detector (`04_DEVELOPMENT_PLAN.md` §4). If the team later demonstrates a need (e.g. **P6 step 6.7** surfaces doc/code drift), a gate enters via a ledger amendment with its own row and check — not by silent adoption. |
| 10 | DECISION | **REFERENCE ONLY** — design input; too heavy to port under event time (plan §4, `04_DEVELOPMENT_PLAN.md` §4). |
| — | Validation state | `DESIGNED` (reference consumed; no mechanism in the target to exercise). → `DESIGNED+CHECKED` only via amendment: if a gate is ever ported, the new row names its runnable check. |

### L-11 — Hosted vector search / embeddings — **DROP**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Prior-work pattern: **in-repository corpus utilities over a local document library** — embeddings, an index, and document extraction built for a corpus that existed in that work. `[FACT — operator experience, prior corpus tooling]` |
| 2 | CURRENT CONSUMER | **None** in any current fleet. The prior consumer was a document corpus that does not exist here, and even there the search stack was consumer-free: no in-repository caller existed, and the one boundary that existed stripped provenance. `[FACT — operator experience]` |
| 3 | BEHAVIOUR PROVED TO DATE | `[UNPROVEN]` Nothing is proved: no index exists here and no retrieval has run. The checks that would surface a need are the **P6 step 6.2** synthetic dry run and, at the event, P3 research-loop throughput (`04_DEVELOPMENT_PLAN.md` §9, §6). `[FACT]` The topic is unknown until T+0, so nothing can be pre-indexed (`03_ARCHITECTURE_BLUEPRINT.md` §1.2). `[FACT]` The standing prior-work rule is carried as this row's reason: existence and quality are not sufficient reasons to include something. `[INFERENCE]` Research-mode retrieval over live sources with mandatory provenance (`04_DEVELOPMENT_PLAN.md` §6, P3.2) covers the event's need; an index would add a second truth store beside `MP` and `REPO`. |
| 4 | TARGET USE | None. |
| 5 | DEPENDENCIES | n/a — absent component. |
| 6 | MULTI-MACHINE RISK | A hosted index is shared state across five machines — a second authoritative store, prohibited (contract §1: no mirroring the repository into a second authoritative database). |
| 7 | SECURITY / PRIVACY RISK | Uploading team research or repository content to a third-party embedding service before organizer permission rules are known (`03_ARCHITECTURE_BLUEPRINT.md` §10 Q12/Q13) is a privacy breach waiting to happen. |
| 8 | REQUIRED REWRITE | None — absence. |
| 9 | TARGET TEST OR REHEARSAL / DROP COST | **Drop cost: none demonstrated.** No plan task depends on vector retrieval. If the revealed topic ships a document corpus too large to read directly, the fallback is mechanical search and human reading; adding hosted search mid-event requires an amendment **and** an explicit permissions answer (Q12, `03_ARCHITECTURE_BLUEPRINT.md` §10). The check that would surface such a need is the **P6 step 6.2** synthetic dry run and, at the event, P3 research-loop throughput (`04_DEVELOPMENT_PLAN.md` §9, §6). |
| 10 | DECISION | **DROP** — no evidence of need; topic is unknown (plan §4, `04_DEVELOPMENT_PLAN.md` §4). |
| — | Validation state | `DESIGNED` (absence by decision). → `DESIGNED+CHECKED` when: the P3 dry run (executed at P6 6.2) has run and its record states whether retrieval without embeddings was sufficient. |

### L-12 — Custom dispatcher / scheduler — **DROP**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Prior-work pattern: a **hand-built dispatcher that became the convergence hub of that system** — the one module every integration had to touch, so wiring anything new was expensive and declarations accumulated instead. `[FACT — operator experience, prior supervised-agent runtime]` |
| 2 | CURRENT CONSUMER | **None**; prohibited by every authority in this package: the contract's prohibited list (no custom distributed runtime, scheduler, or message bus — contract §1), the plan's non-goals (`04_DEVELOPMENT_PLAN.md` §13), and the `RUNTIME` boundary label "existing tooling; no custom scheduler, no message bus" (contract §4). |
| 3 | BEHAVIOUR PROVED TO DATE | `[UNPROVEN]` Nothing is proved; the confirming check is **P6 step 6.7** adversarial review — no artifact silently requires a scheduler (`04_DEVELOPMENT_PLAN.md` §9; `07_FAILURE_AND_REHEARSAL_PLAN.md` §6.7). `[FACT]` The prior-work experience is that a convergence hub makes enforcement expensive, so declarations outnumbered wiring — the exact failure class this package records in `07_FAILURE_AND_REHEARSAL_PLAN.md` §4 (catch ledger) and §2 (control table). `[INFERENCE]` For five lanes the scheduling data already exists in `MP.dependency_graph` + `MP.integration_order`, consumed by humans at the merge gate (edge E18 "human merge, integration order"; `03_ARCHITECTURE_BLUEPRINT.md` §3.3), and Git plus supervised agent tooling carries the rest. |
| 4 | TARGET USE | None. Coordination = Git + supervised agents + human cadence (`04_DEVELOPMENT_PLAN.md` §10, P8 operation table). |
| 5 | DEPENDENCIES | n/a — absent component. |
| 6 | MULTI-MACHINE RISK | A custom dispatcher would be a single point of failure and a second lifecycle truth across five machines — the duplicated-writer / parallel-truth failure classes the contract prohibits (contract §1). |
| 7 | SECURITY / PRIVACY RISK | A scheduler holding task state holds a mirror of the work — a second authoritative database beside `REPO` (prohibited, contract §1). |
| 8 | REQUIRED REWRITE | None — absence. |
| 9 | TARGET TEST OR REHEARSAL / DROP COST | **Drop cost: none at this scale.** Process supervision is what existing tooling already does; judging whether work is acceptable was never the dispatcher's to own (`07_FAILURE_AND_REHEARSAL_PLAN.md` §4 catch ledger; `04_DEVELOPMENT_PLAN.md` §4 gate). If coordination friction appears, the fix is a documented human cadence, tested at **P6 step 6.6** — the time-box check that setup fits the preparation window (`04_DEVELOPMENT_PLAN.md` §9) — not a scheduler. |
| 10 | DECISION | **DROP** — explicitly a non-goal (plan §4, `04_DEVELOPMENT_PLAN.md` §4). |
| — | Validation state | `DESIGNED` (absence by decision). → `DESIGNED+CHECKED` when: P6 6.7 adversarial review has run and confirmed no artifact silently requires a scheduler. |

### L-13 — Semantic GitHub judge — **DROP**

| # | Field | Record |
|---|---|---|
| 1 | SOURCE | Prior-work pattern, **rejected**: an AI component adjudicating semantic correctness of pull requests and CI results, resting on agreement among sources as a trust signal. `[FACT — operator experience: that corroboration-as-truth approach was measured in prior work and did not hold; the measurement belongs to that work and is deliberately not reproduced or quoted here]` The rejection rests on a principle this package states on its own authority: **"Agreement is not truth. Several sources or agents agreeing is recorded as agreement, never as verification: corroboration is a property of the sources, not of the world"** (contract §1). Discarded alternatives: `03_ARCHITECTURE_BLUEPRINT.md` §9. |
| 2 | CURRENT CONSUMER | None; prohibited (contract §1 prohibited list; `04_DEVELOPMENT_PLAN.md` §13 non-goals). |
| 3 | BEHAVIOUR PROVED TO DATE | `[UNPROVEN]` Nothing is proved; the checks that would confirm the absence are **P5.3** schema inspection (observation fields only, no assessment field — `04_DEVELOPMENT_PLAN.md` §8) and **P6 step 6.7** adversarial review confirming no artifact smuggles assessment language into the observer's outputs (`04_DEVELOPMENT_PLAN.md` §9; `07_FAILURE_AND_REHEARSAL_PLAN.md` §6.7). `[FACT]` In this repository, the design that replaces a judge is written down: the observer's deviation report carries observation fields only (`03_ARCHITECTURE_BLUEPRINT.md` §5.5, §8.3), and human judgement is reached solely through facts and risks (edge E26, contract §4). `[INFERENCE]` A judge attached to GitHub would place opaque judgement exactly where the design requires auditable evidence (edge E17: "exact candidate diff + evidence"). |
| 4 | TARGET USE | None. PR assessment = `CI` results (E15/E16) + independent human-or-agent review of the exact diff (L-04) + the human `MERGE` decision. The observer reports facts and risks, never assessment (`DR` node label; E26) — a semantic judge is the failure mode L-06's schema is built to exclude. |
| 5 | DEPENDENCIES | n/a — absent component. |
| 6 | MULTI-MACHINE RISK | A judge's verdicts would become a de-facto coordination signal across lanes — agreement masquerading as truth (contract §1: "agreement is not truth"). |
| 7 | SECURITY / PRIVACY RISK | A semantic judge reading all PR content concentrates repository material in one non-human decision point; a wrong verdict at merge time is unrecoverable under event clock — the reason D6 ("human owns every merge", reversal condition: never) exists (`03_ARCHITECTURE_BLUEPRINT.md` §9). |
| 8 | REQUIRED REWRITE | None — absence. |
| 9 | TARGET TEST OR REHEARSAL / DROP COST | **Drop cost: none.** Semantic acceptance was never automatable on the available evidence; humans read exact diffs anyway (L-04). The only thing forgone is an impressive-looking component — and building components for portfolio appearance is itself prohibited (contract §1). Standing check: **P6 step 6.7** adversarial review confirms no artifact smuggles assessment language into the observer's outputs (reinforced by P5.3's no-assessment-field schema check). |
| 10 | DECISION | **DROP** — places opaque judgement where evidence is required (plan §4, `04_DEVELOPMENT_PLAN.md` §4). |
| — | Validation state | `DESIGNED` (absence by decision). → `DESIGNED+CHECKED` when: P5.3 schema check and P6 6.7 review have run and confirmed no assessment path exists. Re-entry is not anticipated: D6's reversal condition is "never" and the corroboration falsification stands; only a contract change, not a ledger amendment, could reopen this. |

---

## 4. Summary

Count method: 1:1 against plan §4 rows (`04_DEVELOPMENT_PLAN.md` §4), in order. 13 candidates =
5 REUSE + 2 ADAPT + 1 REFERENCE ONLY + 5 DROP (one of the five scoped "for v1"). None added, none
removed, none re-decided.

| ID | Candidate | Verdict (plan §4) | Validation state | Target check → phase | Load-bearing in-repo anchor |
|---|---|---|---|---|---|
| L-01 | Principal/worker separation | **ADAPT** | DESIGNED+CHECKED | P6 6.1; P4.2 | `04` §9, §7 |
| L-02 | Task and result contracts | **REUSE** | DESIGNED+CHECKED | P6 6.2; P4.6 | `04` §9, §7 |
| L-03 | One-writer-per-workspace | **REUSE** | DESIGNED+CHECKED | P4.8; P6 6.3 | `04` §7; `07` §6.3 |
| L-04 | Independent review of exact candidate | **REUSE** | DESIGNED+CHECKED | P4.6; P6 | `04` §7, §9 |
| L-05 | Evidence-before-completion | **REUSE** | DESIGNED+CHECKED | P6 6.2/6.3; P4.6 | `04` §11, §12 |
| L-06 | Read-only observer + read-only credential | **ADAPT** | DESIGNED+CHECKED | P5.1; P5.3; P6 6.5 | `07` §1, §7 |
| L-07 | Git worktree isolation | **REUSE** | DESIGNED+CHECKED | P4.3; P4.8; P6 6.4 | `04` §7, §9 |
| L-08 | Worktree as *security* containment | **DROP** | DESIGNED | P6 6.7 (review confirms absence) | `04` §4; `07` §6.7 |
| L-09 | Heartbeat/watchdog protocol | **DROP for v1** | DESIGNED | P6 6.4/6.6 | `04` §8, §9; `07` §3 |
| L-10 | Full deterministic gates suite | **REFERENCE ONLY** | DESIGNED | none (reference consumed at P1) | `04` §4; `07` §2, §4 |
| L-11 | Hosted vector search / embeddings | **DROP** | DESIGNED | P6 6.2 (need would surface here) | `03` §1.2, §10; `04` §6 |
| L-12 | Custom dispatcher / scheduler | **DROP** | DESIGNED | P6 6.6/6.7 | `04` §13; `07` §4 |
| L-13 | Semantic GitHub judge | **DROP** | DESIGNED | P5.3; P6 6.7 | `03` §9; `04` §13 |

Numbered short forms in the last column follow the anchor convention in §0: `03` = the blueprint,
`04` = the development plan, `07` = the failure and rehearsal plan.

**Where the evidence for these rows now comes from.** No record rests on executed evidence produced
in this project: no rehearsal has run and the event has not happened. Each record's BEHAVIOUR PROVED
TO DATE states that plainly and names the in-repo check that would produce the missing evidence; each
SOURCE records a prior-work pattern as operator experience, which is provenance for a decision and
not proof about this design. Three rows carry the design's weight: **L-03** (one writer per
workspace — the anti-collision rule), **L-05** (a completion event is not acceptance), and **L-08**
(worktrees are not containment, so the read-only claim must be made mechanically or narrowed in
writing). The package-level audit that checked these rows is recorded in §0 above: a census across
all artifacts plus an independent adversarial review (23 findings, all fixed — contract §5;
`07_FAILURE_AND_REHEARSAL_PLAN.md` §9).

---

## 5. What this ledger does NOT prove

- **The event has not happened.** No row describes behaviour observed at a hackathon.
- **No rehearsal for this project has run.** Every target check named above (P4.x, P5.x, P6 6.1–6.8)
  is defined but unexecuted. Therefore **no row in this ledger is `ENFORCED`**, and no row will be
  until its named check is executed and observed to block a real violation.
- **Prior-work experience does not transfer automatically.** Statements marked `[FACT — operator
  experience]` record decisions carried from systems the operator ran at smaller scale (one machine,
  one candidate, one reviewer). Five humans across five machines is untested territory for every
  REUSE row; the P6 rehearsal (`04_DEVELOPMENT_PLAN.md` §9) exists to find where the transfer breaks.
- **A DROP is not proof the dropped component is worthless.** It records absence of demonstrated
  need **for this event**, with a cost statement and an amendment path. L-10 in particular records a
  prior suite whose detectors caught real defects (operator experience); it is reference-only here
  because of event-time cost, not because of doubt about the tooling.
- **No semantic correctness, no hackathon outcome, no claim that monitoring improves delivery.**
  The observer rows (L-06) describe a designed, degradable reporting role; nothing here shows it
  helps the team win or even finish.
- **Classification verdicts belong to the operator.** This ledger records and grounds the plan §4
  decisions; where prior work used a different label for the same item (noted in L-05), the plan §4
  verdict stands and the tension is reported, not silently resolved.

**Privacy:** no participant names, no repository contents, no credentials, no sponsor or organizer
material, and no topic-specific detail appear in this ledger. Every example is synthetic.