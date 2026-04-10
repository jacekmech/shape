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

Shape observes the following principles:

* **Lightweight**  
  Minimal set of activities and documents required to deliver a feature.

* **Loosely Coupled**  
  Clear boundaries between steps and responsibilities.

* **Document-Driven**  
  Structured markdown documents define handovers between steps.

* **Guided Execution**  
  AI produces specifications and code under direct specialist guidance.

* **Iterative**  
  Delivery progresses through repeated refinement across all stages.

* **Discovery-Driven**  
  Learnings are fed back into earlier documents through controlled updates.

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
PRD is accepted as a sufficient and stable definition of the feature scope.

**Feedback Loop**  
- **Inbound**  
  Addenda appended when gaps or inconsistencies are discovered in later stages  
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
Technical Concept is accepted as a stable design baseline and Implementation Slices are defined at a level sufficient to begin execution.

**Feedback Loop**  
- **Inbound**  
  Addenda appended when gaps or inconsistencies are discovered during Implementation  
- **Outbound**  
  May append Addenda to PRD when requirement-level issues are identified

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
  May append Addenda to Technical Concept and/or PRD when gaps or inconsistencies are identified

---

### 4.4 Flow Characteristics

- **Document-Driven**  
  Each stage produces a persistent artifact used as input for subsequent stages

- **Append-Only Evolution**  
  Changes to PRD and Technical Concept are recorded as Addenda, preserving full traceability

- **Optimistically Concurrent**  
  Stages do not block each other; discrepancies are resolved asynchronously through feedback loops

- **Traceable Execution**  
  Progression from PRD to code is fully reconstructable via documents, diffs, and commits

---

## 5. Document Lifecycle

This section defines how specification documents are created, stabilized, and evolved over time.

Shape enforces a **two-phase lifecycle**:

1. **Baseline Creation** — mutable, exploratory  
2. **Append-Only Evolution** — controlled, traceable  

This model ensures stability for execution while preserving the ability to incorporate new information.

---

### 5.1 Baseline Creation

**Summary**  
Documents are created through iterative, Socratic interaction between the user and the AI-agent. The goal is to converge on a complete, internally consistent baseline.

**Process**
- User provides initial input (unstructured or semi-structured)
- AI-agent guides refinement through questions and suggestions
- Document is incrementally structured according to its template
- Gaps, ambiguities, and inconsistencies are resolved during this phase

**Output**  
Version 1 of the document (baseline)

**Completion Condition**
- Document is explicitly reviewed and accepted by the responsible role
- Document is considered stable for downstream use

---

### 5.2 Baseline Immutability

**Summary**  
Once approved, the baseline document is **not modified directly**.

**Rules**
- Existing content is not edited, removed, or rewritten  
- Corrections and updates are not applied inline  
- The baseline remains as the original reference point  

**Rationale**
- Preserves original intent  
- Enables full traceability  
- Prevents silent drift during execution  

---

### 5.3 Addenda (Append-Only Updates)

**Summary**  
All changes after baseline approval are recorded as **Addenda**, appended to the document.

**Structure**
Each Addendum contains:
- **Context** — where and when the issue was identified (e.g., Implementation Slice, Task)
- **Issue** — description of the gap, inconsistency, or new information
- **Decision** — resolution applied
- **Impact** — effect on system behavior, design, or execution

**Rules**
- Addenda are appended in chronological order  
- Existing Addenda are not modified  
- Addenda do not rewrite baseline content; they extend it  

**Usage**
- Captures discoveries during later stages  
- Resolves inconsistencies without blocking progress  
- Maintains alignment across documents  

---

### 5.4 Cross-Document Feedback

**Summary**  
Addenda may propagate across documents when issues affect multiple stages.

**Rules**
- Implementation may append Addenda to:
  - Technical Concept
  - PRD
- Technical Concept may append Addenda to:
  - PRD
- PRD does not propagate further upstream

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
- Implementation Plan reflects full progress  
- Feature is fully implemented in code  

---

### 6.9 Feedback to Documents

**Summary**  
Discoveries during Implementation are recorded via Addenda.

**Rules**
- Gaps or inconsistencies trigger Addenda in:
  - Technical Concept  
  - PRD (if required)  
- Implementation Plan is updated inline (not append-only)

**Characteristics**
- Non-blocking  
- Explicit  
- Traceable  

## 7. Repository Layout Conventions

Define where artifacts live in the monorepo. Even if hardcoded in v1, establish concepts like:
- documentation root
- initiative folder structure
- artifact paths
- skills location

A consistent layout allows Codex to reliably locate and update artifacts and makes the workflow predictable.

---

## 7. Documents Inventory & Schemas

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
  Documents are created, approved, and then extended via **Updates** (append-only).

- **Live document (Implementation Plan)**  
  The Implementation Plan evolves directly during execution and is not append-only.

- **Required status and date**  
  All documents and Updates must include:
  - `status: draft | final`  
  - `date: YYYY-MM-DD`  

---

### 7.1 Product Requirements Definition (PRD)

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
- Status: `draft | final`  
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

Append-only list of changes after baseline approval.

Each Update includes:
- Name  
- Status: `draft | final`  
- Date  
- Context  
- Change / decision  
- Impact  

---

### 7.2 Technical Concept

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
- Status: `draft | final`  
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

Append-only list of changes after baseline approval.

Each Update includes:
- Name  
- Status: `draft | final`  
- Date  
- Context  
- Change / decision  
- Impact  

---

### 7.3 Implementation Plan

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
- Status: `draft | final`  
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