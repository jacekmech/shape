# Shape: AI-Assisted Software Development Workflow

This document outlines the core primitives and design elements required to structure the first version of an AI-assisted, artifact-driven software development workflow in a monorepo setup.

---

## 1. Overview and Principles

Shape is a lightweight software development workflow with clear roles, steps, and document-based handovers, using a **feature** as its atomic unit of work. It provides a minimal but sufficient set of primitives instructing an AI coding agent how to support users in creating feature specifications and working code.

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
  Development progresses through repeated refinement across all stages.

* **Discovery-Driven**  
  Learnings are fed back into PRD and Technical Concept through controlled updates.

* **Optimistically Concurrent**  
  Work proceeds without blocking; discrepancies are resolved asynchronously.

* **Traceable**  
  All changes are explicit, reviewable, and persisted.

Late changes are inherently expensive to coordinate. Shape keeps the mechanism for handling them small and explicit, but does not pretend the problem itself is lightweight. Its goal is not to eliminate the cost of late change, but to prevent silent drift across requirements, design, and implementation.

### Out of Scope

Shape focuses on the core artifact-driven workflow for delivering a feature within an already chosen branch and repository context. It does not define branching strategy or prescribe a specific coding agent vendor, integration mechanism, or mandatory agent instruction filename.

The following areas are intentionally out of scope for Shape:
- document review workflows
- pull request review workflows
- CI/CD design and automation
- testing beyond unit-test-oriented implementation support, including integration, end-to-end, load, and manual testing practices

Shape has been exercised primarily in greenfield development. It is not yet designed as a workflow for scaffolding-heavy setup, large-scale refactoring, or tech-debt cleanup.

---

## 2. Vocabulary

This section defines a precise and shared terminology for the system. The goal is to eliminate ambiguity so that both humans and AI operate consistently.

### Feature  
Atomic unit of work in the workflow. A feature represents a complete unit of functionality developed from ideation through design and implementation into working software.

### Stage  
A distinct phase of the workflow with a defined purpose and output. The core stages are: Product definition (PRD), Technical design (Technical Concept), and Implementation.

### Product Requirements Definition (PRD)  
Markdown document specifying functional and non-functional requirements for a feature.

### Technical Concept
Markdown document specifying technical design and initial implementation direction for a feature. It serves as the design baseline for implementation.

### Implementation Plan  
Markdown document driving feature execution. Its file is scaffolded during feature initiation and then filled in at implementation kickoff by breaking feature implementation into deliverable slices represented by Slice Plans. It continues to evolve during implementation by tracking slice status, task progress, and execution-relevant decisions.

### Slice Plan  
Planning artifact that breaks one slice implementation into executable implementation tasks. Slice Plans are defined in the Implementation Plan and may be added or adjusted during implementation. A Slice Plan defines the slice execution structure and tracks slice-level execution through task progress and final validation.

### Implementation Task  
Fine-grained unit of work derived from a Slice Plan. Typically involves a small, well-defined change (e.g., a few related modifications across code or configuration). Tasks are explicitly listed in the Implementation Plan.

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
Responsible for drafting artifacts, proposing updates, implementing selected task batches, and maintaining workflow artifacts under human guidance. The AI Agent accelerates development work, but does not replace human ownership of requirements, design, or implementation decisions. It should also keep workflow capabilities, current state, and next steps understandable to the user throughout execution. It should signal workflow mode when useful for orientation, especially when entering Shape-driven work, resuming in a fresh session, or when a workflow rule materially affects what happens next, but should avoid repetitive reminder phrasing on every exchange.

---

## 4. Feature Delivery Flow

This section defines how a **Feature** progresses from idea to implemented code through a sequence of stages.

The flow is:

- **Linear stage progression with non-blocking feedback**
- **Driven by document handovers**
- **Extended through append-only feedback loops**
- **Guided by explicit next steps and visible workflow state**

Each stage produces a well-defined artifact that becomes the input to the next stage. Stage entry still follows explicit readiness conditions for upstream artifacts; the non-blocking aspect applies to how later discoveries are captured and propagated through Specification Updates rather than forcing immediate stage rewrites or synchronous rollback.

---

### 4.1 PRD

**Summary**  
Transforms an initial feature idea into a structured **Product Requirements Definition (PRD)**.  
The AI Agent collaborates with the user to iteratively refine input until the document is complete, consistent, and approved for downstream use.

Shape should treat larger user-provided requirement input as a first-class starting point. In many cases, the user will already have a draft PRD, ticket text, notes, or a rough feature brief prepared outside the workflow. The AI Agent should explicitly invite such input before switching to narrower clarification questions.

**Role**  
Product Owner

**Input**  
Unstructured or semi-structured feature description, optionally including an existing draft PRD or larger requirement write-up.

**Output**  
PRD markdown document, structured according to a predefined template and **reviewed for completeness and clarity**.

