# Implementation Plan Template

## Header
- **Title:**
- **Status:** `draft | approved | done`
- **Date:** `YYYY-MM-DD`

---

## Objective
- **What is being delivered:**
- **Key constraints:**

---

## Iterations

Defines the feature implementation breakdown into deliverable iterations.

Refine the Product Specification's proposed delivery iterations using technical feasibility findings. Link each iteration to its product outcome and explain any split, merge, or reordering. The product proposal is not approval of these iterations.

- **Iteration 1:**
  - **Goal:** ...
  - **Scope:** ...
  - **Acceptance criteria:** ...
  - **Status:** `draft | approved | done`

Rules:
- Iterations use explicit status rather than checkboxes.
- New Iterations may be appended during implementation.
- Initial Iterations created during `plan implementation` start as `draft`.
- A selected Iteration moves to `approved` after approved planning in `plan iteration`.
- Iteration implementation progress is inferred from task completion, not from a separate Iteration `in progress` status.
- An Iteration moves to `done` only through explicit validation in `finish iteration`.
- Each iteration should remain small enough to fit within a single focused agent session.
- Each new iteration should normally be executed in a fresh agent session.
- Fresh execution sessions should normally begin by resolving the active feature through **Pick Up Feature** unless the active feature is already unambiguous.

---

## Execution Order

This is the central workspace of the Implementation Plan.

Structure:

- Iteration Name (iteration status)
  - [ ] Implementation Task
  - [ ] Implementation Task

Rules:
- Iteration entries here correspond to the explicit definitions in `## Iterations`.
- Implementation Tasks use checkboxes to indicate progress (`done / not done`).
- Implementation Tasks are added during Iteration approval and updated during iteration execution.
- Developer selects tasks for execution in batches (batches are not explicitly represented).
- This is the only place where sequencing exists.
- Feature-level execution is reflected through Iteration status.
- Iteration-level execution is reflected through task completion and batch state.
- Batches should remain small enough for a single high-quality developer review step.
- Tasks should be marked done only after developer approval of the implemented batch.
- An approved batch should be committed only on explicit developer instruction before the next batch begins so that review boundaries remain clean.

---

## Important Decisions

Captures implementation-time decisions made during execution.

Use for:
- clarifications not worth updating Technical Specification
- trade-offs discovered during coding
- cross-iteration implications

---

## Relevant Files

Curated working file map for upcoming execution.

Use for:
- files or directories likely to matter for upcoming iterations
- anchor files that help a fresh session pick up the feature efficiently
- major code areas already touched that are still relevant to subsequent work

Examples:
- `apps/web/src/features/contact-form/`
- `apps/api/src/routes/contact.ts`
- `packages/validation/src/contact-schema.ts`

Rules:
- Keep this section selective and compact.
- It is a working context map, not a full file inventory.
- Entries may be added, updated, or removed during implementation as relevance changes.
- Prefer files or directories that improve fresh-session pickup and context curation.
- Do not use this section to track task-level progress.
- Do not treat this section as a historical changelog of all touched files.

---

## Notes
- Additional observations
- Clarifications
- Suggested next step when useful for keeping execution flow obvious
