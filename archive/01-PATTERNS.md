# 01 - Patterns: what is worth copying before you start inventing

12 things that someone has already tested in production. Each has a source. All of them concern
working with agents - because that is the only layer of this project that really has to change
and that is not worth thinking through on your own.

There is nothing here about managing a team. There is only: **how to split the work between
5 people and their agents so that it doesn't turn into a crowd.**

---

## A. Research

### A1. Many agents win at research. At code - not so much.

> *"Our internal evaluations show that multi-agent research systems excel especially for
> **breadth-first** queries that involve pursuing multiple independent directions
> simultaneously… We found that a multi-agent system with Claude Opus 4 as the lead agent
> and Claude Sonnet 4 subagents outperformed single-agent Claude Opus 4 by **90.2%** on our
> internal research eval."*

> *"…**most coding tasks involve fewer truly parallelizable tasks than research**, and LLM
> agents are not yet great at coordinating and delegating to other agents in real time."*

- [How we built our multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system)

**What this means on Saturday:** the cover. We split the unknown-domain phase into 3-5
independent sub-questions and run them in parallel - this is the best-confirmed thing
in the whole material. Then **we stop multiplying agents** and go with five people × one
agent per person. The saving is not only because research doesn't parallelize
well - the cost is measurable, see A4.

### A2. A subagent task has four fields. Not ten.

> *"Each subagent needs an **objective**, an **output format**, **guidance on the tools and
> sources** to use, and **clear task boundaries**. Without detailed task descriptions,
> agents duplicate work, leave gaps, or fail to find necessary information."*