**Completion Condition**  
PRD is approved for the feature scope to be handed over downstream.

**Feedback Loop**  
- **Inbound**  
  Specification Updates appended when gaps or inconsistencies are discovered in later stages
- **Outbound**  
  None

**Guidance to user**  
When a PRD interaction step finishes, the AI Agent should clearly indicate the most likely next step, typically continuing PRD refinement or marking the PRD as `approved` when appropriate. Workflow-mode reminders should be used only when they improve orientation, not as repetitive turn prefixes.

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
Technical Concept is approved for implementation planning to begin.

**Feedback Loop**  
- **Inbound**  
  Specification Updates appended when gaps or inconsistencies are discovered during later stages
- **Outbound**  
  May append Specification Updates to PRD when requirement-level issues are identified

**Guidance to user**  
When a Technical Concept interaction step finishes, the AI Agent should clearly indicate the most likely next step, typically continuing Technical Concept refinement, marking it `approved`, or initiating implementation planning.

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
- Updated Implementation Plan reflecting completed Slice Plans and Tasks

**Completion Condition**  
All Slice Plans are completed, validated, and reflected in both code and Implementation Plan.

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
  Stage progression still follows readiness-gated handoffs, but discrepancies discovered later do not force synchronous rework before execution can continue; they are handled through explicit Specification Updates and downstream propagation when relevant

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
  - `status: draft | approved`
  - `date: YYYY-MM-DD`

**Output**  
Version 1 of the document (baseline)

**Completion Condition**
- Document is explicitly reviewed and accepted by the responsible role
- Document status is set to `approved`
- Document is considered stable for downstream use

---

### 5.2 Baseline Immutability

**Summary**  
Once approved, the baseline PRD or Technical Concept is **not modified directly**.

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
- Status: `draft | approved`
- Date
- Context
- Change / decision
- Impact

**Rules**
- Updates are appended in chronological order
- Existing approved Updates are not modified
- Updates do not rewrite baseline content; they extend it
- Only **approved** Updates are considered effective for downstream work

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
- Implementation Plan is updated inline; Slice Plan definition and planning content may be edited only while a Slice Plan is `draft`, or while an `approved` Slice Plan has not yet started execution
- Execution-progress content for a Slice Plan is reflected through task completion and batch state while the Slice Plan remains `approved`
- New Slice Plans may be added during implementation

**Characteristics**
- Non-blocking
- Explicit
- Traceable
- Lightweight by default, but capable of handling late changes when needed

---

## 6. Implementation Lifecycle

This section defines how a feature is executed using **Slice Plans, Tasks, and Batches**.

Execution follows a **developer-controlled, iterative microcycle**:

**Slice Plan → Tasks → Batch → Review → Commit**

The **Implementation Plan** is the central control artifact throughout this process: it defines the feature implementation breakdown into deliverable slices and tracks feature-level execution.

Shape tracks **Implementation Plan status** and **Slice Plan status** separately.
The plan status describes the overall execution artifact for the feature.
Each Slice Plan defines the slice implementation breakdown into Tasks and has its own artifact state. Active slice execution progress is inferred from Tasks and Batches rather than represented as a separate artifact status.

A new slice should begin in a **fresh agent session**. This is a critical Shape discipline, not just a convenience recommendation. It exists to preserve deliberate context curation, reduce carryover noise, and improve output quality. Slices should therefore be small enough to fit within practical agent context limits without depending on long-running conversational carryover. Batches should be selected to preserve high-quality developer reviewability, not just execution speed.

A fresh session should normally begin by resolving the active feature context through **Pick Up Feature**, an agent-supported feature selection operation, unless the active feature is already unambiguous and can be confirmed with minimal friction.

**Slice Plan lifecycle**
- `draft`
  Slice Plan exists in the Implementation Plan but has not yet been planned in enough detail for execution.
- `approved`
  Slice Plan has been planned through **Plan Slice** and is ready for execution.
- `done`
  Slice Plan has been explicitly validated and closed through **Finish Slice**.

**Slice Plan transition rules**
- **Plan Implementation** creates initial Slice Plans in `draft`
- **Plan Slice** transitions the selected Slice Plan from `draft` to `approved`
- **Implement Batch** marks approved Tasks done; the Slice Plan remains `approved` while execution is underway
- **Finish Slice** transitions a validated `approved` Slice Plan to `done`

Task checkboxes track task completion.
Slice Plan status tracks artifact lifecycle.
These are related, but they are not the same mechanism.

---

### 6.1 Initialization

**Summary**  
Implementation begins by filling in the scaffolded Implementation Plan from the approved PRD and Technical Concept.

**State**
- PRD status is `approved`
- Technical Concept status is `approved`
- Implementation Plan is created with its status updated to `approved`
- Initial Slice Plans are defined in `draft` to represent the feature implementation breakdown into deliverable slices
- Tasks are not yet specified
- No execution has occurred

