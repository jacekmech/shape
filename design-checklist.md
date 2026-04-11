# Shape: Codex-Based Artifact-Driven Software Delivery Workflow (v1)

This document outlines the core primitives and design elements required to structure the first version of an AI-assisted, artifact-driven software delivery workflow using Codex in a monorepo setup.

TODOs:
* branching strategy
* document reviews (most likely out out scope)
* PR reviews (most likely out out scope)
* CI/CD (most likely out out scope)
* automated and manual testing (except unit tests) (most likely out out scope)

---

## 1. Overview and Principles

Shape is a lightweight software delivery workflow with clear roles, steps, and document-based handovers, using a **feature** as its atomic unit of delivery. It provides a minimal but sufficient set of primitives instructing an AI coding agent how to support users in creating feature specifications and working code.

Shape structures and amplifies human intent. The quality of what gets delivered is bounded by the quality of the input provided. Clear thinking in — clear software out.

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
  AI produces specifications and code under direct specialist guidance.

* **Iterative**  
  Delivery progresses through repeated refinement across all stages.

* **Discovery-Driven**  
  Learnings are fed back into PRD and Technical Concept through controlled updates.

* **Optimistically Concurrent**  
  Work proceeds without blocking; discrepancies are resolved asynchronously.

* **Traceable**  
  All changes are explicit, reviewable, and persisted.

Late changes are inherently expensive to coordinate. Shape keeps the mechanism for handling them small and explicit, but does not pretend the problem itself is lightweight. Its goal is not to eliminate the cost of late change, but to prevent silent drift across requirements, design, and implementation.

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
Coarse-grained unit of delivery that can be reviewed, integrated, and validated independently. Slices are defined in the Implementation Plan and may be added or adjusted during implementation.

### Implementation Task  
Fine-grained unit of work derived from a Slice. Typically involves a small, well-defined change (e.g., a few related modifications across code or configuration). Tasks are explicitly listed in the Implementation Plan.

### Implementation Batch  
A selected group of Implementation Tasks executed in a single coding step by the AI Agent. Each batch is followed by developer-led diff review and concluded with a commit.

### Specification Update  
Append-only change record added to a PRD or Technical Concept after baseline acceptance. A Specification Update captures newly discovered information, decisions, or corrections without modifying the original baseline content.

---

## 3. Roles and Responsibilities

This section defines roles as **responsibility boundaries**. The workflow can be executed by a single person, but roles clarify responsibilities and allow scaling across specialists.

### Product Owner  
Responsible for feature definition. Provides input during the specification process and collaborates with the AI Agent to produce a structured PRD. Owns requirement-level correctness.

### Architect  
Responsible for technical design. Translates the PRD into a Technical Concept and supports requirement-to-design alignment when changes occur. Owns design-level correctness.

### Developer  
Responsible for execution. Creates and evolves the Implementation Plan, refines Slices into Implementation Tasks, selects Implementation Batches, reviews diffs, commits changes, and validates completed Slices. Owns implementation correctness and repository changes.

### AI Agent  
Responsible for drafting artifacts, proposing updates, implementing approved task batches, and maintaining workflow artifacts under human guidance and approval. The AI Agent accelerates delivery, but does not replace human ownership of requirements, design, or implementation decisions.

### External Review (Out of Scope)  
Formal reviews, approvals, and integration processes (e.g., pull requests, code reviews, deployment approvals) are critical for delivery but are not managed by Shape and remain part of the surrounding engineering environment.

---

## 4. Feature Delivery Flow

This section defines how a **Feature** progresses from idea to implemented code through a sequence of stages.

The flow is:

- **Linear but non-blocking**  
- **Driven by document handovers**  
- **Extended through append-only feedback loops**

Each stage produces a well-defined artifact that becomes the input to the next stage.

---

### 4.1 PRD

**Summary**  
Transforms an initial feature idea into a structured **Product Requirements Definition (PRD)**.  
The AI Agent collaborates with the user to iteratively refine input until the document is complete, consistent, and ready for downstream use.

**Role**  
Product Owner

