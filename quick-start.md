# Shape Quick Start

**Shape is a small AI-assisted software development workflow implemented as a set of agent skills.**

The skills guide an AI coding agent through three workflow stages:

```text
PRD → Technical Concept → Implementation
```

The goal is simple: keep feature development grounded in persistent files instead of loose chat context.

## How you work with Shape

You start a feature:

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

These three files become the working memory for the feature.

## A. Define the feature

Shape first helps you create a PRD.

```markdown
# Contact Form Attachments

Status: approved

Users can attach one PDF, PNG, or JPG file.

Rules:
- maximum file size: 10 MB
- invalid files show a clear error
```

The PRD answers:

```text
What are we building?
```

## B. Design the feature

Shape then helps you create a Technical Concept.

```markdown
# Contact Form Attachments - Technical Concept

Status: approved

Frontend:
- add file input

Backend:
- validate and store the file
```

The Technical Concept answers:

```text
How should this fit into the system?
```

## C. Implement the feature

Shape then helps you create an Implementation Plan.

```markdown
# Contact Form Attachments - Implementation Plan

Status: approved

Slices:
1. Backend upload handling
2. Frontend file input
```

A **Slice** is a larger implementation unit sized for one focused AI session.

Example Slice:

```markdown
Slice 1: Backend upload handling

Tasks:
- [ ] add multipart request handling
- [ ] validate file type and size
- [ ] store the file
```

A **Batch** is a small set of implementation tasks selected from a Slice and sized for one developer-reviewable diff.

Example Batch:

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

```text
PRD
→ Technical Concept
→ Implementation Plan
→ Slice
→ Batch
→ Review
→ Commit
```

Each boundary has a job:

- **PRD** keeps product intent stable.
- **Technical Concept** keeps design decisions visible.
- **Slice** bounds one focused agent session.
- **Batch** bounds one developer-reviewable diff.

Shape moves the agent from **unclear feature idea** to **reviewable, committed code** using persistent artifacts and small execution steps.

**Clear thinking in — clear software out.**