---

### 6.2 Slice Refinement

**Summary**  
A selected slice is broken into **Implementation Tasks** in its Slice Plan.

**Process**
- In a fresh session, the active feature is first resolved through **Pick Up Feature** unless already clearly active
- Developer selects a `draft` Slice Plan, defaulting to the next unfinished one
- AI Agent proposes a breakdown into Tasks
- Developer reviews and requests adjustment if needed
- Tasks are added to the Implementation Plan
- Slice scope is checked against practical agent context limits
- Selected Slice Plan status changes from `draft` to `approved`

**Output**
- `approved` Slice Plan with a defined set of Implementation Tasks

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
- AI Agent may update the **Relevant Files** and **Important Decisions** sections of the Implementation Plan during implementation so that the working execution context stays current as code changes are made

**Constraints**
- AI Agent operates strictly within Batch scope
- AI Agent does not select or reorder Tasks

**Guidance to user**  
When a batch finishes implementing, the AI Agent should clearly ask the Developer for **review** and **approval**, explicitly stating that the next step is to inspect the diff, request any needed adjustments, and then either approve or reiterate.

---

### 6.5 Review, Approval, and Commit

**Summary**  
The Developer validates the result of the Batch as part of the same **Implement Batch** operation.

This is a developer-led review step centered on the diff and intended batch outcome. The Developer may request adjustments, ask for clarifications, record implementation decisions, or even adjust upcoming slice structure before approving the batch. These actions should occur through prompting the AI Agent rather than by directly editing workflow artifacts outside Shape.

Approval and commit form a single normal progression boundary. Once a batch is approved, it should be committed before any subsequent batch begins so that the next review starts from a clean diff boundary.

**Process**
- Developer reviews code diff
- Developer verifies alignment with selected Tasks and slice intent
- Developer may request one or more adjustment iterations
- Developer may ask the AI Agent to record relevant implementation decisions or relevant files
- Developer may reshape future tasking or slice boundaries if implementation reveals a better plan
- Once satisfied, the Developer explicitly confirms the batch is approved
- After approval, the AI Agent marks relevant tasks as completed in the Implementation Plan so that the workflow continues to minimize direct document editing by the Developer
- Completed tasks under an approved Slice Plan show that execution is underway
- Slice Plan and Implementation Plan artifact statuses do not change during batch implementation
- Developer commits or asks the agent to commit the approved batch before the next batch begins

**Outcome**
- Relevant tasks are marked done by the AI Agent in the Implementation Plan
- Slice Plan state remains `approved` until explicit validation closes it as `done`
- Approved and committed changes become part of the codebase
- Batch is finalized

**Notes on agent-assisted review**
- Same-session review by the implementing AI Agent may be useful for summarization, task-to-diff mapping, and obvious risk surfacing
- It should not be treated as a strong independent quality signal
- A separate review-oriented session may provide additional value by examining the diff with fresher context, but this remains supportive rather than authoritative
- Human developer validation remains the trusted approval boundary

**Guidance to user**  
When review support is provided, the AI Agent should clearly state whether the batch is awaiting **review**, under **review / iteration**, awaiting **approval**, approved but still awaiting commit, or fully ready for the next step.

---

### 6.6 Slice Validation

**Summary**  
After all Tasks within a Slice Plan are completed and their approved batches have been committed, the Slice Plan is validated.

**Process**
- Developer verifies that slice objectives are met
- Functional and technical expectations are confirmed
- Slice implementation is confirmed as complete within the intended session-sized boundary
- Developer may confirm that the **Relevant Files** section still reflects the files and directories most useful for subsequent slices; the AI Agent should prune or refresh entries when slice completion changes what is worth carrying forward
- Developer may confirm that the **Important Decisions** section still reflects the changes introduced in the implementation step for subsequent Slice Plans
- Slice Plan status changes from `approved` to `done` only after explicit Developer confirmation

**Output**
- Slice Plan marked `done` in the Implementation Plan

---

### 6.7 Iteration

**Summary**  
The process repeats for the next slice until all Slice Plans are `done`.

**Rule**
- Each new slice should begin in a fresh agent session
- Each fresh execution session should normally begin with Pick Up Feature unless the active feature can be resolved with minimal friction
- No new batch should begin until the previous approved batch has been committed
- This should be treated as a core execution-quality rule, not as optional workflow polish

---

### 6.8 Completion

**Summary**  
Implementation ends when all Slice Plans are `done` and validated.

**Completion Condition**
- All Slice Plans marked `done`
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
- Implementation Plan is updated inline as a live document, including adding new Slice Plans, updating eligible `draft` Slice Plans or not-yet-started `approved` Slice Plans, and maintaining the **Relevant Files** section as a compact working file map for subsequent execution
- Downstream propagation is handled explicitly when relevant
- Approved updates do not silently reinterpret already executed work

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

