# 1 - Research and brainstorm system

**Input:** the topic announced on a piece of paper.
**Output:** [`CAPSULE.md`](../seed/templates/CAPSULE.md) filled in.
**Who:** one laptop, one human, OMP. The rest of the team **does not wait during this time** -
they build their `check.sh` ([`2-BUILD.md`](2-BUILD.md)).
**Stop:** the team chose an option out loud. After that system 1 stays silent to the end.

**Budget: 60 minutes.** Not two hours.

---

## Clock

```
0:00 ──────── 0:35   research: 5 sessions in parallel
                    each gets one question, not a topic
                    each writes to a FILE, does not chat
                           │
0:35 ──────── 0:48   brainstorm: 3 sessions, 3 different entry points
                           │  (pragmatist · skeptic · outsider)
                           ▼
0:48 ──────── 0:58   TEAM CHOOSES out loud → system 1 writes it into the capsule
                           │
0:58 ──────── 1:00   brief read OUT LOUD
                           ▼
                      System 2 starts
```

**Tight. And that is the price of the decision you made:** instead of settling the topic
better, you settle it faster and come back to it later, during the build.
That is why section 4 of the capsule ("what we don't know") is filled in by system 1
automatically - **you do not have time to edit it, and you know less than it does.**
Do not delete it. It is the place where everything the research
did not get to will land.

---

## Research: 5 sessions in 35 minutes

**Why many agents:** this is the one place in the project where many agents
truly win. Anthropic measures on its research eval an advantage of **+90.2%**
over a single agent for questions that branch into many independent
directions. A hackathon topic is exactly such a question.
([source](https://www.anthropic.com/engineering/multi-agent-research-system))

**Why five and not ten:** because the lead has to read them in 10 minutes.
Five files can be skimmed. Ten cannot, and you are left with **twenty
files to read at 3:00 at night** - which is exactly the failure mode that
this whole construction is meant to eliminate.

At 35 minutes, each session gets ~7 minutes of work, which realistically is 3-10
tool calls. From the Anthropic benchmark: a simple question is 1 agent,
3-10 calls. **We are exactly at that boundary.**

### Task split

You split the topic **into questions, not into sections of the topic.** "Protocols in area X" is
a section. "Is protocol Y still used in 2026, since the documentation mentions it" is
a question.

Five questions that cover a hackathon topic well:

1. **Mechanism** - how it works, what the technology underneath is
2. **State of practice** - what people really do in 2026, what is dead
3. **Vector** - how it is attacked / how to protect it, concretely
4. **Tools** - what it is done with, ready-made libraries, code, frameworks
5. **How it is judged** - what the jury / organizer / criterion will look at

Questions 3 and 5 are the most often skipped, and they are the ones that decide the result. If you must
cut - cut question 2, not 5.

Each session gets exactly four things:

```text
GOAL:       One question. One sentence. Not "write about the topic".
WRITE TO:   research/NN-name.md - structure as below
SOURCES:    Yes: documentation, repo, paper/standard, changelog, CVE, dated blog.
            No: "top 10" lists, forums without an answer from the author.
            Fact without a link → [unconfirmed].
BOUNDARY:   What I am NOT looking for.  ← the most important field, most often skipped
```

The last field protects against one specific failure mode: given the task "do
research on X", three sessions will do exactly the same thing. Tasks must **not overlap
in scope**, even if they concern the same area. The task "how it works" and
the task "what to do with it in practice" are two different files.

### File structure

```markdown
# research/03-vector.md

## Established
- A thing. - source: <link>, accessed 2026-10-03

## Inconsistent
- Source A says X, source B says Y. Not resolved. Both links.

## Could not establish
- A question without an answer - why (no sources / contradictory)

## Further
- What I did not look for, because it was outside my task.
```

**The "Inconsistent" section** - a contradiction between sources is information. An average
between X and Y is information **only a bad one**. With an hour-long research there will be more of them,
because there is less time to dig deeper. That is unavoidable.

**The "Could not establish" section** at one hour is **not an exception, it is the norm.**
It is the only section that says outright where the ground is soft.

### Two traps known in advance

**Junk sources.** Agents pick them until you forbid it - described outright
by Anthropic: *"our early agents consistently chose SEO-optimized content farms over
authoritative but less highly-ranked sources like academic PDFs"*. The line about sources
in every task is not a formality. Without it you will get fast, fluent, completely
false research.

**Questions too narrow.** *"Agents often default to overly long, specific queries that
return few results"* - short and broad ones return results. With 7 minutes per session
you have no time for a second attempt, so start broad.

---

## Brainstorm: 3 sessions, 13 minutes, 3 different entry points

**This is the whole trick and it is here because the bet says we have compute.**

Three sessions get **the same topic and the same research, but each starts differently.**
Not three prompt variants in one session - three separate sessions, separate contexts.

| Session | Entry point | Looks for |
|---|---|---|
| **A - pragmatist** | "What is the simplest thing that does this well?" | solutions that can be built and demoed in 14 hours |
| **B - skeptic** | "Assume the previous attempt succeeded. Why is this a bad solution?" | solutions that survive criticism |
| **C - outsider** | "If you were doing this in your industry, how would you do it?" | solutions from outside the industry that nobody is looking for |

**13 minutes is little.** That is why the three sessions run **in parallel**, not one after another, and each
gets the research as input. After the sessions: **compare out loud, 5 minutes, pick
one.**

In the capsule you write section 2 - why this one and not the other two, and **why you
rejected the others**. That is the part system 2 will not reconstruct.

Session C wins most often. Nobody on the team knows the field, so "how would I do this at
my job" is the only prompt that is not tainted by your
assumptions.

---

## Capsule, then STOP

The lead reads the **files**, not the summaries from the sessions. Fills in [`CAPSULE.md`](../seed/templates/CAPSULE.md).

**The only place where the team steps in:** 10 minutes. Briefly, do not read it
out loud in full - you already did that at the choice. Just say:
*"the capsule says we are building X, the five pieces look like this, everyone check whether theirs
is on the list"*.

**The team chooses the option. Out loud. This is a gate and there is no way around it.**

After the choice system 1 **stays silent to the end.** If someone from system 2 asks - the answer
is section 4 of the capsule, and if it is not there, they add it there and keep going.

---

## Rule of thumb

> **A capsule that does not fit on an A4 sheet is not a capsule.**

Research is in `research/`, separately. The capsule is read by five people, one of them sober.
If it is 8 pages, it will not be read - and you will come back to five different models of the
problem, which is exactly the failure mode that this whole construction
is meant to eliminate.
