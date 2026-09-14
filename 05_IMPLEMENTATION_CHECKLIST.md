# Implementation Checklist — Multi-AI Workflow for a Five-Person Cybersecurity Hackathon

**Status:** draft v1, 2026-09-14
**Register:** team runbook. Imperative, binary, assignable. Usable under time pressure by someone who has never read the blueprint.
**Companion to:** `03_ARCHITECTURE_BLUEPRINT.md` (authority §7, cut order §8.2), `04_DEVELOPMENT_PLAN.md` (phases P0–P9, failure matrix §11), `06_ARCHITECTURE.mmd` (node/edge IDs per contract §4)
**Derives from:** every item below is traceable to a plan phase or blueprint rule. This checklist introduces no new mechanism. `[READ]`
**Not in scope:** building the hackathon solution.

**Verification method:** derived by reading `04_DEVELOPMENT_PLAN.md` §2–§11 and `03_ARCHITECTURE_BLUEPRINT.md` §3.2, §3.4, §4.2, §4.4–§4.5, §5, §7, §8.2–§8.3, §9 at commit `3ea098f`; required time-slice structure and topic list from `omega-component-prep/13_LESSONS/28_HACKATHON_TOMORROW_CONCEPT.md` §3; node/edge IDs from contract §4. No item in this file has ever been executed; no rehearsal has run. `[FACT]`

---

## 0. Legend

### 0.1 Claim labels (house convention)

| Label | Meaning |
|---|---|
| `[FACT]` | Executed or read directly. |
| `[INFERENCE]` | Reasoned from evidence. |
| `[UNPROVEN]` | Designed, not tested. Every checklist item below is `[UNPROVEN]` until its verify condition has been observed once. |

### 0.2 Validation states

| State | Meaning |
|---|---|
| `DESIGNED` | Specified. No check has ever exercised it. |
| `DESIGNED+CHECKED` | Specified and a defined check exists that can exercise it (the check is named). |
| `ENFORCED` | A mechanism makes the violation impossible, and that mechanism has been observed to block it. |

**Every slice in this document is `DESIGNED`.** Entry criterion to `DESIGNED+CHECKED`, per slice: the named P6 rehearsal drills (plan §9) that exercise that slice have been run and recorded in the rehearsal record, failures included. Nothing here is `ENFORCED`; `ENFORCED` additionally requires observing the mechanism block a real violation (e.g., T1-11's denied write probe, T1-08's rejected push).

### 0.3 Owner slots

Slots are roles, never names in this document. At T7-02 each slot receives exactly one human, recorded in the private team registry. No participant name ever enters this or any portfolio artifact.

| Slot | Meaning |
|---|---|
| `<team-lead>` | Declares start, freeze, cuts; final human override; reassigns lanes. |
| `<architect>` | Owns artifacts, registry, protocol probes, corrections. |
| `<merge-owner>` | The one human who merges (plan P0.7; blueprint D6). |
| `<s1-operator>` | Runs S1: research mode and observer mode. |
| `<lane-owner-N>` (N=1–5) | Human owning lane N, branch `workstream-N`, its surface. |
| `<participant-N>` (N=1–5) | Any team member, for per-machine checks. |
| `<skeptic>` | Participant assigned to adversarial review (P6.7) and honest-diff cross-check (SB-04). |

### 0.4 Glossary (cold-reader minimum)

- **Mission Package (`MP`)** — the frozen, versioned document that is the only artifact crossing from research into development (blueprint §3.3).
- **Amendment** — a numbered, reasoned, approved change; the only way a frozen package changes.
- **Ownership registry** — the table mapping each change surface to exactly one lane; the arbiter of collision claims (P4.2).
- **Integration branch** — the protected branch where merges land; lanes never commit directly to it.
- **Lane** — one human + one machine + one worktree/branch `workstream-N`.

### 0.5 Item format

```text
- [ ] ID · pass condition — observable, binary
  - owner <slot> · trigger <when / if-branch> · ref P<phase> | nodes <diagram IDs> | edges <E#>
  - verify: <the evidence that proves the pass condition>
  - fail: <rollback> → escalate <slot> <condition>
```

`[OPT]` marks an item cuttable under pressure — cut priority P1 in blueprint §8.2 (see §10). Commands appear in fenced blocks, one command set per block. **All commands are synthetic examples**: `<angle-bracket>` placeholders only, no real credentials, no participant names, no operator home-directory paths.

---

## 1. How to use this document

- **Who reads it:** every participant reads §0–§1 once before T-7. The slot owner executes their slice. During the event, read only §11 (quick card), §5 (per-cycle), §10 (cut order).
- **Order:** by time: §2 (T-7) → §3 (T-1) → §4 (event start) → §5 (per cycle, repeated) → §6 (freeze) → §7 (submission) → §8 (teardown).
- **When an item fails:** execute its `fail:` branch. Rollback restores the pass condition → check the box and log the incident (item ID + observed output) in the event log. Rollback does not restore it → escalate: post item ID + observed output to the named slot. Unresolved within `<escalation-window>` (constant from T7-09) → `<team-lead>` decides. A decision that changes package content is a numbered amendment (DC-09), never a verbal agreement.
- **Who checks a box:** only the owner, only after observing the verify condition. Checking a box without observation is a defect (§9).
- **Never skip silently:** an item that cannot be run is recorded as an open limitation at ES-09, with its ID.

---

## 2. Slice: T-7 days

**Gate (plan §2):** P0 closed, P1 classified, P2 observed. Every machine observed by command, not described.
**Validation state: `DESIGNED`.** Entry to `DESIGNED+CHECKED`: this slice executed during preparation, and P6.6 (time-box check) records that setup fits the preparation window.

- [ ] **T7-01 · Q1–Q14 closed: every open question (blueprint §10) has a written answer with an owner, or is recorded as an assumption with a named fallback. Zero blanks.**
  - owner `<architect>` · trigger: T-7 session; no phase beyond P0 starts while Q1/Q2 are open (plan §14) · ref P0 §3 | nodes — | edges —
  - verify: answers log shows 14 rows; each row = answer + source, or assumption + fallback.
  - fail: assign each blank to a slot with a deadline; if Q1 or Q2 is still blank → preparation halts → escalate `<team-lead>`.

- [ ] **T7-02 · Every owner slot in §0.3 is assigned to exactly one human in the private team registry; each assigned human confirms aloud. Zero unassigned slots.**
  - owner `<team-lead>` · trigger: T-7 session, after T7-01 · ref P0.7 | nodes `MERGE`, `ESC` | edges —
  - verify: registry shows a human against every slot; merge-owner is one named human (blueprint D6).
  - fail: `<team-lead>` assigns by decision and records it; unassigned at T-1 → GO/NO-GO item for `<team-lead>`.

- [ ] **T7-03 · Reuse ledger complete: every candidate row carries a classification (`REUSE`/`ADAPT`/`REFERENCE ONLY`/`DROP`). Count of rows without a decision = 0.**
  - owner `<architect>` · trigger: T-7 session · ref P1 §4 | nodes — | edges —
  - verify: ledger decision column has zero empty cells; each `REUSE`/`ADAPT` row carries the 10-field record (plan §4).
  - fail: classify now; a component with no demonstrated need is dropped, not deferred (plan §4 gate) → escalate `<team-lead>` only on a dispute.

