# Deliverable Contract — the frozen interfaces this package was authored against

**Status:** final, 2026-09-15
**Purpose:** this package was written by several authors working in parallel, each owning exactly one
file. This document is the contract they were given: the system invariants they could not redesign,
the house style every artifact follows, the diagram node and edge IDs every artifact cites, and the
file-ownership map that kept two writers off one fact. It is published because otherwise the
cross-references in the other artifacts ("contract §4") resolve to nothing.

**Verification method.** Written against the working tree at commit `531830a` (see `HISTORY.md` for
the full commit sequence, included so SHAs resolve in copies without git history); the node and edge
inventory in §4 was checked against the rendered diagram (`render/06_ARCHITECTURE.png`, produced
from `06_ARCHITECTURE.mmd` by mermaid-cli 11.17.0 with mermaid 11.17.2). No mechanism described here
has been executed: no rehearsal has run and the event has not happened.

**Claim labels used across the package.** `[FACT]` — executed or read directly. `[INFERENCE]` —
reasoned from evidence. `[UNPROVEN]` — designed, not tested.

---

## 1. System invariants — what no author could redesign

Two machines carry three roles:

- **S1 — research machine.** Decomposes an unknown topic into a frozen, versioned **Mission
  Package**, and runs two concurrent modes: `research` (on demand) and `observe` (continuous).
- **S2 — development fleet.** Five humans, five machines, one writer per workspace, branch, or
  worktree. Builds against the frozen package.
- **Observer** — a role on S1, not a separate system, and **degradable (tier 2)**: under time
  pressure it is switched off and the team loses monitoring, never the ability to build.

| Principle | Meaning |
|---|---|
| Topic-agnostic | The hackathon topic is unknown. No component may assume a domain. |
| Mission Package is the only cross-boundary artifact | Research hands no prose to developers. Frozen on human approval; changes are numbered amendments. |
| Human owns merge | No AI merges. Ever. |
| One writer per workspace | No two workstreams on one surface. |
| Facts require sources | Every factual claim carries provenance. |
| Agreement is not truth | Several sources or agents agreeing is recorded as agreement, never as verification: corroboration is a property of the sources, not of the world. |
| Degrade visibly | Every failure mode has a named fallback, and every degradation is announced. |
| Every field names its reader | A declaration is cheap and feels like progress; wiring it is expensive and invisible. Every declared field names the reader that consumes it, or it is deleted. |
| Scope cut is explicit | The cut order is part of the deliverable, not an admission. |
| Instruction is not enforcement | An instruction in a prompt is not a control. A role described as read-only is read-only only when something makes mutation impossible; where that mechanism cannot be configured, the claim is narrowed in writing rather than upgraded in prose. |
| Untrusted input is data, never instruction | Content ingested from external sources — pages, documents, search results, provider output — enters the package as quoted evidence and never as an instruction. The fleet executes the frozen package, not the web. A source that contains instruction-shaped text is a finding about that source, and any lane acting on such text is a defect, not a shortcut. |

**Prohibited everywhere in this package** — never proposed, never documented as present: building
the hackathon solution; a second agent runtime; a custom distributed runtime, scheduler, or message
bus; an internal goal-broker service or goal-transfer database; AI merge authority; a permanent
agent-per-human role ontology; mirroring the repository into a second authoritative store;
dashboards built for appearance; a semantic repository judge; treating multi-agent agreement as
truth.

---

## 2. House style — binding on every artifact

1. **Header legend** defining the claim labels and the validation states, plus a verification-method
   line naming what was actually read or run (commit SHA, sections, render command).
2. **Typed claim labels** on every claim: `[FACT]`, `[INFERENCE]`, `[UNPROVEN]`.
3. **Anchored claims.** `file:line` or `§N` cross-references. Quote verbatim output where it is the
   evidence. Never state in prose what a table or a generated count can state.
4. **Counts carry method.** State how the count was taken and what was classified out.
5. **Validation states with entry criteria.**

| State | Meaning |
|---|---|
| `DESIGNED` | Specified in an artifact. No check has ever exercised it. |
| `DESIGNED+CHECKED` | Specified, and a defined check exists that can exercise it (the check is named). |
| `ENFORCED` | A mechanism makes the violation impossible, and that mechanism has been observed to block it. |

