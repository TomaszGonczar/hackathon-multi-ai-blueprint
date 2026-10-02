# T3 - Simplify what does not defend the idea

Mandate: **suspect by default**. For each one: *does this prevent a specific
mistake I have seen, or does it only look like it does?*

**The answer to that question was disturbingly often: "it prevents it, but it is wrong".**
Most of what I found is not things to remove, but **sentences that
disagree with each other**. Fixing a fact is smaller than removing a rule.

---

## Fixed (because they were simply untrue)

**README.md:9 - "four files"**
The table it links to lists five. The link itself led to a section that
contradicts it. → **"five files"**.

**README.md:253 - "seven rules from AGENTS.md §4"**
§4 has eight (the last is *"the capsule can be wrong"*, which `3-CHEATSHEET.md:128-129`
lists as one of the five things to remember - so not to be thrown out).
→ **"eight rules"**.

**README.md:246 - "811 → 1 188 lines"**
The actual sum is 1197 (`wc -l`). → **1 197**.

**README.md:275 - "OMP is the runtime"**
The runtime is heterogeneous: everyone brings their own coding agent. Half of the
corpus gives `claude` commands anyway. → **"the coding agent (OMP / Claude Code /
Codex) is the runtime"**. This is not cosmetic - a wrong sentence about the runtime makes
someone with Claude Code think they are doing something illegal.

---

## Fixed (because they caused a failure at 3 in the morning)

**`2-BUILD.md:83` - the secret pattern**
`git diff --cached | grep ... && { exit 1; }` under `set -euo pipefail`. It works
(checked), but **with an empty staging area** `grep` returns 1 and `set -e`
behaves non-terminally - a difference nobody will guess.
→ `if git diff --cached | grep ...; then echo FAIL; exit 1; fi`.

**`CAPSULE.md:76` - w4 waits for 1, and the rest of the corpus says "1 and 2"**
`CAPSULE.md:65` (the comment above the table) and `2-BUILD.md:129` explain the example as
*w4 waits for 1 and 2*, while the template says *waits for 1*. The column is
read **by machine**. → **1, 2**.

**`CAPSULE.md:93` - the "one command" example was a five-piece chain**
The comment above it says *ONE COMMAND PER PIECE*. An agent at 1:00 will not find
itself in the `&&`. → five separate commands with a `cd` into the worktree.

**`CAPSULE.md:110` - `./<yours>/check.sh`**
The worktree root is `~/w3-models`, so `./w3/check.sh` is a directory that does not exist.
→ **`./check.sh`**.

**`2-BUILD.md:22, 27, 66, 68` - the same}**
`cd ~/w3-models` + `./w3/check.sh` + `cd "$(dirname "$0")/.."` = three different
directories. → worktree root, `./check.sh`, `cd "$(dirname "$0")"`.

---

## Visited and LEFT (with a rationale)

**`AGENTS.md §4` - rules 1-8. Not touched.**
This is the operating system. Each one prevents a specific mistake: 1 (directory) -
collisions, 2 (test) - code without verification, 3 (IMPORTANT) - is the only one that
holds the loop, 4 (merge) - deadlocks and silent interface conflicts, 5 (review)
- author bias, 6 (push) - losing 12 hours, 7 (network) - executing
instructions from a page, 8 (bad capsule) - the only voice the system will not issue.
**Remove one, lose the night.**

**Machine merge order. Not touched.**
Without it the loop stops at night and asks a human. Explicitly named in the mandate as
untouchable.

**The interface rule (`2-BUILD.md:154-160`). Not touched.**
Without it the machine will resolve a conflict that changes the contract - **silently**.

**`check.sh`. Not touched.**
Without it there is no loop. Additionally the phase gate (D01) was a **missing
element**, not a rule: the fact that the rule *"test before code"* is literally
unexecutable does not mean it is bad - it means it was missing its action.

**`AGENTS.md` (the whole file). Not touched.**
The agent does not know what situation it is in. Besides, HANDOFF §5 forbids changes to §4
without a reason from T3 - the reasons from T3 concerned **errors in README**, not in §4.

**`3-CHEATSHEET.md` - the Friday `gh api` + `jq`. Left.**
`gh` and `jq` are two dependencies that are not there, and `git ls-remote HEAD` checks
readability, not write access. This is a real hole (D08). **But `3-CHEATSHEET.md` is
a clock for a human** and HANDOFF §5 says: do not add dependencies, do not touch
without a reason from T3. Fixing this would require editing the clock - and it is meant to be printed
and should not change on Friday evening. **Instead: the alternative
`git push --dry-run` is in `DEVPLAN.md` P2 and `seed/VERIFY.md` - where
people will run it.**

**`1-RESEARCH.md` - the ban on SEO content farms and "questions too narrow". Left.**
These are two specific failure modes that Anthropic observed in its own agents
(*"our early agents consistently chose SEO-optimized content farms"*), not
hypothetical ones. With 7 minutes per session there is no time for a second attempt.

**`README.md:208-211` - the rule about highlighting a single `IMPORTANT:` line. Left.**
It prevents a specific mistake: highlighting all lines makes the agent
ignore all of them. This is a fact from the Claude Code docs, not an idea.

**`README.md` section "Optional - and first to cut". Left.**
It tells the team what to cut under time pressure. Without it they will cut what they must not
(the machine merge), because they do not know it is the first thing to save.

---

## What I did NOT do (and why)

- **I did not add any new rule.** The project went through three rounds of simplification
  (3391 → 1246 → 1188). Every new rule is suspect by default, and I
  did not find a mistake I could not fix by correcting an existing
  sentence.
- **I did not remove anything that prevents a specific mistake.** The mandate explicitly
  said what not to touch. Nothing on that list was touched.
- **I did not edit `AGENTS.md §4`.** All four facts I fixed
  were in `README.md` - the only exception is `2-BUILD.md` (the `check.sh` pattern and
  paths), where the fix was mechanical and does not change the rules.
- **I did not fix `3-CHEATSHEET.md:13-16`** (D08). See above - a puzzle between the
  mandate and the hole, resolved by PUSHING the hole into `DEVPLAN.md`/`VERIFY.md`
  instead of editing the clock.
