# Shape: Codex-Based Artifact-Driven Software Delivery Workflow (v0.1)

This document outlines the core primitives and design elements required to structure the first version of an AI-assisted, artifact-driven software delivery workflow using Codex in a monorepo setup.

---

## 1. Overview and Principles

Shape is a lightweight software delivery workflow with clear roles, steps, and document-based handovers, using a **feature** as its atomic unit of delivery. It provides a minimal but sufficient set of primitives instructing an AI coding agent how to support users in creating feature specifications and working code.

Shape structures and amplifies human intent. The quality of what gets delivered is bounded by the quality of the input provided. Clear thinking in — clear software out.

Shape separates execution units by cognitive boundary:

- a **Slice** is sized for reliable execution within a single focused AI session
- a **Batch** is sized for reliable human review within a single developer validation step

Shape is designed not only to be structurally sound, but also easy to operate in practice. A workflow that is conceptually strong but difficult to understand or drive will not be adopted consistently. Shape therefore treats guided execution, discoverability of capabilities, and clear next-step signaling as first-class workflow qualities rather than user-interface polish.

Shape observes the following principles:

* **Lightweight**  
  Minimal set of activities and documents required to deliver a feature.

* **Highly Collaborative**  
  Roles collaborate tightly around the same feature and shared artifacts.

* **Loosely Coupled**  
  Clear boundaries between steps and responsibilities.

* **Document-Driven**  
  Structured markdown documents define handovers between steps.

* **Guided Execution**  
  AI produces specifications and code under direct specialist guidance and should always orient the user toward the next meaningful step.

* **Discoverable**  
  Workflow capabilities should be easy to inspect and understand so that users can operate Shape without memorizing its internal model.

* **Iterative**  
  Delivery progresses through repeated refinement across all stages.

* **Discovery-Driven**  
  Learnings are fed back into PRD and Technical Concept through controlled updates.

* **Optimistically Concurrent**  
  Work proceeds without blocking; discrepancies are resolved asynchronously.

* **Traceable**  
  All changes are explicit, reviewable, and persisted.

Late changes are inherently expensive to coordinate. Shape keeps the mechanism for handling them small and explicit, but does not pretend the problem itself is lightweight. Its goal is not to eliminate the cost of late change, but to prevent silent drift across requirements, design, and implementation.

### Out of Scope

Shape v1 focuses on the core artifact-driven workflow for delivering a feature within an already chosen branch and repository context. It does not define branching strategy or prescribe a specific coding agent vendor, integration mechanism, or mandatory agent instruction filename.

Shape does define repository readiness expectations for agent-assisted delivery, but it does not standardize the full setup or installation model for agent tooling across repositories.

It also does not yet define a streamed or continuous delivery mode beyond the standard document update flow described in this specification.

The following areas are intentionally out of scope for Shape v1:
- document review workflows
- pull request review workflows
- CI/CD design and automation
- testing beyond unit-test-oriented implementation support, including integration, end-to-end, load, and manual testing practices

Shape has been exercised primarily in greenfield development. It is not yet designed as a workflow for scaffolding-heavy setup, large-scale refactoring, or tech-debt cleanup.

---

## 2. Vocabulary

This section defines a precise and shared terminology for the system. The goal is to eliminate ambiguity so that both humans and AI operate consistently.

### Feature  
Atomic delivery unit of the workflow. A feature represents a complete unit of functionality delivered from ideation through design and implementation into working software.

### Stage  
A distinct phase of the workflow with a defined purpose and output. The core stages are: Product definition (PRD), Technical design (Tech Concept), and Implementation.

### Product Requirements Definition (PRD)  
Markdown document specifying functional and non-functional requirements for a feature.

### Technical Concept (Tech Concept)  
Markdown document specifying technical design and initial implementation direction for a feature. It serves as the design baseline for implementation.

### Implementation Plan  
Markdown document driving execution. It is created at implementation kickoff and evolves during implementation by defining Implementation Slices, adding detailed Implementation Tasks, and tracking progress.

### Implementation Slice  
Coarse-grained execution unit of delivery that can be reviewed, integrated, and validated independently. Slices are defined in the Implementation Plan and may be added or adjusted during implementation. A Slice should be small enough to fit into a single focused agent session without relying on long-running conversational carryover.

### Implementation Task  
Fine-grained unit of work derived from a Slice. Typically involves a small, well-defined change (e.g., a few related modifications across code or configuration). Tasks are explicitly listed in the Implementation Plan.

### Implementation Batch  
A selected group of Implementation Tasks executed in a single coding step by the AI Agent and then reviewed by the Developer. A Batch should be small enough to fit into a single high-quality developer review step. Each batch is followed by developer-led review and, once approved, must be concluded with a commit before the next batch begins.

### Specification Update  
Append-only change record added to a PRD or Technical Concept after baseline readiness. A Specification Update captures newly discovered information, decisions, or corrections without modifying the original baseline content.

### Repository Guidance  
Repository-specific instructions, conventions, and architectural direction available to the AI Agent through agent-facing files or equivalent guidance. This includes repository structure, development commands, local coding patterns, validation expectations, and architectural constraints.

### Active Step  
The current workflow action being executed or proposed. Shape should keep the active step and likely next step visible so that the user does not need to infer workflow state from raw document changes alone.

---

## 3. Roles and Responsibilities

This section defines roles as **responsibility boundaries**. The workflow can be executed by a single person, but roles clarify responsibilities and allow scaling across specialists.

### Product Owner  
Responsible for feature definition. Provides input during the specification process and collaborates with the AI Agent to produce a structured PRD. Owns requirement-level correctness.

### Architect  
Responsible for technical design. Translates the PRD into a Technical Concept and supports requirement-to-design alignment when changes occur. Owns design-level correctness.

### Developer  
Responsible for execution. Creates and evolves the Implementation Plan, refines Slices into Implementation Tasks, selects Implementation Batches, reviews diffs, requests adjustments, records implementation decisions, confirms task completion, commits approved batches, and validates completed Slices. Owns implementation correctness and repository changes.

### AI Agent  
Responsible for drafting artifacts, proposing updates, implementing selected task batches, and maintaining workflow artifacts under human guidance. The AI Agent accelerates delivery, but does not replace human ownership of requirements, design, or implementation decisions. It should also keep workflow capabilities, current state, and next steps understandable to the user throughout execution. It should signal workflow mode when useful for orientation, especially when entering Shape-driven work, resuming in a fresh session, or when a workflow rule materially affects what happens next, but should avoid repetitive reminder phrasing on every exchange.

