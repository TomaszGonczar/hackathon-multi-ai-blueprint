# History — what changed, in order

**Purpose:** several artifacts cite the commit their claims were verified against. In a copy of this
package without git history, those short SHAs would otherwise resolve to nothing. This file makes the
provenance checkable inside any copy.

**Reading the SHAs.** A verification line names the commit that was current when *that* artifact was
last verified — so different files cite different commits. That is expected, not an inconsistency:
each file states the state it was checked against, and the sequence below shows what moved between
them.

| Commit | Date | What changed |
|---|---|---|
| `3ea098f` | 2026-09-14 | The two v1 drafts (`03_ARCHITECTURE_BLUEPRINT.md`, `04_DEVELOPMENT_PLAN.md`) committed as authored, preserved unmodified. This is the baseline several artifacts cite. |
| `99fd9c4` | 2026-09-14 | The deliverable package: `06_ARCHITECTURE.mmd` and its renders; validation-state columns and diagram cross-references added to `03` and `04`; `02`, `05`, `07`, `08`, `README` created. Independent adversarial review (23 findings) and the mechanical cross-artifact census were applied in this commit. |
| `64e33a5` | 2026-09-14 | The agreement sweep recorded as run; the portfolio claim in `07` and `08` corrected from "sweep not yet run" to the actual state. |
| `531830a` | 2026-09-15 | Discovery closure: Q1 (one team), Q2 (24 h or more, two days with overnight work) and Q14 (the team executes) answered and recorded; `01_DISCOVERY_CLOSURE.md` created; the overnight protocol designed in response to Q2 (plan §10 cadence rows, §11 failure rows, checklist DC-14–DC-16, ledger V12, premortem PM-12). |
| `711c8b3` | 2026-09-15 | Portfolio readiness: every citation of the operator's private toolchain removed and replaced with this package's own reasoning or its own audit results; `00_DELIVERABLE_CONTRACT.md` published so cross-references resolve; the claim reworded to what the artifacts support. |
| `5e5baab` | 2026-09-15 | Principal-Engineer review applied: untrusted-input boundary (V13, DC-17, P3.8), budget frame, rubric trace, review record published (`09_REVIEW_RECORD.md`). |
| `6411afd` | 2026-09-15 | Independent review findings resolved (`09_REVIEW_RECORD.md` §4, F-01 to F-10) and Flowsint (`reconurge/flowsint`) incorporated as candidate L-14 and rehearsal fixture. |

## [Unreleased]
- **Change:** Reframe setup from "five-machine fleet" to "local multi-laptop"
- **Impact:** Clarifies local prep (research laptop + dev clones) vs. cloud deployment
- **Files:** `README.md`, `03_ARCHITECTURE_BLUEPRINT.md`, `05_IMPLEMENTATION_CHECKLIST.md`, `HISTORY.md`

**What this file is not.** It is a derived view of the repository's commit log, kept so a reader
without git can verify the provenance lines. It records what changed; it makes no claim about whether
any change was correct, and nothing here is evidence that a mechanism works — no rehearsal has run.