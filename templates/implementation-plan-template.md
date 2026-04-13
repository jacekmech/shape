# Implementation Plan Template

## Header
- **Title:**
- **Status:** `draft | ready | in progress | done`
- **Date:** `YYYY-MM-DD`

---

## Objective
- **What is being delivered:**
- **Key constraints:**

---

## Slices

Defines the high-level structure of execution.

- [ ] Slice Name — Goal

Rules:
- Slices are represented with checkboxes.
- New slices may be appended during implementation.
- Each Slice should remain small enough to fit within a single focused agent session.
- Each new Slice should normally be executed in a fresh agent session.
- Fresh execution sessions should normally begin by resolving the active feature through **Pick Up Feature** unless the active feature is already unambiguous.

---

## Execution Order

This is the central workspace of the Implementation Plan.

Structure:

- [ ] Slice Name
  - [ ] Implementation Task
  - [ ] Implementation Task

Rules:
- Slices and Tasks use checkboxes to indicate progress (`done / not done`).
- Implementation Tasks are appended continuously during execution.
- Developer selects tasks for execution in batches (batches are not explicitly represented).
- This is the only place where sequencing exists.
- Progress is reflected inline.
- Batches should remain small enough for a single high-quality developer review step.
- Tasks should be marked done only after developer approval of the implemented batch.
- An approved batch should be committed before the next batch begins so that review boundaries remain clean.

---

## Important Decisions

Captures implementation-time decisions made during execution.

Use for:
- clarifications not worth updating Technical Concept
- trade-offs discovered during coding
- cross-slice implications

---

## Relevant Files

Curated working file map for upcoming execution.

Use for:
- files or directories likely to matter for upcoming Slices
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