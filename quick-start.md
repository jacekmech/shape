# Shape Quick Start

**Shape is a small AI-assisted software delivery workflow implemented as a set of agent skills.**

The skills guide an AI coding agent through three delivery stages:

PRD → Technical Concept → Implementation

The goal is simple: keep feature delivery grounded in persistent files instead of loose chat context.

## How you work with Shape

You start a feature with a prompt like:

```text
Use Shape to start a feature for adding file attachments to the contact form.
```

Shape creates a feature workspace:

```text
features/
  contact-form-attachments/
    01-prd.md
    02-tech-concept.md
    03-implementation-plan.md
```

These three files become the working memory for the feature development.

## A. Define the feature

Shape first helps you create a PRD.

At the beginning of this step, the agent should guide product clarification before writing the artifact. For example:

```text
I’ll help you define the PRD for this feature. Let’s first clarify the user goal,
main behavior, constraints, and acceptance criteria before I create the initial PRD draft.
```

Example PRD:

```markdown
# Contact Form Attachments

Status: ready

Users can attach one PDF, PNG, or JPG file.

Rules:
- maximum file size: 10 MB
- invalid files show a clear error
```

The PRD answers:

**What are we building?**

## B. Design the feature

Shape then helps you create a Technical Concept.

At the beginning of this step, the agent should use the ready PRD and guide the design discussion. For example:

```text
I’ll create the Technical Concept from the ready PRD. First, I’ll review the existing code structure
and clarify the frontend, backend, validation, storage, and error-handling design.
```

Example Technical Concept:

```markdown
# Contact Form Attachments - Technical Concept

Status: ready

Frontend:
- add file input

Backend:
- validate and store the file
```

The Technical Concept answers:

**How should this fit into the system?**

## C. Implement the feature

Shape then helps you move from design into controlled implementation.

Implementation has two planning levels:

1. **Overall implementation planning** — creates the Implementation Plan and proposes the main Slices.
2. **Slice planning** — prepares one selected Slice in detail by defining its Tasks and important decisions.

At the beginning of overall implementation planning, the agent should use the ready PRD and Technical Concept to propose the implementation structure. For example:

```text
I’ll create the Implementation Plan from the ready PRD and Technical Concept.
First, I’ll propose the main implementation slices, each sized for one focused AI session.
```

Example Implementation Plan:

```markdown
# Contact Form Attachments - Implementation Plan

Status: planned

Slices:
1. Backend upload handling
2. Frontend file input
```

A **Slice** is a larger implementation unit sized for one focused AI session.

Before implementing a Slice, Shape plans that Slice in more detail. For example:

```text
I’ll prepare Slice 1: Backend upload handling. I’ll break it into reviewable tasks,
call out important implementation decisions, and wait for your approval before changing code.
```

Example Slice:

```markdown
Slice 1: Backend upload handling

Tasks:
- [ ] add multipart request handling
- [ ] validate file type and size
- [ ] store the file
```

Slice implementation is organized into **Batches** so that each code change stays small enough for efficient diff review.

Example Batch prompt:

```text
Implement only this batch from Slice 1:

- add multipart request handling
- validate file type and size

Do not implement storage yet.
```

The agent implements the Batch, stops, and asks for review.

After approval, the plan is updated:

```markdown
Slice 1: Backend upload handling

Tasks:
- [x] add multipart request handling
- [x] validate file type and size
- [ ] store the file
```

The approved Batch is committed before the next Batch starts.

## What Shape gives you

Shape connects the whole feature flow:

PRD  
→ Technical Concept  
→ Implementation Plan  
→ Slice  
→ Batch  
→ Review  
→ Commit

Each boundary has a job:

- **PRD** keeps product intent stable.
- **Technical Concept** keeps design decisions visible.
- **Implementation Plan** turns the feature into executable delivery structure.
- **Slice** bounds one focused agent session.
- **Batch** bounds one developer-reviewable diff.

Shape moves the agent from **unclear feature idea** to **reviewable, committed code** using persistent artifacts and small execution steps.

**Clear thinking in — clear software out.**