**Input**  
Unstructured or semi-structured feature description.

**Output**  
PRD markdown document, structured according to a predefined template and **reviewed for completeness and clarity**.

**Completion Condition**  
PRD is accepted as ready for the feature scope to be handed over downstream.

**Feedback Loop**  
- **Inbound**  
  Specification Updates appended when gaps or inconsistencies are discovered in later stages  
- **Outbound**  
  None

---

### 4.2 Technical Concept

**Summary**  
Transforms the PRD into a **Technical Concept**, defining architecture, constraints, and implementation direction.

**Role**  
Architect

**Input**  
- PRD markdown document  
- Codebase  
- Optional technical notes (unstructured or semi-structured)

**Output**  
Technical Concept markdown document (design baseline)

**Completion Condition**  
Technical Concept is accepted as ready for implementation planning to begin.

**Feedback Loop**  
- **Inbound**  
  Specification Updates appended when gaps or inconsistencies are discovered during later stages  
- **Outbound**  
  May append Specification Updates to PRD when requirement-level issues are identified

---

### 4.3 Implementation

**Summary**  
Executes the feature based on the **PRD**, **Technical Concept**, and **Implementation Plan**.  
Implementation begins by creating the **Implementation Plan**, then incrementally refining Slices into **Implementation Tasks**, executing them in **Implementation Batches**, reviewing diffs, and committing changes.

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

---

### 4.4 Flow Characteristics

- **Document-Driven**  
  Each stage produces a persistent artifact used as input for subsequent stages

- **Append-Only Evolution**  
  Changes to PRD and Technical Concept are recorded as Specification Updates, preserving full traceability

- **Optimistically Concurrent**  
  Stages do not block each other; discrepancies are resolved asynchronously through explicit update handling

- **Traceable Execution**  
  Progression from PRD to code is fully reconstructable via documents, diffs, and commits

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

**Process**
- User provides initial input (unstructured or semi-structured)
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
- Status: `proposed | approved`
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
- Technical Concept may propose Specification Updates to:
  - PRD
- Implementation may propose Specification Updates to:
  - Technical Concept
  - PRD
- Specification Updates may also be proposed independently of the main stage flow
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
- Developer selects a Slice  
- AI Agent proposes a breakdown into Tasks  
- Developer reviews and adjusts if needed  
- Tasks are added to the Implementation Plan  
- Implementation Plan status changes from `ready` to `in progress` when active execution begins

**Output**
- Slice with a defined set of Implementation Tasks  

**Completion Condition**
- Tasks are sufficiently granular for execution  
- Slice scope is clear and bounded  

---

### 6.3 Batch Selection

**Summary**  
The Developer selects a subset of Implementation Tasks to execute as a **Batch**.

**Rules**
- Batch is explicitly defined by the Developer  
- Batch size is small and controlled (e.g., 1–3 Tasks)  
- Batch defines the scope of the next execution step  

---

### 6.4 Batch Execution

**Summary**  
The AI Agent executes the selected Batch.

**Process**
- AI Agent implements code changes required by the selected Tasks  
- AI Agent updates the Implementation Plan:
  - marks Tasks as completed  
  - records progress  

**Constraints**
- AI Agent operates strictly within Batch scope  
- AI Agent does not select or reorder Tasks  

---

### 6.5 Review and Commit

**Summary**  
The Developer validates the result of the Batch.

**Process**
- Developer reviews code diff  
- Developer verifies alignment with Tasks and Slice intent  
- Developer commits changes  

**Outcome**
- Accepted changes become part of the codebase  
- Batch is finalized  

---

### 6.6 Slice Validation

**Summary**  
After all Tasks within a Slice are completed, the Slice is validated.

**Process**
- Developer verifies that Slice objectives are met  
- Functional and technical expectations are confirmed  

**Output**
- Slice marked as completed in Implementation Plan  

---

### 6.7 Iteration