- [ ] **T7-04 · Machine matrix complete: six machines (S1 + five lanes) self-report by command; six rows recorded, each confirmed by its owner. Zero described-from-memory rows.**
  - owner `<participant-N>` each; `<architect>` collects · trigger: T-7 session · ref P2 §5 | nodes `S1`, `L1`–`L5` | edges —
  - verify: six command outputs pasted into the matrix.
  - fail: repair or replace the machine before T-1; if irreplaceable → record risk + reassign lane plan → escalate `<team-lead>`.
  ```bash
  # Synthetic example — run per machine; paste full output into the matrix
  uname -mrs
  df -h <workspace-dir>
  free -h 2>/dev/null || vm_stat
  uptime
  ```

- [ ] **T7-05 · Account matrix verified: every AI account, CLI, and key answers an authenticated call from the machine that will use it. Zero rows verified by description.**
  - owner `<participant-N>` each · trigger: T-7 session · ref P2 §5 | nodes `AG` | edges E19–E23
  - verify: one recorded response per account/CLI/key row.
  - fail: fix or reissue the credential; still unauthenticated at T-1 → the tool is removed from event-day capability bundles → escalate `<architect>`.
  ```bash
  # Synthetic example — one authenticated call per tool in the account matrix
  <ai-cli> auth status
  <git-host-cli> api user
  ```

- [ ] **T7-06 · Credential placement map complete and clean: one row per secret (what it authorizes, where it lives, which slot owns it); secret scan over the repository returns zero findings; zero secrets in any prompt or agent configuration.**
  - owner `<architect>` · trigger: T-7 session, after T7-05 · ref P2 §5, blueprint §7 (credentials row) | nodes `OB`, `REPO` | edges E24
  - verify: scan output shows zero findings; map has one row per credential in the account matrix.
  - fail: any finding → revoke + rotate that secret immediately, move it to `<secret-store>`, rescan → escalate `<team-lead>`.
  ```bash
  # Synthetic example — <secret-scanner> is whichever scanner T7-06 records in the map
  <secret-scanner> --path <repo-root> --all-branches --report text
  # Pass = zero findings
  ```

- [ ] **T7-07 · Repository access proven: all five humans and S1 fetch the remote successfully (six recorded outputs); the collaborator permission list matches the recorded topology; push rights exist only where the ownership model says.**
  - owner `<architect>` + each `<participant-N>` runs the probe · trigger: T-7 session · ref P2 §5, P4.1 | nodes `REPO` | edges E9–E13, E24
  - verify: six probe outputs + permission list pasted next to the topology record.
  - fail: fix org permissions; unresolved at T-1 → fallback: pushes serialize through `<merge-owner>`'s machine, recorded as a degradation → escalate `<team-lead>`.
  ```bash
  # Synthetic example — run on each of the six machines; pass = HEAD SHA printed
  git ls-remote <repo-url> HEAD
  ```

- [ ] **T7-08 · Reachability matrix tested: every machine-to-Git-host pair and the S1-to-provider pair tested by command. Zero cells marked "assumed".**
  - owner `<participant-N>` each · trigger: T-7 session · ref P2 §5 | nodes `REPO`, `S1`, `OB` | edges E24
  - verify: matrix cells contain a tested result (reachable / unreachable + workaround).
  - fail: record the unreachable pair + workaround (e.g., `<fallback-network>`); if S1 cannot reach the Git host → observer cannot run; plan ES-07 = OFF → escalate `<architect>`.

- [ ] **T7-09 · Event constants recorded: duration, submission deadline, freeze threshold, escalation window, clock-skew tolerance, push interval, report cadence, retry interval, commit interval, triage window, converge window, fix window, demo duration, manual-status window, reassignment window, submission buffer, min battery, min free disk — eighteen values, each with its source (organizer material or dated team decision). Zero values marked TBD.**
  - owner `<architect>` · trigger: T-7 session, after T7-01 · ref P0.2, blueprint §10 Q2/Q11 | nodes — | edges —
  - verify: constants block shows eighteen rows; each row names its source.
  - fail: adopt a conservative default and record it as an assumption with fallback (plan §3 gate — never silently defaulted) → escalate `<team-lead>`.

- [ ] **T7-10 · Portfolio capture consent recorded: explicit written consent stating what may be captured; privacy rule (no participant names, no repository contents, no credentials, no sponsor or organizer material, no topic-specific detail) read to the team and acknowledged.**
  - owner `<architect>` · trigger: T-7 session · ref P0.8, blueprint §11 | nodes — | edges —
  - verify: consent text stored with source; five acknowledgments logged.
  - fail: no consent → no capture at all; teardown sanitization (TD-04) runs regardless.

---

## 3. Slice: T-1 day

**Gate (plan §2, §9):** P3 dry run passes, P4 collision test passes, P5 credential proven write-incapable, P6 rehearsal record exists including what failed. A rehearsal that found nothing is insufficient, not a pass.
**Validation state: `DESIGNED`.** Entry to `DESIGNED+CHECKED`: drills P6.1–P6.5 run and recorded (items T1-01, T1-09, T1-13, T1-14, T1-15 are those drills), corrections closed per P6.8 (T1-17).

- [ ] **T1-01 · Dry-run package produced (drill 6.2): a synthetic topic through S1 yields a Mission Package with all ten fields, validating against the schema; a named second person reads it and states their next action without asking the author anything.**
  - owner `<s1-operator>` + one reader · trigger: T-1 rehearsal window · ref P3 §6 gate | nodes `RM`, `MP`, `APPR` | edges E1–E2
  - verify: validator output + the second person's recorded statement, both in the rehearsal record.
  - fail: repair the generator and rerun once; still failing by T-1 evening → the package for the event is authored by hand into the same schema (S1 degrades to research-only); the package itself is P0, never cut (§10) → escalate `<architect>`.

- [ ] **T1-02 · Provenance holds: in the dry-run package, count of claims that lack a source AND lack the `[unverified]` marker = 0.**
  - owner `<s1-operator>` · trigger: after T1-01 · ref P3.2, blueprint §3.2 rule 1 | nodes `RM`, `MP` | edges E1
  - verify: validator rule output recorded.
  - fail: strip or mark each unsourced claim; an unsourced claim cannot be built against → rerun T1-01 verify.
  ```bash
  # Synthetic example — pass = 0
  <package-validator> --file <package-file> --rule provenance --format count
  ```

- [ ] **T1-03 · Contradiction survives synthesis: two deliberately contradictory synthetic sources both appear in `evidence`, flagged contested. Neither averaged away nor resolved by vote.**
  - owner `<s1-operator>` + `<skeptic>` plants the contradiction · trigger: during T1-01 dry run · ref P3.3, blueprint §3.2 rule 3 | nodes `RM`, `MP` | edges E1
  - verify: both positions present with their sources in the dry-run output; `<skeptic>` signs off.
  - fail: repair the synthesis step; rerun; record the failure in the rehearsal record (plan §9 gate expects findings).

- [ ] **T1-04 · Silent edit impossible: after approval, a probe edit to the package produces either a numbered amendment (vN+1 with reason + approver) or a rejection. No path edits vN in place.**
  - owner `<architect>` · trigger: after T1-05 approval exists · ref P3.5, D3 | nodes `MP`, `APPR` | edges E28
  - verify: probe output recorded: version increment or rejection message.
  - fail: add the missing protection; if silent edit remains possible → record the limitation and route every package change through a PR reviewed by `<merge-owner>` (compensating control, logged) → escalate `<team-lead>`.

- [ ] **T1-05 · Approval gate blocks: a probe lane start before any approval record exists is refused; the approval record for vN shows package version + approver slot + timestamp.**
  - owner `<architect>` + `<team-lead>` approves · trigger: dry run, before lanes pull the package · ref P3.6 | nodes `APPR`, `MP` | edges E2–E4
  - verify: refusal logged; approval record present.
  - fail: if no mechanical gate exists → procedure gate: lanes pull the package only after `<team-lead>` announces approval and the record is written; announce-then-pull observed once in rehearsal.

