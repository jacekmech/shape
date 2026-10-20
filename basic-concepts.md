# Shape

**Shape is a small AI-assisted software development workflow implemented as a set of agent skills.**

It helps teams and individuals build software features with an AI coding agent in a way that stays structured, reviewable, and usable in real engineering work. Shape gives the work a simple structure: a feature is defined through a small set of documents, implementation is broken into execution units that fit AI context, and completed work is grouped into review units that fit developer attention.

The goal is not to replace engineering judgment. The goal is to make human intent clearer, agent execution more reliable, and iteration faster without losing control.

**Shape structures and amplifies human intent. Clear thinking in — clear software out.**

## Core idea

Shape is built around the **feature** as its main unit of work. Each feature is guided by persistent artifacts and implemented through small execution units.

### 1. Feature artifacts

For each feature, Shape maintains three core documents:

- **Product Specification** describing what should be built
- **Technical Specification** describing how it should be built
- **Implementation Plan** describing how implementation is split into Iterations, with their scope, status, and tasks

These are created and updated by the AI agent under human guidance. They are not disposable notes; they preserve intent, design, and execution structure in a form that survives individual sessions and can be reused, updated, and reviewed throughout development.

```text
Idea -> Product Specification -> Technical Specification -> Implementation Plan -> Iterations -> Done
```

Feedback loops:
- Technical Specification may reveal Product Specification updates
- Iteration planning or implementation may reveal Product Specification or Technical Specification updates

Specifications may be authored in Shape or represented by small artifacts linking to existing documents. Each retains Shape status, scope, and a reviewed source revision. The Product Specification includes an initial proposal of delivery iterations; the Implementation Plan refines it into executable Iterations. An iteration is a bounded delivery increment, not a fixed-duration sprint.

### 2. Execution units

Shape keeps implementation execution separate from the artifacts that describe and control it.

- **Iteration** is a bounded delivery increment defined in the Implementation Plan, with an objective, scope, acceptance criteria, and implementation tasks. The same iteration is planned, executed, and validated.
- **Task** is a concrete implementation step inside an approved Iteration
- **Batch** is a selected group of Tasks implemented together and sized for focused developer review

```text
Implementation Plan -> Iteration (n) -> Tasks -> Batch (m) -> Review and commit -> Iteration done
```

Development loops:
- Iterations deliver coherent functional pieces of the feature. Each Iteration should have a coherent implementation goal and be small enough for one focused agent session.
- Tasks and Batches execute an approved Iteration. When the Tasks are implemented, reviewed, approved, committed where needed, and validated against the iteration goal, the Iteration becomes `done`.
- Done Iterations collectively make the Implementation Plan `done`.
- Batches iterate over reviewable pieces inside an Iteration. Each Batch should produce a diff small enough for the developer to understand, review, approve, and commit.

### 3. Agent and developer attention

Shape uses different units for agent work and developer review:

- **Iterations** are shaped around AI attention: agent context, session continuity, and the amount of implementation work that can be handled reliably in one focused run.
- **Batches** are shaped around developer attention: review diffs, approval decisions, and commit boundaries.

## What is different about Shape

### 1. It treats AI-assisted development as a workflow problem, not only a tooling problem

Better models and better agents help, but they do not by themselves create reliable software development. Shape starts from the assumption that the missing piece in many teams is not capability, but operating structure.

Its focus is therefore not the agent alone, but the development workflow around it: how intent is recorded, how work is split, how changes are tracked, and how results are reviewed.

### 2. Append-only artifact updates

Shape treats feature documents as persistent, evolving development artifacts rather than static specs that must always be rewritten into a clean final form.

When new learnings appear, they are incorporated through explicit updates instead of silent replacement. This makes changes traceable, preserves earlier intent, and reduces the risk of hidden drift across requirements, design, and implementation.

AI makes this far more practical. Maintaining structured artifacts used to feel too heavy for the speed of development. With AI, updates can be drafted, aligned, and compressed with much less manual effort.

### 3. Explicit care for LLM context and session boundaries: the Iteration

Shape assumes that reliable AI execution depends on keeping work inside a manageable context boundary and ensuring progress does not depend on a single live session.

An **Iteration** is intentionally small enough to guide a single focused agent session with a clear objective, limited ambiguity, and bounded implementation scope.

One of Shape's core ideas is that workflow quality improves when implementation planning artifacts are shaped around practical agent context limits instead of pretending that an entire feature should be implemented in one continuous conversation.

### 4. Explicit care for developer context: the Batch

Shape also assumes that review quality depends on bounded cognitive load.

A **Batch** groups completed implementation work into a reviewable unit that a developer can validate without diff fatigue, context switching overload, or blurred acceptance decisions.

Iterations optimize for agent execution. Batches optimize for human validation.

Together, they let implementation move fast without forcing either the AI or the developer to work in units that are too large for reliable judgment.

Repository context still matters when it is available. Shape uses repository guidance as input to technical design and implementation decisions, but it does not turn that context into a workflow checkpoint.

## Status vocabulary

Shape uses small status vocabularies to keep artifact and execution state explicit. Artifact status describes the state of a document or plan as a control artifact. It does not mean the execution work described by that artifact has already happened.

### Documents and iterations

- **Product Specification:** `draft`, `approved`
- **Technical Specification:** `draft`, `approved`
- **Implementation Plan:** `draft`, `approved`, `done`
- **Iteration:** `draft`, `approved`, `done`
- **Specification Updates:** `draft`, `approved`

### Execution

- **Tasks:** not done, done
- **Batches:** selected, implemented, reviewed, approved, committed

Use the values literally:
- `draft` means still being refined
- `approved` means accepted for downstream use or as the execution baseline
- `done` means the execution described by the artifact has been completed, reviewed, committed where needed, and validated

For the implementation artifacts:
- an approved Implementation Plan means the overall iteration structure is accepted
- an approved Iteration means the task breakdown is accepted and ready for execution
- a done Iteration means its Tasks and Batches have completed the implementation described by that Iteration
- a done Implementation Plan means all Iterations are done

Implementation progress is inferred from execution units:
- an approved Iteration with no completed Tasks is ready to start
- an approved Iteration with some completed Tasks is actively being implemented
- an Iteration becomes `done` only after the iteration objective is validated