In Shape, a feature is the primary unit of work. The repository layout should reflect that.

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

## 8. Documents Inventory & Templates

Shape uses three core documents:

- Product Requirements Definition (PRD)
- Technical Concept
- Implementation Plan

These documents define the baseline specification and execution structure for a feature.

The design document explains the **intent**, **role**, and **minimum expected structure** of each document.  
The full canonical templates live in:

- `/workflow-templates/prd-template.md`
- `/workflow-templates/technical-concept-template.md`
- `/workflow-templates/implementation-plan-template.md`

Those template files should be treated as the authoritative starting point when creating new feature documents.

Each document has a clear purpose, minimal structure, and a defined evolution model.

---

### General Rules (applies to all documents)

All Shape documents follow these principles:

- **Minimal and skimmable**  
  Structure is intentionally small. Content can expand inside sections as needed.

- **AI-assisted**  
  Documents are created and extended through AI-human collaboration.

- **Baseline + Updates (PRD, Technical Concept)**  
  PRD and Technical Concept are created as baseline documents, approved, and later extended only through **Specification Updates** using an append-only model.

- **Live document (Implementation Plan)**  
  The Implementation Plan evolves directly during execution and is not append-only.

- **Required status and date**  
  All documents and Specification Updates must include:
  - a document-type-specific `status`
  - `date: YYYY-MM-DD`

- **Status model by document type**
- PRD: `draft | approved`
- Technical Concept: `draft | approved`
- Implementation Plan: `draft | approved | done`

- **Status model for Slice Plans**
  - `draft | approved | done`

- **Status model for Specification Updates**
  - `draft | approved`

---

### 8.1 Product Requirements Definition (PRD)

#### Purpose

The PRD defines **what** is being built and **why**, from a product and user perspective.

It focuses on:
- user value
- expected behavior
- constraints

It avoids:
- technical design
- internal system structure

The full template is defined in:
- `/workflow-templates/prd-template.md`

#### Expected Structure

The PRD should contain:

- **Header**
  - Title
  - Status: `draft | approved`
  - Date

- **Goal**
  - Problem
  - User value
  - Expected outcome

- **Flow**
  - Main flow (happy path)
  - Key alternative / error paths
  - Final states

- **Requirements**
  - Functional requirements (observable behavior)
  - Business rules / constraints

- **Acceptance Criteria**
  - Conditions that must be met for the feature to be considered correct
  - Outcome-oriented and testable at a high level

- **UX Notes**
  - Inputs / interactions
  - Feedback (success / error)
  - Optional link to detailed UX

- **Non-Functional Requirements**
  - Performance / latency
  - Reliability
  - Dependencies (if product-relevant)

- **Notes**
  - Assumptions
  - Open questions
  - Optional / stretch ideas

- **Out of Scope**
  - Explicit exclusions
  - Known non-goals for this feature

- **Updates**
  - Append-only Specification Updates added after baseline readiness

Each PRD Update includes:
- Name
- Status: `draft | approved`
- Date
- Context
- Change / decision
- Impact

Only approved Updates are considered effective.

---

### 8.2 Technical Concept

#### Purpose

The Technical Concept defines **how** the feature will be built at design level.

It focuses on:
- architecture
- responsibilities
- interfaces
- constraints
- implementation direction
- alignment with repository-specific architectural guidance and local engineering conventions

It avoids:
- task-level planning
- code-level decisions unless architecturally relevant

The full template is defined in:
- `/workflow-templates/technical-concept-template.md`

#### Expected Structure

The Technical Concept should contain:

- **Header**
  - Title
  - Status: `draft | approved`
  - Date

- **Overview**
  - Technical summary
  - Key constraints
  - Core design principle

- **Repository Alignment**
  - Relevant repository guidance used during design
  - Important architectural or organizational constraints from agent-facing instructions
  - Local conventions or preferred patterns that materially shape the solution

- **Architecture**
  - Main components / units
  - Responsibility split
  - System boundaries

- **Flow**
  - End-to-end technical flow
  - Key processing steps

- **Interfaces**
  - External APIs / contracts
  - Key internal interfaces (if relevant)

- **Data & Validation**
  - Core data structures (high-level)
  - Validation rules
  - Error model

- **Frontend / Backend Notes**
  - Key frontend behavior (if relevant)
  - Backend responsibilities / orchestration

- **Testing Notes**
  - Integration testing expectations
  - Manual testing considerations
  - Performance / load testing considerations
  - Known risk areas requiring validation

- **Risks & Trade-offs**
  - Major risks
  - Important decisions

- **Notes**
  - Assumptions
  - Non-goals
  - Deferred decisions

- **Out of Scope**
  - Explicit technical exclusions
  - Known non-goals at design level

- **Updates**
  - Append-only Specification Updates added after baseline readiness