- [ ] **T1-06 · S1 offline serves the frozen package: with S1 disconnected, a lane machine obtains the last approved package from the Git remote; research shows a visible PAUSED marker.**
  - owner `<s1-operator>` + `<lane-owner-1>` · trigger: T-1 rehearsal window · ref P3.7, blueprint §3.4 | nodes `MP`, `REPO`, `S1` | edges E29
  - verify: fetch output recorded with S1 down; pause marker observed.
  - fail: the package is not in the remote → fix publication path (package must live in Git, not only on S1) → rerun the drill.

- [ ] **T1-07 · `[OPT]` Provider failover drilled: with the primary AI provider disabled, one research sub-question completes via the secondary provider or manual browser research, with provenance.**
  - owner `<s1-operator>` · trigger: T-1 rehearsal window · ref P3, plan §11 (provider outage) | nodes `RM` | edges E1
  - verify: sub-question output + sources recorded.
  - fail: record "no failover path; event fallback = manual browser research only" (plan §11 row 3) → escalate `<architect>`.

- [ ] **T1-08 · Fleet topology live: direct push to the integration branch by a lane credential is rejected by the server (rejection message recorded); ownership registry holds one row per workstream over five disjoint surfaces.**
  - owner `<architect>` · trigger: T-1 rehearsal window · ref P4.1–P4.2 | nodes `REPO`, `L1`–`L5` | edges E9–E13
  - verify: rejected-push output in the rehearsal record; registry shows 5 rows, zero shared surfaces.
  - fail: enable protection; if the org lacks protection (Q9 answer) → compensating control: only `<merge-owner>` holds a credential that can reach the integration branch; record the limitation.
  ```bash
  # Synthetic example — probe from a lane credential; pass = server rejection
  git push <repo-url> HEAD:refs/heads/<integration-branch>
  ```

- [ ] **T1-09 · Collision drill passed (drill 6.3 = P4.8 gate): two machines deliberately claim one surface; the second claim is refused by the registry, or — if it slips through — the observer emits a same-surface deviation report.**
  - owner `<lane-owner-1>` + `<lane-owner-2>` + `<s1-operator>` · trigger: T-1 rehearsal window · ref P4.8, P6.3 | nodes `L1`, `L2`, `OB`, `DR` | edges E27
  - verify: refusal output or deviation report recorded.
  - fail: harden the registry check; if only the observer caught it → note that enforcement lives in the registry, the observer is tier 2 and may be OFF → rerun once.

- [ ] **T1-10 · Human-only merge verified: a probe merge attempt by a lane credential is rejected; an audit lists every credential held by any AI process and shows none carries merge rights.**
  - owner `<merge-owner>` audits · trigger: T-1 rehearsal window · ref P4.6, D6, blueprint §7 | nodes `MERGE`, `REPO` | edges E17–E18
  - verify: rejection output + credential-scope audit list recorded.
  - fail: strip the right immediately; if the platform cannot strip it → integration branch accepts pushes only from `<merge-owner>`'s machine; record the limitation → escalate `<team-lead>`.

- [ ] **T1-11 · Observer credential proven write-incapable (load-bearing test, P5.1): a write probe with the observer token is denied by the server. Denial output recorded verbatim.**
  - owner `<s1-operator>` · trigger: T-1 rehearsal window · ref P5.1, D7, blueprint §7 | nodes `OB`, `REPO` | edges E24
  - verify: denial status/output pasted into the rehearsal record.
  - fail: rescope the token and rerun; if a read-only scope cannot be configured → the claim is downgraded and stated ("instructed read-only — limitation"), and the observer runs with reduced access or stays OFF (ES-07). Never softened into "we told it not to write" (blueprint §7).
  ```bash
  # Synthetic example — observer token attempts to create a ref; pass = 403 (provider's denial code)
  curl -s -o /dev/null -w "%{http_code}\n" \
    -H "Authorization: Bearer <observer-token>" \
    -X POST "https://<git-host>/api/<api-version>/repos/<org>/<repo>/git/refs" \
    -d '{"ref":"refs/heads/synthetic-write-probe","sha":"<existing-commit-sha>"}'
  ```

- [ ] **T1-12 · Observer report schema has observation fields only: a probe deviation report lists deviation, timestamp, package version — and the schema contains no assessment field.**
  - owner `<s1-operator>` · trigger: after T1-11 · ref P5.3, blueprint §8.3 | nodes `DR`, `OB` | edges E25–E26
  - verify: schema listing + one probe report recorded.
  - fail: delete the assessment field; if the tooling cannot → reports pass through a template that drops assessment before posting; log the workaround.

- [ ] **T1-13 · Observer-off drill passed (drill 6.5 = P5.6): with the observer disabled, the next status query shows an explicit OUTAGE signal within `<report-cadence>`, and one lane completes a full work cycle meanwhile.**
  - owner `<s1-operator>` + `<lane-owner-3>` · trigger: T-1 rehearsal window · ref P5.6, P6.5 | nodes `OB`, `ESC` | edges E30
  - verify: outage signal observed; lane cycle completion recorded.
  - fail: add a heartbeat line (observer: OK/OUTAGE) to the status path → rerun the drill.

- [ ] **T1-14 · Disconnection drill passed (drill 6.4): one lane machine is killed mid-task; a different human resumes that lane from Git state alone — branch, package, registry — and states the next action aloud within `<reassignment-window>`. No verbal handoff used.**
  - owner `<team-lead>` assigns the replacement · trigger: T-1 rehearsal window · ref P6.4, blueprint §4.5 | nodes `L1`–`L5`, `REPO`, `MP`, `AG` | edges E29
  - verify: replacement's stated next action matches the branch state; timing recorded.
  - fail: unpushed work was lost → the failure is a DC-04 violation: tighten `<push-interval>` and rerun the drill.

- [ ] **T1-15 · Tabletop passed (drill 6.1): each of the five participants states aloud their lane, their surface, what they may write, and whom they escalate to; all five statements match the registry. Zero mismatches.**
  - owner `<team-lead>` · trigger: T-1 rehearsal window, whole team · ref P6.1 | nodes `L1`–`L5`, `ESC` | edges E27
  - verify: five statements recorded (audio or notes) and checked against the registry.
  - fail: mismatch → correct the registry or reassign the lane; rerun for that participant only.

- [ ] **T1-16 · Clocks synchronized: all six machines report UTC within `<clock-skew-tolerance>` (constant from T7-09). Six timestamps recorded.**
  - owner `<participant-N>` each · trigger: T-1 rehearsal window; re-verified at ES-05 · ref P2 (observed machine state), P5.3 (report timestamps) | nodes `DR` | edges —
  - verify: max pairwise difference of the six recorded timestamps ≤ tolerance.
  - fail: enable NTP or set manually; a machine that cannot hold time → its lane's timestamps are marked untrusted in deviation reports.
  ```bash
  # Synthetic example — run on all six machines within one minute; compare outputs
  date -u +"%Y-%m-%dT%H:%M:%SZ"
  ```