### External Review (Out of Scope)  
Formal reviews and integration processes (e.g., pull requests, code reviews, deployment approvals) are critical for delivery but are not managed by Shape and remain part of the surrounding engineering environment.

---

## 4. Feature Delivery Flow

This section defines how a **Feature** progresses from idea to implemented code through a sequence of stages.

The flow is:

- **Linear but non-blocking**
- **Driven by document handovers**
- **Extended through append-only feedback loops**
- **Guided by explicit next steps and visible workflow state**

Each stage produces a well-defined artifact that becomes the input to the next stage.

---

### 4.1 PRD

**Summary**  
Transforms an initial feature idea into a structured **Product Requirements Definition (PRD)**.  
The AI Agent collaborates with the user to iteratively refine input until the document is complete, consistent, and ready for downstream use.

Shape should treat larger user-provided requirement input as a first-class starting point. In many cases, the user will already have a draft PRD, ticket text, notes, or a rough feature brief prepared outside the workflow. The AI Agent should explicitly invite such input before switching to narrower clarification questions.

**Role**  
Product Owner

**Input**  
Unstructured or semi-structured feature description, optionally including an existing draft PRD or larger requirement write-up.

**Output**  
PRD markdown document, structured according to a predefined template and **reviewed for completeness and clarity**.

**Completion Condition**  
PRD is accepted as ready for the feature scope to be handed over downstream.

**Feedback Loop**  
- **Inbound**  
  Specification Updates appended when gaps or inconsistencies are discovered in later stages
- **Outbound**  
  None

**Guidance to user**  
When a PRD interaction step finishes, the AI Agent should clearly indicate the most likely next step, typically continuing PRD refinement or marking the PRD as `ready` when appropriate. Workflow-mode reminders should be used only when they improve orientation, not as repetitive turn prefixes.

---

### 4.2 Technical Concept

**Summary**  
Transforms the PRD into a **Technical Concept**, defining architecture, constraints, and implementation direction.

Shape should treat larger user-provided technical input as a first-class starting point. In many cases, the user will already have a draft Technical Concept, design notes, architectural constraints, or implementation direction prepared outside the workflow. The AI Agent should explicitly invite such input before switching to narrower design questions.

Technical Concept drafting must explicitly align with repository-specific guidance available through agent-facing instructions and related repository documents. This includes repository structure, architectural patterns, validation commands, code organization conventions, and preferred implementation boundaries. Shape assumes that technical design quality depends not only on the PRD, but also on how well the proposed design fits the actual repository environment.

**Role**  
Architect

**Input**  
- PRD markdown document
- Codebase
- Repository guidance
- Optional technical notes, draft Technical Concept, or other semi-structured design input

**Output**  
Technical Concept markdown document (design baseline)

**Completion Condition**  
Technical Concept is accepted as ready for implementation planning to begin.

**Feedback Loop**  
- **Inbound**  
  Specification Updates appended when gaps or inconsistencies are discovered during later stages
- **Outbound**  
  May append Specification Updates to PRD when requirement-level issues are identified

**Guidance to user**  
When a Technical Concept interaction step finishes, the AI Agent should clearly indicate the most likely next step, typically continuing Technical Concept refinement, marking it `ready`, or initiating implementation planning.

---

### 4.3 Implementation

**Summary**  
Executes the feature based on the **PRD**, **Technical Concept**, and **Implementation Plan**.  
Implementation begins by creating the **Implementation Plan**, then incrementally refining Slices into **Implementation Tasks**, executing them in **Implementation Batches**, reviewing diffs, and committing approved changes.

The **Implementation Plan** acts as the **primary execution control document**, evolving throughout this stage.

> Execution occurs through iterative microcycles (Slice → Task → Batch → Review → Commit).  
> These are defined separately in the Implementation Lifecycle.

**Role**  
Developer

**Input**  
- PRD markdown document
- Technical Concept markdown document
- Codebase

**Output**  
- Implementation Plan markdown document
- Implemented feature committed to the current branch
- Updated Implementation Plan reflecting completed Slices and Tasks

**Completion Condition**  
All Implementation Slices are completed, validated, and reflected in both code and Implementation Plan.

**Feedback Loop**  
- **Inbound**  
  None
- **Outbound**  
  May append Specification Updates to Technical Concept and/or PRD when gaps or inconsistencies are identified

**Guidance to user**  
When an implementation step finishes, the AI Agent should clearly indicate the next likely step, such as picking up the active feature in a fresh session, reviewing the batch, committing an approved batch, recording an implementation decision, finishing the slice, preparing the next slice, or finishing implementation.

---

### 4.4 Flow Characteristics

- **Document-Driven**  
  Each stage produces a persistent artifact used as input for subsequent stages

- **Append-Only Evolution**  
  Changes to PRD and Technical Concept are recorded as Specification Updates, preserving full traceability

- **Optimistically Concurrent**  
  Stages do not block each other; discrepancies are resolved asynchronously through explicit update handling

- **Traceable Execution**  
  Progression from PRD to code is fully reconstructable via documents, diffs, commits, and approved batch boundaries

- **Handheld Progression**  
  The AI Agent should not merely enforce document structure, but should actively guide the user toward the next valid and useful workflow action

---

## 5. Document Lifecycle

This section defines how specification documents are created, stabilized, and evolved over time.

Shape enforces a **two-phase lifecycle** for **PRD** and **Technical Concept**:

1. **Baseline Creation** — mutable, exploratory
2. **Append-Only Evolution** — controlled, traceable

The **Implementation Plan** follows a different lifecycle: it is a **live document** updated inline during execution.

This model ensures stability for execution while preserving the ability to incorporate new information.

---

### 5.1 Baseline Creation

**Summary**  
PRD and Technical Concept are created through iterative, Socratic interaction between the user and the AI Agent. The goal is to converge on a complete, internally consistent baseline.

The user may also begin by supplying a larger draft or semi-structured write-up. Shape should explicitly allow and encourage this because it often accelerates convergence and reduces unnecessary questioning.

**Process**
- User provides initial input (unstructured or semi-structured)
- AI Agent explicitly offers the option to paste a larger existing draft if available
- AI Agent guides refinement through questions and suggestions
- Document is incrementally structured according to its template
- Gaps, ambiguities, and inconsistencies are resolved during this phase
- Document metadata is set explicitly, including:
  - `status: draft | ready`
  - `date: YYYY-MM-DD`

**Output**  
Version 1 of the document (baseline)

**Completion Condition**
- Document is explicitly reviewed and accepted by the responsible role
- Document status is set to `ready`
- Document is considered stable for downstream use