**Nothing in this package is `ENFORCED`.** No rehearsal has run and the event has not happened.
Every control row states its entry criterion to the next state. The statement is repeated in each
artifact's header deliberately: every document is written to be read standalone, and a state that
only existed in one file would be invisible to a reader holding the others. It is falsifiable, not
self-sealing — execute P5.1 and the observer row's state changes.

6. **Downgrade language only.** Write "contractually read-only; no write path observed", never
   "security-enforced". Write "designed, unrehearsed", never "proven".
7. **Failure writing is root-cause grouped**, each entry shaped *what was observed → evidence → why
   → what prevents it*, with prevention pointing at a runnable check rather than at discipline.
8. Every artifact keeps a **positive-patterns** or limitations statement, and every acceptance
   condition is observable.
9. English only. No emoji. No buzzwords, no throat-clearing, no empty contrasts.

---

## 3. Attribution, privacy, and the claim

**The claim, stated exactly:**

> The operator designed and documented an implementation-ready multi-AI workflow for a five-person
> cybersecurity team facing an unknown hackathon topic: a research machine that freezes an approved
> Mission Package, a multi-laptop development fleet under one-writer ownership, and a read-only,
> degradable observer. Deliverables: architecture blueprint, A–Z development plan, implementation
> checklist, and a version-controlled diagram.

**Scope of the discovery, stated exactly:** discovery is specified rather than completed. Stakeholder
intent, constraints, assumptions, non-goals, risks, and decision owners are explicit. Of the fourteen
architecture-blocking questions, two are answered, one is answered in part, and eleven remain open,
tracked with sources and dates in `01_DISCOVERY_CLOSURE.md` (counted by the register's own status
column: 2 `ANSWERED`, 1 `PARTIAL`, 11 `OPEN`).

**Attribution, stated exactly:**

> The operator designed the architecture and workflow. The operator did not build, deploy, or test
> these systems, and did not participate in the hackathon solution. The five-person team owns
> implementation of the hackathon solution. No hackathon outcome or semantic correctness is claimed.

**Privacy:** no participant names, no repository contents, no credentials, no sponsor or organizer
material, no topic-specific detail that could disadvantage the team's event. Every example is
synthetic and labelled synthetic.

**What this package does not prove:** no hackathon outcome; no semantic correctness of the team's
solution; no proof that any mechanism held under real time pressure; no rehearsal evidence (none
exists yet); no claim that monitoring improves delivery.

---

## 4. Diagram inventory — the node and edge IDs every artifact cites

`06_ARCHITECTURE.mmd` is the single diagram and the source of truth for these identifiers. Every
other artifact cites them rather than redrawing anything.

### Subgraphs and nodes

| Subgraph | Node ID | Meaning |
|---|---|---|
| `RUNTIME` | — | Coordination / runtime boundary: existing tooling (Git + supervised agents). No custom scheduler, no message bus. Contains `S1` and `S2`. |
| `S1` | — | Research machine — one machine, two concurrent roles |
| | `RM` | Research mode — topic decomposition, provenance |
| | `MP` | Mission Package vN — frozen, versioned (artifact node) |
| | `OB` | Observer mode — read-only, tier-2 **degradable** |
| | `DR` | Deviation report — observation fields only, no assessment field |
| `S2` | — | Development fleet — five humans, five machines, one writer per workspace |
| | `AG` | Task-selected capability bundles — chosen per task, not per human |
| | `L1`–`L5` | Lane N — human N, machine N, worktree/branch `workstream-N` |
| `GH` | — | Repository and CI — the single source of truth |
| | `REPO` | Git remote — repository, branches (artifact node) |
| | `PR` | Pull requests — exact candidate diffs |
| | `CI` | CI checks — reproducible commands, not narration |
| `HA` | — | Human authority — no AI merge, ever |
| | `APPR` | Package approval gate (decision node) |
| | `MERGE` | Merge owner — one named human (decision node) |
| | `ESC` | Escalation / decision point (decision node) |
| `LEG` | `LEG*` | Legend — exemplar edges for each visual class plus the standing notes |

### Edges

