# Portfolio Brief — Multi-AI Hackathon Workflow: a client-style architecture engagement

**Status:** draft v1, 2026-09-14
**Author:** Tomasz Gonczar
**Register:** reviewer-facing case study. Operational detail lives in the artifacts; this document
exists to be read in fifteen minutes by someone assessing engineering judgment.
**Companion artifacts:** `00_DELIVERABLE_CONTRACT.md` (the frozen authoring contract) ·
`01_DISCOVERY_CLOSURE.md` · `02_REUSE_LEDGER.md` · `03_ARCHITECTURE_BLUEPRINT.md` ·
`04_DEVELOPMENT_PLAN.md` · `05_IMPLEMENTATION_CHECKLIST.md` · `06_ARCHITECTURE.mmd` ·
`07_FAILURE_AND_REHEARSAL_PLAN.md`

**Claim labels used below:** `[FACT]` = executed or read directly against the named source.
`[INFERENCE]` = reasoned from evidence. `[UNPROVEN]` = designed, not tested. Verification method:
every statement about the artifacts was read against this repository's working tree at commit
`531830a`, in these files — `00_DELIVERABLE_CONTRACT.md` (§1–§7), `01_DISCOVERY_CLOSURE.md`
(§1–§5), `02_REUSE_LEDGER.md` (§0–§5), `03_ARCHITECTURE_BLUEPRINT.md` (§0–§12),
`04_DEVELOPMENT_PLAN.md` (§1–§15), `05_IMPLEMENTATION_CHECKLIST.md`, `06_ARCHITECTURE.mmd`,
`07_FAILURE_AND_REHEARSAL_PLAN.md` (§1–§10). Nothing below cites a source outside this repository
for a technical claim. Three outside inputs are named where they are used, and none of them is
reproduced here: the engagement brief, held by the operator — it is the authority for the ten-field
shape of the reuse records (`02_REUSE_LEDGER.md` §0); the operator's prior-work experience, cited in
`02_REUSE_LEDGER.md` §3 as provenance for reuse decisions and never as evidence about this design;
and one relayed team-contact statement about event duration (`01_DISCOVERY_CLOSURE.md` Q2, labelled
`[UNVERIFIED — second-hand]`). No rehearsal has run and the event has not happened, so nothing
below claims a tested mechanism or an observed outcome.

---

## 1. Problem

A five-person cybersecurity team entered an October 2026 hackathon with an **unknown topic** —
revealed at or near event start — and a duration measured in hours. They asked for a working method:
how to research a domain none of them knows, plan against it, and build across five machines
without the coordination itself consuming the clock.
`[FACT — blueprint §1–§2 and the "Client:" line of its header]`

The interesting constraint is not technical difficulty. It is **simultaneity**: research, planning,
and building overlap in one short window, across five people who cannot all hold the same context.
The classic failure shapes are known in advance: five incompatible mental models of the problem, a
plan that silently drifts from what is being built, two developers colliding on one surface,
progress asserted from narration instead of evidence, and a single machine whose death takes the
plan with it. `[FACT — blueprint §1.1]`

Because the topic is unknown, **no domain knowledge can be prepared**. The only thing that can be
prepared is process. That single sentence drove every decision below: the system must be
topic-agnostic, and any component that assumes a domain has already failed the brief.
`[FACT — blueprint §1.2]`

## 2. Engagement shape

Client-style discovery, not tool selection first. The discovery record (stakeholder intent, success
criteria, constraints, assumptions, open questions, non-goals, risks, decisions with owners) was
captured before any component was chosen `[FACT — blueprint §2]`, and fourteen questions that only
the team and organizers can answer were explicitly **left open** rather than silently assumed —
with the affected section named for each, so the architecture is written to survive either answer
`[FACT — blueprint §10]`. Three have since been answered or partly answered (Q1 one team; Q2 at
least 24 hours, two days with overnight work; Q14 the team executes) and the rest remain open,
tracked with sources and dates in [`01_DISCOVERY_CLOSURE.md`](01_DISCOVERY_CLOSURE.md).

A reuse audit preceded architecture selection. Every candidate mechanism carried over from prior
agent-system work was classified `REUSE / ADAPT / REFERENCE ONLY / DROP` against a ten-field record
— including "behaviour actually proved", which is where most candidates failed
`[FACT — 02_REUSE_LEDGER.md §3–§4]`.

## 3. The key decisions

The full decision record with reversal conditions is blueprint §9 (D1–D8). The three that carry
the design:

**D2 — The Mission Package is the only artifact that crosses from research into development.**
Research does not hand prose to five builders; it freezes a versioned package (objective,
constraints, evidence with provenance, unknowns, acceptance tests, interfaces, dependency graph,
task ownership, integration order, escalation rules). Changes become numbered amendments with an
approver — silent prompt drift is classified as a defect, not an update. This is the "goal
brokerage" the project needed, implemented as a **document contract rather than a service**: the
discarded-alternatives table records why an internal goal-broker service, a message bus, and a
goal-transfer database were all rejected — each adds a failure domain for a capability Git plus a
versioned file already provide. `[FACT — blueprint §3.3, §9]`

**D6 + D5 — Humans own every merge; one writer per workspace.** No AI merge authority exists in
the design, with "never" as the reversal condition. Parallelism is chosen per task from the
dependency graph — five machines are an operational constraint, not a mandate for five concurrent
workstreams. `[FACT — blueprint §4.1–4.2, §9]`

**D1 + D7 — The observer is a role on the research machine, read-only by credential.** A third
system was deliberately not built: the observer's baseline is the frozen package, the package lives
on S1, so the observer belongs there — one fewer failure domain, one fewer version-skew bug class.
And because **instruction is not enforcement** — "An instruction in a prompt is not a control. A
role described as read-only is read-only only when something makes mutation impossible; where that
mechanism cannot be configured, the claim is narrowed in writing rather than upgraded in prose." —
the read-only claim will rest on token scope once P5.1 executes, or be **downgraded in writing** if
scoping is unavailable; until that execution it is `DESIGNED+CHECKED`, never `ENFORCED`. The
observer is also explicitly **degradable**: tier 2 in the cut order. Under time pressure it is
switched off and the team loses monitoring — never the ability to build.
`[FACT — 00_DELIVERABLE_CONTRACT.md §1; blueprint §5, §7, §8.2]`

## 4. Evidence of method, not of outcome

What can be shown:

- **Acceptance is observable or it does not exist.** Every plan task carries a check another person
  can run; the load-bearing ones are behavioural: a write attempt through the observer token must
  *fail by execution* (P5.1); two machines must *demonstrably* fail to claim one surface (P4.8);
  a deliberately contradictory synthetic source set must *survive* synthesis unresolved (P3.3);
  the plan itself must survive an **anti-cheerleader check** — feed the observer an objectively
  wrong plan and verify it reports deviation instead of defending it (plan §6 explicit test,
  scored at plan §12).
  `[FACT — 04_DEVELOPMENT_PLAN.md §6–§8]`
- **A premortem ran in place of a rehearsal, with twelve named failure reasons.** No rehearsal has
  occurred — the event has not happened. Rather than leave that as a hole,
  `07_FAILURE_AND_REHEARSAL_PLAN.md` §3 records a Klein-style premortem (assume the October run
  failed; why?) whose twelve reasons each name the mechanism they attack, the mitigation that
  already exists, the artifact line it lives on, and the exposure that remains; §4 adds a catch
  ledger of what this design process already caught, and §5 the decision log naming the data that
  was absent for every judgment call. `[FACT — 07_FAILURE_AND_REHEARSAL_PLAN.md §3–§5]`
- **The validation ledger states what is not proven.** Twelve mechanisms, each with a written
  rationale for its state and the entry criterion to the next: four `DESIGNED`, eight
  `DESIGNED+CHECKED`, **zero `ENFORCED`**. A declaration is cheap and feels like progress; wiring it
  is expensive and invisible. Every declared field names the reader that consumes it, or it is
  deleted. `[FACT — 07_FAILURE_AND_REHEARSAL_PLAN.md §1–§2]`
- **The package was reviewed adversarially and cross-checked mechanically, and the defects found are
  listed rather than hidden.** An independent adversarial review produced 23 findings, 6 of them
  MAJOR, all recorded and fixed; a mechanical census of ten checks across every artifact found the
  rest — emoji, absolute paths, a D4 decision-text divergence, and a namespace collision in which
  the cut priorities and the plan phases used the same `P` labels, since resolved by renaming the
  cut priorities to `C0`–`C2` — also fixed. `[FACT — 00_DELIVERABLE_CONTRACT.md §5]`
- **Answering one discovery question exposed a live design gap that is now covered.** Q2 (24 hours
  or more, two days with overnight work) showed that the observer's stall rule would fire on
  deliberately sleeping lanes; the four mechanisms that close the gap are named where they apply —
  pause declaration excluded from stall alerts (DC-15), push-before-offline (DC-14), recorded shift
  handover, and a staffed overnight escalation channel (DC-16), carried as ledger row V12 and
  premortem entry PM-12. `[FACT — 01_DISCOVERY_CLOSURE.md §2]`

## 5. Limitations — stated before a reviewer has to find them