- [ ] **T1-17 · Rehearsal record complete: drills 6.1–6.6 outputs recorded including every failure; adversarial review (6.7) contradictions listed; each contradiction closed by an artifact edit (6.8), not by conversation. Time-box result (6.6) states whether setup fits the preparation window.**
  - owner `<architect>` + `<skeptic>` · trigger: end of T-1 rehearsal window · ref P6 gate, §9 | nodes — | edges —
  - verify: record exists, names its failures, and each finding points at a changed file/section.
  - fail: correction pass before T-1 evening; contradictions still open at event start → recorded as named limitations at ES-09 → GO/NO-GO by `<team-lead>`.

- [ ] **T1-18 · Observer runtime proven on S1 (P5.7): the observer starts by one documented command, emits its first heartbeat within `<report-cadence>`, and stops on command with zero reports after the stop timestamp. Both directions recorded.**
  - owner `<s1-operator>` · trigger: T-1 rehearsal, after T1-11 · ref P5.7 | nodes `OB`, `DR`, `ESC` | edges E24–E26, E30
  - verify: start command + first-heartbeat timestamp + stop command + zero-reports-after-stop, all in the rehearsal record.
  - fail: no heartbeat within one cadence → observer treated as OFF for the rehearsal and the loss announced (E30); start/stop procedure corrected before T-1 evening → escalate `<architect>`.

- [ ] **T1-19 · One reproducible CI command proven (P4.9): a single command runs on every PR against the integration candidate; run once on a synthetic PR and its output recorded; the command is the one DC-05 and FZ-05 consume.**
  - owner `<architect>` · trigger: T-1 rehearsal, after T1-08 · ref P4.9 | nodes `CI`, `PR` | edges E15–E16
  - verify: synthetic PR run output recorded; DC-05 and FZ-05 name the same command string.
  - fail: command missing or non-reproducible → CI evidence downgrades to DC-05 manual verification for the rehearsal, stated as weaker evidence → escalate `<architect>`.

---

## 4. Slice: Event start (T+0)

**Gate (plan §10 P7):** machine health → credentials present → repository reachable → roles announced → observer status stated aloud → start. Sequence is mandatory; ES-09 is the declaration.
**Validation state: `DESIGNED`.** Entry to `DESIGNED+CHECKED`: the startup sequence run once end-to-end in rehearsal (P6.1 tabletop + T1 drills) and recorded; full exercise happens only at the event.

- [ ] **ES-01 · Machine health: all six machines pass the health probe — power connected or battery above `<min-battery>`, free disk above `<min-free-disk>`, probe output collected.**
  - owner `<participant-N>` each; `<team-lead>` collects · trigger: first action at T+0, venue arrival · ref P7 §10 | nodes `S1`, `L1`–`L5` | edges —
  - verify: six probe outputs in the event log.
  - fail: lane machine fails → DC-07 replacement path; S1 fails → event starts with observer OFF (ES-07) and the frozen package served from Git (T1-06 path, edge E29) → escalate `<team-lead>`.
  ```bash
  # Synthetic example — same probe as T7-04, rerun at the venue
  uname -mrs
  df -h <workspace-dir>
  uptime
  ```

- [ ] **ES-02 · Credentials present and least-privilege: every person's own credential answers an authenticated call; the observer token in use is the exact key proven write-incapable at T1-11 (same key ID); secret scan (T7-06 command) rerun returns zero findings.**
  - owner `<participant-N>` each; `<s1-operator>` for the token check · trigger: after ES-01 · ref P7, P2 §5 | nodes `AG`, `OB`, `REPO` | edges E19–E24
  - verify: six authenticated responses + token key-ID match + zero-finding scan in the event log.
  - fail: a credential is dead → reissue from the placement map (T7-06); a person without a working credential does not drive AI processes this event; manual work continues → escalate `<team-lead>`.

- [ ] **ES-03 · Repository reachable from all six machines: the T7-07 probe succeeds six times at the venue.**
  - owner `<participant-N>` each · trigger: after ES-02 · ref P7 | nodes `REPO` | edges E9–E13, E24
  - verify: six probe outputs.
  - fail: switch to `<fallback-network>` (ES-08 branch); still unreachable → offline start: lanes work on local branches per DC-06; `<team-lead>` records "remote-down start" in the event log.

- [ ] **ES-04 · Frozen package local on every lane machine: each lane holds the approved package vN; its hash matches the approval record.**
  - owner `<lane-owner-N>` each · trigger: after ES-03 · ref P7, blueprint §3.4 | nodes `MP`, `L1`–`L5` | edges E4–E8
  - verify: five hash outputs equal the recorded value.
  - fail: pull from the remote (source of truth); remote unreachable → copy from `<merge-owner>`'s machine via `<transfer-medium>`; record which path was used.
  ```bash
  # Synthetic example — pass = hash equals the approval record for vN
  shasum -a 256 <package-file>
  ```

- [ ] **ES-05 · `[OPT]` Clocks re-verified: the T1-16 check rerun at the venue; six timestamps within `<clock-skew-tolerance>`.**
  - owner `<participant-N>` each · trigger: after ES-04 · ref P7, P5.3 | nodes `DR` | edges —
  - verify: max pairwise difference ≤ tolerance, recorded.
  - fail: resync; a machine that cannot resync → its lane's timestamps marked untrusted in observer reports.

- [ ] **ES-06 · Roles announced aloud: `<team-lead>` reads the ownership registry; each `<lane-owner-N>` answers "present, lane N, surface X"; `<merge-owner>` and escalation contacts named aloud. Five answers recorded.**
  - owner `<team-lead>` · trigger: after ES-05 · ref P7, P4.2 | nodes `L1`–`L5`, `MERGE`, `ESC` | edges —
  - verify: five responses in the event log (audio or notes).
  - fail: an absent lane → DC-07 replacement before start; no replacement → lanes consolidate per cut priority P2 (serialize, §10) → escalate `<team-lead>`.

- [ ] **ES-07 · Observer status stated aloud: ON with cadence `<report-cadence>` and alerts bounded to deviation/failure/conflict/stall — or OFF as a tier-2 cut. If ON, the first heartbeat (observer: OK) is seen within one cadence.**
  - owner `<s1-operator>` announces; `<team-lead>` records · trigger: after ES-06 · ref P7, P5.4, P5.7 | nodes `OB`, `DR`, `ESC` | edges E24–E26, E30
  - verify: announced state + timestamp in the event log; heartbeat observed if ON.
  - fail: no heartbeat within one cadence → treat as OFF, announce OFF, continue; the loss is visible, never silent (edge E30).

- [ ] **ES-08 · Connectivity baseline and fallback tested: venue path proven by ES-03; `<fallback-network>` tested from at least one machine. Branch: if the venue network fails mid-event → lanes switch to `<fallback-network>`; if all networks fail → DC-06 offline mode, physical sync via `<transfer-medium>`.**
  - owner `<architect>` · trigger: after ES-03 · ref P7, P2 §5 (network map) | nodes `REPO` | edges E9–E13
  - verify: fallback test output recorded.
  - fail: no fallback works → record "offline event"; DC-06 becomes the default operating mode; merges serialize on `<merge-owner>`'s machine when connectivity returns.

- [ ] **ES-09 · Start declared: ES-01–ES-08 all checked. `<team-lead>` declares T+0 start; declaration + timestamp recorded; every unchecked item is first recorded as a named accepted limitation.**
  - owner `<team-lead>` · trigger: after ES-08 · ref P7 gate | nodes `ESC` | edges —
  - verify: declaration in the event log with a limitation list (possibly empty).
  - fail: any item unchecked and unrecorded → start is not declared; run its fail branch first.

---

## 5. Slice: Per development cycle

