# 02 - Six decisions to make

Every card: **question → why it matters → options with cost → what would settle it →
what happens if you don't decide.**

Options are given with numbers, not aesthetics. Each has a price - none is free.
The last column is the **default**, so the evening doesn't get stuck on analysis: if you
don't decide, you do the default and move on. A decision you made from the
unwritten is worse than a written one, but better than none.

Status legend: `OPEN` · `DEFAULT` · `CLOSED`

---

## D1 - How much research before the first line of code?

**Status:** `OPEN` · **Default:** 90 minutes, broad, 3-5 subagents in parallel

### Why it matters

This is the only place in the whole project where multiple agents really win - plus 90.2%
on Anthropic's internal eval (pattern A1). But research costs **~15×** the tokens
of a regular chat (A4). So the question is not "is it worth it", but "can you afford it".

| Option | Cost | Risk |
|---|---|---|
| **A. A lot (60-120 min)** | 15× tokens, blocks ~2 people | Topic misunderstood → 6 h of building nothing |
| **B. Little (20 min), start build in parallel** | cheap | Parallel build on guesses, then a rebuild |
| **C. Only the obvious points, the rest along the way** | cheapest | fragmentary context, lots of arguments |

### What would settle it

Whether the team has access to tokens with an unlimited or large limit. This is a question for
the people who decide that - not for documents.

### If you don't decide

**A, with a hard stop at 90 minutes.** Not because it is the best, but because it
defends itself best: research is the only phase that can be shortened later. A
misunderstood topic cannot.

> **A note on what this decision does NOT settle:** the gap between the plan and reality.
> No mechanism will detect it - see D2 and the section on what cannot be
> automated in [`04-SYSTEM-PRODUCTION.md`](04-SYSTEM-PRODUCTION.md).

---

## D2 - One spec for everything, or a spec per workstream?

**Status:** `OPEN` · **Default:** spec per workstream, 4 parts, the agent writes it by asking a human

### Why it matters

This is a decision about the cost of context, not about aesthetics. Every agent starts with a clean window.
If you give it 200 lines of a spec for the whole project, it will read them and ignore half
(C1 → the "attention budget" pattern). If you give it 20 lines of its own - it will read everything.

| Option | Cost | Risk |
|---|---|---|
| **A. One SPEC.md for everything** | cheaper to write | the agent gets lost, `04` on `main` 5-fold |
| **B. Spec per workstream (recommended)** | ×5 writing, ~15 min total | interfaces between specs have to be settled by hand |
| **C. No spec, ad hoc prompt** | 0 | the agent guesses interfaces, integration conflict only at merge |

### What would settle it

Whether you know up front where the boundaries between your workstreams run. If yes -
B. If not - **this is the first task for the evening, not for Saturday.**

### If you don't decide

**B.** Four sections, not eleven fields:

1. **What** - one sentence, falsifiable
2. **Where** - which files/directories, which not to touch
3. **What we don't do** - this is the most often skipped, and it saves the most time
4. **How we check** - one command, returns 0 or 1

The agent writes them, asking you via `AskUserQuestion`, and **saves to `SPEC.md`**.
The session that then implements is **new** - not the one that wrote.
Source: [B2](01-PATTERNS.md).

---

## D3 - What is "the test"?

**Status:** `OPEN` · **Default:** one script per workstream, `bash workstream-X/check.sh` → exit 0/1

### Why it matters

**This is the only decision without which the rest doesn't work.**

The mechanism without which the production system doesn't exist:

> *"Claude stops when the work looks done. Without a check it can run, 'looks done' is the
> only signal available, and **you become the verification loop: every mistake waits for
> you to notice.**"*
> - [Claude Code](https://code.claude.com/docs/en/best-practices)

If you leave the evening with one thing - let it be this command. The rest is
optional.

| Option | Cost | Risk |
|---|---|---|
| **A. Script per workstream** | 10-20 min per workstream, ×5 | highest safety net |
| **B. One e2e test for everything** | cheap | doesn't work until everything works at once - so almost never at night |
| **C. Manual "take a look" checklist** | 0 | exactly the failure mode described by the quote above |

### What would settle it

What the judging looks like. If scoring is **"works / doesn't work"** live - you need
A. If it is **static analysis / a report / a presentation** - A in a different form, but still
with a command, because the jury will look at the result anyway.

**A trap we know about:** "a green test that scans nothing is not proof"
- this is from the previous version (`AUDIT.md` §2 item 7) and still true. The test has to **break
something**. Before you write the test, break the code on purpose and check that the test notices.

### If you don't decide

**A, with the rule: the agent has the right to stop only after a green test.** Put it in
as a rule in `CLAUDE.md` and as `--allowedTools`. If the test doesn't exist, the workstream
doesn't start.

---

## D4 - Review: fresh session, built-in `/code-review`, or just a human?

**Status:** `OPEN` · **Default:** fresh session, 2 minutes, diff + criteria

### Why it matters

This is the **replacement for the observer** and the only decision that says whether we overturn
anything from the previous version other than the observer itself.

The mechanism that makes this worth doing:

> *"**A fresh context improves code review since Claude won't be biased toward code it just
> wrote.**"*
> *"A reviewer running in a fresh subagent context **sees only the diff and the criteria
> you give it, not the reasoning that produced the change**."*
> - [Claude Code](https://code.claude.com/docs/en/best-practices)

| Option | Cost | Risk |
|---|---|---|
| **A. Fresh session per PR** | ~2 min × number of PRs | overpays: the reviewer always finds something (see the caveat) |
| **B. Built-in `/code-review`** | 1 command, no configuration | doesn't know your spec, so doesn't know what matters |
| **C. C2 - two independent reviews in a row** | ×2 to A | best detection, most noise |
| **D. Human only** | 0 | a human at 4 AM doesn't read diffs |

### What would settle it

How many PRs will realistically be created. With ~15 PRs option A is 30 minutes of total
time - not a trifle. With 60 - it starts to hurt and then B.

**A caveat that has to be said out loud:** *"A reviewer prompted to find gaps
will usually report some, even when the work is sound… chasing every finding leads to
over-engineering."* You have to **ask the reviewer to report only gaps concerning
correctness and the spec**, and ignore the rest. Otherwise you build abstractions for things
that cannot happen.

### If you don't decide

**A, with a quick B-style adjustment:** `claude -p "review the diff against SPEC.md, report only
correctness gaps, not style"`. One line, zero configuration, works from minute zero.

---

## D5 - What **must** work mechanically?

**Status:** `OPEN` · **Default:** 3 things, the rest is text

### Why it matters

The old version invented the principle "instruction is not enforcement" and wrote it four
times without closing it. The answer is simpler than 776 lines of census:

> *"**Unlike CLAUDE.md instructions which are advisory, hooks are deterministic and
> guarantee the action happens.**"*
> - [Claude Code - Hooks](https://code.claude.com/docs/en/hooks-guide)

| Candidate for an obligation | Mechanism | Cost |
|---|---|---|
| Test passes before a commit | Stop hook | 5 min |
| Nobody pushes to `main` | branch protection | 5 min, but **requires** repo access - see below |
| No secrets in the repo | pre-commit scan | 15 min to configure |
| Changes to the Brief are numbered amendments | PR review | procedural |
| Every push every 30 min | discipline | **impossible** - stays as text |

**A practical note:** if you don't have rights to a repo with branch protection, the option
"nobody pushes to main" falls back to discipline. Then honestly write it down as a
limitation, instead of writing "it is secured". The previous version had exactly this
problem in 4 places (`AUDIT.md` §3).

### What would settle it

Check **now**, not on Saturday: whether each of the five has the right to push to `main`. On that
depends whether merge is a gate (good) or a convention (weak).

### If you don't decide

**Three: test in the commit, no secrets, main protected.** Everything else is text.
If something cannot be made mechanical - add it to `AUDIT.md` as a known
limitation, not as a rule.

---

## D6 - Does this even fit in four days?

**Status:** `OPEN` · **Default:** yes, with one preparation phase

### Why it matters

The old plan assumed six preparation phases spread over two weeks and said
"P0-P2 are non-negotiable" (`AUDIT.md` §3.4). Today is Tuesday, Saturday is in
4 days. **This plan is unenforceable and that is not its fault - it is a mismatch.**

| Option | Cost | Risk |
|---|---|---|
| **A. One 30 min session on Friday** | 30 min | something will only show up on Saturday |
| **B. Zero preparation** | 0 | 90 min of setup on site instead of 90 min of research |
| **C. Carry out the previous version's plan** | 2 weeks | on Saturday you build a process instead of a product |

### What to do in those 30 minutes

Exactly the list in [`05-CHEATSHEET-FOR-SATURDAY.md`](05-CHEATSHEET-FOR-SATURDAY.md), the "Friday" section.
Thirteen items, all reversible.

### If you don't decide

**A.** Because option B costs the same 90 minutes - only on site, in chaos, instead of
in the calm of a Friday evening.

---

## Summary: what is left to do after the evening

| # | What | Who | When |
|---|---|---|---|
| D1 | Check the token limit / API credit | whoever manages the accounts | **Friday** |
| D2 | Draw the boundaries of the five workstreams | the whole team, 20 min | **Friday** |
| D3 | Write one working `check.sh` for one workstream | 1 person | **Friday** |
| D4 | Choose the review command | 1 person | **Friday** |
| D5 | Check repo rights | whoever has the GitHub token | **Friday** |
| D6 | Enter the numbers in the document and print it | team-lead | **Friday** |

Six items. Not sixty-six. The previous version had 77 of them, and that didn't
yet count 18 constants and 14 questions.