- [ibid.](https://www.anthropic.com/engineering/multi-agent-research-system)

A concrete failure mode they cite: for the task *"research the semiconductor shortage"*
one subagent went into the 2021 crisis, and two others **did exactly the same thing** on
the 2025 supply chain sites. The division of work must be in the text of the task, not in the head
of the parent agent.

**This replaces the ten-field "Mission Package"** from the previous version. Four fields:
what, in what format, from what sources, where its territory ends.

### A3. A subagent's output lands in a file, it does not come back through the parent agent

> *"**Subagent output to a filesystem** to minimize the 'game of telephone.' Direct
> subagent outputs can bypass the main coordinator… Subagents call tools to store their
> work in external systems, then pass lightweight references back to the coordinator.
> This prevents information loss during multi-stage processing and reduces token overhead."*

- [ibid.](https://www.anthropic.com/engineering/multi-agent-research-system)

**What this means:** `research/01-traffic-analysis.md`, `research/02-techniques.md`… instead of
12,000 tokens pasted by the parent agent into one window. The team reads the files,
not the summary. A summary is sometimes more convenient and always worse.

### A4. The cost does not match intuition

> *"In our data, agents typically use about **4×** more tokens than chat interactions, and
> multi-agent systems use about **15×** more tokens than chats. For economic viability,
> multi-agent systems require tasks where the value of the task is high enough to pay for
> the increased performance."*

- [ibid.](https://www.anthropic.com/engineering/multi-agent-research-system)

**A question for the evening:** does the team have the tokens for that 15×? If yes - research can be
pushed wide. If not - narrow and short. **This is a real decision variable, not
minutiae.** See D1.

### A5. Scaling effort has numbers written down

> *"Simple fact-finding requires just **1 agent with 3-10 tool calls**, direct comparisons
> might need **2-4 subagents with 10-15 calls each**, and complex research might use
> **more than 10 subagents** with clearly divided responsibilities."*

- [ibid.](https://www.anthropic.com/engineering/multi-agent-research-system)

> *"We counteracted this tendency by prompting agents to **start with short, broad
> queries**, evaluate what's available, then progressively narrow focus."*

- [ibid.](https://www.anthropic.com/engineering/multi-agent-research-system)

**What this means:** not "do research". The concrete numbers written down in [`03-SYSTEM-RESEARCH.md`](03-SYSTEM-RESEARCH.md).
Decision D1 is a choice from that little table, not improvisation.

### A6. Agents pick junk sources until you forbid it

> *"Human testers noticed that our early agents consistently **chose SEO-optimized
> content farms** over authoritative but less highly-ranked sources like academic PDFs or
> personal blogs. Adding source quality heuristics to our prompts helped resolve this
> issue."*

- [ibid.](https://www.anthropic.com/engineering/multi-agent-research-system)

**What this means:** the brief should have **one line about sources** - allowed: documentation,
repo, paper, changelog, standards. Not allowed: an undated blog, "10 best X",
forums without the author's reply. The rest is probably true and there is no way to check it.

---

## B. Production

### B1. The test closes the loop. Without it, you are the loop.

> *"Claude stops when the work looks done. Without a check it can run, 'looks done' is the
> only signal available, and **you become the verification loop: every mistake waits for
> you to notice.**"*

> *"**The trust-then-verify gap.** Claude produces a plausible-looking implementation
> that doesn't handle edge cases. **Fix:** Always provide verification. If you can't verify
> it, don't ship it."*

- [Claude Code - Best practices](https://code.claude.com/docs/en/best-practices)

**This is the most important pattern in the whole material.** Not "good practices". A mechanism:
the agent reads the test result, fixes, reads again. Without that it stops at "looks
done" and every mistake waits until someone notices. **Decision D3.**

### B2. A spec has four parts. Not eleven fields.

> *"The most useful specs are **self-contained**: they **name the files and interfaces
> involved**, **state what is out of scope**, and **end with an end-to-end verification
> step** that proves the feature works. Time spent making the spec precise pays off more
> than time spent watching the implementation."*

- [Claude Code - Best practices](https://code.claude.com/docs/en/best-practices)

> *"…start with a minimal prompt and ask Claude to **interview you** using the
> `AskUserQuestion` tool… then **write a complete spec to SPEC.md**. Once the spec is
> complete, **start a fresh session to execute it.** The new session has clean context
> focused entirely on implementation, and you have a written spec to reference."*

- [ibid.](https://code.claude.com/docs/en/best-practices)

**Four parts:** *what* · *where* (files, interfaces) · *what we don't do* · *how we check*.
The agent writes the spec by asking the human. The session that executes it is **new** - not the one
that wrote it. The previous version had the 10 Mission Package fields; four are enough, and
four can be maintained.

### B3. A worktree per person - collisions are structurally impossible

> *"Run multiple Claude sessions in parallel… **Worktrees: run separate CLI sessions in
> isolated git checkouts so edits don't collide.**"*

- [Claude Code - Parallel sessions](https://code.claude.com/docs/en/best-practices)

The previous version **designed this rule from scratch** and called it the most important
(`AUDIT.md` §2 pt 4). The tool has it built in. The rule is not needed - it is enough
not to copy the repo by hand.

### B4. Fresh context = an honest reviewer. This replaces the observer.

> *"A fresh context improves code review since Claude won't be biased toward code it just
> wrote."*

> *"**A reviewer running in a fresh subagent context sees only the diff and the criteria
> you give it, not the reasoning that produced the change**, so it evaluates the result on
> its own terms."*

- [Claude Code - Adversarial review step](https://code.claude.com/docs/en/best-practices)

A caveat you need to know:

> *"A reviewer prompted to find gaps will **usually report some, even when the work is
> sound**, because that is what it was asked to do. **Chasing every finding leads to
> over-engineering.** Tell the reviewer to flag only gaps that affect correctness or the
> stated requirements, and treat the rest as optional."*

- [ibid.](https://code.claude.com/docs/en/best-practices)

**This is the whole replacement for the observer** and it is described in the README. The three problems of the old
process (it judges itself, it doesn't see a misunderstood topic, noise vs silence) disappear,
because the reviewer doesn't know the plan, works when it is needed, and costs two minutes.

### B5. Build against it from the start - two independent voices

> *"**Voting:** Reviewing a piece of code for vulnerabilities, where **several different
> prompts review and flag the code if they find a problem**."*

> *"**Evaluator-optimizer:** one LLM call generates a response while another provides
> evaluation and feedback in a loop… the two signs of good fit: the LLM responses can be
> demonstrably improved when a human articulates their feedback; and the model can provide
> this feedback."*

- [Building effective agents](https://www.anthropic.com/research/building-effective-agents)

**Why this matters here in particular:** this is a security project. Whoever let your thing through
in the middle of the night, not you - because they had no time to read the diff. Two independent reviews
in a row cost twice as much as one, and they catch what one doesn't.

### B6. Routing: a cheap model for the easy, an expensive one for the hard

> *"**Routing** easy/common questions to smaller, cost-efficient models while hard/unusual
> questions to more capable models to optimize for best performance."*

- [Building effective agents](https://www.anthropic.com/research/building-effective-agents)

**What this means:** the same pattern as in a human team. One person is good
at "make a class that parses a header", another is good at "design an
authentication protocol". Not every agent on the team has to get the best model.

---

## C. Tools that replace documentation

### C1. A hook is deterministic. A prompt is advice.

> *"**Unlike CLAUDE.md instructions which are advisory, hooks are deterministic and
> guarantee the action happens.**"*

- [Claude Code - Hooks](https://code.claude.com/docs/en/hooks-guide)

This is the answer to the principle "instruction is not enforcement", which the previous version
wrote four times and did not close out. The answer is in the tool. **Decision D5.**

### C2. `/doctor prompt-audit` looks for contradictions on its own

> "…looks for problems such as **instructions written for older models, references to
> files or commands that don't exist, and instructions that contradict each other**."

- [Claude Code - Memory](https://code.claude.com/docs/en/memory)

The previous package built its own census in 776 lines to look for drift between
files. That census compared identifiers, not the content of sentences - which is why it let through
the live contradiction described in `AUDIT.md` §3.1. This command does exactly what
was intended.

### C3. A directory name is a signal for the agent

> *"Folder hierarchies, naming conventions, and timestamps all provide important signals
> that help both humans and agents understand when and how to utilize information."*

- [Effective context engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)

> *"find the **smallest possible set of high-signal tokens** that maximize the likelihood of
> some desired outcome."*

- [ibid.](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)

**What this means:** naming directories and branches so that *from the name* you can see what is
inside is context engineering, not aesthetics. `w2-anomaly-detection/` says
more than `module_b/`. It works on both sides - human and agent.

### C4. Examples beat rules

> *"Teams will often stuff a **laundry list of edge cases** into a prompt in an attempt to
> articulate every possible rule… Instead, we recommend working to curate a set of
> **diverse, canonical examples**… For an LLM, examples are the **'pictures' worth a
> thousand words**."*

- [Effective context engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)

**This is a direct answer to the question "what should such blueprints look like".**
Not: 40 rules. Yes: **three worked examples and one principle**. The previous version had
40 rules and zero examples. That is why it is unreadable.

### C5. The whole process is already a product: spec-kit

> *"**Constitution once per project; specify → plan → tasks → implement → converge per
> feature.**"*
> - [GitHub spec-kit](https://github.com/github/spec-kit)

Plus a separate process for evaluating an idea before you write a line:
> *"**intake → research → define → shape → decide**… ending in a **go / needs-clarification /
> kill** decision… stopping with a documented reason is also a useful result."*

- [ibid.](https://github.com/github/spec-kit)

**What this means:** there is no need to invent phases. Ready-made ones exist, tested on
thousands of projects, and they can be adapted. But **you don't need to install them** -
there is a four-step summary of them in [`04-SYSTEM-PRODUCTION.md`](04-SYSTEM-PRODUCTION.md).
If someone on the team knows spec-kit, use it. If not - don't let them lose a night on it.

---

## What these sources **don't** contain

So as not to suggest that everything is solved:

- **There is no data on 5 people working in parallel on one new system at night.**
  Everything above comes from the work of one company with its own agents and from individual
  users. Transferring it to your scenario is **a trial, not a conclusion.**
- **There is no data on quality degradation under time pressure and fatigue.** All the
  benchmarks I cite measure the agent with full context and no pressure.
  This is a gap that no source fills.
- **There is no comparison of "1 person + 1 agent" vs "5 people + 5 agents" vs "1 person +
  10 agents".** Nobody has measured this in conditions that apply to you.

These are empty spots, not arguments against. But it is worth knowing that they are empty spots.