---

### 5.2 Baseline Immutability

**Summary**  
Once ready, the baseline PRD or Technical Concept is **not modified directly**.

**Rules**
- Existing content is not edited, removed, or rewritten
- Corrections and updates are not applied inline
- The baseline remains as the original reference point

**Rationale**
- Preserves original intent
- Enables full traceability
- Prevents silent drift during execution

---

### 5.3 Specification Updates (Append-Only Changes)

**Summary**  
All changes after baseline readiness are recorded as **Specification Updates**, appended to the PRD or Technical Concept.

**Structure**
Each Specification Update includes:
- Name
- Status: `draft | ready`
- Date
- Context
- Change / decision
- Impact

**Rules**
- Updates are appended in chronological order
- Existing ready Updates are not modified
- Updates do not rewrite baseline content; they extend it
- Only **ready** Updates are considered effective for downstream work

**Usage**
- Captures discoveries during later stages
- Resolves inconsistencies without blocking progress
- Maintains alignment across documents

---

### 5.4 Cross-Document Feedback

**Summary**  
Specification Updates may originate during Technical Concept creation, slice planning, implementation, or independent review outside the main stage flow.

**Rules**
- Technical Concept may add Specification Updates to:
  - PRD
- Implementation may add Specification Updates to:
  - Technical Concept
  - PRD
- Specification Updates may also be created independently of the main stage flow
- Propagation to downstream artifacts is handled explicitly when relevant
- Implementation Plan is updated inline and does not use append-only Specification Updates

**Characteristics**
- Non-blocking
- Explicit
- Traceable
- Lightweight by default, but capable of handling late changes when needed

---

## 6. Implementation Lifecycle

This section defines how a feature is executed using **Implementation Slices, Tasks, and Batches**.

Execution follows a **developer-controlled, iterative microcycle**:

**Slice → Tasks → Batch → Review → Commit**

The **Implementation Plan** is the central control artifact throughout this process.

A new Slice should begin in a **fresh agent session**. This is a critical Shape discipline, not just a convenience recommendation. It exists to preserve deliberate context curation, reduce carryover noise, and improve output quality. Slices should therefore be small enough to fit within practical agent context limits without depending on long-running conversational carryover. Batches should be selected to preserve high-quality developer reviewability, not just execution speed.

A fresh session should normally begin by resolving the active feature context through **Pick Up Feature**, unless the active feature is already unambiguous and can be confirmed with minimal friction.

---

### 6.1 Initialization

**Summary**  
Implementation begins by creating an Implementation Plan from the ready PRD and Technical Concept.

**State**
- PRD status is `ready`
- Technical Concept status is `ready`
- Implementation Plan is created
- Initial Slices are defined
- Tasks are not yet specified
- No execution has occurred

---

### 6.2 Slice Refinement

**Summary**  
A selected Implementation Slice is expanded into **Implementation Tasks**.

**Process**
- In a fresh session, the active feature is first resolved through Pick Up Feature unless already clearly active
- Developer selects a Slice
- AI Agent proposes a breakdown into Tasks
- Developer reviews and adjusts if needed
- Tasks are added to the Implementation Plan
- Slice scope is checked against practical agent context limits
- Implementation Plan status changes from `ready` to `in progress` when active execution begins

**Output**
- Slice with a defined set of Implementation Tasks

**Completion Condition**
- Tasks are sufficiently granular for execution
- Slice scope is clear and bounded
- Slice remains small enough to be executed within a single focused agent session

**Guidance to user**  
When slice preparation finishes, the AI Agent should indicate the next likely step, typically selecting a small execution batch from the prepared tasks.

---

### 6.3 Batch Selection

**Summary**  
The Developer selects a subset of Implementation Tasks to execute as a **Batch**.

**Rules**
- Batch is explicitly defined by the Developer
- Batch size is small and controlled (e.g., 1–3 Tasks)
- Batch defines the scope of the next execution step
- Batch should remain small enough for a single high-quality developer review step
- The next batch should not begin until the current approved batch has been committed

---

### 6.4 Batch Execution

**Summary**  
The AI Agent executes the selected Batch.

**Process**
- AI Agent implements code changes required by the selected Tasks
- AI Agent keeps within the selected Batch scope
- AI Agent does not select or reorder Tasks
- AI Agent does **not** mark the batch as approved merely because implementation completed
- AI Agent may update temporary execution state in the Implementation Plan if needed, but task completion should be finalized only after developer approval during review

**Constraints**
- AI Agent operates strictly within Batch scope
- AI Agent does not select or reorder Tasks

**Guidance to user**  
When a batch finishes implementing, the AI Agent should clearly ask the Developer for **review** and **approval**, explicitly stating that the next step is to inspect the diff, request any needed adjustments, and then either approve or reject the batch.

---

### 6.5 Review and Commit

**Summary**  
The Developer validates the result of the Batch.

This is a developer-led review step centered on the diff and intended batch outcome. The Developer may request adjustments, ask for clarifications, record implementation decisions, or even adjust upcoming Slice structure before approving the batch. These actions should occur through prompting the AI Agent rather than by directly editing workflow artifacts outside Shape.

Approval and commit form a single normal progression boundary. Once a batch is approved, it should be committed before any subsequent batch begins so that the next review starts from a clean diff boundary.

**Process**
- Developer reviews code diff
- Developer verifies alignment with selected Tasks and Slice intent
- Developer may request one or more adjustment iterations
- Developer may ask the AI Agent to record relevant implementation decisions
- Developer may reshape future tasking or slice boundaries if implementation reveals a better plan
- Once satisfied, the Developer explicitly confirms the batch is approved.
- After approval, the AI Agent marks relevant tasks as completed in the Implementation Plan so that the workflow continues to minimize direct document editing by the Developer.
- Developer commits the approved batch before the next batch begins

**Outcome**
- Approved and committed changes become part of the codebase
- Relevant tasks are marked done by the AI Agent in the Implementation Plan
- Batch is finalized

**Notes on agent-assisted review**
- Same-session review by the implementing AI Agent may be useful for summarization, task-to-diff mapping, and obvious risk surfacing
- It should not be treated as a strong independent quality signal
- A separate review-oriented session may provide additional value by examining the diff with fresher context, but this remains supportive rather than authoritative
- Human developer validation remains the trusted approval boundary

**Guidance to user**  
When review support is provided, the AI Agent should clearly state whether the batch is awaiting **review**, awaiting **approval**, approved but still awaiting commit, or fully ready for the next step.

---