**One cycle =** task taken from the frozen package → work on the lane branch → push → PR → CI → merge decision. Every lane runs this loop for every task. Branch conditions mirror the plan §11 failure matrix.
**Validation state: `DESIGNED`.** Entry to `DESIGNED+CHECKED`: the cycle exercised end-to-end in rehearsal — P6.3 (T1-09), P6.4 (T1-14), P6.5 (T1-13) — and recorded.

- [ ] **DC-01 · Cycle opens on a package task: the lane owner records the package version and field (e.g., `task_ownership`, `interfaces`) this task comes from, in the branch or PR description. Branch: if the task is not in the frozen package → work does not start; a numbered amendment is requested first.**
  - owner `<lane-owner-N>` · trigger: each cycle start · ref P8 §10, D2/D3 | nodes `MP`, `L1`–`L5`, `ESC` | edges E4–E8, E28
  - verify: task reference (field + version) visible in the branch/PR record.
  - fail: work started without a reference → stop the lane; `<architect>` files the amendment; work resumes only on the recorded decision (DC-09).

- [ ] **DC-02 · Surface claim exclusive before first write: the registry shows the lane's surface unclaimed by any other lane. Branch: if already claimed → both lanes stop; `<team-lead>` reassigns per the ownership rule or serializes the two workstreams (plan §11, fleet collision); if the observer is ON it additionally reports the same-surface claim.**
  - owner `<lane-owner-N>` checks; `<team-lead>` resolves · trigger: before the first commit of a cycle · ref P4.2, P8 | nodes `L1`–`L5`, `OB`, `DR` | edges E27
  - verify: registry row + timestamp for this claim.
  - fail: conflicting claim discovered mid-write → both stop at the last pushed commit; `<team-lead>` splits or reassigns surfaces; the split is recorded (amendment if it changes `interfaces`).

- [ ] **DC-03 · Lane isolation held: the cycle's commits exist only on `workstream-<N>`; zero commits by lane credentials on the integration branch (rejection proven at T1-08).**
  - owner `<lane-owner-N>` · trigger: continuous during the cycle · ref P4.2 | nodes `L1`–`L5`, `REPO` | edges E9–E13
  - verify: at cycle close, the integration branch log shows no lane-authored direct commits.
  - fail: a direct commit exists → `<merge-owner>` reverts it on the integration branch; work re-done on the lane branch; incident logged.

- [ ] **DC-04 · Push cadence held: the lane branch is pushed at least every `<push-interval>` (T7-09) and at every break; remote HEAD equals local HEAD while the network is up. The remote branch is the replacement source for DC-07.**
  - owner `<lane-owner-N>` · trigger: recurring, every `<push-interval>` · ref P8, blueprint §4.5 | nodes `REPO` | edges E9–E13
  - verify: the two commands below print the same SHA.
  - fail: remote unreachable → DC-06 (local commits continue; unpushed window recorded); network up but cadence missed twice → `<team-lead>` names the risk in the event log.
  ```bash
  # Synthetic example — pass = both SHAs equal
  git ls-remote <repo-url> refs/heads/workstream-<N>
  git rev-parse workstream-<N>
  ```

- [ ] **DC-05 · PR carries evidence: the PR shows the exact candidate diff plus either a green CI run of the task's acceptance command, or — branch: if CI is unavailable — a manual verification comment where a second person pasted the command output, marked "manual verification — weaker evidence" (plan §11). Zero PRs with neither.**
  - owner `<lane-owner-N>` opens; second person verifies when CI is down · trigger: each cycle, before merge review · ref P8, plan §11 (CI unavailable) | nodes `PR`, `CI` | edges E14–E17
  - verify: PR page shows CI result or the marked manual-verification comment.
  - fail: CI red → fix on the lane branch, push, rerun; evidence missing at review → `<merge-owner>` rejects the PR (DC-11).

- [ ] **DC-06 · Connectivity loss absorbed: branch: if the remote is unreachable from a lane → commits continue locally on `workstream-<N>` every `<commit-interval>`; push retried every `<retry-interval>`; nobody waits on the network. Branch: if S1 is unreachable → lanes continue against the local frozen package (ES-04); observer is declared OFF (ES-07 fail path); research pauses visibly (plan §11, S1 machine lost).**
  - owner `<lane-owner-N>` locally; `<team-lead>` declares S1-lost · trigger: any remote/S1 unreachability · ref P8, plan §11, blueprint §3.4/§4.5 | nodes `REPO`, `MP`, `S1`, `OB` | edges E29, E30
  - verify: local commit log shows continued commits during the outage; outage start/end timestamps in the event log.
  - fail: outage outlasts `<retry-interval>` × 3 → escalate `<team-lead>`: switch to `<fallback-network>` (ES-08) or run the remainder offline with physical sync.

- [ ] **DC-07 · Worker replacement from Git state alone: branch: if a lane's human or machine drops → `<team-lead>` reassigns the lane; the replacement fetches `workstream-<N>`, reads `task_ownership` + registry, and states the next action aloud. Pass = the replacement proceeds with no verbal handoff (drilled at T1-14).**
  - owner `<team-lead>` assigns · trigger: any lane dropout · ref blueprint §4.5, P6.4, plan §11 | nodes `L1`–`L5`, `REPO`, `AG`, `MP` | edges E29
  - verify: replacement's stated next action matches the branch state; reassignment timestamp logged.
  - fail: unpushed work lost (DC-04 violation) → resume from the last pushed commit; log the lost delta as an accepted loss; re-scope via amendment if the task no longer fits.

- [ ] **DC-08 · `[OPT]` Status answerable on demand: any member asks "where are we?" and receives an answer naming the package version and per-lane facts, with no assessment. Branch: if the observer is OFF → the same answer is assembled manually from the Git log + registry within `<manual-status-window>`.**
  - owner `<s1-operator>` (ON) or the member themself (OFF) · trigger: any time, on demand · ref P5.5 | nodes `OB`, `DR` | edges E25–E26
  - verify: one recorded Q&A pair per sync point.
  - fail: no answer within the window → logged as a monitoring gap; `<team-lead>` schedules a manual sync.

- [ ] **DC-09 · Escalations decided by humans: branch: if any trigger fires — interface wrong, acceptance test unsatisfiable, same-surface claim, plan/reality divergence beyond the current amendment — the lane stops work and posts facts (item ID, command output, package version) to `<team-lead>` + `<architect>`. Work resumes only on a recorded decision: amend (numbered) / accept with logged drift / reassign.**
  - owner any lane member triggers; `<team-lead>` decides · trigger: the four conditions above · ref P4.4, P8, plan §11 (plan diverges) | nodes `ESC`, `MP`, `DR` | edges E27–E28
  - verify: decision recorded with timestamp and decider slot.
  - fail: no decision within `<escalation-window>` → lane stays stopped; `<team-lead>` applies the cut order (§10) to that task.

- [ ] **DC-10 · Human override immediate: any human halts any AI process on their lane at any time; after the halt command, the count of matching AI processes on that machine = 0. Resume only on the same human's instruction. No AI process survives a human halt.**
  - owner any `<lane-owner-N>` · trigger: any time, no justification required · ref blueprint §7 (human authority), §4.3 | nodes `AG`, `L1`–`L5`, `ESC` | edges —
  - verify: post-halt process count recorded (command below).
  - fail: a process does not stop → kill by PID; if it still persists → disconnect the machine from the network and record the incident → escalate `<team-lead>`.
  ```bash
  # Synthetic example — halt, then prove zero remain; pass = 0
  <stop-command>
  pgrep -fl "<lane-ai-process-pattern>" | wc -l
  ```