| Class | Visual | Edges | Meaning |
|---|---|---|---|
| `flow` | solid blue | `E1`–`E18` | Normal artifact handoff: research → package → approval → lanes → push → PR → CI → merge. `E4` is labelled as the only artifact crossing the research/development boundary. |
| `select` | dotted purple | `E19`–`E23` | Capability selection. **Rendered collapsed**: one edge `AG --> L1` labelled "per-task bundle — every lane, selected per task". Semantics unchanged; the collapse is recorded in the `.mmd` header. |
| `observe` | dashed grey | `E24`–`E26` | Read-only observation: repository/PR/CI events → observer → deviation report → escalation. |
| `fail` | dashed red | `E27`–`E30` | Escalation and degradation: lane escalation → skills decision point → numbered amendment request; `E29` (degraded local build if S1 is lost — **drawn `REPO --> L5`** per the recorded reroute); `E30` (observer outage is itself visible). |
| node style | orange dashed border, pale fill | `OB` | The `degradable` class, used only by the observer. |

Legend notes carried in the render: the degradable node style; the lane left-to-right order
(2,5,3,4,1) is layout output and lane identity is the label, never the position; all examples are
synthetic.

---

## 5. Authoring method — how this package was produced

Each artifact had exactly one writer. That is the same rule the package imposes on the development
fleet, applied to its own production.

| File | Owner | Wave |
|---|---|---|
| `06_ARCHITECTURE.mmd`, `render/*` | diagram author | 1 |
| `02_REUSE_LEDGER.md` | ledger author | 1 |
| `03_ARCHITECTURE_BLUEPRINT.md` | blueprint author | 2 |
| `04_DEVELOPMENT_PLAN.md` | plan author | 2 |
| `05_IMPLEMENTATION_CHECKLIST.md` | checklist author | 2 |
| `07_FAILURE_AND_REHEARSAL_PLAN.md` | failure-plan author | 2 |
| `08_PORTFOLIO_BRIEF.md` | coordinator (the operator, T. Gonczar) | 3 |
| `01_DISCOVERY_CLOSURE.md`, `README.md`, `00_DELIVERABLE_CONTRACT.md` | coordinator (the operator, T. Gonczar) | 3 |

Interfaces were frozen before authoring began: the invariants in §1, the ten Mission Package fields,
the phase IDs `P0`–`P9`, the decision IDs `D1`–`D8`, the cut priorities, the validation vocabulary,
and the node and edge IDs in §4. Node identifiers were frozen independently of edge routing, so a
fallback in one artifact's diagram could not invalidate another artifact's references.

Two fallbacks were taken during the diagram work and are recorded rather than hidden: the `AG` edge
collapse (`E19`–`E23` → one edge) and the `E29` reroute to `L5`. Both are noted in the `.mmd` header
and in this table.

Artifacts cite different commits in their verification lines because each was last verified at a
different point in the sequence; `HISTORY.md` lists the commits and what each changed, so a reader
without git can still place every claim.

Six artifacts disagreeing is the predicted failure mode of parallel authorship. It was checked, not
assumed: a mechanical census across all artifacts (node IDs, edge IDs, the ten-field schema, the cut
order, `D1`–`D8`, the phase index, the validation states) and an independent adversarial review
(23 findings in one adversarial pass — 6 MAJOR, 14 MINOR, 3 NIT, counted by the reviewer's own severity labels — all fixed). The findings themselves are published with locations and dispositions in
`09_REVIEW_RECORD.md`, not merely counted; the summary is in `07_FAILURE_AND_REHEARSAL_PLAN.md`.

---

## 6. Reading list

Everything an author needed is inside this repository: `01_DISCOVERY_CLOSURE.md` (questions and
answers), `03_ARCHITECTURE_BLUEPRINT.md` (the architecture), `04_DEVELOPMENT_PLAN.md` (the plan),
`05_IMPLEMENTATION_CHECKLIST.md` (the operational register), `06_ARCHITECTURE.mmd` (the diagram),
`07_FAILURE_AND_REHEARSAL_PLAN.md` (validation ledger, premortem, catch ledger), and
`08_PORTFOLIO_BRIEF.md` (the reviewer-facing case study).

---

## 7. Definition of done per artifact

- Every required element present; header legend and verification-method line present.
- Every claim labelled and anchored; counts carry their method.
- Every mechanism carries a validation state with entry criteria to the next.
- Attribution and privacy stated where required, verbatim per §3.
- No emoji, no invented components, nothing from the prohibited list in §1.
- Cross-references use the identifiers in §4 and `§N` section numbers that exist.
- Nothing claims `ENFORCED`.