### 6.6 Slice Validation

**Summary**  
After all Tasks within a Slice are completed and their approved batches have been committed, the Slice is validated.

**Process**
- Developer verifies that Slice objectives are met
- Functional and technical expectations are confirmed
- Slice is confirmed as complete within the intended session-sized boundary

**Output**
- Slice marked as completed in Implementation Plan

---

### 6.7 Iteration

**Summary**  
The process repeats for the next Slice until all Slices are completed.

**Rule**
- Each new Slice should begin in a fresh agent session
- Each fresh execution session should normally begin with Pick Up Feature unless the active feature can be resolved with minimal friction
- No new batch should begin until the previous approved batch has been committed
- This should be treated as a core execution-quality rule, not as optional workflow polish

---

### 6.8 Completion

**Summary**  
Implementation ends when all Slices are completed and validated.

**Completion Condition**
- All Slices marked as completed
- Implementation Plan status is set to `done`
- Implementation Plan reflects full progress
- Feature is fully implemented in code

---

### 6.9 Feedback to Documents

**Summary**  
Discoveries during Implementation may require requirement-level or design-level updates.

**Rules**
- Requirement-level issues may trigger draft Specification Updates to PRD
- Design-level issues may trigger draft Specification Updates to Technical Concept
- Implementation Plan is updated inline as a live document
- Downstream propagation is handled explicitly when relevant
- Ready updates do not silently reinterpret already executed work

**Characteristics**
- Non-blocking
- Explicit
- Traceable

---

## 7. Repository Layout Conventions

This section defines where Shape artifacts live in the monorepo and how they are organized.

Shape explicitly optimizes repository layout for **speed, feature-level collaboration, and execution continuity**, rather than for strict separation of artifacts by role or document type.

The workflow assumes tight collaboration between Product Owner, Architect, Developer, and AI Agent around the same feature. For that reason, the core feature artifacts are **co-located in a single feature folder**, instead of being separated into document-type buckets such as `prds/`, `tech-concepts/`, and `implementation-plans/`.

This is a deliberate choice. Shape favors:

- faster handoffs
- lower navigation overhead
- stronger feature-local context
- easier AI-assisted artifact resolution
- room for additional feature-specific documents when needed

over stricter role-based separation in repository structure.

---

### 7.1 Default Layout

The default Shape layout for a feature is:

```text
features/
  202404-automated-map-creation/
    01-prd.md
    02-tech-concept.md
    03-implementation-plan.md
```

This convention is the default and recommended repository structure for Shape.

---

### 7.2 Layout Rules

#### Feature folder

Each feature has its own dedicated folder under `features/`.

The folder name should contain:

- a stable feature identifier
- a short, human-readable slug

Recommended pattern:

```text
<feature-id>-<feature-slug>
```

Example:

```text
202404-automated-map-creation
```

This keeps feature folders unique, readable, and easy to scan in an IDE.

---

#### Core document filenames

Each feature folder contains exactly these three core documents:

- `01-prd.md`
- `02-tech-concept.md`
- `03-implementation-plan.md`

These filenames are intentionally:

- short
- predictable
- ordered
- easy for both humans and AI tools to resolve

The numeric prefixes preserve a stable visual and logical order in IDEs and file listings.

---

### 7.3 Why Shape Uses Feature Folders

Shape does **not** recommend storing artifacts in separate repository-wide buckets such as:

```text
prds/
tech-concepts/
implementation-plans/
```

That model increases separation between related artifacts of the same feature and adds unnecessary navigation overhead during iterative work.

In Shape, a feature is the primary unit of delivery. The repository layout should reflect that.

Co-locating the PRD, Technical Concept, and Implementation Plan in one folder:

- keeps the feature context together
- makes cross-document work faster
- improves discoverability of all feature artifacts during implementation
- reduces ambiguity for AI-assisted workflows
- allows extra ad hoc feature documents to be added without inventing new repository-wide categories

This means Shape explicitly chooses **feature-local collaboration over repository-level role separation**.

---

### 7.4 Additional Feature-Local Documents

A feature folder may contain additional documents when needed.

Examples include:

- research notes
- UX notes
- diagrams
- decision logs
- slice summaries
- rollout notes

These documents are optional and feature-specific. They do not replace the three core Shape artifacts, but may support them.

Shape prefers keeping such documents inside the same feature folder whenever they are specific to that feature.

---

### 7.5 Root Path Flexibility

Shape uses `features/` as the default logical root for feature artifacts.

However, the physical root may vary by repository. For example, a team may place the feature folders under a different top-level path if needed.

Examples:

```text
features/
docs/features/
geoform-documentation/features/
```

Shape should therefore define a **recommended default layout**, while allowing the repository-specific root location to be configured by the team.

The important constraint is not the exact root name, but the internal structure of each feature folder.

---

### 7.6 Resolution Principle for AI-Assisted Workflows

Repository conventions must allow an AI-assisted system to resolve feature artifacts deterministically.

For that reason, Shape favors:

- one folder per feature
- one predictable filename per core artifact
- stable folder naming
- minimal ambiguity in artifact location

This reduces the need for heuristic searching and makes skills more reliable when creating, reading, and updating artifacts.

---

### 7.7 Summary

Shape standardizes on a **feature-folder layout**:

```text
features/
  202404-automated-map-creation/
    01-prd.md
    02-tech-concept.md
    03-implementation-plan.md
```

This layout is chosen deliberately to support:

- speed
- tight cross-role collaboration
- feature-local execution context
- scalable AI-assisted artifact handling

rather than stricter separation of artifacts by role or document type.

---

## 8. Documents Inventory & Schemas

This section defines the three core documents used in Shape:

- Product Requirements Definition (PRD)
- Technical Concept
- Implementation Plan

Each document has a clear purpose, minimal structure, and a defined evolution model.

---

### General Rules (applies to all documents)

All documents in Shape follow these principles:

- **Minimal and skimmable**  
  Structure is intentionally small. Content can expand inside sections as needed.

- **AI-assisted**  
  Documents are created and extended through AI-human collaboration.

- **Baseline + Updates (PRD, Technical Concept)**  
  Documents are created, accepted as ready, and then extended via **Specification Updates** (append-only).

- **Live document (Implementation Plan)**  
  The Implementation Plan evolves directly during execution and is not append-only.

- **Required status and date**  
  All documents and Updates must include a document-type-specific status and:
  - `date: YYYY-MM-DD`

- **Status model by document type**
  - PRD: `draft | ready`
  - Technical Concept: `draft | ready`
  - Implementation Plan: `draft | ready | in progress | done`

