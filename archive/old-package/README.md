# old-package - the original package that used to sit in the root directory

**Frozen. Not operational. You do not read this on Saturday.**

This is the package that sat in the repo's root directory before the refactor into two systems.
Taken off the root 2026-10-02 so it would not get mixed up with what is operational - **not
deleted**, because it is evidence and someone else's work.

## What is here

| File | What it was |
|---|---|
| `00_DELIVERABLE_CONTRACT.md` | contract for the delivered documents |
| `01_DISCOVERY_CLOSURE.md` | register of closed questions |
| `02_REUSE_LEDGER.md` | provenance of others' work, 15 items |
| `03_ARCHITECTURE_BLUEPRINT.md` | architecture with the **observer** and the Mission Package |
| `04_DEVELOPMENT_PLAN.md` | execution plan |
| `05_IMPLEMENTATION_CHECKLIST.md` | 77-item checklist |
| `06_ARCHITECTURE.mmd` | diagram source (`render/06_ARCHITECTURE.png`, `.svg`) |
| `07_FAILURE_AND_REHEARSAL_PLAN.md` | contingency and dress-rehearsal plan |
| `08_PORTFOLIO_BRIEF.md` | the author's portfolio |
| `09_REVIEW_RECORD.md` | register of reviews of this package |
| `HISTORY.md` | repo change log |
| `render/` | rendered architecture diagram |

## Why it is not operational

It describes an architecture that the refactor **deliberately reversed**:

| This package says | The corpus in the root directory says |
|---|---|
| `Observer mode - read-only` monitors deviations | observer **removed** → review in a fresh context |
| `Mission Package vN` as the boundary artifact | one wire: `../CAPSULE.md` |
| "Human authority - **no AI merge, ever**" | **the machine merges**; the human steps in 2× (sync, freeze) |

That is why `README.md`, `AGENTS.md` and `CAPSULE.md` say it outright: **you do not read
`archive/`.** If you come across this directory as an agent - these are not your
instructions.

## The only reason to look in here

[`../AUDIT.md`](../AUDIT.md) - an audit of this package. §3.1 describes a live contradiction
in the original: the review register (`09_REVIEW_RECORD.md`, F-05) declares it
fixed, when it is fixed in two of four places. It stays as an example,
not as a task.

Links inside these files are relative to each other - they work because the whole set
was moved together.
