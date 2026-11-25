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
The user guides the work and makes approval decisions.

### Next-step oriented
Skills should normally end by making the next likely valid workflow action obvious to the user.

---

## 2. Skill Scope Rules

### One skill per operation
Each Shape operation should normally map to one skill file.

Examples:
- `create product specification` -> `create-product-specification.md`
- `plan iteration` -> `plan-iteration.md`
- `implement batch` -> `implement-batch.md`
- `review code` -> `review-code.md`

### Do not merge adjacent operations without a strong reason
For example:
- `implement batch` may absorb adjacent batch review and commit handling only when Shape explicitly defines that combined microcycle
- `review code` provides a read-only independent assessment of a completed batch; it does not replace approval from the user or modify workflow state
- `create technical specification` should not absorb `update technical specification`

Shape deliberately separates these boundaries. Skill boundaries should preserve them.

### Use imperative verb-phrase naming
Skill names should be short imperative phrases aligned with Shape operations.

Examples:
- `initiate feature`
- `pick up feature`
- `show status`
- `create product specification`

Do not use vague or branded names such as:
- `feature setup helper`
- `workflow navigator`
- `artifact manager`

### Prefer one stable filename per skill
Use lowercase kebab-case filenames under `/skills`.

Examples:
- `initiate-feature.md`
- `update-technical-specification.md`
- `record-implementation-decision.md`

---

## 3. Skill Content Principles

### Write for execution, not inspiration
A skill file should help an agent perform a workflow action correctly.  
It should not read like philosophy, marketing copy, or a high-level overview.

### Encode rules where they matter
The skill should include workflow rules that materially affect behavior.

Examples:
- Product Specification and Technical Specification updates are append-only after readiness
- only approved updates are effective
- implementation tasks are marked done only after explicit approval from the user
- `implement batch` includes commit as part of completing the operation, even when the user performs the commit directly
- the agent may create the required commits only on explicit instruction from the user

### Anchor to real artifacts and sections
Where relevant, the skill should refer to:

- feature folder layout
- file naming conventions
- actual target documents
- actual target sections within templates

Examples:
- Product Specification `## Updates`
- Technical Specification `## Repository Alignment`
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

### Product Specification baseline work
Skills touching authored Product Specification baseline creation should use the Product Specification template structure:

- `## Header`
- `## Goal`
- `## Flow`
- `## Requirements`
- `## Acceptance Criteria`
- `## Proposed Delivery Iterations`
- `## UX Notes`
- `## Non-Functional Requirements`
- `## Notes`
- `## Out of Scope`
- `## Updates`

### Product Specification update work
Product Specification updates must be appended under `## Updates` using the update structure already defined by the template.

They should:
- not rewrite approved baseline content
- not silently edit prior approved updates
- normally prefer continuing an existing draft update if one already exists

### Technical Specification baseline work
Skills touching authored Technical Specification baseline creation should use the Technical Specification template structure, including `## Repository Alignment`.

This section is not optional in practice when repository guidance materially shapes design.

### Technical Specification update work
Technical Specification updates must be appended under `## Updates` and follow the defined update structure.

They should:
- preserve baseline immutability after readiness
- avoid silently rewriting approved content
- explicitly align with repository guidance when relevant

### Implementation Plan work
Skills touching the Implementation Plan should treat it as a live inline execution document.

They should work against the actual sections:

- `## Header`
- `## Objective`
- `## Iterations`
- `## Execution Order`
- `## Important Decisions`
- `## Relevant Files`
- `## Notes`

Implementation Plan skills must respect:
- Iteration status and task checkboxes
- inline progress updates
- no explicit batch representation in the document
- selective maintenance of `## Relevant Files`

---

## 5. Human Approval

### Preserve human ownership
The user reviews requirements, design, and implementation and decides whether to accept workflow changes, authorize commits, or proceed to the next step.

### Do not collapse approval boundaries
A skill must not imply approval merely because work is completed.

Examples:
- `implement batch` does not approve the batch
- `implement batch` supports review handling but does not replace approval from the user
- `finish iteration` should not assume completion without confirmation from the user

Skills that can move artifacts or execution state across approval boundaries should use explicit mandatory wording:
- If explicit approval is still missing, YOU MUST stop for human review before changing an artifact, update, iteration, or plan from a draft or active state into an approved or done state.
- YOU MUST NOT mark artifacts or updates approved or done, or mark tasks or batches complete, without explicit approval from the user.
- YOU MUST NOT treat completed drafting, planning, implementation, validation, or revision work as approval.
- An explicit request for a specific status change authorizes that transition once its preconditions are met.

### Propose commits proactively

At an accepted repository checkpoint, review the diff and identify the changes in scope. If commit consent is still needed, YOU MUST report the status or accepted changes and propose the commit subject and scope in the same reply. End with one yes/no question asking whether to create the proposed commit or commits.

> I marked the Technical Specification `approved`. The proposed commit, `Approve Shape technical specification`, covers the status change in `02-technical-specification.md`.
>
> Should I create this commit?

Approval of the status change leaves commit consent pending. If the user also explicitly requested a commit covering the current changes, create it. YOU MUST keep each commit scoped to the accepted diff and surface unrelated or unexpected changes before committing.