- [ ] **DC-11 · Merges human, ordered, evidenced: `<merge-owner>` reviews the exact candidate diff + CI evidence and merges in the package `integration_order`. Branch: evidence missing → reject; when CI is unavailable, accept only after DC-05 manual verification is logged. No AI merges anything, ever (D6 reversal condition: never).**
  - owner `<merge-owner>` · trigger: each PR reaching review · ref P8, D6, blueprint §7 | nodes `MERGE`, `PR`, `CI`, `REPO` | edges E17–E18
  - verify: merge commit author is the `<merge-owner>` human account; order matches `integration_order`.
  - fail: an out-of-order or unevidenced merge exists → `<merge-owner>` reverts on the integration branch; incident logged; re-merge in order.

- [ ] **DC-12 · Deviation reports triaged: every observer report receives a named human's answer within `<triage-window>`: amend / accept with logged drift / escalate. Zero reports auto-resolved or unanswered at sync.**
  - owner `<team-lead>` answers; `<s1-operator>` forwards · trigger: each report, observer ON · ref P8, plan §11 | nodes `DR`, `ESC`, `MP` | edges E25–E26, E28
  - verify: each report has an answer with decider slot + timestamp.
  - fail: a report is unanswered at the next sync → re-announced aloud; twice unanswered → observer treated as noise source; consider the P1 cut (§10).

- [ ] **DC-13 · Cycle closed on evidence: the task's acceptance test (package `acceptance_tests`) is run and its command + output recorded in the PR. "It works" without a reproducible command is unverified — the cycle stays open (plan §11, last row).**
  - owner `<lane-owner-N>` · trigger: each cycle end · ref P8, P3 `acceptance_tests`, blueprint §7 (check evidence) | nodes `CI`, `MP`, `PR` | edges E15–E17
  - verify: PR shows command + output for every acceptance test of the task.
  - fail: test fails → fix within the cycle, or escalate DC-09 (acceptance test unsatisfiable).

---

## 6. Slice: Freeze

**Gate:** the frozen build passes the package acceptance tests on the integration branch, or the demo scope is amended in writing. Freeze time = submission deadline − `<freeze-threshold>` (T7-09).
**Validation state: `DESIGNED`.** Entry to `DESIGNED+CHECKED`: freeze and cut-order branch walked in the P6.1 tabletop and time-boxed by P6.6, recorded; full exercise happens only at the event.

- [ ] **FZ-01 · Freeze declared aloud by `<team-lead>` at submission deadline − `<freeze-threshold>`; timestamp recorded; all five lanes acknowledge in the channel/log.**
  - owner `<team-lead>` · trigger: clock reaches the threshold · ref P8 | nodes `ESC` | edges —
  - verify: declaration + five acknowledgments logged.
  - fail: a lane does not acknowledge → `<team-lead>` contacts it directly; the lane is frozen regardless once declared.

- [ ] **FZ-02 · Cut order applied per §10: P2 rows cut first, then P1 if still short, P0 never. Each cut recorded with timestamp, row cut, and what was lost (§10 column 3).**
  - owner `<team-lead>` decides; `<architect>` records · trigger: FZ-01, or earlier on DC-09 escalation · ref blueprint §8.2 | nodes `OB`, `CI`, `L1`–`L5` | edges —
  - verify: cut log entries match §10 rows.
  - fail: a cut touches a P0 row → invalid; reverse it; P0 ships no matter what (plan §11, time running out: ship the P0 set only).

- [ ] **FZ-03 · Post-freeze merges restricted: zero merges after FZ-01 except demo-blocking defects; each such merge individually authorized by `<merge-owner>` with a one-line reason recorded in the PR.**
  - owner `<merge-owner>` · trigger: every merge attempt after freeze · ref P8, D6 | nodes `MERGE`, `PR` | edges E17–E18
  - verify: every post-freeze merge commit has a recorded reason.
  - fail: an unauthorized post-freeze merge exists → revert; incident logged.

- [ ] **FZ-04 · Lanes converge: every lane's HEAD is a commit where that lane's acceptance check passed (PASS@sha), or the lane is marked CUT in the registry with `<team-lead>` approval. Zero half-integrated surfaces.**
  - owner `<lane-owner-N>` each; `<team-lead>` approves cuts · trigger: within `<converge-window>` of FZ-01 · ref P8 | nodes `L1`–`L5`, `REPO` | edges E9–E13
  - verify: registry shows PASS@sha or CUT per lane.
  - fail: a lane cannot reach PASS → revert the lane branch to its last green commit, or mark CUT → escalate `<team-lead>`.

- [ ] **FZ-05 · Package acceptance tests pass on the integration branch end-to-end; full command output recorded. Branch: a test fails → fix within `<fix-window>` under FZ-03 rules; else cut the feature and record a numbered amendment narrowing demo scope. Never present an untested feature as working.**
  - owner `<merge-owner>` runs; `<skeptic>` witnesses · trigger: after FZ-04 · ref P8, P3 `acceptance_tests` | nodes `MP`, `CI`, `MERGE` | edges E15–E18
  - verify: recorded output covers every acceptance test, or the amendment names the dropped ones.
  - fail: neither fix nor amendment in time → demo scope shrinks to the passing subset; amendment recorded before submission (SB-04 consumes it).

- [ ] **FZ-06 · Demo dry run completed once against the frozen build, within `<demo-duration>`; presenter named. Branch: over time → cut demo scope by amendment, never skip the dry run.**
  - owner `<team-lead>` · trigger: after FZ-05 · ref P8 | nodes `MP` | edges —
  - verify: dry-run timing + presenter recorded.
  - fail: dry run broken → the failure is demo-blocking; FZ-03 fix path applies.

- [ ] **FZ-07 · Observer minimized or OFF per FZ-02: state announced aloud. Branch: if OFF → manual Git reads at each sync point, with the reader named (blueprint §8.2: on-demand Git reads remain).**
  - owner `<s1-operator>` · trigger: FZ-02 cut of the P1 observer row, or noise per DC-12 · ref P5.7 | nodes `OB`, `ESC` | edges E30
  - verify: announced state + named reader (if OFF) logged.
  - fail: state unclear → treat as OFF and announce OFF; ambiguity in monitoring is worse than absence.

- [ ] **FZ-08 · Submission pack assembled: repository link at the frozen SHA, quickstart, evidence pack (CI outputs, package version + amendment log, merge log). Verified by a fresh clone + quickstart on a machine that did not build it.**
  - owner `<architect>` assembles; `<participant-N>` (non-builder) verifies · trigger: after FZ-06 · ref P8 | nodes `REPO`, `CI`, `MP`, `PR` | edges E14, E18
  - verify: fresh-clone quickstart output recorded.
  - fail: quickstart broken → fix documentation only; code changes need FZ-03 authorization.
  ```bash
  # Synthetic example — on a machine that did not build the project; pass = quickstart completes
  git clone <repo-url> <fresh-dir>
  cd <fresh-dir> && <quickstart-command>
  ```

---

## 7. Slice: Submission

**Gate:** submitted SHA equals the recorded integration-branch HEAD, and a delivery receipt exists.
**Validation state: `DESIGNED`.** Entry to `DESIGNED+CHECKED`: submission branch walked in the P6.1 tabletop (including the SB-03 recovery path with constants from T7-09); full exercise happens only at the event.