- **Status model for Specification Updates**
  - `draft | ready`

---

### 8.1 Product Requirements Definition (PRD)

#### Purpose

Defines what is being built and why, from a product and user perspective.

Focus:
- user value
- expected behavior
- constraints

Avoid:
- technical design
- internal system structure

---

#### Structure

##### Header
- Title
- Status: `draft | ready`
- Date

---

##### Goal
- Problem
- User value
- Expected outcome

---

##### Flow
- Main flow (happy path)
- Key alternative / error paths
- Final states

---

##### Requirements
- Functional requirements (observable behavior)
- Business rules / constraints

---

##### Acceptance Criteria
- Conditions that must be met for the feature to be considered correct
- Outcome-oriented and testable at a high level

---

##### UX Notes
- Inputs / interactions
- Feedback (success / error)
- Optional link to detailed UX

---

##### Non-Functional Requirements
- Performance / latency
- Reliability
- Dependencies (if product-relevant)

---

##### Notes
- Assumptions
- Open questions
- Optional / stretch ideas

---

##### Out of Scope
- Explicit exclusions
- Known non-goals for this feature

---

##### Updates

Append-only list of Specification Updates after baseline readiness.

Each Update includes:
- Name
- Status: `draft | ready`
- Date
- Context
- Change / decision
- Impact

Only ready Updates are considered effective.

---

### 8.2 Technical Concept

#### Purpose

Defines how the feature will be built at design level.

Focus:
- architecture
- responsibilities
- interfaces
- constraints
- implementation direction
- alignment with repository-specific architectural guidance and local engineering conventions

Avoid:
- task-level planning
- code-level decisions unless architecturally relevant

---

#### Structure

##### Header
- Title
- Status: `draft | ready`
- Date

---

##### Overview
- Technical summary
- Key constraints
- Core design principle

---

##### Repository Alignment
- Relevant repository guidance used during design
- Important architectural or organizational constraints from agent-facing instructions
- Local conventions or preferred patterns that materially shape the solution

---

##### Architecture
- Main components / units
- Responsibility split
- System boundaries

---

##### Flow
- End-to-end technical flow
- Key processing steps

---

##### Interfaces
- External APIs / contracts
- Key internal interfaces (if relevant)

---

##### Data & Validation
- Core data structures (high-level)
- Validation rules
- Error model

---

##### Frontend / Backend Notes
- Key frontend behavior (if relevant)
- Backend responsibilities / orchestration

---

##### Testing Notes
- Integration testing expectations
- Manual testing considerations
- Performance / load testing considerations
- Known risk areas requiring validation

---

##### Risks & Trade-offs
- Major risks
- Important decisions

---

##### Notes
- Assumptions
- Non-goals
- Deferred decisions

---

##### Out of Scope
- Explicit technical exclusions
- Known non-goals at design level

---

##### Updates

Append-only list of Specification Updates after baseline readiness.

Each Update includes:
- Name
- Status: `draft | ready`
- Date
- Context
- Change / decision
- Impact

Only ready Updates are considered effective.

---

### 8.3 Implementation Plan

#### Purpose

Controls how the feature is executed.

Focus:
- slices
- tasks
- progress
- decisions made during execution

This is a live document, updated continuously during implementation.

---

#### Structure

##### Header
- Title
- Status: `draft | ready | in progress | done`
- Date

---

##### Objective
- What is being delivered
- Key constraints

---

##### Slices

Defines the high-level structure of execution.

- [ ] Slice Name — Goal

(Slices are represented with checkboxes. New slices may be appended during implementation.)

Each Slice should remain small enough to fit within a single focused agent session, and each new Slice should normally be executed in a fresh agent session. Fresh execution sessions should normally begin by resolving the active feature through Pick Up Feature unless the active feature is already unambiguous.

---

##### Execution Order

This is the central workspace of the Implementation Plan.

Structure:

- [ ] Slice Name
  - [ ] Implementation Task
  - [ ] Implementation Task

Rules:
- Slices and Tasks use checkboxes to indicate progress (`done / not done`)
- Implementation Tasks are appended continuously during execution
- Developer selects tasks for execution in batches (batches are not explicitly represented)
- This is the only place where sequencing exists
- Progress is reflected inline
- Batches should remain small enough for a single high-quality developer review step
- Tasks should be marked done only after developer approval of the implemented batch
- An approved batch should be committed before the next batch begins so that review boundaries remain clean

---

##### Important Decisions

Captures implementation-time decisions made during execution.

Use for:
- clarifications not worth updating Technical Concept
- trade-offs discovered during coding
- cross-slice implications

---

##### Notes

- Additional observations
- Clarifications
- Suggested next step when useful for keeping execution flow obvious

---

## 9. Workflow Operations

This section defines the core operations performed within Shape.

Operations are the **canonical actions of the workflow**. They describe what Shape must be able to do, independent of prompt wording or implementation details.

Shape distinguishes between:

- **Primary workflow operations** — actions that advance a feature through definition, design, and implementation
- **Supporting operations** — actions that establish or inspect local workflow context

Specification change handling is intentionally explicit. Shape does not attempt to make late changes look cheap or effortless. Instead, it provides a small operational model for drafting and readying them without silently rewriting requirements, design, or execution state.

Shape also assumes that a workflow is easier to use when its capabilities are visible. Supporting operations should therefore make it possible to inspect current workflow state and available capabilities without requiring the user to memorize internal operation names.

---

### 9.1 Primary Workflow Operations

#### 1. Initiate Feature
**Description**  
Create the initial feature workspace and establish the feature as a deliverable unit in the repository.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Proposes feature identifier and slug if needed, scaffolds the feature folder and core artifact files according to Shape conventions, evaluates repository readiness, and indicates the most likely next step after setup.

**User**  
Provides or approves the feature identity and confirms creation of the feature workspace.

---

#### 2. Create PRD
**Description**  
Draft and iteratively refine the Product Requirements Definition until it is ready for downstream use.

**Responsible role**  
Product Owner

**AI Agent**  
Guides the discussion, explicitly invites any larger existing requirement draft if available, identifies gaps and ambiguities, drafts and revises the PRD, and updates the document until it is ready. It should conclude each interaction turn with the clearest next step. It may briefly signal that work is proceeding under Shape when entering workflow mode or when that orientation materially helps, but should avoid repetitive reminder phrasing on every exchange.

**User**  
Provides product intent, optionally provides existing requirement material, answers clarification questions, reviews the draft, and marks the PRD as ready.

---

