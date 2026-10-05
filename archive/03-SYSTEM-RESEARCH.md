# 03 - Research system

**Goal:** turn an unknown topic into one file that five people work from for
the next 20 hours. In 90 minutes. Without asking anyone for permission.

**Scope:** hour 0 → 1.5. Then people work in parallel, and this system is
done. It doesn't return to research unless a question comes up that the brief doesn't
answer - then it returns for 10 minutes.

---

## The one sentence that defines the phase

> **Research doesn't answer the question "how to do it". It answers the question "what was
> actually asked and what we don't know yet".**

The difference is practical: an agent that tries to propose a solution produces
prose that looks like knowledge. An agent that produces the **structure of the problem**
produces something that can be verified and referred back to.

---

## Division of work: one lead, 3-5 subagents

```
              topic (raw text, verbatim)
                        │
                        ▼
              ┌───────────────────┐
              │  LEAD             │  breaks the topic into 3-5 sub-questions
              │  (~5 min)         │  that can be researched INDEPENDENTLY
              └─────────┬─────────┘
                        │  one task per subagent
        ┌───────────┬───┴───────┬───────────┐
        ▼           ▼           ▼           ▼
    ┌────────┐  ┌────────┐  ┌────────┐  ┌────────┐
    │sub-1   │  │sub-2   │  │sub-3   │  │sub-4   │   each: own context,
    │writes  │  │writes  │  │writes  │  │writes  │   own tools,
    │to FILE │  │to FILE │  │to FILE │  │to FILE │   zero contact with each other
    └────┬───┘  └────┬───┘  └────┬───┘  └────┬───┘
         │           │           │           │
         └───────────┴─────┬─────┴───────────┘
                           ▼
                 ┌───────────────────┐
                 │  SYNTHESIS (lead) │  reads the FILES, not summaries
                 │  (~10 min)        │  assembles BRIEF v1
                 └───────────────────┘
```

**Why subagents don't see each other:** two independent investigations arriving at the same
fact give independent confirmation. One agreeing with the other 100% means something completely
different than two independent confirmations of the same fact.

This is older than agents - it is the reason we have two
independent branches of evidence at all. The agent is no exception here, just faster.

---

## Four task fields

Every subagent gets **exactly** these four things. No more. (Pattern A2.)

```text
GOAL:       One sentence. What I am to establish - not "write about the topic", but a specific question.
FORMAT:     Where I write (research/NN-name.md) and in what structure (heading + sources).
SOURCES:    Allowed: documentation, repo, paper/standard, changelog, CVE, official blogs.
            Not allowed: undated blogs, "10 best" lists, forums without the author's reply.
            Every fact: link + access date. No link → mark [unconfirmed].
BOUNDARY:   What I do NOT look for. This field is the most important and the most often skipped.
```

The last field is the most important. Without it subagents do exactly the same thing - this is a
documented failure mode: given the task *"research the semiconductor shortage"*
one went into the 2021 crisis, and two others did the same about the 2025 supply chain.

**An example of two real tasks on the same topic:**

```text
GOAL:     Which protocols and formats are actually used in [area], and which are dead.
BOUNDARY: I do NOT look for the history of protocols. I am only interested in the state as of 2026.

GOAL:     What are the typical attack vectors on [class of systems] and how to defend against them.
BOUNDARY: I do NOT look for general "best practices" advice. Specific CVEs, configurations, checklists.
```

These two questions give different files, different people to read, and **no overlapping
fragments**. That is exactly the point.

---

## Structure of the output file

Every subagent writes to its own file, **doesn't send the result to the lead** (pattern A3 -
the "game of telephone" eats information and tokens).

```markdown
# research/02-protocols.md

## Established
- A thing we know. - source: URL, accessed 2026-10-03

## Inconsistent
- Source A says X, source B says Y. **Not resolved.** Both links.

## Could not establish
- A question for which no answer was found. - why (no sources? contradictory?)

## Suggestions for further questions
- What I didn't look for, because it was outside my task.
```