- [ ] **SB-01 · Submitted artifact identified: the SHA in the submission log equals the integration-branch HEAD; `<submission-tag>` created by `<merge-owner>`.**
  - owner `<merge-owner>` · trigger: immediately after freeze converges (FZ-04) · ref P8, blueprint §7 (repository truth) | nodes `REPO`, `MERGE` | edges E18
  - verify: recorded SHA equals command output; tag exists.
  - fail: mismatch → investigate before submitting; submit the tagged frozen SHA, never a moving HEAD.
  ```bash
  # Synthetic example — pass = output equals the submission log SHA
  git -C <repo-root> rev-parse HEAD
  git -C <repo-root> tag -a <submission-tag> -m "submission"
  ```

- [ ] **SB-02 · Submission delivered by a named human through the organizer channel before the deadline; the receipt (confirmation message, screenshot, or timestamp) is recorded in the submission log.**
  - owner `<team-lead>` (or the slot T7-09 names) · trigger: after SB-01, before deadline − `<submission-buffer>` · ref P8 | nodes — | edges —
  - verify: receipt stored next to the SHA.
  - fail: channel error → SB-03 immediately; do not retry silently past the buffer.

- [ ] **SB-03 · Submission recovery executed when needed: branch: primary channel fails → retry once, then `<fallback-channel>` (recorded from organizer material at T7-09); branch: deadline − `<submission-buffer>` reached with no success → contact `<organizer-contact>` and deliver the frozen state through any permitted channel. Every attempt timestamped; decision by `<team-lead>`.**
  - owner `<team-lead>` · trigger: any SB-02 failure · ref P8, concept anatomy (submission recovery) | nodes `ESC` | edges —
  - verify: attempt log shows channel, time, outcome per try.
  - fail: all channels fail → `<organizer-contact>` escalation is the last path; record everything for the post-event account.

- [ ] **SB-04 · Honest diff stated: every cut feature, open unknown, and manual-verification substitute appears in the demo/submission notes. `<skeptic>` cross-checks the notes against the amendment log + FZ-05 output; zero unexplained differences.**
  - owner `<skeptic>` cross-checks; `<architect>` writes · trigger: before SB-02 delivery · ref plan §11 (topic harder than expected — state unknowns in the demo), P8 | nodes `MP`, `DR` | edges —
  - verify: cross-check result recorded: notes vs. amendments, difference count = 0.
  - fail: an unclaimed gap exists → fix the notes before delivery; delivery of an overclaim is a privacy/honesty defect, not a rounding error.

- [ ] **SB-05 · Post-submission lock: no force-push and no history rewrite on the integration branch after SB-01; a probe rewrite is rejected by protection; later changes happen only on new branches.**
  - owner `<merge-owner>` · trigger: after SB-01 · ref blueprint §7 (repository truth, audit trail) | nodes `REPO` | edges E18
  - verify: probe rejection recorded (or protection setting output).
  - fail: history was rewritten → the tagged SHA (SB-01) remains the submission of record; incident logged for the post-event account → escalate `<team-lead>` before any further push to the integration branch.

---

## 8. Slice: Teardown

**Gate (plan §10 P9):** observer stopped → credentials released → evidence archived → sanitized before anything reaches a portfolio → no participant, repository, or organizer material exposed. Order is mandatory: archive before any deletion.
**Validation state: `DESIGNED`.** Entry to `DESIGNED+CHECKED`: teardown walked in the P6.1 tabletop and TD-02/TD-04 commands dry-run on synthetic fixtures during rehearsal; full exercise happens only after the event.

- [ ] **TD-01 · Observer stopped: the process is terminated; zero reports emitted after the stop timestamp; final observer state recorded in the event log.**
  - owner `<s1-operator>` · trigger: first action after submission (SB-02/SB-03 complete) · ref P9 | nodes `OB` | edges E24–E26
  - verify: process absent; last report timestamp precedes the stop.
  - fail: process persists → kill by PID; still persisting → disconnect S1 from the network and record.

- [ ] **TD-02 · Credentials released: the observer token is revoked first, then each event credential per the team decision; every revoked key fails an authenticated call. Zero event credentials left alive.**
  - owner `<s1-operator>` (observer token); `<participant-N>` each (own keys) · trigger: after TD-01 · ref P9, blueprint §7 (least privilege) | nodes `OB`, `AG` | edges E24
  - verify: revocation confirmations + failed probe outputs recorded.
  - fail: CLI revocation unavailable → revoke in the provider console and prove it with the failed probe; a key that cannot be revoked is recorded and monitored.
  ```bash
  # Synthetic example — revoke, then probe with the dead key; pass = 401
  <provider-cli> credentials revoke --id <observer-key-id>
  curl -s -o /dev/null -w "%{http_code}\n" \
    -H "Authorization: Bearer <observer-token>" \
    "https://<git-host>/api/<api-version>/repos/<org>/<repo>"
  ```

- [ ] **TD-03 · Evidence archived before any deletion: seven artifact classes stored at `<archive-location>` with a checksum — package versions, amendments, approval records, rehearsal record, CI logs, merge log + deviation reports, submission receipts.**
  - owner `<architect>` · trigger: after TD-02 · ref P9 | nodes `MP`, `DR`, `CI` | edges —
  - verify: archive listing covers all seven classes; checksum recorded.
  - fail: a class is missing → recover from the Git remote and channel logs; TD-06 stays blocked until the listing is complete.

- [ ] **TD-04 · Sanitization proven before anything leaves the team: a scan of `<public-artifacts-dir>` for participant-name patterns, secret markers, repository contents, organizer/sponsor material, and topic-specific detail returns zero matches. The scan is run by a second person, not the packer.**
  - owner `<skeptic>` runs; `<architect>` packs · trigger: before any publication step · ref P9, contract §3 privacy | nodes — | edges —
  - verify: zero-match output recorded.
  - fail: any match → strip, rescan; publication stays blocked until zero. No exceptions for "just the demo".
  ```bash
  # Synthetic example — patterns come from the privacy rule, never real names; pass = 0
  grep -rnI -e "<participant-name-pattern>" -e "<secret-marker>" -e "<organizer-material-pattern>" <public-artifacts-dir> | wc -l
  ```

- [ ] **TD-05 · Exposure review passed: `<architect>` + `<skeptic>` review every artifact leaving the team against the does-not-prove list — no hackathon outcome claimed, no semantic correctness claimed, no claim that any mechanism held under real pressure beyond what the record shows, no rehearsal evidence claimed beyond what exists, no claim that monitoring improves delivery. Review recorded.**
  - owner `<architect>` + `<skeptic>` · trigger: after TD-04 · ref P9, contract §3 | nodes — | edges —
  - verify: review note lists each artifact and its checked claim boundaries.
  - fail: an artifact overclaims → rewrite or withhold; withholding is always available.

- [ ] **TD-06 · Local cleanup last: lane worktrees and local clones deleted only after TD-03 is checked. Branch: TD-03 unchecked → delete nothing (irreversible); when in doubt, keep.**
  - owner `<participant-N>` each · trigger: after TD-05 · ref P9 | nodes `L1`–`L5` | edges —
  - verify: each machine's cleanup acknowledged in the log after TD-03's checksum exists.
  - fail: premature deletion → recover from the remote and the archive; record the incident.

---

## 9. Gate: every check must be observable

A checked box corresponds to an **observed condition**: a command output, a recorded artifact, a logged spoken acknowledgment. Never to "configuration exists", "should work", or "is set up".

- The verify line of each item names the evidence. No evidence, no check mark.
- A box checked without observation is a **defect**: record it in the rehearsal/event log with the item ID and the true state. Defects found in rehearsal are the expected output of P6 (plan §9 gate: a rehearsal that found nothing is insufficient).
- Evidence quality rules inherited from the blueprint: a green exit code that scanned nothing is not evidence (§7); multi-source or multi-agent agreement is recorded as agreement, never as verification (§3.2 — the sibling project `dSearch` measured 261 corroborated URLs, 38 correct, precision 0.1456 `[FACT, source: blueprint §3.2]`).
- "It works" without a reproducible command is treated as unverified (plan §11, last row; applied at DC-13).