#### 3. Create Technical Concept
**Description**  
Draft and iteratively refine the Technical Concept from the ready PRD until it is ready for implementation.

**Responsible role**  
Architect

**AI Agent**  
Validates the PRD as input, explicitly invites any larger existing technical draft if available, analyzes the codebase and repository guidance, aligns the proposed design with repository structure and local architectural patterns, drafts and revises the Technical Concept, and updates the document until it is ready. It should conclude each interaction turn with the clearest next step.

**User**  
Provides technical guidance and constraints, optionally provides existing technical design material, reviews design decisions, and marks the Technical Concept as ready.

---

#### 4. Initiate Implementation
**Description**  
Create the initial Implementation Plan from the ready PRD and Technical Concept and prepare execution to begin.

**Responsible role**  
Architect

**AI Agent**  
Validates that PRD and Technical Concept are ready, proposes the initial Implementation Plan structure and initial slices, checks that slices are shaped for fresh-session execution, and creates the document.

**User**  
Reviews the proposed implementation structure, adjusts it if needed, and marks the Implementation Plan as ready.

---

#### 5. Prepare Slice
**Description**  
Expand a selected implementation slice into executable implementation tasks while keeping the slice within practical agent context limits.

**Responsible role**  
Developer

**AI Agent**  
In a fresh session, resolves the active feature through Pick Up Feature unless already clearly active, proposes a task breakdown for the selected slice, checks that the slice remains suitable for execution in a fresh agent session, updates the Implementation Plan if the proposal is accepted, and indicates the next likely step.

**User**  
Selects the slice, reviews and adjusts the proposed tasks, and confirms updating the Implementation Plan.

---

#### 6. Implement Batch
**Description**  
Execute a selected batch of implementation tasks in code and prepare the result for developer review.

**Responsible role**  
Developer

**AI Agent**  
Implements the selected tasks, keeps within batch scope, summarizes what changed, and explicitly asks the Developer for **review** and **approval**. It should not treat implementation completion as batch approval.

**User**  
Selects the tasks for the batch and provides any execution constraints or corrections.

---

#### 7. Review Batch
**Description**  
Validate that the implemented batch matches the selected tasks and intended slice outcome.

**Responsible role**  
Developer

**AI Agent**  
Summarizes what changed, explains how the batch maps to the selected tasks, highlights notable decisions or risks, supports iterative adjustment requests, records implementation decisions when asked, marks tasks as done only after explicit Developer approval, clearly distinguishes between “awaiting review,” “awaiting approval,” and “approved but awaiting commit,” and indicates whether the batch is ready to commit.

**User**  
Reviews the diff and explanation, requests adjustments if needed, validates correctness and scope, decides whether the batch is approved, and lets the AI Agent update the Implementation Plan accordingly.

---

#### 8. Commit Batch
**Description**  
Persist an approved implementation batch as an explicit repository checkpoint.

**Responsible role**  
Developer

**AI Agent**  
Proposes a commit message if needed, identifies the reviewed and approved batch boundary to be committed, and confirms the next likely step after commit. This commit is the normal required boundary before any subsequent batch begins.

**User**  
Confirms the batch has been approved and creates the commit.

---

#### 9. Record Implementation Decision
**Description**  
Record an implementation-time decision or clarification that should remain visible during execution.

**Responsible role**  
Developer

**AI Agent**  
Identifies decisions worth recording, proposes a concise entry for the Implementation Plan, and inserts it if accepted.

**User**  
Reviews the proposed decision record, adjusts it if needed, and confirms storing it in the Implementation Plan.

---

#### 10. Update PRD
**Description**  
Add a new PRD Specification Update or continue refining an existing draft PRD update until it remains `draft` or is marked `ready`.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Summarizes the issue, proposes the Specification Update content in append-only form, and updates the relevant PRD update entry.

**User**  
Confirms that the issue should be formalized, adjusts the proposal if needed, and decides whether the result remains `draft` or becomes `ready`.

---

#### 11. Update Technical Concept
**Description**  
Add a new Technical Concept Specification Update or continue refining an existing draft Technical Concept update until it remains `draft` or is marked `ready`.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Summarizes the issue, proposes the Specification Update content in append-only form, aligns the update with repository guidance and local architectural patterns when relevant, and updates the relevant Technical Concept update entry.

**User**  
Confirms that the issue should be formalized, adjusts the proposal if needed, and decides whether the result remains `draft` or becomes `ready`.

---

#### 12. Finish Slice
**Description**  
Validate that a slice is complete and mark it as done in the Implementation Plan.

**Responsible role**  
Developer

**AI Agent**  
Summarizes completed tasks and resulting functionality, confirms whether the slice is complete within its intended boundary, and updates the slice state if the developer confirms completion. It should treat committed approved batches as the expected precondition for closing the slice.

**User**  
Reviews the implemented slice outcome, validates that the slice goal has been met, and confirms marking the slice complete.

---

#### 13. Finish Implementation
**Description**  
Conclude implementation by verifying completion state, repository readiness, and final Implementation Plan status.

**Responsible role**  
Developer

**AI Agent**  
Checks that all slices are marked complete, confirms the Implementation Plan reflects execution state, checks for unresolved draft updates, proposes final status updates, and indicates completion clearly.

**User**  
Verifies repository cleanliness and completion readiness, then confirms marking the Implementation Plan as done.

---

### 9.2 Supporting Operations

#### 14. Pick Up Feature
**Description**  
Select the feature to work on and make it the active local Shape context.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Resolves candidate feature folders, sets the selected feature as active in local Shape state, confirms the resolved workspace, and indicates the most likely next step based on current workflow state. When a single in-progress feature is the obvious candidate, the agent should resolve it with minimal friction, preferably through a short confirmation rather than a heavy selection ritual.

**User**  
Identifies or chooses the feature to work on and confirms the selection if needed.

---

#### 15. Show Status
**Description**  
Display the current Shape configuration, active feature context, resolved artifacts, structural warnings, and likely next actions.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Reads Shape configuration and local state, resolves the active feature and core artifacts, reports current statuses and missing prerequisites, surfaces repository readiness state, and suggests the next likely workflow step.

**User**  
Requests the current workflow state and uses the result to decide what to do next.

---

#### 16. Show Capabilities
**Description**  
Display the currently supported Shape operations or skills in a user-friendly form so that the workflow is easy to operate without memorization.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Lists the relevant operations or skills, groups them by stage when useful, and indicates which ones are currently most relevant given the active workflow state.

**User**  
Requests guidance on what Shape can do and uses the result to choose the next action.

---