**Summary**  
The process repeats for the next Slice until all Slices are completed.

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
- Requirement-level issues may trigger proposed Specification Updates to PRD
- Design-level issues may trigger proposed Specification Updates to Technical Concept
- Implementation Plan is updated inline as a live document
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
  - `proposed | approved`

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
- Status: `proposed | approved`  
- Date  
- Context  
- Change / decision  
- Impact  

Only approved Updates are considered effective.

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
- Status: `proposed | approved`  
- Date  
- Context  
- Change / decision  
- Impact  

Only approved Updates are considered effective.

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

---

## 9. Workflow Operations

This section defines the core operations performed within Shape.

Operations are the **canonical actions of the workflow**. They describe what Shape must be able to do, independent of prompt wording or implementation details.

Shape distinguishes between:

- **Primary workflow operations** — actions that advance a feature through definition, design, and implementation
- **Supporting operations** — actions that establish or inspect local workflow context

Specification change handling is intentionally explicit. Shape does not attempt to make late changes look cheap or effortless. Instead, it provides a small operational model for proposing and approving them without silently rewriting requirements, design, or execution state.

---

### 9.1 Primary Workflow Operations

#### 1. Initiate Feature
**Description**  
Create the initial feature workspace and establish the feature as a deliverable unit in the repository.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Proposes feature identifier and slug if needed, and scaffolds the feature folder and core artifact files according to Shape conventions.

**User**  
Provides or approves the feature identity and confirms creation of the feature workspace.

---

#### 2. Create PRD
**Description**  
Draft and iteratively refine the Product Requirements Definition until it is ready for downstream use.

**Responsible role**  
Product Owner

**AI Agent**  
Guides the discussion, identifies gaps and ambiguities, drafts and revises the PRD, and updates the document until it is ready.

**User**  
Provides product intent, answers clarification questions, reviews the draft, and approves the PRD as ready.

---

#### 3. Create Technical Concept
**Description**  
Draft and iteratively refine the Technical Concept from the ready PRD until it is ready for implementation.

**Responsible role**  
Architect

**AI Agent**  
Validates the PRD as input, analyzes the codebase and constraints, drafts and revises the Technical Concept, and updates the document until it is ready.

**User**  
Provides technical guidance and constraints, reviews design decisions, and approves the Technical Concept as ready.

---

#### 4. Initiate Implementation
**Description**  
Create the initial Implementation Plan from the ready PRD and Technical Concept and prepare execution to begin.

**Responsible role**  
Architect

**AI Agent**  
Validates that PRD and Technical Concept are ready, proposes the initial Implementation Plan structure and initial slices, and creates the document.

**User**  
Reviews the proposed implementation structure, adjusts it if needed, and approves the Implementation Plan as ready.

---

#### 5. Prepare Slice
**Description**  
Expand a selected implementation slice into executable implementation tasks.

**Responsible role**  
Developer

**AI Agent**  
Proposes a task breakdown for the selected slice and updates the Implementation Plan if the proposal is approved.

**User**  
Selects the slice, reviews and adjusts the proposed tasks, and approves updating the Implementation Plan.

---

#### 6. Implement Batch
**Description**  
Execute a selected batch of implementation tasks in code and reflect completed work in the Implementation Plan.

**Responsible role**  
Developer

**AI Agent**  
Implements the selected tasks, keeps within batch scope, and updates task progress in the Implementation Plan.

**User**  
Selects the tasks for the batch and provides any execution constraints or corrections.

---

#### 7. Review Batch
**Description**  
Validate that the implemented batch matches the selected tasks and intended slice outcome.

**Responsible role**  
Developer

**AI Agent**  
Summarizes what changed, explains how the batch maps to the selected tasks, and highlights notable decisions or risks.

**User**  
Reviews the diff and explanation, validates correctness and scope, and decides whether the batch is accepted or requires changes.

---

#### 8. Commit Batch
**Description**  
Persist an accepted implementation batch as an explicit repository checkpoint.

**Responsible role**  
Developer

**AI Agent**  
Proposes a commit message if needed and identifies the reviewed batch boundary to be committed.

**User**  
Confirms the batch is accepted and creates the commit.

---

#### 9. Record Implementation Decision
**Description**  
Record an implementation-time decision or clarification that should remain visible during execution.