---

## 10. Cut order under time pressure

Priorities below are the **scope-cut priorities P0/P1/P2 of blueprint §8.2** — not the plan phases P0–P9. Rows 1–3 reproduce blueprint §8.2 verbatim; the last column maps each row to this checklist.

| Priority | Component | If cut, what is lost | Checklist consequence |
|---|---|---|---|
| **P0 — never cut** | Mission Package + frozen baseline | The fleet builds against nothing | ES-04, DC-01 stay in force in every scenario |
| **P0 — never cut** | One-writer-per-workspace | Collisions consume the clock | DC-02, DC-03 stay in force even when lanes serialize |
| **P0 — never cut** | Human merge authority | Unrecoverable integration damage | DC-11, FZ-03 stay in force; no exception under time pressure |
| **P1 — cut under pressure** | Observer continuous mode | Loses monitoring; on-demand Git reads remain | ES-07 announces OFF; DC-08/DC-12 fall back to manual Git reads (FZ-07) |
| **P1 — cut under pressure** | Checklist items marked optional | Slower restart; nothing breaks | Drop the `[OPT]` items: T1-07, ES-05, DC-08 |
| **P2 — cut first** | Parallel workstreams | Slower, but sequential still ships | Lanes serialize under DC-02/DC-03; the registry still governs order |
| **P2 — cut first** | Automated CI beyond one check | Manual verification, weaker evidence | DC-05's manual-verification branch becomes the default path |

**Branching rule.** If remaining time < `<freeze-threshold>` (T7-09) → cut the P2 rows now. If the projected finish still exceeds the deadline → cut the P1 rows. Never cut a P0 row: the fallback is to ship the P0 set only (plan §11, "time running out"). Every cut is recorded: timestamp, row cut, decider slot, what was lost.

---

## 11. Event-day quick card (one screen)

**Startup (T+0, in this order):** health (ES-01) → credentials (ES-02) → repo reachable (ES-03) → frozen package local + hash-matched (ES-04) → roles aloud (ES-06) → observer status aloud, ON or OFF (ES-07) → `<team-lead>` declares start (ES-09).

**Merge rule — no exceptions, no ambiguity:** no AI merges anything, ever. Only the human `<merge-owner>` merges. Only a PR showing the exact candidate diff plus green CI — or, only when CI is unavailable, a second person's logged manual verification marked "weaker evidence" (DC-05). Only in the package `integration_order`. After freeze, only demo-blocking defects, each with a recorded reason (FZ-03).

**Escalate now (stop the lane, post facts + item ID to `<team-lead>`, DC-09) if:**
- an interface in the package is wrong;
- an acceptance test cannot be satisfied;
- two lanes claim one surface;
- plan and reality diverge beyond the current amendment;
- the observer is silent past one `<report-cadence>` (outage — treat as OFF, announce it);
- the remote is unreachable past `<retry-interval>` × 3 (DC-06 → ES-08 fallback).

**Freeze rule:** at deadline − `<freeze-threshold>`, `<team-lead>` declares freeze aloud (FZ-01). Cut order: P2 first, then P1, never P0 (§10). Every lane ends at PASS@sha or CUT (FZ-04). Package acceptance tests run on the integration branch (FZ-05). One demo dry run (FZ-06). Post-freeze merges: demo-blocking defects only, with reasons (FZ-03).

**Failure one-liners (plan §11):** S1 lost → build against the local frozen package, observer OFF (DC-06). Collision → stop both lanes, reassign per registry (DC-02). CI down → manual verification, logged as weaker (DC-05). Person/machine lost → reassign from Git state alone (DC-07). Network down → commit locally, push on reconnect (DC-06). Time short → cut order (§10). "It works" with no command → unverified, cycle stays open (DC-13).

---

## 12. Coverage map — concept §3 required topics

Every topic required by `28_HACKATHON_TOMORROW_CONCEPT.md` §3, and where it is covered:

| Required topic | Items |
|---|---|
| Credential placement | T7-06 (map + zero-secret scan), ES-02 (present + least-privilege + token identity), TD-02 (revoked, proven dead) |
| Repository access | T7-07 (six-machine fetch + permission list), ES-03 (venue reachability), SB-05 (post-submission lock) |
| Machine health | T7-04 (matrix by command), ES-01 (venue probe) |
| Time synchronization | T1-16 (six-machine check), ES-05 `[OPT]` (venue re-verify) |
| Connectivity loss | ES-08 (baseline + fallback), DC-06 (lane and S1 loss branches), T1-06 (offline package drill) |
| Worker replacement | T1-14 (disconnection drill), DC-07 (event-day reassignment), DC-04 (push cadence — the precondition) |
| Conflicting writes | DC-02 (claim before write + collision branch), T1-09 (collision drill), DC-03 (lane isolation) |
| Failing CI | DC-05 (red CI and CI-unavailable branches), FZ-05 (acceptance failure branch), DC-13 (evidence-or-open) |
| Human override | DC-10 (halt any AI process), DC-11 + quick card (human-only merge), DC-09 (human decisions on escalation), ES-09 (human start declaration) |
| Offline fallback | T1-06 (frozen package from Git), T1-07 `[OPT]` (provider failover), ES-04 (package pre-placed locally), DC-06 (offline operating mode) |

---

## 13. Phase index (P0–P9 → items)

| Plan phase | Checklist items |
|---|---|
| P0 Discovery closure | T7-01, T7-02, T7-09, T7-10 |
| P1 Reuse ledger | T7-03 |
| P2 Environment inventory | T7-04, T7-05, T7-06, T7-07, T7-08, T1-16 |
| P3 Research machine | T1-01, T1-02, T1-03, T1-04, T1-05, T1-06, T1-07 |
| P4 Development fleet | T7-07, T1-08, T1-09, T1-10, T1-19, ES-06, DC-02, DC-03, DC-11 |
| P5 Observer | T1-11, T1-12, T1-13, T1-18, ES-07, DC-08, DC-12, FZ-07 (TD-01/TD-02 verify P5 outputs at teardown; listed under P9) |
| P6 Rehearsal | T1-01 (6.2), T1-09 (6.3), T1-13 (6.5), T1-14 (6.4), T1-15 (6.1), T1-17 (6.6–6.8 + gate) |
| P7 Event-day startup | ES-01 … ES-09 |
| P8 Event operation | DC-01 … DC-13, FZ-01 … FZ-08, SB-01 … SB-05 |
| P9 Teardown | TD-01 … TD-06 |

No plan phase lacks checklist coverage. `[FACT — method: each phase's tasks in plan §3–§10 were mapped item-by-item while writing §2–§8; the mapping above is the result, and every item ID listed exists in this file.]`

---

## 14. Status

70 checkable items (counting method: `grep -c '^- \[ \] ' 05_IMPLEMENTATION_CHECKLIST.md` returns 71; subtract the one template line inside the §0.5 format-example code block, which is an illustration, not a checkable item → 70. Distribution, counted per ID prefix the same way: T-7 = 10, T-1 = 19, event start = 9, per-cycle = 13, freeze = 8, submission = 5, teardown = 6.)

Nothing in this checklist has been executed. It is designed, unrehearsed. The P6 rehearsal (plan §9) is its first test, and its recorded failures are expected to correct this document (T1-17). All command examples are synthetic.
