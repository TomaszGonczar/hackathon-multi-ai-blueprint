# Hackathon Multi-AI Workflow Blueprint

**One-sentence decision:** two machines carry three roles — a research machine freezes an approved,
versioned Mission Package; a five-machine development fleet builds against it under one-writer
ownership; a read-only, degradable observer on the research machine reports deviation from the
frozen plan. Humans approve the package and own every merge.

**Status:** design complete, unrehearsed. Every mechanism is `DESIGNED` or `DESIGNED+CHECKED`;
nothing is `ENFORCED` — the October event has not happened and no rehearsal has run. Each artifact
states what observation would upgrade each claim.

## What this is

An implementation-ready multi-AI workflow for a five-person cybersecurity team facing a hackathon
whose topic is unknown at preparation time. The package is topic-agnostic by design: its value is
structure, not answers. It covers three systems — single-machine research, five-machine
development, and read-only GitHub observation — plus the plan, checklist, and rehearsal/failure
documentation to stand them up without a second architecture session.

## The picture

![Architecture diagram](render/06_ARCHITECTURE.png)

Source of truth: [`06_ARCHITECTURE.mmd`](06_ARCHITECTURE.mmd) (Mermaid, ELK layout; legend
included; normal flow solid blue, observation dashed grey, failure/escalation dashed red,
capability selection dotted purple). Rendered with `-w 2400`; the committed raster is 2384×2855 px (the render command in `06_ARCHITECTURE.mmd` reproduces it).
The embed above is reduced for orientation only; read the diagram at full size:
[PNG](render/06_ARCHITECTURE.png) · [SVG](render/06_ARCHITECTURE.svg).

## Documents — two registers, one diagram

**Team register** (imperative, scannable, usable under time pressure):

| File | What it is |
|---|---|
| [`05_IMPLEMENTATION_CHECKLIST.md`](05_IMPLEMENTATION_CHECKLIST.md) | 74 binary, assignable checks across seven time slices (T-7, T-1, event start, per cycle, freeze, submission, teardown) plus an event-day quick card |

**Reviewer register** (narrative, trade-offs, judgment):

| File | What it is |
|---|---|
| [`03_ARCHITECTURE_BLUEPRINT.md`](03_ARCHITECTURE_BLUEPRINT.md) | Source-of-truth architecture: discovery record, three systems, authority and security boundaries, cut order, decisions D1–D8 with reversal conditions, discarded alternatives |
| [`04_DEVELOPMENT_PLAN.md`](04_DEVELOPMENT_PLAN.md) | A–Z plan: phases P0–P9, ownership, observable acceptance per task, failure matrix, acceptance matrix |
| [`02_REUSE_LEDGER.md`](02_REUSE_LEDGER.md) | Every candidate from prior work classified REUSE / ADAPT / REFERENCE ONLY / DROP against a ten-field record, with what was actually proved |
| [`07_FAILURE_AND_REHEARSAL_PLAN.md`](07_FAILURE_AND_REHEARSAL_PLAN.md) | Validation ledger, three-state control table, premortem, catch ledger, decision log with missing-data entries, rehearsal drills |
| [`08_PORTFOLIO_BRIEF.md`](08_PORTFOLIO_BRIEF.md) | Fifteen-minute case study: problem → decisions → evidence → limitations |

**Shared records** (both readers):

- [`HISTORY.md`](HISTORY.md) — the commit sequence, so the provenance lines in the artifacts resolve in a copy without git history.
- [`09_REVIEW_RECORD.md`](09_REVIEW_RECORD.md) — every review finding with its location and disposition, and the mechanical census results: the evidence behind the claim that review happened and defects were fixed.
- [`00_DELIVERABLE_CONTRACT.md`](00_DELIVERABLE_CONTRACT.md) — the frozen interfaces this package was authored against: system invariants, house style, the diagram node and edge IDs every artifact cites, the file-ownership map, and the two recorded diagram fallbacks. Read it to see why the artifacts agree with each other and with the diagram.
- [`01_DISCOVERY_CLOSURE.md`](01_DISCOVERY_CLOSURE.md) — every question the architecture branches on, its answer or its open status, the answer's source and date, and what each answer changed in the other artifacts.

Every artifact cross-references the diagram by node ID (`MP`, `L1`–`L5`, `OB`, `MERGE`, …) and edge
ID (`E1`–`E30`), and a mechanical census checks the agreement once per revision — after that sweep, further drift has no automatic check, so the identifiers are what make a disagreement findable rather than impossible (`07_FAILURE_AND_REHEARSAL_PLAN.md` §4 CATCH-6).

## Reading order

- **Team member, 10 minutes:** README → `05` quick card → your slice in `05`.
- **Reviewer, 15 minutes:** `08` → the diagram above → `03` §0/§8/§9 → `07` validation ledger.
- **Implementer, full pass:** `03` → `04` → `05` → `07`, with `02` for provenance of each mechanism.

## Attribution and privacy

The operator designed the architecture and workflow. The operator did not build, deploy, or test
these systems, and did not participate in the hackathon solution. The five-person team owns
implementation of the hackathon solution. No hackathon outcome or semantic correctness is claimed.

No participant names, repository contents, credentials, sponsor or organizer material, or
topic-specific detail appear here. All examples are synthetic and labelled synthetic.

**This package does not prove:** any hackathon outcome; semantic correctness of the team's
solution; that any mechanism held under real time pressure; rehearsal evidence (none exists yet);
that monitoring improves delivery.
