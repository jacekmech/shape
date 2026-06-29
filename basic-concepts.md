# Shape

**Shape is a small AI-assisted software development workflow implemented as a set of agent skills.**

It helps teams and individuals build software features with an AI coding agent in a way that stays structured, reviewable, and usable in real engineering work. Shape gives the work a simple structure: a feature is defined through a small set of documents, implementation is broken into execution units that fit AI context, and completed work is grouped into review units that fit developer attention.

The goal is not to replace engineering judgment. The goal is to make human intent clearer, agent execution more reliable, and iteration faster without losing control.

**Shape structures and amplifies human intent. Clear thinking in — clear software out.**

## Core idea

Shape is built around the **feature** as its main unit of work. Each feature is guided by persistent artifacts and implemented through small execution units.

### 1. Feature artifacts

For each feature, Shape maintains four core artifact types:

- **Product Requirements Definition (PRD)** describing what should be built
- **Technical Concept** describing how it should be built
- **Implementation Plan** describing how implementation is split into session-sized plans
- **Slice Plan** describing one focused implementation slice in executable task detail

These are created and updated by the AI agent under human guidance. They are not disposable notes; they preserve intent, design, and execution structure in a form that survives individual sessions and can be reused, updated, and reviewed throughout development.

```text
Idea -> PRD -> Technical Concept -> Implementation Plan -> Slice Plans -> Done
```

Feedback loops:
- Technical Concept may reveal PRD updates
- Slice planning or implementation may reveal PRD or Technical Concept updates

### 2. Execution units

Shape keeps implementation execution separate from the artifacts that describe and control it.

- **Task** is a concrete implementation step inside an approved Slice Plan
- **Batch** is a selected group of Tasks implemented together and sized for focused developer review

```text
Implementation Plan -> Slice Plan (n) -> Tasks -> Batch (m) -> Review and commit -> Slice Plan done
```

Development loops:
- Slice Plans iterate over functional pieces of the feature. Each Slice Plan should have a coherent implementation goal and be small enough for one focused agent session.
- Tasks and Batches execute an approved Slice Plan. When the Tasks are implemented, reviewed, approved, committed where needed, and validated against the slice goal, the Slice Plan becomes `done`.
- Done Slice Plans collectively make the Implementation Plan `done`.
- Batches iterate over reviewable pieces inside a Slice Plan. Each Batch should produce a diff small enough for the developer to understand, review, approve, and commit.

### 3. Agent and developer attention

Shape uses different units for agent work and developer review:

- **Slice Plans** are shaped around AI attention: agent context, session continuity, and the amount of implementation work that can be handled reliably in one focused run.
- **Batches** are shaped around developer attention: review diffs, approval decisions, and commit boundaries.

## What is different about Shape

### 1. It treats AI-assisted development as a workflow problem, not only a tooling problem

Better models and better agents help, but they do not by themselves create reliable software development. Shape starts from the assumption that the missing piece in many teams is not capability, but operating structure.

Its focus is therefore not the agent alone, but the development workflow around it: how intent is recorded, how work is split, how changes are tracked, and how results are reviewed.

### 2. Append-only artifact updates

Shape treats feature documents as persistent, evolving development artifacts rather than static specs that must always be rewritten into a clean final form.

When new learnings appear, they are incorporated through explicit updates instead of silent replacement. This makes changes traceable, preserves earlier intent, and reduces the risk of hidden drift across requirements, design, and implementation.

AI makes this far more practical. Maintaining structured artifacts used to feel too heavy for the speed of development. With AI, updates can be drafted, aligned, and compressed with much less manual effort.

### 3. Explicit care for LLM context and session boundaries: the Slice Plan

Shape assumes that reliable AI execution depends on keeping work inside a manageable context boundary and ensuring progress does not depend on a single live session.

A **Slice Plan** is intentionally small enough to guide a single focused agent session with a clear objective, limited ambiguity, and bounded implementation scope.

One of Shape's core ideas is that workflow quality improves when implementation planning artifacts are shaped around practical agent context limits instead of pretending that an entire feature should be implemented in one continuous conversation.

### 4. Explicit care for developer context: the Batch

Shape also assumes that review quality depends on bounded cognitive load.

A **Batch** groups completed implementation work into a reviewable unit that a developer can validate without diff fatigue, context switching overload, or blurred acceptance decisions.

Slice Plans optimize for agent execution. Batches optimize for human validation.

Together, they let implementation move fast without forcing either the AI or the developer to work in units that are too large for reliable judgment.

Shape also assumes that repository context matters. Good feature artifacts improve feature-level intent, but agent-facing repository guidance improves implementation consistency, validation reliability, and alignment with local engineering conventions.

## Status vocabulary

Shape uses small status vocabularies to keep artifact and execution state explicit. Artifact status describes the state of a document or plan as a control artifact. It does not mean the execution work described by that artifact has already happened.

### Artifacts

- **PRD:** `draft`, `approved`
- **Technical Concept:** `draft`, `approved`
- **Implementation Plan:** `draft`, `approved`, `done`
- **Slice Plan:** `draft`, `approved`, `done`
- **Specification Updates:** `draft`, `approved`

### Execution

- **Tasks:** not done, done
- **Batches:** selected, implemented, reviewed, approved, committed

Use the values literally:
- `draft` means still being refined
- `approved` means accepted for downstream use or as the execution baseline
- `done` means the execution described by the artifact has been completed, reviewed, committed where needed, and validated

For the implementation artifacts:
- an approved Implementation Plan means the overall slice structure is accepted
- an approved Slice Plan means the task breakdown is accepted and ready for execution
- a done Slice Plan means its Tasks and Batches have completed the implementation described by that Slice Plan
- a done Implementation Plan means all Slice Plans are done

Implementation progress is inferred from execution units:
- an approved Slice Plan with no completed Tasks is ready to start
- an approved Slice Plan with some completed Tasks is actively being implemented
- a Slice Plan becomes `done` only after the slice objective is validated
