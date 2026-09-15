# Portfolio Brief — Multi-AI Hackathon Workflow: a client-style architecture engagement

**Status:** draft v1, 2026-09-14
**Author:** Tomasz Gonczar
**Register:** reviewer-facing case study. Operational detail lives in the artifacts; this document
exists to be read in fifteen minutes by someone assessing engineering judgment.
**Companion artifacts:** `03_ARCHITECTURE_BLUEPRINT.md` · `04_DEVELOPMENT_PLAN.md` ·
`05_IMPLEMENTATION_CHECKLIST.md` · `06_ARCHITECTURE.mmd` · `07_FAILURE_AND_REHEARSAL_PLAN.md` ·
`02_REUSE_LEDGER.md`

**Claim labels used below:** `[FACT]` = executed or read directly against the named source.
`[INFERENCE]` = reasoned from evidence. `[UNPROVEN]` = designed, not tested. Verification method:
all statements about the artifacts were checked against the repository working tree at the commit
named in each artifact's own header; statements about prior projects are anchored to files under
the author's `omega-component-prep/13_LESSONS/` audit corpus.

---

## 1. Problem

A five-person cybersecurity team entered an October 2026 hackathon with an **unknown topic** —
revealed at or near event start — and a duration measured in hours. They asked for a working method:
how to research a domain none of them knows, plan against it, and build across five machines
without the coordination itself consuming the clock. `[FACT — return brief §1, blueprint §2]`

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

A reuse audit preceded architecture selection. Every candidate mechanism from the author's prior
agent-system work was classified `REUSE / ADAPT / REFERENCE ONLY / DROP` against a ten-field record
— including "behaviour actually proved", which is where most candidates failed
`[FACT — 02_REUSE_LEDGER.md; return brief §8]`.

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
And because a prior rehearsal proved that *instructing* an agent to be read-only is not enforcement
`[FACT — 13_LESSONS/27_ORCA_VERTICAL_SLICE_REHEARSAL]`, the read-only claim will rest on token
scope once P5.1 executes, or be **downgraded in writing** if scoping is unavailable; until that
execution it is `DESIGNED+CHECKED`, never `ENFORCED`. The observer is also explicitly
**degradable**: tier 2 in the cut order. Under time pressure it is switched off and the team loses
monitoring — never the ability to build. `[FACT — blueprint §5, §7, §8.2]`

## 4. Evidence of method, not of outcome

What can be shown:

- **A prior falsification changed this design.** The sibling project `dSearch` measured
  multi-source corroboration as a truth proxy: 261 corroborated URLs, 38 correct — precision
  0.1456. `[FACT — 13_LESSONS corpus, cited in blueprint §3.2]` That number is why the research
  rules state *agreement is not truth* and why contradictions are preserved rather than merged or
  voted away — and why a "semantic GitHub judge" sits in the discarded-alternatives table.
- **The author's own audit is applied against this design.** A 17-mechanism census of the prior
  system found 13 with declarations and no production consumer. `[FACT — 01_FAILURE_CATALOG.md
  RC-1]` The hackathon artifacts therefore run every control through a three-state table
  (declared / declared+evidenced / enforced) and a validation ledger in
  `07_FAILURE_AND_REHEARSAL_PLAN.md` — the audit's lesson converted into a documentation gate.
- **Acceptance is observable or it does not exist.** Every plan task carries a check another person
  can run; the load-bearing ones are behavioural: a write attempt through the observer token must
  *fail by execution* (P5.1); two machines must *demonstrably* fail to claim one surface (P4.8);
  a deliberately contradictory synthetic source set must *survive* synthesis unresolved (P3.3);
  the plan itself must survive an **anti-cheerleader check** — feed the observer an objectively
  wrong plan and verify it reports deviation instead of defending it (plan §6 explicit test,
  scored at plan §12).
  `[FACT — 04_DEVELOPMENT_PLAN.md §6–§8]`
- **A premortem was run in place of a rehearsal.** No rehearsal has occurred — the event has not
  happened. Rather than leave that as a hole, `07` records a Klein-style premortem (assume the
  October run failed; why?), a catch ledger of what the design process already caught, and a
  decision log naming the data that was absent for every judgment call. `[FACT — 07]`

## 5. Limitations — stated before a reviewer has to find them

- **Nothing is `ENFORCED`.** Every mechanism in the package is `DESIGNED` or `DESIGNED+CHECKED`;
  the entry criterion for the rest is the P6 rehearsal, which has not run. The blueprint claims no
  mechanism is proven, and says why (§8.4). `[FACT]`
- **The observer grades its own plan's homework.** S1 authors the package and later measures
  against it. The mitigation is structural — the deviation-report schema has observation fields
  only, no assessment field — but a schema constraint against a motivated rationaliser is
  `DESIGNED`, not `ENFORCED`, until the anti-cheerleader check passes. `[FACT — blueprint §8.3;
  04 §6]`
- **The two structural questions are settled, and one of them changed the design.** Q1 resolved as
  one five-person team (the five-teams branch is closed). Q2 resolved as at least 24 hours, expected
  two days with overnight work — which made overnight operation live and added four mechanisms the
  design did not previously carry: pause declaration excluded from stall alerts, push-before-offline,
  recorded shift handover, and a staffed overnight escalation channel (`[FACT]` Q2 is second-hand and
  `[UNVERIFIED]` until an organizer confirms it). The night window is `[UNPROVEN]`: drills 6.1–6.8 run
  in a single sitting, so the noise bound has never been tested at 03:00. `[FACT — 01 Q1–Q2; 04 §10–§12; 07 PM-12]`
- **Coordination overhead is charged against the same clock as building.** The design's own risk
  is that three roles for five people is too much process; the explicit cut order (blueprint §8.2)
  is the answer, and whether the P0 floor really fits in the event window is `[UNPROVEN]` until
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

> The operator ran client-style discovery with a five-person cybersecurity team facing an unknown
> topic, and designed an implementation-ready multi-AI workflow: a research machine that freezes an
> approved Mission Package, a five-machine development fleet under one-writer ownership, and a
> read-only degradable observer. Deliverables: architecture blueprint, A–Z development plan,
> implementation checklist, and a version-controlled diagram.

This sentence is usable as of 2026-09-14: all artifacts exist, and the agreement sweep ran — a
mechanical cross-artifact census (node/edge IDs, ten-field schema, cut order, D1–D8, ENFORCED-as-
state, attribution, phase index) plus an independent adversarial review. Its findings (8 census
violations, 23 review findings) were fixed and committed in `99fd9c4`; the census re-checks that
followed (emoji, absolute paths, D4 text, item count) returned clean. The claim above is therefore
stated as a claim; the does-not-prove list in §6 still bounds it.

---

## Reading order for a reviewer with fifteen minutes

1. This brief (§3 decisions, §5 limitations).
2. `06_ARCHITECTURE.mmd` rendered — one picture of the whole system; legend included.
3. `03_ARCHITECTURE_BLUEPRINT.md` §0, §8, §9 — the one-sentence decision, the cut order, the
   decision record with reversal conditions.
4. `07_FAILURE_AND_REHEARSAL_PLAN.md` — validation ledger and premortem: what is claimed at what
   confidence, and what would upgrade each claim.
5. If time remains: `04` (execution plan), `05` (team-facing checklist), `02` (reuse ledger).
