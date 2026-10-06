# Pre-event review - the method applied to itself

On the evening of **2 October 2026**, the night before the event, the playbook's own System 1
was pointed at the playbook. A separate coding-agent session got one hand-off file,
[`HANDOFF.md`](HANDOFF.md), with the state of play, hard constraints and six tasks: find the
contradictions, find what would break in the first fifteen minutes of event morning, simplify,
write the run sheet, build a one-command seed, and report.

## What it found

- **Ten defects that would have broken event morning**, each with an action -
  [`T2-TEN-THINGS.md`](T2-TEN-THINGS.md). For example: the `check.sh` path pointed at a directory
  that did not exist; "test before code" could not be executed before the code existed (fixed
  with a `PHASE` gate); `git worktree add -b` failed when a teammate had already pushed the
  branch. Two of the ten were found only by running the seed, not by reading.
- **Three more bugs in the new seed, caught by its own end-to-end test** -
  [`REPORT.md`](REPORT.md) §4. The worktrees were created before the agent context was
  committed, so every agent would have started without its rules or the capsule; and the
  merge-order gate reported every branch as already merged, so a piece with dependencies could
  have landed on `main` first.
- **Five hard contradictions and four ambiguities** between the files -
  [`T1-CONTRADICTIONS.md`](T1-CONTRADICTIONS.md).
- **Nothing removed** - [`T3-SIMPLIFICATIONS.md`](T3-SIMPLIFICATIONS.md). Every rule it
  examined either prevented a specific mistake or was wrong, and a wrong sentence is cheaper to
  fix than to remove. It fixed four untrue sentences and five passages that would have failed
  at 3 a.m.

## Files

| File | What |
|---|---|
| [`HANDOFF.md`](HANDOFF.md) | the assignment: state of play, decisions not to revisit, tasks T1-T6 |
| [`T1-CONTRADICTIONS.md`](T1-CONTRADICTIONS.md) | where the files said different things, with line numbers |
| [`T2-TEN-THINGS.md`](T2-TEN-THINGS.md) | ten things that would not work on event morning, each with an action |
| [`T3-SIMPLIFICATIONS.md`](T3-SIMPLIFICATIONS.md) | what was fixed, what was left alone, and why |
| [`REPORT.md`](REPORT.md) | the summary, under 150 lines |

The other two deliverables live where they are used: the run sheet,
[`playbook/DEVPLAN.md`](../../playbook/DEVPLAN.md) (T4), and the seed,
[`seed/`](../../seed/README.md) (T5).

> **Dated record.** File paths and line numbers inside these documents point at the repository
> as it was on 2 October 2026 - before the playbook moved into `playbook/` and before the root
> copies of `AGENTS.md` and `CAPSULE.md` were removed in favour of `seed/templates/`. The
> [changelog](../../CHANGELOG.md) says where to find that state in the history.