Each Technical Concept Update includes:
- Name
- Status: `draft | approved`
- Date
- Context
- Change / decision
- Impact

Only approved Updates are considered effective.

---

### 8.3 Implementation Plan

#### Purpose

The Implementation Plan controls **how the feature is executed**.

It focuses on:
- Slice Plans
- tasks
- progress
- decisions made during execution
- relevant files for upcoming execution context curation

This is a live document and is updated continuously during implementation.

The full template is defined in:
- `/workflow-templates/implementation-plan-template.md`

#### Expected Structure

The Implementation Plan should contain:

- **Header**
  - Title
  - Status: `draft | approved | done`
  - Date

- **Objective**
  - What is being delivered
  - Key constraints

- **Slice Plans**
  - High-level execution structure
  - Represented as explicit Slice Plan entries with their own status
  - New Slice Plans may be appended during implementation

  Each slice should remain small enough to fit within a single focused agent session, and each new slice should normally be executed in a fresh agent session. Fresh execution sessions should normally begin by resolving the active feature through **Pick Up Feature** unless the active feature is already unambiguous.

  Each Slice Plan uses this lifecycle:
  - `draft` when initially created during implementation planning
  - `approved` after slice planning is approved
  - `done` after the Slice Plan is explicitly validated and closed

- **Execution Order**
  - Central execution workspace
  - Structure:
    - Slice Plan
    - Implementation Tasks under the Slice Plan

  Rules:
  - Slice Plan entries in `## Execution Order` have their status indicated in parentheses after Slice Plan name
  - Implementation Tasks use checkboxes to indicate progress (`done / not done`)
  - Implementation Tasks are appended continuously during execution
  - Slice Plan definition and planning content should be changed only while the Slice Plan is `draft`, or while an `approved` Slice Plan has no completed tasks
  - Execution-progress content is reflected through task completion while the Slice Plan remains `approved`
  - Developer selects tasks for execution in batches (batches are not explicitly represented)
  - This is the only place where sequencing exists
  - Progress is reflected inline through task completion and Slice Plan status
  - Batches should remain small enough for a single high-quality developer review step
  - Tasks should be marked done only after developer approval of the implemented batch
  - An approved batch should be committed before the next batch begins so that review boundaries remain clean

- **Important Decisions**
  - Implementation-time decisions made during execution
  - Clarifications not worth updating Technical Concept
  - Trade-offs discovered during coding
  - Cross-slice implications

- **Relevant Files**
  - Curated working file map for upcoming execution
  - Maintained by the AI Agent during implementation
  - May include files or directories
  - Kept selective and compact
  - May be refreshed or pruned as slice-by-slice relevance changes
  - Not a full file inventory, task tracker, or historical changelog
  
- **Notes**
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

Specification change handling is intentionally explicit. Shape does not attempt to make late changes look cheap or effortless. Instead, it provides a small operational model for drafting and approving them without silently rewriting requirements, design, or execution state.

Shape also assumes that a workflow is easier to use when its capabilities are visible. Supporting operations should therefore make it possible to inspect current workflow state and available capabilities without requiring the user to memorize internal operation names.

---

### 9.1 Primary Workflow Operations

#### 1. Initiate Feature
**Description**  
Create the initial feature workspace and establish the feature as a concrete unit of work in the repository.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Proposes feature identifier and slug if needed, scaffolds the feature folder and core artifact files according to Shape conventions, and indicates the most likely next step after setup. This includes scaffolding an initial `03-implementation-plan.md` file from the default template, but it does not fill in execution content such as slices or tasks beyond that starting structure.

**User**  
Provides or approves the feature identity, confirms creation of the feature workspace, commits the changes or asks the Agent to commit.

**Ends with**  
**Feature workspace created and committed.**

---

#### 2. Create PRD
**Description**  
Draft and iteratively refine the Product Requirements Definition until it is approved for downstream use.

**Responsible role**  
Product Owner

**AI Agent**  
Guides the discussion, explicitly invites any larger existing requirement draft if available, identifies gaps and ambiguities, drafts and revises the PRD, and updates the document until it is approved. It should conclude each interaction turn with the clearest next step. It may briefly signal that work is proceeding under Shape when entering workflow mode or when that orientation materially helps, but should avoid repetitive reminder phrasing on every exchange. It must not mark the document as approved without explicit approval from the user. It must not move on to the next workflow operation without explicit approval from the user.

**User**  
Provides product intent, optionally provides existing requirement material, answers clarification questions, reviews the draft, approves the PRD, commits the changes or asks the Agent to commit.

**Ends with**  
**PRD approved and committed.**

---

#### 3. Create Technical Concept
**Description**  
Draft and iteratively refine the Technical Concept from the approved PRD until it is approved for implementation.

**Responsible role**  
Architect

