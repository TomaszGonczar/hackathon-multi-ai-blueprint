# Changelog

Notable changes to the playbook and the seed. Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Versions before 1.0.0 were assigned afterwards, from the commit history; dates are commit dates.

## [1.1.0] - 2026-10-06 - Portfolio edition

### Added
- `README.md` for readers outside the team: the problem, the design, the result and how to try it.
  The diagram is now a Mermaid block GitHub renders itself, top to bottom, in light and dark.
- `seed/verify.sh`: the ten checks from `seed/VERIFY.md` in one command. It exits 0 only if all
  ten pass, and it changes nothing.
- CI runs the seed end to end in a throwaway `HOME`, twice, plus three cases that must fail: a
  vacuous merge gate, a disabled secrets gate and a blocked worktree. ShellCheck on all three scripts.
- `AGENTS.md` for coding agents working on this repository, `.gitattributes` for the language bar,
  and `docs/pre-event-review/README.md`, an index of the night-before review.

### Changed
- Layout. The playbook moved to `playbook/` (the old root README is now `playbook/README.md`), the
  review records to `docs/pre-event-review/`, and the diagram to `docs/assets/`. `seed/SEED.md` is
  now `seed/README.md`. Every move keeps its history (`git log --follow`).

### Fixed
- `seed/bootstrap.sh` printed `OK` and exited 0 after a failed `git worktree add`. It now exits 1
  at the step that failed.
- `seed/VERIFY.md` check 7 could not fail: phase 0 exits 1 anyway, so `exit=1` passed even with
  the secrets gate disabled. It now requires the `FAIL: secret` message, in both phases.
- `playbook/DEVPLAN.md` said to run `bash seed/VERIFY.md` (a Markdown file) and expect 8/8. It is
  `bash seed/verify.sh`, 10/10.
- `seed/templates/AGENTS.md` section 7 ended with a duplicated, malformed table.

### Removed
- Root `AGENTS.md` and `CAPSULE.md`. Both were stale copies of `seed/templates/` (the `AGENTS.md`
  copy still had the `./<yours>/check.sh` path bug), and a root `AGENTS.md` is loaded as
  instructions by any coding agent that opens the repository.
- The CI census of `archive/old-package/`. The archive is frozen, so the count could never change.

## [1.0.1] - 2026-10-05 - English

- Translated from Polish line for line, including file names and the seed's default directories
  (`~/hackathon-rozwiazanie` → `~/hackathon-solution`, `w1-kawalek` → `w1-piece`, `archiwum/` →
  `archive/`). [Pull request #8](https://github.com/TomaszGonczar/hackathon-multi-ai-blueprint/pull/8).

## [1.0.0] - 2026-10-03 - Event day 🥉

- The version on `main` during the event, 3–4 October 2026: commit `f689ba2`, in Polish.
- A five-person team ran it at TAURON Arena Kraków and placed 3rd.

## [0.3.0] - 2026-10-02 - The method applied to itself

- A coding-agent session, briefed with one hand-off file, ran System 1 on the project itself: ten
  defects that would have broken event morning, each with an action; five hard contradictions and
  four ambiguities; nine fixes; nothing removed.
- `seed/`: `bootstrap.sh` (solution repo + five worktrees, idempotent, offline), the templates and
  `VERIFY.md`. Its end-to-end test caught three bugs, among them worktrees created without the
  agent context and a merge-order gate that reported every branch as already merged.
- `DEVPLAN.md`: the run sheet from Friday evening to submission, every step with an owner.
- The v1 package moved to `archive/old-package/`. Merged as pull requests
  [#1](https://github.com/TomaszGonczar/hackathon-multi-ai-blueprint/pull/1) to
  [#7](https://github.com/TomaszGonczar/hackathon-multi-ai-blueprint/pull/7).

## [0.2.0] - 2026-09-30 - Two systems, one file

- The observer was removed and replaced by review in a fresh context.
- The Mission Package was replaced by `CAPSULE.md`, the only file between System 1 and System 2.
- "No AI merge, ever" was reversed: agents merge themselves in the order the capsule gives, and
  humans step in at sync and freeze.
- Research went from two hours to one, and `AGENTS.md` became a state machine with one block that
  changes.
- 3,391 lines became about 1,200.

## [0.1.0] - 2026-09-14 - The v1 package

- Ten documents: architecture blueprint, development plan, a 77-item implementation checklist,
  reuse ledger, failure and rehearsal plan, review record and others, now in `archive/old-package/`.
- Several review rounds; nothing executed. The audit that followed (`archive/AUDIT.md`) found a
  contradiction the review register listed as fixed in only two places out of four.