### 9.3 Notes on Change Handling

Shape keeps change handling intentionally small:

- Specification Updates are append-only
- Specification Update status is limited to `draft | ready`
- Only ready updates are considered effective
- Downstream propagation is handled explicitly when relevant
- Shape does not require formal lineage tracking between related updates across artifacts

This keeps the mechanism understandable while still making late changes visible and controlled.

---

## 10. Skill Inventory

This section defines the initial set of skills supporting the core operations of Shape.

Skills are listed here as a **capability inventory only**. This document does **not** define full skill contents or embed skill files. Each skill will be implemented separately in its own file.

For Shape v1, each skill should be described in this document using only:

- **Skill name**
- **Purpose**
- **Triggers on**
- **Outcome**

Skills should be named consistently as short imperative verb phrases and should align with workflow operations and artifact boundaries.

The inventory should also be easy to surface to the user on demand. Shape assumes that capability discoverability is essential for practical adoption.

---

### 10.1 Core Skills

- **initiate feature**
  - **Purpose:** create the initial feature workspace according to Shape repository conventions
  - **Triggers on:** request to start a new feature
  - **Outcome:** feature folder and core artifact files exist for the new feature

- **pick up feature**
  - **Purpose:** resolve and select an existing feature as the active Shape context
  - **Triggers on:** request to work on an existing feature
  - **Outcome:** active feature context is set to the selected feature

- **show status**
  - **Purpose:** display the current Shape context, resolved artifacts, statuses, structural warnings, and likely next step
  - **Triggers on:** request to inspect current workflow state
  - **Outcome:** current workflow state is visible to the user

- **show capabilities**
  - **Purpose:** display supported Shape operations or skills in a user-friendly way
  - **Triggers on:** request to see what Shape can currently do
  - **Outcome:** user can understand available workflow actions without memorizing internal operation names

- **create prd**
  - **Purpose:** create or refine the PRD baseline until it reaches a usable state
  - **Triggers on:** request to start or continue PRD definition
  - **Outcome:** PRD exists in `draft` or `ready` state

- **update prd**
  - **Purpose:** add a new PRD Specification Update or continue refining an existing draft PRD update until it remains `draft` or is marked `ready`
  - **Triggers on:** request to record, continue, or finalize a requirement-level change, correction, or newly discovered information
  - **Outcome:** PRD contains a newly added or updated Specification Update in `draft` or `ready` state

- **create technical concept**
  - **Purpose:** create or refine the Technical Concept baseline from the PRD, codebase, repository guidance, and technical context
  - **Triggers on:** request to start or continue technical design
  - **Outcome:** Technical Concept exists in `draft` or `ready` state

- **update technical concept**
  - **Purpose:** add a new Technical Concept Specification Update or continue refining an existing draft Technical Concept update until it remains `draft` or is marked `ready`
  - **Triggers on:** request to record, continue, or finalize a design-level change, correction, or newly discovered information
  - **Outcome:** Technical Concept contains a newly added or updated Specification Update in `draft` or `ready` state

- **initiate implementation**
  - **Purpose:** create the initial Implementation Plan from the ready PRD and Technical Concept
  - **Triggers on:** request to begin implementation planning
  - **Outcome:** Implementation Plan exists with initial slices and is ready for execution

- **prepare slice**
  - **Purpose:** expand a selected implementation slice into executable implementation tasks while keeping the slice within practical agent context limits and suitable for fresh-session execution
  - **Triggers on:** request to refine a slice for execution
  - **Outcome:** selected slice has implementation tasks added to the Implementation Plan

- **implement batch**
  - **Purpose:** execute a selected batch of implementation tasks in code and hand the result off for Developer **review** and **approval**
  - **Triggers on:** request to implement one or more selected implementation tasks
  - **Outcome:** code changes exist for the selected batch and are ready for review

- **review batch**
  - **Purpose:** summarize and inspect the implemented batch against the selected tasks while preserving Developer-led **review** and **approval**
  - **Triggers on:** request to review completed batch work
  - **Outcome:** implemented batch is visible and understandable for Developer review, and tasks can be marked done by the AI Agent once the batch is explicitly approved

- **commit batch**
  - **Purpose:** persist an accepted implementation batch as a repository checkpoint
  - **Triggers on:** request to commit reviewed batch changes
  - **Outcome:** accepted batch is committed to the repository

- **record implementation decision**
  - **Purpose:** capture an implementation-time decision in the Implementation Plan
  - **Triggers on:** request to document a relevant implementation clarification or trade-off
  - **Outcome:** Implementation Plan contains the recorded decision

- **finish slice**
  - **Purpose:** validate a completed slice and mark it as done
  - **Triggers on:** request to close a slice whose tasks are completed
  - **Outcome:** selected slice is marked as done in the Implementation Plan

- **finish implementation**
  - **Purpose:** conclude implementation after all slices are completed and validated
  - **Triggers on:** request to finalize feature implementation
  - **Outcome:** Implementation Plan is marked as `done`

---

### 10.2 Inventory Notes

- Skills should remain aligned with workflow operations, not with arbitrary prompt phrasing.
- Skills should operate on explicit artifacts and repository state.
- Skills should respect Shape document lifecycle rules, including append-only updates for PRD and Technical Concept.
- `show capabilities` should make the workflow easier to use by surfacing current possibilities in plain language.
- `create prd` and `create technical concept` should explicitly support both large initial draft input and incremental question-driven refinement.
- `create technical concept` should explicitly use repository guidance and local architectural conventions as inputs to design work.
- `update prd` and `update technical concept` should clearly support both creating a new update and continuing an existing draft update.
- Shape strongly prefers at most one draft Specification Update per target document at a time. Multiple concurrent draft updates in the same document are discouraged because they increase ambiguity and drift risk. Skills should warn about this situation and prefer continuing an existing draft, but should not assume they can fully prevent manual divergence.
- `prepare slice` should explicitly account for practical agent context limits.
- `prepare slice` and `initiate implementation` should both reinforce that each new Slice should normally begin in a fresh agent session.
- `prepare slice` should normally begin a fresh execution session by resolving the active feature through `pick up feature`, unless the active feature is already unambiguous.
- `implement batch` and `review batch` should preserve batch sizes that remain reviewable by a developer in one focused step.
- `review batch` should support Developer-led review and approval, not replace them.
- `commit batch` should be treated as the normal required boundary after approval and before the next batch begins.
- Workflow-mode reminder phrasing should be used selectively for orientation, not repeated mechanically on every exchange.
- Skills should normally end by indicating the most likely next valid workflow action.