**AI Agent**  
Validates the PRD as input, explicitly invites any larger existing technical draft if available, analyzes the codebase and repository guidance, aligns the proposed design with repository structure and local architectural patterns, drafts and revises the Technical Concept, and updates the document until it is approved. It should conclude each interaction turn with the clearest next step. It must not mark the document as approved without explicit approval from the user. It must not move on to the next workflow operation without explicit approval from the user.

**User**  
Provides technical guidance and constraints, optionally provides existing technical design material, reviews design decisions, approves the Technical Concept, commits the changes or asks the Agent to commit.

**Ends with**  
**Technical Concept approved and committed.**

---

#### 4. Plan Implementation
**Description**  
Fill in the scaffolded Implementation Plan from the approved PRD and Technical Concept and prepare execution to begin.

**Responsible role**  
Developer

**AI Agent**  
Validates that PRD and Technical Concept are approved, fills in the scaffolded Implementation Plan by proposing the initial execution structure and initial Slice Plans, checks that slices are shaped for fresh-session execution, and updates the document accordingly. It does not create implementation tasks, and initial Slice Plans are created in `draft`. It must not mark the Implementation Plan as approved without explicit approval from the user. It must not move on to the next workflow operation without explicit approval from the user.

**User**  
Reviews the proposed implementation structure, asks for adjustments if needed, approves the Implementation Plan as the execution baseline, commits the changes in the Implementation Plan or asks the agent to commit.

**Ends with**  
**Implementation Plan approved as the execution baseline and committed.**

---

#### 5. Plan Slice
**Description**  
Turn a selected implementation slice into a concrete, reviewable execution proposal and record the approved planning changes in the Implementation Plan.

**Responsible role**  
Developer

**AI Agent**  
In a fresh session, resolves the active feature through the **Pick Up Feature** operation unless already clearly active. For the selected Slice Plan, it:
- asks clarifying questions if needed
- proposes the **Implementation Tasks**
- proposes any **Important Decisions** that should be made before execution
- checks whether the Slice Plan is still sized appropriately for a focused execution session

Once the proposals are approved, it updates the Implementation Plan with the agreed Implementation Tasks and any agreed Important Decisions, and transitions the selected Slice Plan from `draft` to `approved`. It then indicates the next likely step. It does not proceed to implementation without explicit approval.

**User**  
Selects the Slice Plan, reviews the proposed tasks and decisions, iterates if needed, explicitly approves the planning changes to the Implementation Plan, commits the updates in the Implementation Plan or asks the agent to commit.

**Ends with**  
**Approved changes recorded in the Implementation Plan, the selected Slice Plan transitioned to `approved`, and the result committed.**

---

#### 6. Implement Batch
**Description**  
Execute an approved batch of implementation tasks through its full internal lifecycle: user input, agent execution, developer review and iteration, approval-driven plan updates, and commit.

**Responsible role**  
Developer

**AI Agent**  
Starts implementation **only after explicit Developer approval** for the selected batch. Within this single operation, it:
- accepts the selected task batch and any execution constraints from the Developer
- asks clarifying questions if needed
- implements the selected tasks in code
- stays within the approved batch scope
- updates the **Relevant Files** list in the Implementation Plan to reflect the resulting implementation state
- updates **Important Decisions** in the Implementation Plan when implementation introduces decisions worth preserving
- gives a **very brief summary** of what changed and explicitly asks the Developer to review the batch
- supports review iteration by explaining task-to-diff mapping, highlighting notable decisions, gaps, or risks, and applying requested adjustments
- marks tasks as done in the Implementation Plan **only after explicit Developer approval**
- leaves Slice Plan and Implementation Plan artifact statuses unchanged during batch implementation
- proposes a commit message or commit summary when useful
- creates the commit itself **only if explicitly asked by the Developer**

The AI Agent does **not** treat implementation completion as approval. It does **not** mark tasks as done until approval is explicit. It does **not** assume who performs the commit, but it does treat commit as part of completing the operation, and it does not move to the next batch or workflow operation without explicit approval.

**User**  
Selects the tasks for the batch, provides execution constraints or corrections, reviews the resulting diff, requests any needed iterations, explicitly approves the batch when satisfied, and then commits the approved batch directly or asks the Agent to create the commit.

**Ends with**  
**Selected batch carried through implementation, developer review, approval-driven plan updates, and commit.**

---

#### 7. Finish Slice
**Description**  
Validate that an `approved` Slice Plan is complete and transition it to `done` in the Implementation Plan.

**Responsible role**  
Developer

**AI Agent**  
Summarizes completed tasks and resulting functionality, confirms whether the Slice Plan is complete within its intended boundary, and updates the Slice Plan state only if the Developer explicitly confirms completion. It should treat committed approved batches as the expected precondition for closing the Slice Plan. It must not mark the Slice Plan `done` without explicit Developer approval.

**User**  
Reviews the implemented slice outcome, validates that the slice goal has been met, confirms transitioning the Slice Plan from `approved` to `done`, commits the updated Implementation Plan or asks the agent to commit.

