# Shape Quick Start

**Shape is a small AI-assisted software development workflow implemented as a set of agent skills.**

The skills guide an AI coding agent through three workflow stages:

Product Specification → Technical Specification → Implementation

The goal is simple: keep feature development grounded in persistent files instead of loose chat context.

## How you work with Shape

You start a feature with a prompt like:

```text
Use Shape to start a feature for adding file attachments to the contact form.
```

Shape creates a feature workspace:

```text
docs/implementation/
  contact-form-attachments/
    01-product-specification.md
    02-technical-specification.md
    03-implementation-plan.md
...
```

Shape first offers to use existing Product and Technical Specifications. You can supply either document's name, repository path, or URL. Each Shape specification file can simply record its source link, scope, reviewed revision, and Shape approval status. You can reference one specification and draft the other.

These three files become the working memory for the feature development.

## A. Define the feature

Shape first helps you create a Product Specification.

If you choose to author a new specification, the agent guides product clarification before drafting. For example:

```text
I’ll help you define the Product Specification for this feature. Let’s first clarify the user goal,
main behavior, constraints, and acceptance criteria before I create the initial Product Specification draft.
```

Example Product Specification:

```markdown
# Contact Form Attachments

Status: approved

Users can attach one PDF, PNG, or JPG file.

Rules:
- maximum file size: 10 MB
- invalid files show a clear error

Proposed Delivery Iterations:
- Iteration 1: attach and submit one valid file; confirm it reaches the recipient.
- Iteration 2: validate size/type and show actionable errors; reject invalid files.
...
```

The Product Specification answers:

**What are we building, and what could we deliver first?**

The delivery outline is provisional; technical design and implementation planning refine it into Iterations. An iteration is a bounded delivery increment, not a fixed-duration sprint.

## B. Design the feature

Shape then helps you create a Technical Specification.

At the beginning of this step, the agent should use the ready Product Specification and guide the design discussion. For example:

```text
I’ll create the Technical Specification from the ready Product Specification. First, I’ll review the existing code structure
and clarify the frontend, backend, validation, storage, and error-handling design.
```

Example Technical Specification:

```markdown
# Contact Form Attachments - Technical Specification

Status: approved

Frontend:
- add file input

Backend:
- validate and store the file
...
```

The Technical Specification answers:

**How should this fit into the system?**

## C. Implement the feature

Shape then helps you move from design into controlled implementation.

Implementation has two planning levels:

1. **Overall implementation planning** — creates the Implementation Plan by breaking feature implementation into deliverable iterations.
2. **Iteration planning** — prepares one selected iteration in detail by breaking iteration implementation into Tasks and important decisions.

At the beginning of overall implementation planning, the agent should use the ready Product Specification and Technical Specification to propose the implementation structure. For example:

```text
I’ll create the Implementation Plan from the ready Product Specification and Technical Specification.
First, I’ll propose the main deliverable iterations, each sized for one focused AI session.
```

Example Implementation Plan:

```markdown
# Contact Form Attachments - Implementation Plan

Status: approved

Iterations:
1. Backend upload handling — draft
2. Frontend file input — draft
...
```

An **Iteration** breaks one iteration into implementation tasks and tracks execution of that iteration.

Before implementing an Iteration, Shape plans it in more detail. For example:

```text
I’ll prepare Iteration 1: Backend upload handling. I’ll break it into reviewable tasks,
call out important implementation decisions, and wait for your approval before changing code.
```

Example Iteration:

```markdown
Iteration 1: Backend upload handling
Status: approved

Tasks:
- [ ] add multipart request handling
- [ ] validate file type and size
- [ ] store the file
...
```

Iteration implementation is organized into **Batches** so that each code change stays small enough for efficient diff review.

Example Batch prompt:

```text
Implement only this batch from Iteration 1:

- add multipart request handling
- validate file type and size

Do not implement storage yet.
```

The agent implements the Batch, stops, and provides a Batch Summary. In a fresh session, you can paste that summary and ask for a code review; the optional **`review code`** skill reports any actionable findings as `[P1]`, `[P2]`, or `[P3]` bullets without changing the batch.

After approval, the plan is updated:

```markdown
Iteration 1: Backend upload handling
Status: approved

Tasks:
- [x] add multipart request handling
- [x] validate file type and size
- [ ] store the file
```

The agent proposes two commits together for this Batch, first the implementation and then the Shape plan updates. One confirmation covers both. Both commits are complete before the next Batch starts.

## What Shape gives you

Shape connects the whole feature flow:

Product Specification\
→ Technical Specification\
→ Implementation Plan  
→ Iteration\
→ Batch  
→ Review  
→ Commit

Each boundary has a job:

- **Product Specification** keeps product intent stable.
- **Technical Specification** keeps design decisions visible.
- **Implementation Plan** turns the feature into executable delivery structure.
- **Iteration** bounds one focused agent session.
- **Batch** bounds one developer-reviewable diff.

Shape moves the agent from **unclear feature idea** to **reviewable, committed code** using persistent artifacts and small execution steps.

**Clear thinking in — clear software out.**