**Responsible role**  
Developer

**AI Agent**  
Identifies decisions worth recording, proposes a concise entry for the Implementation Plan, and inserts it if approved.

**User**  
Reviews the proposed decision record, adjusts it if needed, and approves storing it in the Implementation Plan.

---

#### 10. Propose Specification Update
**Description**  
Propose an append-only update to the PRD or Technical Concept when a requirement-level or design-level gap, inconsistency, or late change is identified.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Summarizes the issue, proposes the Specification Update content in append-only form, and adds it with status `proposed`.

**User**  
Confirms that the issue should be formalized, adjusts the proposal if needed, and approves creating the proposed update entry.

---

#### 11. Approve Specification Update
**Description**  
Approve a proposed Specification Update so that it becomes part of the effective specification.

**Responsible role**  
Product Owner or Architect, depending on target artifact and team policy

**AI Agent**  
Presents the proposed update, highlights its likely impact, and changes its status to `approved` if approval is granted.

**User**  
Reviews the proposed update, decides whether to approve it, and triggers any downstream adjustments when relevant.

---

#### 12. Finish Slice
**Description**  
Validate that a slice is complete and mark it as done in the Implementation Plan.

**Responsible role**  
Developer

**AI Agent**  
Summarizes completed tasks and resulting functionality, and updates the slice state if the developer approves completion.

**User**  
Reviews the implemented slice outcome, validates that the slice goal has been met, and approves marking the slice complete.

---

#### 13. Finish Implementation
**Description**  
Conclude implementation by verifying completion state, repository readiness, and final Implementation Plan status.

**Responsible role**  
Developer

**AI Agent**  
Checks that all slices are marked complete, confirms the Implementation Plan reflects execution state, and proposes final status updates.

**User**  
Verifies repository cleanliness and completion readiness, then approves marking the Implementation Plan as done.

---

### 9.2 Supporting Operations

#### 14. Pick Up Feature
**Description**  
Select the feature to work on and make it the active local Shape context.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Resolves candidate feature folders, sets the selected feature as active in local Shape state, and confirms the resolved workspace.

**User**  
Identifies or chooses the feature to work on and confirms the selection if needed.

---

#### 15. Show Status
**Description**  
Display the current Shape configuration, active feature context, resolved artifacts, and structural warnings.

**Responsible role**  
Product Owner, Architect, or Developer

**AI Agent**  
Reads Shape configuration and local state, resolves the active feature and core artifacts, and reports current statuses and missing prerequisites.

**User**  
Requests the current workflow state and uses the result to decide what to do next.

---

### 9.3 Notes on Change Handling

Shape keeps change handling intentionally small:

- Specification Updates are append-only
- Specification Update status is limited to `proposed | approved`
- Only approved updates are considered effective
- Downstream propagation is handled explicitly when relevant
- Shape does not require formal lineage tracking between related updates across artifacts

This keeps the mechanism understandable while still making late changes visible and controlled.

---

## 10. Skill Inventory

List the initial set of skills required to support the workflow. For example:
- pick up feature
- show status
- create PRD draft
- generate Technical Concept from PRD
- initiate implementation
- prepare slice
- implement batch
- review batch summary
- record implementation decision
- propose specification update
- approve specification update
- finish slice
- finish implementation

Skills should align with workflow operations and operate on defined artifacts.

---

## 11. Review and Commit Boundaries

Define when explicit reviews, diffs, and commits must occur. At minimum:
- after each artifact creation/update
- after each implementation batch
- at the end of each slice

This enforces discipline, ensures visibility of changes, and keeps the workflow auditable. Frequent commits within slices are allowed, but key checkpoints must be explicit.

---

## Summary

This checklist defines the minimal but complete set of primitives required to build a coherent v1 workflow. The focus should be on clarity, consistency, and explicit structure — especially around artifacts, lifecycle, operations, and change management.

The most critical elements to get right early are:
- artifact schemas
- artifact lifecycle
- change/feedback model
- workflow operations

These form the foundation upon which all automation and skills will operate.