**Ends with**  
**Slice Plan validated as complete, transitioned to `done` in the Implementation Plan, and committed.**

---

#### 8. Update PRD
**Description**  
Add a new PRD Specification Update or continue refining an existing draft PRD update until it remains `draft` or is marked `approved`.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Summarizes the issue, proposes the Specification Update content in append-only form, and updates the relevant PRD update entry.

**User**  
Confirms that the issue should be formalized, adjusts the proposal if needed, decides whether the result remains `draft` or becomes `approved`, commits the changes or asks the Agent to commit.

**Ends with**  
**PRD Specification Update recorded with its selected status and committed.**

---

#### 9. Update Technical Concept
**Description**  
Add a new Technical Concept Specification Update or continue refining an existing draft Technical Concept update until it remains `draft` or is marked `approved`.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Summarizes the issue, proposes the Specification Update content in append-only form, aligns the update with repository guidance and local architectural patterns when relevant, and updates the relevant Technical Concept update entry.

**User**  
Confirms that the issue should be formalized, adjusts the proposal if needed, decides whether the result remains `draft` or becomes `approved`, commits the changes or asks the Agent to commit.

**Ends with**  
**Technical Concept Specification Update recorded with its selected status and committed.**

---

#### 10. Update Implementation Plan
**Description**  
Apply relevant approved updates from the PRD and/or Technical Concept to the Implementation Plan.

**Responsible role**  
Developer

**AI Agent**  
Identifies which approved PRD or Technical Concept updates affect execution planning, summarizes their implementation impact, and proposes corresponding inline changes to the Implementation Plan. It may add new Slice Plans or update existing `draft` Slice Plans or not-yet-started `approved` Slice Plans, but does not modify already-started `approved` Slice Plans, `done` Slice Plans, or any Implementation Tasks.

**User**  
Confirms that the specification updates should be reflected in the Implementation Plan, reviews the proposed planning changes, adjusts them if needed, approves updating the document, commits the changes or asks the Agent to commit.

**Ends with**  
**Implementation Plan updated to reflect approved specification changes and committed.**

---

#### 11. Finish Feature
**Description**  
Conclude implementation by verifying completion state, repository cleanliness, and final Implementation Plan status.

**Responsible role**  
Developer

**AI Agent**  
Checks that all Slice Plans are marked `done`, confirms the Implementation Plan reflects execution state, treats the Implementation Plan as the canonical feature-completion artifact, checks for unresolved draft updates, proposes final status updates, clears local workspace state so `activeFeature` becomes `null`, and indicates completion clearly.

**User**  
Verifies repository cleanliness and completion state, confirms marking the Implementation Plan as done, commits the change or asks the Agent to commit.

**Ends with**  
**Implementation Plan marked as done, active workspace feature cleared, repository confirmed clean, and completion committed.**

---

### 9.2 Supporting Operations

#### 12. Pick Up Feature
**Description**  
Select the feature to work on and make it the active local Shape context.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Resolves candidate feature folders, sets the selected feature as active in local Shape state, confirms the resolved workspace, and indicates the most likely next step based on current workflow state. When a single in-progress feature is the obvious candidate, the agent should resolve it with minimal friction, preferably through a short confirmation rather than a heavy selection ritual.

**User**  
Identifies or chooses the feature to work on and confirms the selection if needed.

---

#### 13. Show Status
**Description**  
Display the current Shape configuration, active feature context, resolved artifacts, structural warnings, and likely next actions.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Reads Shape configuration and local state, resolves the active feature and core artifacts, reports current statuses and missing prerequisites, and suggests the next likely workflow step.

**User**  
Requests the current workflow state and uses the result to decide what to do next.

---

#### 14. Show Capabilities
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
- Specification Update status is limited to `draft | approved`
- Only approved updates are considered effective
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
  - **Outcome:** feature folder and core artifact files exist for the new feature and the workspace is ready for use

- **create prd**
  - **Purpose:** draft and iteratively refine the PRD baseline until it is approved
  - **Triggers on:** request to start or continue PRD definition
  - **Outcome:** PRD is updated and can reach `approved` state for downstream use

- **create technical concept**
  - **Purpose:** draft and iteratively refine the Technical Concept baseline from the approved PRD, codebase, repository guidance, and technical context until it is approved
  - **Triggers on:** request to start or continue technical design
  - **Outcome:** Technical Concept is updated and can reach `approved` state for implementation use

- **plan implementation**
  - **Purpose:** create the initial Implementation Plan from the approved PRD and Technical Concept and prepare execution to begin
  - **Triggers on:** request to begin implementation planning
  - **Outcome:** Implementation Plan exists with initial Slice Plans and can reach `approved` state as the execution baseline

