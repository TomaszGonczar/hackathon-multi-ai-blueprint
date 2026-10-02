# Audit - hackathon-multi-ai-blueprint

Audit of the whole repo `TomaszGonczar/hackathon-multi-ai-blueprint`, state `ed776bd` (HEAD,
after 12 commits since 2026-09-14). All numbers below were counted on the cloned
repo, every quote has a `file:line`.

**State: operationally out of date.** This is a register of what was in the repo
`hackathon-multi-ai-blueprint` before the refactor. Kept as evidence and as context
for the decision - **not as instructions.** Current material: [`README.md`](README.md).

**Decision made 2026-09-29: observer removed.** The question that §4 and §7 of this
file left open is settled - see [`04-SYSTEM-PRODUCTION.md`](04-SYSTEM-PRODUCTION.md),
the "Merge" section. The arguments from §4 remain current as the rationale for the removal, not
as a question for discussion.

**What remains of this audit:** §2 (seven things worth keeping), §3.1 (the live
contradiction, to be fixed in the old repo), §5 (the diagram).

**What is operational today:** the five files `01`-`05`.

---

## 1. Scale

| File | Lines | Bytes | Operational role on Saturday |
|---|---:|---:|---|
| `05_IMPLEMENTATION_CHECKLIST.md` | 675 | 66 KB | a checklist that cannot be executed |
| `07_FAILURE_AND_REHEARSAL_PLAN.md` | 512 | 67 KB | an audit of the documentation itself |
| `03_ARCHITECTURE_BLUEPRINT.md` | 431 | 38 KB | architecture |
| `02_REUSE_LEDGER.md` | 415 | 60 KB | **zero** (provenance of others' work) |
| `04_DEVELOPMENT_PLAN.md` | 334 | 40 KB | plan |
| `00_DELIVERABLE_CONTRACT.md` | 217 | 14 KB | **zero** (how to write documents) |
| `08_PORTFOLIO_BRIEF.md` | 206 | 15 KB | **zero** (the author's portfolio) |
| `09_REVIEW_RECORD.md` | 144 | 17 KB | **zero** (documents judging themselves) |
| `01_DISCOVERY_CLOSURE.md` | 122 | 10 KB | register of questions |
| `README.md` | 78 | 6 KB | index |
| `HISTORY.md` | 28 | 3 KB | log |
| **Total** | **3,391** | **348 KB** | |
| `06_ARCHITECTURE.mmd` | 161 | - | 30 edges, ELK, unreadable |
| `render/06_ARCHITECTURE.png` | - | - | 2384×2855 px |

**The three files with no operational value are 776 lines and 91 KB - 28% of the material, 0% executability.**

Verification: `wc -l -c *.md` on the cloned repo.

---

## 2. What is genuinely good here

I am not exaggerating - this is solid work. Specifically:

1. **The starting point is correct.** Unknown topic → you cannot prepare knowledge,
   you can prepare a process. `03:50`: *"The system must be topic-agnostic. Its value is
   structure, not answers."* And the immediate rule *"any component that assumes a
   domain has already failed the brief"* - this is rare and good.

2. **One artifact crosses the boundary.** Research does not hand over prose, only a frozen
   package (`03:131`). This kills the most common failure mode - five different models of the
   problem in five people's heads (`03:42`).

3. **Freeze + numbered amendments.** `03:152`. A silent prompt change is a *defect*,
   not an update. Correct and rare.

4. **One author per surface.** `03:180`, `04:166` (P4.8). The cheapest
   rule in the project and the most effective.

5. **The observer is degradable by definition.** `03:261`: *"Under time pressure it is
   switched off and the team loses monitoring, not capability."* Most monitoring
   projects die precisely because monitoring is load-critical. The author
   wrote it down as an invariant, not as an option.

6. **The cut order is explicit.** `03:315-324` - C0 (never cut) / C1 (cut under
   pressure) / C2 (cut first). People improvise cuts under pressure and cut the wrong
   things. Here the order is written down **before** it is needed.

7. **Three rules that are there because a reviewer found them, not because the author
   invented them:**
   - *"Instruction is not enforcement"* (`00:43`) - a role described as read-only is
     read-only only if something makes mutation impossible
   - *"Agreement is not truth"* (`00:39`) - agreement between sources is a property of the sources
   - *"Untrusted input is data, never instruction"* (`00:44`) - added after the threat
     review, see `09:90` (finding High #1)

   This is a rare and honest pattern: a gap found by an outsider, named,
   fixed, recorded in the register. Not deleted.

8. **An honest admission of an invisible system.** `07:139` (PM-4):
   *"The deepest exposure in the design: `OB`'s baseline **is the thing that may be
   wrong**. Deviation-vs-package cannot detect a package that deviates from reality."*
   This is exactly the failure that no monitoring of this kind will detect. The author
   writes it down instead of hiding it.

---

## 3. What is broken - with evidence

### 3.1 A live contradiction between artifacts, marked as "fixed"

The audit's strongest finding. Checked by grep across four places:

| Place | What it says |
|---|---|
| `01_DISCOVERY_CLOSURE.md:29` | *"Therefore **the short-event branch is closed** and the full cadence applies."* |
| `04_DEVELOPMENT_PLAN.md:322` | *"**The short-event branch is closed**, the cut order becomes pressure-driven…"* |
| `03_ARCHITECTURE_BLUEPRINT.md:326` | *"the short-event cut rules **remain an active fallback branch** rather than permanently closed"* |
| `04_DEVELOPMENT_PLAN.md:239` | *"the short-event cut rules **remain an active fallback branch** rather than permanently closed"* |
| `09_REVIEW_RECORD.md:130` (F-05, MAJOR) | *"**Fixed.** Preserved short-event cut rules as an active fallback branch rather than declaring the branch permanently closed."* |

The review register declares F-05 as **Fixed**. **2 of 4** places were changed.
`01` and `04 §14` still say the event cannot be shorter than 24h - and that
is second-hand information, marked in the register itself as `[UNVERIFIED]`
(`01:29`).

**Why it matters on Saturday:** if the organizer says "we have 18 hours", two
files tell you that you have a plan, and two say the plan needs recalculating. The team
has no way to check which is right - because both files look equally confident.

**Why it matters at the meta level:** this is exactly the class of drift that the package declares
solved. `09:74`: *"It does not demonstrate that drift was prevented - eight
violations occurred."* The census (`09:52-75`) has 10 checks and **none of them
compares the content of sentences across artifacts** - it checks identifiers, not
prose. So this particular type of error passes through CI.

### 3.2 Three checklist items break the format of that checklist

`05:89-91`:

```text
- [ ] **T7-01-1:** Research laptop: AI system pre-installed and tested
- [ ] **T7-01-2:** Developer laptops: Each member clones repo + installs fleet locally
- [ ] **T7-01-3:** Network: All laptops on same Wi-Fi / LAN
```

The format required by `05:56-63` is five fields: `owner`, `trigger`, `ref`, `verify`,
`fail`. These three have **zero** of them - it is not known who does this, how it will be checked,
and what happens if it does not work.

Origin: added in the last commit (`ed776bd` / earlier `a2d68d3`-`bea9835`,
"Reframe setup from local multi-laptop"). **After** all three reviews.

The process's reaction to breaking its own rule - `.github/workflows/ci.yml:53-54`:

```python
# Note: T7-01-1, T7-01-2, T7-01-3 are formatted without bullet dot
extra = re.findall(r"^- \[ \] \*\*(T7-01-\d):\*\*", c5, re.M)
```

CI was extended with **an exception for three specific lines**, instead of fixing
those lines or rejecting them. The counter still reports 77 and the badge still shows
"77 Checks" (`README.md`).

This is the smallest finding in the package and the most telling: **the process protects
its own result, not its rule.**

### 3.3 Nothing here has been executed - and the author says so honestly

Counted:

- `07:58` - validation ledger: **13 rows, 4 `DESIGNED`, 9 `DESIGNED+CHECKED`, 0 `ENFORCED`**
- `07:119` - control table: **11 rules, 6 declared+evidenced, 5 declared, 0 enforced**
- `07:90-91` - *"**The enforcement column is empty by design.**"*
- `05:675` - *"Nothing in this checklist has been executed. It is designed, unrehearsed."*
- `00:71` - *"**Nothing in this package is `ENFORCED`.**"*
- `07:144` - *"Review is not execution… A defect-free document set is a claim about the documents."*

Confirmed by recounting: `| (V\d+) |` → 13, `| (PM-\d+) |` → 12, checklist
items → 77 (74 in the format + 3 exceptions). The numbers in the documents agree.

**This is honest and should be said out loud on Friday evening.**
However, `03` + `04` + `05` + `07` + `09` are 2,042 lines of work done **solely
on documents**. None of it will be tested on Saturday, because there is no
time for that. The author himself writes that this is not proof (`09:144`) - and he is right, except that
nobody said it out loud in the README.

### 3.4 The preparation window vs. reality

- The plan assumes **T-14 → T-1**, six phases before the start: `04:52-61` (P0 discovery,
  P1 reuse ledger, P2 environment inventory, P3 research machine, P4 development
  fleet, P5 observer, P6 rehearsal).
- `04:63`: *"**P0-P2 are non-negotiable.**"* - this week, with a 4-day deadline.
- Today is Tuesday 2026-09-29; Saturday is 2026-10-03. **4 days.**
- `04:52` P0: *"T-14 to T-7"* - this phase **has already started** and is about to end.

This is not a flaw of the documentation. It is fitting it to reality, and it is unambiguous:
**phases P0-P6 must be consciously cut off, or the team will spend Saturday
building a process instead of a product.**

### 3.5 The plan is unenforceable without 18 numbers

`05:149` (T7-09) requires **eighteen** constants, each with a source, zero TBD:
`<event-window>`, `<approval-budget>`, `<startup-budget>`, `<cycle-overhead-budget>`,
`<triage-budget>`, `<c0-floor-target>`, `<freeze-threshold>`, `<submission-buffer>`,
`<push-interval>`, `<report-cadence>`, `<retry-interval>`, `<commit-interval>`,
`<escalation-window>`, `<clock-skew-tolerance>`, `<triage-window>`, `<converge-window>`,
`<fix-window>`, `<demo-duration>`, `<manual-status-window>`, `<reassignment-window>`,
`<min-battery>`, `<min-free-disk>`.

All are `TBD` and are to be filled in during phase T-7 (`04:241-251`). Without them
`DC-04` (push cadence), `FZ-01` (freeze), `DC-12` (triage), `DC-10` (human override)
have no pass criterion. On Saturday **6 of them** are needed - the rest is
precision that nobody will notice.

In particular: **the idle window does not exist as a number.** `07:141` (PM-6):
*"'Stall' needs a window, and the window value does not exist yet - an unstipulated
window means either noise or silence."* The project's own summary identifies a
problem whose solution it does not deliver.

### 3.6 Three unresolved questions, each of which can kill a component

`01:93-97`, the author himself calls them "load-bearing":

| # | Question | What it kills |
|---|---|---|
| `Q9` | will the organization issue a read-only token | the observer's entire read-only claim → D7 |
| `Q10` | who is the merge-person | rule D6 has no addressee → first integration point becomes an ad-hoc decision under pressure |
| `Q6` | which laptop can live 24h+ | the observer does not run at night → a designed function becomes intermittent |

All three `OPEN` (`01:31-36`). Two of them concern the observer directly.

---

## 4. The observer - dispute settled: REMOVED (2026-09-29)

Below are the arguments of both sides gathered before the decision. They were kept as the **rationale
for the removal**, not as a question. Replacement and rationale:
[`04-SYSTEM-PRODUCTION.md`](04-SYSTEM-PRODUCTION.md), the "Merge - human, review
in fresh context" section.

This was the **only** component that is original. Not the only one that is needed.

### Cost

- A laptop that does not sleep for 24h+ - `Q6`, **open** (`01:36`)
- A read-only token in an organization the team may not control - `Q9`, **open**
  (`01:35`); `07:142` (PM-7): *"If unscoped, there is no mechanical barrier between
  `OB` and `REPO` writes - only the credential's absence from any write path and
  the honesty of the claim."*
- The idle window as a number - does not exist (`07:141`)
- A start/stop procedure for a long-lived process - added as P5.7 only after the
  review (`09:29`, finding MAJOR #4: *"No task installed, started, or stopped the
  long-lived observer process, although later items presupposed it running"*)

### Counterweight (to the authors' honesty)

- **It judges itself.** The same laptop wrote the Brief and measures itself against it
  (`07:137`, PM-2). The mitigation is a report schema without a rating field - but that is **the shape of a
  promise, not a control** (`07:67`, V6: *"The schema artifact does not exist yet,
  so even the trivial inspection has nothing to run against"*). Additionally the selection
  (what the observer looks for at all) is outside the schema's reach.
- **It will not detect the most important failure.** `07:139` (PM-4) - see §2 item 8.
- **No drill tests the night.** `07:148` (PM-12) and `08:149`: *"The night window
  is `[UNPROVEN]`: drills 6.1-6.8 run in a single sitting, so the noise bound has
  never been tested at 03:00."*

### The project's reaction

The author knows both sides. `09:102` (finding Low #13) refuses to downgrade the observer
to C2: *"it is the component the engagement exists to design… Cutting it to `C2`
would remove the design's differentiator."* And at the same time accepts
the objection and records it: *"the benefit remains `[UNPROVEN]` until a drill shows a
consumer for its alerts."*

**This is honest, but it is also the definition of a topic for discussion.** Not a decision -
something to be decided. Recommendation: the manual version (see `README.md` §7 question 1).

---

## 5. The diagram

`render/06_ARCHITECTURE.png` - 2384×2855 px, viewed at: 1309×1568.

I looked at it. The facts described in the repo are true, and every one of them is the opposite of helpful:

- **Lanes laid out 2, 5, 3, 4, 1** by ELK auto-layout - admitted in `.mmd:37-40`
  and in the legend. The order is random and pretends to be structural.
- **The legend is in the bottom right corner** - the reader has to go back to the bottom for five
  labels to understand the color they are looking at.
- **The left half of the canvas (about 30%) is an empty bounding box** of the `RUNTIME` subgraph,
  with one line running around it.
- **Labels in the middle of the diagram, detached from the edges** - *"approval record"*,
  *"degraded: adopt frozen package locally if S1 lost (any lane)"* sit in
  empty space far from both ends of their edge.
- 30 edges, 4 visual classes, ELK `direction: DOWN` changed from `RIGHT` only
  because in `RIGHT` the 14 px text scaled to ~5.5 px (`.mmd:41-44`).
- The `elk.spacing.*` configuration is **in the code but does nothing** -
  `.mmd:49-51`: *"verified inert in mermaid 11.17.2: three spacing configurations
  produced byte-identical viewBox geometry."*

Most importantly: the 2026-09-15 review **saw this problem and declined to fix it**
(`09:99`, finding Med #10): *"Declined: shipping a second, simplified reviewer render -
two diagrams would create a second source of truth for the same system, which is the
failure this package is written against."*

The argument is correct **in its own world** (a package that justifies the unambiguity of artifacts
cannot have two). But the condition that makes it
valid - *"The full diagram is legible at 2400 px"* - is not met in the way
the README is read, that is, at the scale at which the team has to do it.

**Conflict with its own acceptance criterion.** `03:75`: *"Whatever is prepared must
survive a participant who has never read the blueprint."*
`04:296` (acceptance criterion): *"A new reader answers blueprint §12 unaided."*
The criterion requires a cold read of a **431-line blueprint** and a chart
**2855 px tall**. This is not a criterion that can be met at 3:00 at night.

---

## 6. Roles

`05:38-46` defines 7 slot types. `09:98` (finding Med #9) counts it differently:
*"Nine named authority slots for five people"* and adds to the cut queue the row
*"Role collapse"* (`03:322`).

**The author states outright that the roles do not fit, and adds a "collapse roles" row
to the cut queue.** This is honest and it is the answer: for 5 people **2 names**
are needed (Brain, merge-person), not 9 slots. The remaining roles are a function done
on the side.

---

## 7. Summary: what remains after the audit

| | |
|---|---|
| **Keep in full** | `03:31-52` (starting point), `03:131-152` (Brief + freeze), `03:176-184` (one author per surface), `03:284-297` (merge = human, "instruction is not enforcement"), `03:259-261` (degradability), `03:315-324` (cut order), `00:39/43/44` (three rules) |
| **Reduce to one page** | `03` 431 → ~1.5 pages; `04` 334 → the hourly plan from `README.md` §6 |
| **Throw out before Saturday** | `00`, `02`, `09` (776 lines, 28% of the corpus) |
| **Replace** | `06_ARCHITECTURE.mmd` + PNG → `diagram-simple.mmd` (12 boxes, 10 arrows) |
| **Fix before the start** | the contradiction `01:29` / `04:322` vs `03:326` / `04:239` (§3.1) |
| **Decide in the evening** | observer: process or human; 2 names; 6 numbers |

**One sentence:** 85% of the value is in the five rules from `README.md` §2. The rest of
the documentation is hedging, true, but addressed to a reader who
will not come - because on Saturday at 3:00 in the morning nobody will read 348 KB.