When reporting completed commits for the current operation, YOU MUST put a **Commits** block at the end of the summary. Read the short hash and exact, unabridged subject of each commit from Git and list them in creation order. Include a passive hint only for commits the user authorized before seeing their exact subjects. Put “The commit message can be adjusted if needed.” beneath the eligible entry, or “Either commit message can be adjusted if needed.” beneath the list when both commits qualify.

### Separate codebase and Shape commits

- Files inside Shape feature folders resolved under the configured feature root are Shape artifacts. All other files are non-Shape changes.
- If both kinds of changes are in scope, YOU MUST propose the codebase commit first and the Shape artifact commit second in one proposal. Give the subject and scope of each and ask once for consent to create both in order. If only one kind of change is in scope, propose a single commit.
- The Shape subject MUST identify the artifact change. Use `shape:` if it fits repository conventions.
- When the user explicitly approves closing the Iteration with the final batch, validate closure and commit the codebase changes first. Then mark the Iteration `done` and record closure with the final batch's Shape changes in the second commit.

### Preserve next-step boundaries
Skills should make the next likely valid workflow action obvious, but making the next action obvious is not permission to start it.

- After the commit boundary is resolved, YOU MUST ask whether to proceed when there is a specific next Shape workflow step to offer.
- YOU MUST NOT proceed to the next Shape workflow step unless the user explicitly approves proceeding.
- YOU MUST NOT silently combine adjacent Shape operations, even when the next operation seems obvious.
- YOU MUST NOT start implementation, a new batch, iteration closure, or feature completion merely because the previous step reached review, approval, or commit readiness.

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

- each new iteration should normally begin in a fresh agent session
- fresh execution sessions should normally begin with `pick up feature` unless the active feature is already unambiguous
- iterations should remain small enough for focused execution without relying on long conversational carryover

Skills should not overdramatize this rule, but they should preserve it where operationally relevant.

---

## 7. Tone and Writing Style

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

### Follow-up questions

- When the user needs to make a decision or provide input, end the reply with one question in its own paragraph after the summary, findings, checks, links, and any **Commits** block and adjustment hint.
- Use a yes/no question when the user can decide on a single named action, such as approving a draft, committing an accepted diff, or starting a specific workflow step. Ask about each approval boundary separately once it is reached.
- When the answer needs a choice or missing information, give the relevant options or context before asking for the specific input.
- End with the result when no user decision or input is needed and there is no concrete next action to offer.
- Include these rules in each installed skill's source file.

---

## 8. Recommended Skill File Structure

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

## 9. What a Good Skill Must Make Clear

A good Shape skill should make the following clear without ambiguity:

- what triggers the skill
- which artifacts are read
- which artifacts are created or updated
- which sections are affected
- what rules constrain the operation
- what user confirmation is required
- what completion looks like
- what the likely next step is

If any of those are unclear, the skill is probably too vague.

---

## 10. What Skills Should Not Try to Do

Shape skills should not:

- restate the full Shape specification
- absorb multiple operations into one broad helper
- hide document lifecycle rules
- silently rewrite immutable baseline sections
- replace explicit human review and approval boundaries
- turn `Relevant Files` into a full inventory or changelog
- improvise alternative document schemas
- use fuzzy language when the workflow requires a hard boundary

---

## 11. Relationship Between Principles and Examples

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

## 12. Practical Generation Guidance

When generating skills in batches:

- keep one skill per file
- keep file structure stable
- preserve naming consistency
- ground each skill in the Shape spec and templates
- review each batch before accepting it as canonical
- prefer a small number of excellent example skills over a large number of inconsistent first-pass skills

Small-batch generation with review is preferred over one-shot bulk generation of the full skill set.

---

## 13. Definition of Done for a Shape Skill

A skill file is ready when:

- it maps clearly to one Shape operation
- its filename is stable and predictable
- it is grounded in actual Shape artifacts and rules
- it preserves responsibility and approval boundaries
- it uses the common Shape skill structure
- it is specific enough to guide execution, not just describe intent
- it makes the likely next workflow step obvious
- when a follow-up applies, it specifies that the question goes last and uses yes/no for a single proposed action

If a skill is elegant but vague, it is not done.

## Specification modes and upgrade compatibility

At initiation and before drafting, offer to reference existing Product and/or Technical Specifications by name, path, or URL. Honor choices already supplied. Each specification independently uses authored mode or `specification-reference-template.md`; reference mode replaces full authored section requirements. Always read the referenced source, check scope and reviewed revision, and require Shape approval. Product specifications must include or link to proposed delivery iterations, adding a local supplement if needed. Source changes use append-only updates with old/new revisions and downstream impact.

YOU MUST keep a file for each specification in the feature folder, including when the source lives elsewhere. Implementation planning requires both local artifacts to be approved and must link to their resolved paths. Follow external sources through the local reference artifacts.

Skills must resolve configured roots and artifact filenames before using defaults. Legacy `prd`/`technicalConcept` keys, PRD/Technical Concept files, and Slice Plan headings remain readable without rewriting project documents. Installed skill directories use the new names. Installer upgrades remove old managed and retired skill names, replace the current skill set, and preserve per-agent inventories for subsequent upgrades.
