# Shape Skill Design Principles

## Purpose

This document defines how Shape skills should be designed so that they are:

- consistent across the skill set
- easy to install and discover in a repository
- closely aligned with Shape workflow operations
- grounded in actual Shape artifacts rather than generic prompting
- reliable enough to be generated or extended in batches without style drift

This file is the design standard for Shape skills. It should be used when creating new skills manually or when asking an AI coding agent such as Codex to generate additional skill files.

---

## 1. Core Design Goals

Shape skills should optimize for the following qualities:

### Narrow and explicit
Each skill should correspond to one primary Shape operation.  
A skill should do one thing well, not absorb adjacent workflow responsibilities.

### Artifact-aware
A skill should operate against real Shape artifacts, repository structure, and document sections.  
It should not be written as a generic assistant behavior prompt.

### Operational rather than theoretical
A skill should define how the agent should behave in the repository and workflow, not merely restate Shape concepts.

### Consistent
All skills should use a common structure, tone, and level of specificity so that the skill set feels like one coherent system.

### Installable
Each skill should be self-contained, file-based, and easy to map to one Shape capability.

### Human-guided
Skills should preserve Shape's responsibility model.  
The AI Agent accelerates work, but does not take ownership away from the responsible human role.

### Next-step oriented
Skills should normally end by making the next likely valid workflow action obvious to the user.

---

## 2. Skill Scope Rules

### One skill per operation
Each Shape operation should normally map to one skill file.

Examples:
- `create prd` -> `create-prd.md`
- `plan slice` -> `plan-slice.md`
- `implement batch` -> `implement-batch.md`

### Do not merge adjacent operations without a strong reason
For example:
- `implement batch` may absorb adjacent batch review and commit handling only when Shape explicitly defines that combined microcycle
- `create technical concept` should not absorb `update technical concept`

Shape deliberately separates these boundaries. Skill boundaries should preserve them.

### Use imperative verb-phrase naming
Skill names should be short imperative phrases aligned with Shape operations.

Examples:
- `initiate feature`
- `pick up feature`
- `show status`
- `create prd`

Do not use vague or branded names such as:
- `feature setup helper`
- `workflow navigator`
- `artifact manager`

### Prefer one stable filename per skill
Use lowercase kebab-case filenames under `/skills`.

Examples:
- `initiate-feature.md`
- `update-technical-concept.md`
- `record-implementation-decision.md`

---

## 3. Skill Content Principles

### Write for execution, not inspiration
A skill file should help an agent perform a workflow action correctly.  
It should not read like philosophy, marketing copy, or a high-level overview.

### Encode rules where they matter
The skill should include workflow rules that materially affect behavior.

Examples:
- PRD and Technical Concept updates are append-only after readiness
- only ready updates are effective
- implementation tasks are marked done only after explicit developer approval
- `implement batch` includes commit as part of completing the operation, even when the developer performs the commit directly
- the agent may create that commit only on explicit developer instruction

### Anchor to real artifacts and sections
Where relevant, the skill should refer to:

- feature folder layout
- file naming conventions
- actual target documents
- actual target sections within templates

Examples:
- PRD `## Updates`
- Technical Concept `## Repository Alignment`
- Implementation Plan `## Execution Order`
- Implementation Plan `## Relevant Files`

### Be precise about allowed changes
A good Shape skill should make clear:

- what it may create
- what it may update
- what it must not modify
- what requires user confirmation
- what state transitions are allowed

### Prefer deterministic behavior over open-ended creativity
When a step has a known repository or artifact shape, the skill should follow it.  
It should not improvise unnecessary structure.

---

## 4. Artifact-Awareness Rules

### PRD baseline work
Skills touching PRD baseline creation should use the exact PRD template structure:

- `## Header`
- `## Goal`
- `## Flow`
- `## Requirements`
- `## Acceptance Criteria`
- `## UX Notes`
- `## Non-Functional Requirements`
- `## Notes`
- `## Out of Scope`
- `## Updates`

### PRD update work
PRD updates must be appended under `## Updates` using the update structure already defined by the template.

They should:
- not rewrite ready baseline content
- not silently edit prior ready updates
- normally prefer continuing an existing draft update if one already exists

### Technical Concept baseline work
Skills touching Technical Concept baseline creation should use the exact Technical Concept template structure, including `## Repository Alignment`.

This section is not optional in practice when repository guidance materially shapes design.

### Technical Concept update work
Technical Concept updates must be appended under `## Updates` and follow the defined update structure.

They should:
- preserve baseline immutability after readiness
- avoid silently rewriting ready content
- explicitly align with repository guidance when relevant

### Implementation Plan work
Skills touching the Implementation Plan should treat it as a live inline execution document.

They should work against the actual sections:

- `## Header`
- `## Objective`
- `## Slices`
- `## Execution Order`
- `## Important Decisions`
- `## Relevant Files`
- `## Notes`

Implementation Plan skills must respect:
- slice and task checkboxes
- inline progress updates
- no explicit batch representation in the document
- selective maintenance of `## Relevant Files`

---

## 5. Responsibility and Approval Principles

### Preserve human ownership
The responsible role owns correctness and approval:

- Product Owner owns requirement correctness
- Architect owns design correctness
- Developer owns implementation correctness and repository changes

The skill should support that role, not erase it.

### Do not collapse approval boundaries
A skill must not imply approval merely because work is completed.

Examples:
- `implement batch` does not approve the batch
- `implement batch` supports review handling but does not replace developer approval
- `finish slice` should not assume completion without developer confirmation

### Make review state explicit
Where relevant, skills should distinguish clearly between:
- awaiting review
- under revision
- awaiting approval
- approved but awaiting commit
- ready for next step

---

## 6. Fresh-Session and Context-Curation Principles

Shape treats fresh-session execution as a quality discipline, especially in implementation.

Skills should reinforce that:

- each new Slice should normally begin in a fresh agent session
- fresh execution sessions should normally begin with `pick up feature` unless the active feature is already unambiguous
- slices should remain small enough for focused execution without relying on long conversational carryover

Skills should not overdramatize this rule, but they should preserve it where operationally relevant.

---

## 7. Repository Readiness Principles

Skills that operate against repository structure should account for repository readiness.

At minimum, repository-oriented skills should be able to notice whether the repository appears to provide:

- agent-facing instructions
- feature artifact location guidance
- test, lint, build, and format commands
- coding conventions
- architectural guidance

If readiness is weak, the skill should surface the risk explicitly rather than pretending the workflow is fully controlled.

The workflow should warn, not bluff.

---

## 8. Tone and Writing Style

Shape skills should be written in a tone that is:

- direct
- operational
- calm
- specific
- non-marketing
- non-theatrical

Avoid:
- excessive motivational language
- generic assistant disclaimers
- inflated claims of certainty or authority
- verbose theory sections

Prefer:
- crisp constraints
- explicit workflow boundaries
- clear expected outcomes
- practical instructions

---

## 9. Recommended Skill File Structure

Each skill file should follow a stable structure.

Recommended structure:

1. `# <Skill Name>`
2. `## Purpose`
3. `## When to Use`
4. `## Inputs`
5. `## Preconditions`
6. `## Behavior`
7. `## Artifact Rules`
8. `## Outputs`
9. `## Completion Signals`
10. `## Guardrails`
11. `## Likely Next Step`

Not every skill needs the exact same depth in every section, but the overall structure should remain highly consistent.

---

## 10. What a Good Skill Must Make Clear

A good Shape skill should make the following clear without ambiguity:

- what triggers the skill
- which role is responsible
- which artifacts are read
- which artifacts are created or updated
- which sections are affected
- what rules constrain the operation
- what user confirmation is required
- what completion looks like
- what the likely next step is

If any of those are unclear, the skill is probably too vague.

---

## 11. What Skills Should Not Try to Do

Shape skills should not:

- restate the full Shape specification
- absorb multiple operations into one broad helper
- hide document lifecycle rules
- silently rewrite immutable baseline sections
- pretend repository readiness is better than it is
- replace explicit human review and approval boundaries
- turn `Relevant Files` into a full inventory or changelog
- improvise alternative document schemas
- use fuzzy language when the workflow requires a hard boundary

---

## 12. Relationship Between Principles and Examples

The first generated skills should be treated as reference implementations of these principles.

Use them to calibrate:

- wording
- section structure
- level of detail
- artifact specificity
- strictness of boundaries

When generating additional skills, new files should match both:
- this principles document
- the existing approved example skills

If the principles and examples conflict, the principles should be treated as the higher-level standard and the examples should be revised.

---

## 13. Practical Generation Guidance

When generating skills in batches:

- keep one skill per file
- keep file structure stable
- preserve naming consistency
- ground each skill in the Shape spec and templates
- review each batch before accepting it as canonical
- prefer a small number of excellent example skills over a large number of inconsistent first-pass skills

Small-batch generation with review is preferred over one-shot bulk generation of the full skill set.

---

## 14. Definition of Done for a Shape Skill

A skill file is ready when:

- it maps clearly to one Shape operation
- its filename is stable and predictable
- it is grounded in actual Shape artifacts and rules
- it preserves responsibility and approval boundaries
- it uses the common Shape skill structure
- it is specific enough to guide execution, not just describe intent
- it makes the likely next workflow step obvious

If a skill is elegant but vague, it is not done.
