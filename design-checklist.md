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
Markdown document specifying technical design and initial work breakdown into coarse-grained Implementation Slices. It serves as the design baseline for implementation.

### Implementation Plan  
Markdown document driving execution. It starts from the initial Implementation Slices defined in the Technical Concept and evolves during implementation by adding detailed Implementation Tasks and tracking progress.

### Implementation Slice  
Coarse-grained unit of delivery that can be reviewed, integrated, and validated independently. Slices originate in the Technical Concept and are executed and refined in the Implementation Plan.

### Implementation Task  
Fine-grained unit of work derived from a Slice. Typically involves a small, well-defined change (e.g., a few related modifications across code or configuration). Tasks are explicitly listed in the Implementation Plan.

### Implementation Batch  
A selected group of Implementation Tasks executed in a single coding step by the AI-agent. Each batch is followed by developer-led diff review and concluded with a commit.

### Update  
Append-only change record added to a ready PRD or ready Technical Concept after baseline acceptance. An Update captures newly discovered information, decisions, or corrections without modifying the original baseline content.

---

## 3. Roles and Responsibilities

This section defines roles as **responsibility boundaries**. The workflow can be executed by a single person, but roles clarify responsibilities and allow scaling across specialists.

### Product Owner  
Responsible for feature definition. Provides input during the specification process and collaborates with the AI-agent to produce a structured PRD.

### Architect  
Responsible for technical design. Translates the PRD into a Technical Concept and prepares the initial version of the Implementation Plan, including coarse-grained Implementation Slices.

### Developer  
Responsible for execution. Evolves the Implementation Plan, refines Slices into Implementation Tasks, selects Implementation Batches, reviews diffs, commits changes, and validates completed Slices.

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
The AI-agent collaborates with the user to iteratively refine input until the document is complete, consistent, and ready for downstream use.

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
  Updates appended when gaps or inconsistencies are discovered in later stages  
- **Outbound**  
  None

---

### 4.2 Technical Concept

**Summary**  
Transforms the PRD into a **Technical Concept**, defining architecture, constraints, and an initial breakdown into **Implementation Slices**.  
Also initializes the **Implementation Plan** with coarse-grained structure.

**Role**  
Architect

**Input**  
- PRD markdown document  
- Codebase  
- Optional technical notes (unstructured or semi-structured)

**Output**  
- Technical Concept markdown document (design baseline)  
- Implementation Plan markdown document with defined **Implementation Slices**

**Completion Condition**  
Technical Concept is accepted as ready for implementation to begin and Implementation Slices are defined at a level sufficient to start execution planning.

**Feedback Loop**  
- **Inbound**  
  Updates appended when gaps or inconsistencies are discovered during Implementation  
- **Outbound**  
  May append Updates to PRD when requirement-level issues are identified

---

### 4.3 Implementation

**Summary**  
Executes the feature based on the **Technical Concept** and **Implementation Plan**.  
The Developer incrementally refines Implementation Slices into **Implementation Tasks**, executes them in **Implementation Batches**, reviews diffs, and commits changes.

The **Implementation Plan** acts as the **primary execution control document**, evolving throughout this stage.

> Execution occurs through iterative microcycles (Slice → Task → Batch → Review → Commit).  
> These are defined separately in the Implementation Lifecycle.

**Role**  
Developer

**Input**  
- PRD markdown document  
- Technical Concept markdown document  
- Implementation Plan markdown document  
- Codebase  

**Output**  
- Implemented feature committed to the current branch  
- Updated Implementation Plan reflecting completed Slices and Tasks  

**Completion Condition**  
All Implementation Slices are completed, validated, and reflected in both code and Implementation Plan.

**Feedback Loop**  
- **Inbound**  
  None  
- **Outbound**  
  May append Updates to Technical Concept and/or PRD when gaps or inconsistencies are identified

---

### 4.4 Flow Characteristics

- **Document-Driven**  
  Each stage produces a persistent artifact used as input for subsequent stages

- **Append-Only Evolution**  
  Changes to PRD and Technical Concept are recorded as Updates, preserving full traceability

- **Optimistically Concurrent**  
  Stages do not block each other; discrepancies are resolved asynchronously through feedback loops

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
PRD and Technical Concept are created through iterative, Socratic interaction between the user and the AI-agent. The goal is to converge on a complete, internally consistent baseline.

**Process**
- User provides initial input (unstructured or semi-structured)
- AI-agent guides refinement through questions and suggestions
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

### 5.3 Updates (Append-Only Changes)

**Summary**  
All changes after baseline readiness are recorded as **Updates**, appended to the PRD or Technical Concept.

**Structure**
Each Update includes:
- Name
- Status: `draft | ready`
- Date
- Context
- Change / decision
- Impact

**Rules**
- Updates are appended in chronological order  
- Existing Updates are not modified  
- Updates do not rewrite baseline content; they extend it  

**Usage**
- Captures discoveries during later stages  
- Resolves inconsistencies without blocking progress  
- Maintains alignment across documents  