- This section defines only the inventory and intent of skills.
- Full skill behavior, prompts, validations, and file formats belong in separate skill files.

---

## 11. Repository Readiness for Agent-Assisted Delivery

Shape assumes that artifact quality alone is not sufficient to ensure high-quality agent-assisted delivery. The surrounding repository context also matters.

Even with a strong PRD, Technical Concept, and Implementation Plan, a coding agent will produce less reliable results if the repository does not clearly communicate how code should be written, validated, and organized.

This section defines what Shape expects from the repository environment, how missing guidance affects delivery quality, and how Shape skills should behave when repository readiness is incomplete.

---

### 11.1 Purpose

The purpose of repository readiness guidance is to improve:

- implementation consistency
- alignment with local repository conventions
- architectural correctness
- validation reliability
- predictability of agent output
- overall delivery quality

Shape does not require a specific coding agent vendor or a single mandatory instruction filename. Instead, it expects that the repository provides sufficient agent-facing guidance in a form that the coding agent can reliably consume.

Examples of such files may include:

- `AGENTS.md`
- `CLAUDE.md`
- `GEMINI.md`
- other repository-level agent instruction files
- contributor or engineering guidance documents referenced from agent-facing instructions

The important requirement is not the exact filename, but the presence of clear, accessible, repository-specific guidance.

---

### 11.2 Expected Repository Guidance

Shape strongly prefers that the repository provides agent-facing guidance covering the following areas.

#### Repository structure
The agent should be able to understand:

- how the repository is organized
- where major code areas live
- where documentation artifacts live
- where Shape feature folders are expected to be created
- whether there are important monorepo boundaries or ownership boundaries

#### Development and validation commands
The agent should be able to understand:

- how to install dependencies
- how to run relevant tests
- how to run linting
- how to run formatting
- how to build the project
- how to validate changes before review

#### Code style and local conventions
The agent should be able to understand:

- formatting expectations
- naming conventions
- file organization preferences
- local patterns that should be followed
- conventions that differ from generic framework defaults

#### Architectural constraints and preferred patterns
The agent should be able to understand:

- important architectural boundaries
- preferred implementation patterns
- forbidden or discouraged patterns
- how responsibilities are typically split
- which decisions should remain consistent across features

#### Delivery and workflow expectations
The agent should be able to understand:

- Shape artifact conventions
- where PRD, Technical Concept, and Implementation Plan files live
- how append-only updates are handled
- how implementation work is expected to proceed in slices and batches
- that each new Slice should normally begin in a fresh agent session
- that fresh execution sessions should normally begin by resolving the active feature unless it is already unambiguous
- that Slice sizing should account for practical agent context limits
- that Batch sizing should account for practical developer review limits
- that an approved batch should normally be committed before the next batch begins
- where the agent should be conservative and ask for confirmation

---

### 11.3 Readiness Levels

Shape should treat repository readiness as graded rather than binary.

#### Ready enough
The repository contains sufficient guidance for an agent to operate with acceptable consistency and predictability.

Typical characteristics:

- repository structure is understandable
- validation commands are available
- coding conventions are documented
- architectural direction is at least partially clear
- Shape artifact locations and workflow expectations are discoverable

This is the preferred operating condition.

#### Degraded
Some important guidance is missing, incomplete, outdated, or fragmented.

Typical characteristics:

- agent instructions exist but are partial
- some commands are missing or unclear
- architectural expectations are only partly documented
- local conventions must be inferred from code rather than stated explicitly

Work may still proceed, but results are likely to be:

- less consistent
- more error-prone
- less aligned with repository conventions
- more likely to require manual correction or rework

This condition should trigger a warning, but should not automatically block work.

#### High risk
Critical guidance is missing or too unclear for reliable agent-assisted delivery.

Typical characteristics:

- no usable agent-facing repository instructions
- no clear validation commands
- no understandable repository structure guidance
- no clear indication of local coding or architectural expectations

Work may still technically proceed, but the probability of low-quality, inconsistent, or misaligned output is materially higher.

This condition should trigger a strong warning and explicit user confirmation before continuing.

---

### 11.4 Non-Blocking but Explicit Policy

Shape does not assume it can fully prevent users from working in an underprepared repository.

Accordingly:

- missing repository guidance should not automatically block feature initiation
- Shape should inspect and report missing or weak guidance explicitly
- Shape should communicate likely consequences of proceeding without it
- Shape should ask for explicit confirmation before continuing in clearly degraded or high-risk conditions

Shape prefers transparent warnings over false guarantees of control.

This is intentional. A user may choose to proceed despite missing guidance, may modify files manually outside Shape, or may accept lower predictability for the sake of speed. The workflow should acknowledge that reality rather than pretending it can fully enforce repository discipline.

---

### 11.5 Expected Skill Behavior

This section should be operationalized primarily through the `initiate feature` skill and, where useful, through `show status`.

#### Initiate feature
When starting a feature, the skill should:

- inspect the repository for agent-facing guidance
- determine whether relevant guidance appears present, partial, or critically missing
- summarize the current readiness state
- identify the most important gaps
- explain that lower readiness reduces delivery quality and predictability
- ask whether the user wants to proceed if readiness is degraded or high risk

The skill should not hard-block feature creation solely because readiness is incomplete.

#### Show status
When requested, the skill should also be able to surface repository readiness information, including:

- whether agent-facing guidance appears present
- whether major gaps were previously detected
- whether the current repository state appears ready enough, degraded, or high risk for agent-assisted delivery

This keeps repository readiness visible beyond the initial feature setup.

#### Create Technical Concept
When drafting technical design, the skill should:

- explicitly use repository guidance and local architectural instructions as design inputs
- avoid proposing solutions that clearly conflict with established project patterns without calling this out
- mention important repository-alignment constraints when they materially shape the concept

This keeps architectural alignment visible as a central part of design work rather than as an implicit side effect.

---

### 11.6 Minimal Recommendation for Shape Repositories

For practical use, Shape strongly recommends that a repository provide at least:

- one agent-facing repository instruction file
- clear locations for Shape feature artifacts
- lint, test, build, and formatting commands
- key coding style expectations
- important architectural constraints and preferred implementation patterns

This is not intended as heavy process. It is the minimum repository context needed to reduce ambiguity and improve the quality of agent-assisted delivery.

---

### 11.7 Summary Principle

Shape assumes that coding agents perform best when repository expectations are explicit.

Good artifacts improve feature-level intent. Good repository guidance improves implementation-level consistency.

Both are needed for reliable agent-assisted delivery.