- **Nothing is `ENFORCED`.** Every mechanism in the package is `DESIGNED` or `DESIGNED+CHECKED`;
  the entry criterion for the rest is the P6 rehearsal, which has not run. The blueprint claims no
  mechanism is proven, and says why (§8.4). `[FACT]`
- **The observer grades its own plan's homework.** S1 authors the package and later measures
  against it. The mitigation is structural — the deviation-report schema has observation fields
  only, no assessment field — but a schema constraint against a motivated rationaliser is
  `DESIGNED`, not `ENFORCED`, until the anti-cheerleader check passes.
  `[FACT — blueprint §8.3; 04_DEVELOPMENT_PLAN.md §6]`
- **The two structural questions are settled, and one of them changed the design.** Q1 resolved as
  one five-person team (the five-teams branch is closed). Q2 resolved as at least 24 hours, expected
  two days with overnight work — which made overnight operation live and added four mechanisms the
  design did not previously carry: pause declaration excluded from stall alerts, push-before-offline,
  recorded shift handover, and a staffed overnight escalation channel (`[FACT]` Q2 is second-hand and
  `[UNVERIFIED]` until an organizer confirms it). The night window is `[UNPROVEN]`: drills 6.1–6.8 run
  in a single sitting, so the noise bound has never been tested at 03:00.
  `[FACT — 01_DISCOVERY_CLOSURE.md §1 Q1–Q2; 04_DEVELOPMENT_PLAN.md §10–§12;
  07_FAILURE_AND_REHEARSAL_PLAN.md §3 PM-12]`
- **Coordination overhead is charged against the same clock as building.** The design's own risk
  is that three roles for five people is too much process; the explicit cut order (blueprint §8.2)
  is the answer, and whether the never-cut floor (cut priority C0) really fits in the event window is `[UNPROVEN]` until
  the time-box drill (P6.6) runs.
- **No hackathon outcome is claimed.** The team owns implementation; this engagement produced the
  workflow, not the solution, and no semantic correctness of anything they build is asserted.

## 6. Attribution — stated exactly

> The operator designed the architecture and workflow. The operator did not build, deploy, or test
> these systems, and did not participate in the hackathon solution. The five-person team owns
> implementation of the hackathon solution. No hackathon outcome or semantic correctness is claimed.

**Privacy:** no participant names, no repository contents, no credentials, no sponsor or organizer
material, and no topic-specific detail that could disadvantage the team's October event. Any
example in this package is synthetic and labelled synthetic.

**What this does not prove:** no hackathon outcome; no semantic correctness of the team's solution;
no proof that any mechanism held under real time pressure; no rehearsal evidence (none exists yet);
no claim that monitoring improves delivery.

## 7. The claim, stated exactly

> The operator designed and documented an implementation-ready multi-AI workflow for a five-person
> cybersecurity team facing an unknown hackathon topic: a research machine that freezes an approved
> Mission Package, a five-machine development fleet under one-writer ownership, and a read-only,
> degradable observer. Deliverables: architecture blueprint, A–Z development plan, implementation
> checklist, and a version-controlled diagram.

Discovery is specified rather than completed: stakeholder intent, constraints, assumptions,
non-goals, risks and decision owners are explicit. Of the fourteen architecture-blocking questions,
two are answered, one is answered in part, and eleven remain open, tracked in
`01_DISCOVERY_CLOSURE.md`.

This sentence is usable as of 2026-09-14: all artifacts exist, and the agreement sweep ran — a
mechanical cross-artifact census (node/edge IDs, ten-field schema, cut order, D1–D8, ENFORCED-as-
state, attribution, phase index) plus an independent adversarial review. Its findings — 23 review
findings, 6 of them MAJOR, and the census violations (emoji, absolute paths, a D4 decision-text
divergence, and a namespace collision in which the cut priorities and the plan phases used the same
`P` labels) — were fixed; the collision by renaming the cut priorities to `C0`–`C2`, the rest
committed in `99fd9c4`; the census re-checks that followed returned clean. The claim above is
therefore stated as a claim, frozen with its scope in `00_DELIVERABLE_CONTRACT.md` §3; the
does-not-prove list in §6 still bounds it.

---

## Reading order for a reviewer with fifteen minutes

1. This brief (§3 decisions, §5 limitations).
2. `06_ARCHITECTURE.mmd` rendered — one picture of the whole system; legend included.
3. `03_ARCHITECTURE_BLUEPRINT.md` §0, §8, §9 — the one-sentence decision, the cut order, the
   decision record with reversal conditions.
4. `07_FAILURE_AND_REHEARSAL_PLAN.md` — validation ledger and premortem: what is claimed at what
   confidence, and what would upgrade each claim.
5. If time remains: `04` (execution plan), `05` (team-facing checklist), `02` (reuse ledger).