- **plan slice**
  - **Purpose:** turn a selected Slice Plan into a concrete, reviewable execution proposal by defining Implementation Tasks and recording any agreed Important Decisions
  - **Triggers on:** request to refine a Slice Plan for execution
  - **Outcome:** approved planning changes are recorded in the Implementation Plan and the selected Slice Plan can move from `draft` to `approved`

- **implement batch**
  - **Purpose:** execute an approved batch of implementation tasks through its full internal lifecycle of input, execution, review and iteration, approval-driven plan updates, and commit
  - **Triggers on:** request to implement one or more approved implementation tasks
  - **Outcome:** the selected batch can move through execution, developer review, revision, approval, task completion updates, and commit without splitting into separate workflow operations or crossing approval or commit consent boundaries implicitly

- **finish slice**
  - **Purpose:** validate that an `approved` Slice Plan is complete and transition it to `done` in the Implementation Plan
  - **Triggers on:** request to close a Slice Plan whose tasks have been completed through approved batches and any explicitly requested commits
  - **Outcome:** selected Slice Plan is transitioned to `done` in the Implementation Plan and can be committed as complete

- **update prd**
  - **Purpose:** add a new PRD Specification Update or continue refining an existing draft PRD update until it remains `draft` or is marked `approved`
  - **Triggers on:** request to record, continue, or finalize a requirement-level change, correction, or newly discovered information
  - **Outcome:** PRD contains a newly added or updated Specification Update in `draft` or `approved` state

- **update technical concept**
  - **Purpose:** add a new Technical Concept Specification Update or continue refining an existing draft Technical Concept update until it remains `draft` or is marked `approved`
  - **Triggers on:** request to record, continue, or finalize a design-level change, correction, or newly discovered information
  - **Outcome:** Technical Concept contains a newly added or updated Specification Update in `draft` or `approved` state

- **update implementation plan**
  - **Purpose:** apply relevant approved updates from the PRD and/or Technical Concept to the Implementation Plan
  - **Triggers on:** request to propagate approved specification updates into execution planning
  - **Outcome:** Implementation Plan is updated inline to reflect approved specification changes without changing already-started Slice Plans, `done` Slice Plans, or any Implementation Tasks

- **finish feature**
  - **Purpose:** conclude implementation by verifying completion state, repository cleanliness, and final Implementation Plan status
  - **Triggers on:** request to finalize feature implementation
  - **Outcome:** Implementation Plan can be marked as `done`, active workspace feature context can be cleared, and repository state can be confirmed clean and complete

### 10.2 Supporting Skills

- **pick up feature**
  - **Purpose:** resolve and select an existing feature as the active Shape context
  - **Triggers on:** request to work on an existing feature or continue work in a fresh session
  - **Outcome:** active feature context is set to the selected feature

- **show status**
  - **Purpose:** display the current Shape configuration, active feature context, resolved artifacts, structural warnings, and likely next actions
  - **Triggers on:** request to inspect current workflow state
  - **Outcome:** current workflow state is visible to the user

- **show capabilities**
  - **Purpose:** display supported Shape operations or skills in a user-friendly way
  - **Triggers on:** request to see what Shape can currently do
  - **Outcome:** user can understand available workflow actions without memorizing internal operation names

---

### 10.3 Inventory Notes

- Skills should remain aligned with workflow operations, not with arbitrary prompt phrasing.
- Skills should operate on explicit artifacts and repository state.
- Skills should respect Shape document lifecycle rules, including append-only updates for PRD and Technical Concept.
- `show capabilities` should make the workflow easier to use by surfacing current possibilities in plain language.
- `create prd` and `create technical concept` should explicitly support both large initial draft input and incremental question-driven refinement.
- `create technical concept` should explicitly use repository guidance and local architectural conventions as inputs to design work.
- `update prd` and `update technical concept` should clearly support both creating a new update and continuing an existing draft update.
- Shape strongly prefers at most one draft Specification Update per target document at a time. Multiple concurrent draft updates in the same document are discouraged because they increase ambiguity and drift risk. Skills should warn about this situation and prefer continuing an existing draft, but should not assume they can fully prevent manual divergence.
- `plan slice` should explicitly account for practical agent context limits.
- `plan slice` and `plan implementation` should both reinforce that each new slice should normally begin in a fresh agent session.
- `plan slice` should normally begin a fresh execution session by resolving the active feature through `pick up feature`, unless the active feature is already unambiguous.
- `implement batch` should preserve batch sizes that remain reviewable by a developer in one focused step.
- `implement batch` should support Developer-led review and approval, not replace them.
- `implement batch` should keep explicit approval and explicit commit consent as separate boundaries even when commit happens within the same skill flow.
- Workflow-mode reminder phrasing should be used selectively for orientation, not repeated mechanically on every exchange.
- Skills should normally end by indicating the most likely next valid workflow action.

- This section defines only the inventory and intent of skills.
- Full skill behavior, prompts, validations, and file formats belong in separate skill files.

---