The **Inconsistent** section is the most important and the most often skipped. A contradiction between
sources is information, not a problem to be settled by a vote. If the team
loses 20 minutes settling it, it has won - because it knows where the ground is soft.

The **Could not establish** section protects against what you fear most:
building on a foundation nobody checked.

---

## Scaling: concrete numbers, not "do research"

Quote ([pattern A5](01-PATTERNS.md)):

> *"Simple fact-finding requires just **1 agent with 3-10 tool calls**, direct comparisons
> might need **2-4 subagents with 10-15 calls each**, and complex research might use
> **more than 10 subagents** with clearly divided responsibilities."*

Translated to Saturday:

| Type of sub-question | How many subagents | Commands per agent | Who reads the result |
|---|---|---|---|
| "how does it work" (protocol, format) | 1 | 3-10 | 1 person + lead |
| "which to choose" (2-3 options) | 2-4 | 10-15 | team decision, 10 min |
| "how to do it well" (patterns, best practice) | 3-5 | 10-15 | everyone, in the synthesis |

**Don't exceed 5.** Above that the lead can't synthesize the results
and instead of a synthesis you get a second set of files to read.

---

## Synthesis → BRIEF v1

The lead reads the **files**, not summaries. Assembles **one page**. Structure:

```markdown
# BRIEF v1 - approved 2026-10-03, at 1:30

## 1. What we are doing
One sentence. It can be falsified - if not, we go back to research.

## 2. What we know
5-8 points, each with a link. This is the core. The rest of the team doesn't extend it.

## 3. What we don't know
A list of open questions. Honest. Someone will surely start looking at it.

## 4. What "done" looks like
Tests that have to pass. Preferably before anyone starts writing.

## 5. Who does what
Five workstreams, five people, one row each: who, what, where, how we check.
```

**Hard rule: if the brief doesn't fit on one page, it is not a brief.**
An 8-page brief won't be read at 20:00. Shorten it to a size that fits
on an A4 sheet - the rest is in the `research/` files, which nobody will open, and that
is the point.

**Who writes it:** the lead, in 10 minutes, based on the files. **Who reads it:** everyone,
out loud, in 15 minutes. **Who approves it:** one person, out loud. The rest don't vote,
they just ask questions in those 15 minutes.

---

## Three traps known before anyone falls into them

### 1. Agents choose junk sources until you forbid it

> *"…our early agents consistently **chose SEO-optimized content farms** over
> authoritative but less highly-ranked sources like academic PDFs or personal blogs."*
> - [Anthropic](https://www.anthropic.com/engineering/multi-agent-research-system)

The line about sources in every task (field 3 above) is not a formality. Without it you will get
a fast, fluent, completely untrue brief.

### 2. Questions that are too narrow return zero results

> *"Agents often default to overly long, specific queries that return few results…
> **start with short, broad queries**, evaluate what's available, then progressively
> narrow focus."*
> - [ibid.](https://www.anthropic.com/engineering/multi-agent-research-system)

Short and broad first, then narrowing. The reverse order is the most common
reason for empty research.

### 3. Agent agreement is not truth

Two subagents that found the same thing and wrote the same thing are **not two proofs**.
They may be reading the same source. Agreement is a property of the sources, not of the world.

Practical consequence: **only what has a link goes into the brief.** The rest is
marked as unconfirmed and building on it is allowed, but written down.
The previous version had this rule and had it right - it stays.

---

## What this system does **not** do

- **Doesn't produce a solution.** If the brief contains an architecture proposal, that is
  a sign the agent went too far. Go back to the structure of the problem.
- **Doesn't return at night.** There is an exception: a question that the brief doesn't answer and that
  blocks work. Then 10 minutes, one subagent, an addendum to the brief **with a number**.
- **Doesn't replace a human's knowledge of the topic.** None of you knows the domain. The brief
  gives you a structure in which you can search - not answers.
- **Doesn't guarantee the topic is understood correctly.** Nobody guarantees that. If the
  brief is wrong, you will see it while building, in hour 4. This is unavoidable and
  no tool removes it.
