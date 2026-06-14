# Shape

**Shape is a small AI-assisted software development workflow implemented as a set of agent skills.**

It helps teams and individuals build software features with an AI coding agent in a way that stays structured, reviewable, and usable in real engineering work. Shape gives the work a simple structure: a feature is defined through a small set of documents, implementation is broken into execution units that fit AI context, and completed work is grouped into review units that fit developer attention.

The goal is not to replace engineering judgment. The goal is to make human intent clearer, agent execution more reliable, and iteration faster without losing control.

**Shape structures and amplifies human intent. Clear thinking in — clear software out.**

## Core idea

Shape is built around the **feature** as its main unit of work. Each feature is guided by persistent artifacts and implemented through small execution boundaries.

### 1. Feature artifacts

For each feature, Shape maintains three core artifacts:

- **Product Requirements Definition (PRD)** describing what should be built
- **Technical Concept** describing how it should be built
- **Implementation Plan** describing how implementation is split into executable steps

These are created and updated by the AI agent under human guidance. They are not disposable notes; they preserve intent, design, and execution structure in a form that survives individual sessions and can be reused, updated, and reviewed throughout development.

```text
Idea -> PRD -> Technical Concept -> Implementation -> Done
```

Feedback loops:
- Technical Concept may reveal PRD updates
- Implementation may reveal PRD or Technical Concept updates

### 2. Execution boundaries

Shape also defines two deliberately different execution boundaries:

- **Slice** is a unit of work sized to fit a focused AI execution session
- **Batch** is a unit of completed work sized to fit a focused developer review step

```text
Implementation Plan -> Slice (n) -> Tasks -> Batch (m) -> Review and commit -> Slice done
```

Development loops:
- Slices iterate over functional pieces of the feature. Each slice should have a coherent implementation goal and be small enough for one focused agent session.
- Batches iterate over reviewable pieces inside a slice. Each batch should produce a diff small enough for the developer to understand, review, approve, and commit.

### 3. Agent and developer attention

Shape uses different boundaries for agent work and developer review:

- **Slices** are shaped around AI attention: agent context, session continuity, and the amount of implementation work that can be handled reliably in one focused run.
- **Batches** are shaped around developer attention: review diffs, approval decisions, and commit boundaries.

## What is different about Shape

### 1. It treats AI-assisted development as a workflow problem, not only a tooling problem

Better models and better agents help, but they do not by themselves create reliable software development. Shape starts from the assumption that the missing piece in many teams is not capability, but operating structure.

Its focus is therefore not the agent alone, but the development workflow around it: how intent is recorded, how work is split, how changes are tracked, and how results are reviewed.

### 2. Append-only artifact updates

Shape treats feature documents as persistent, evolving development artifacts rather than static specs that must always be rewritten into a clean final form.

When new learnings appear, they are incorporated through explicit updates instead of silent replacement. This makes changes traceable, preserves earlier intent, and reduces the risk of hidden drift across requirements, design, and implementation.

AI makes this far more practical. Maintaining structured artifacts used to feel too heavy for the speed of development. With AI, updates can be drafted, aligned, and compressed with much less manual effort.

### 3. Explicit care for LLM context and session boundaries: the Slice

Shape assumes that reliable AI execution depends on keeping work inside a manageable context boundary and ensuring progress does not depend on a single live session.

A **Slice** is intentionally small enough to be handled in a single focused agent session with a clear objective, limited ambiguity, and bounded implementation scope.

One of Shape's core ideas is that workflow quality improves when execution units are designed around practical agent context limits instead of pretending that an entire feature should be implemented in one continuous conversation.

### 4. Explicit care for developer context: the Batch

Shape also assumes that review quality depends on bounded cognitive load.

A **Batch** groups completed implementation work into a reviewable unit that a developer can validate without diff fatigue, context switching overload, or blurred acceptance decisions.

Slices optimize for agent execution. Batches optimize for human validation.

Together, they let implementation move fast without forcing either the AI or the developer to work in units that are too large for reliable judgment.

Shape also assumes that repository context matters. Good feature artifacts improve feature-level intent, but agent-facing repository guidance improves implementation consistency, validation reliability, and alignment with local engineering conventions.

## Status vocabulary

Shape uses small status vocabularies to keep artifact and execution state explicit.

### Artifacts

- **PRD:** `draft`, `approved`
- **Technical Concept:** `draft`, `approved`
- **Implementation Plan:** `draft`, `approved`, `in progress`, `done`
- **Specification Updates:** `draft`, `approved`

### Execution

- **Slices:** `draft`, `planned`, `in progress`, `done`

Use the values literally:
- `draft` means still being refined
- `approved` means accepted for downstream use or as the execution baseline
- `planned` means a slice has been broken into tasks and is ready for execution
- `in progress` means implementation is actively underway
- `done` means the relevant workflow is complete