---

### 5.4 Cross-Document Feedback

**Summary**  
Updates may propagate across documents when issues affect multiple stages.

**Rules**
- Implementation may append Updates to:
  - Technical Concept
  - PRD
- Technical Concept may append Updates to:
  - PRD
- PRD does not propagate further upstream
- Implementation Plan is updated inline and does not use append-only Updates

**Characteristics**
- Non-blocking (work continues while updates are recorded)  
- Explicit (all changes are documented)  
- Traceable (full history preserved)  

---

## 6. Implementation Lifecycle

This section defines how a feature is executed using **Implementation Slices, Tasks, and Batches**.

Execution follows a **developer-controlled, iterative microcycle**:

**Slice → Tasks → Batch → Review → Commit**

The **Implementation Plan** is the central control artifact throughout this process.

---

### 6.1 Initialization

**Summary**  
Implementation begins with an existing Implementation Plan containing **Implementation Slices** defined during the Technical Concept stage.

**State**
- Implementation Plan status is `ready`
- Slices are defined  
- Tasks are not yet specified  
- No execution has occurred  

---

### 6.2 Slice Refinement

**Summary**  
A selected Implementation Slice is expanded into **Implementation Tasks**.

**Process**
- Developer selects a Slice  
- AI-agent proposes a breakdown into Tasks  
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
The AI-agent executes the selected Batch.

**Process**
- AI-agent implements code changes required by the selected Tasks  
- AI-agent updates the Implementation Plan:
  - marks Tasks as completed  
  - records progress  

**Constraints**
- AI-agent operates strictly within Batch scope  
- AI-agent does not select or reorder Tasks  

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
Discoveries during Implementation are recorded through two different mechanisms, depending on document type.

**Rules**
- Gaps or inconsistencies affecting PRD or Technical Concept trigger append-only Updates
- Implementation Plan is updated inline as a live document
- Updates may be appended to:
  - Technical Concept  
  - PRD (if required)

**Characteristics**
- Non-blocking  
- Explicit  
- Traceable  

## 7. Repository Layout Conventions

This section defines where Shape artifacts live in the monorepo and how they are organized.

Shape explicitly optimizes repository layout for **speed, feature-level collaboration, and execution continuity**, rather than for strict separation of artifacts by role or document type.

The workflow assumes tight collaboration between Product Owner, Architect, and Developer around the same feature. For that reason, the core feature artifacts are **co-located in a single feature folder**, instead of being separated into document-type buckets such as `prds/`, `tech-concepts/`, and `implementation-plans/`.

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
  Documents are created, accepted as ready, and then extended via **Updates** (append-only).

- **Live document (Implementation Plan)**  
  The Implementation Plan evolves directly during execution and is not append-only.

- **Required status and date**  
  All documents and Updates must include a document-type-specific status and:
  - `date: YYYY-MM-DD`

- **Status model by document type**
  - PRD: `draft | ready`
  - Technical Concept: `draft | ready`
  - Implementation Plan: `draft | ready | in progress | done`

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

Append-only list of changes after baseline readiness.

Each Update includes:
- Name  
- Status: `draft | ready`  
- Date  
- Context  
- Change / decision  
- Impact  

---

### 8.2 Technical Concept

#### Purpose

Defines how the feature will be built at design level.

Focus:
- architecture  
- responsibilities  
- interfaces  
- constraints  
- slice-level decomposition  

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

##### Slices

Initial breakdown into Implementation Slices:

- [ ] Slice Name — Goal  

(Slices are represented with checkboxes and updated during execution)

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

Append-only list of changes after baseline readiness.

Each Update includes:
- Name  
- Status: `draft | ready`  
- Date  
- Context  
- Change / decision  
- Impact  

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

Define the core operations the system performs. Examples include:
- create artifact
- update artifact
- append feedback
- resolve latest approved artifact
- start slice
- conclude slice

These are conceptual building blocks that later map to skills. Defining them early ensures a clean separation between workflow logic and implementation.

---

## 10. Skill Inventory

List the initial set of skills required to support the workflow. For example:
- create PRD draft
- generate Tech Concept from PRD
- generate Implementation Plan
- append feedback
- start/conclude slice

Skills should align with workflow operations and operate on defined artifacts.

---

## 11. Review and Commit Boundaries

Define when explicit reviews, diffs, and commits must occur. At minimum:
- after each artifact creation/update
- at the end of each slice

This enforces discipline, ensures visibility of changes, and keeps the workflow auditable. Frequent commits within slices are allowed, but key checkpoints must be explicit.

---

## Summary

This checklist defines the minimal but complete set of primitives required to build a coherent v1 workflow. The focus should be on clarity, consistency, and explicit structure — especially around artifacts, lifecycle, and change management.

The most critical elements to get right early are:
- artifact schemas
- artifact lifecycle
- change/feedback model

These form the foundation upon which all automation and skills will operate.