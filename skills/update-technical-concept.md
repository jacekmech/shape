# update technical concept

## Purpose
Add a new Technical Concept Specification Update or continue refining an existing draft Technical Concept update after the baseline is already `approved`, while preserving append-only change handling and Architect ownership of design-level changes.

## When to Use
Use this skill when the user needs to record a design change, correction, clarified constraint, or newly discovered technical information after the Technical Concept baseline is already approved.

Typical triggers:
- “update technical concept”
- “record this design change”
- “add a tech concept update”
- “continue the draft technical update”
- “mark this design update approved”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- design-level change, correction, or newly discovered technical information

Helpful but optional:
- the intended update name
- an existing draft update already present under `## Updates`
- related downstream impact on the Implementation Plan or PRD

## Preconditions
Before updating the Technical Concept:
- resolve the active feature and locate `02-tech-concept.md`
- confirm the Technical Concept baseline status is already `approved`
- inspect `## Updates` for existing draft and approved updates
- inspect repository guidance or codebase context when the change is driven by actual implementation or repository constraints
- determine whether an existing draft update should be continued instead of creating a new one

This skill is for post-approval Technical Concept evolution.
If the Technical Concept baseline is still `draft`, design work belongs in `create technical concept` instead.

## Behavior
Treat Technical Concept changes after readiness as append-only Specification Updates.

Prefer continuing an existing draft update when it matches the current change.
Shape strongly prefers at most one draft update per target document at a time because multiple concurrent drafts increase ambiguity and drift risk.

When no suitable draft update exists:
- append a new update under `## Updates`
- give it a clear name
- set the date
- keep its status accurate as `draft` or `approved`

When refining an update:
- explain the context that caused the design change
- state the design change or decision explicitly
- describe the impact on execution planning, repository alignment, interfaces, validation, or risk where relevant

The responsible role remains the Architect.
The agent may draft or refine update language, but should not silently finalize uncertain design intent without clear user confirmation.

Only mark the update `approved` when the Architect explicitly accepts it as effective.

## Workflow Boundary Rules

- YOU MUST stop for Architect review before changing a Technical Concept Specification Update from `draft` to `approved`.
- YOU MUST NOT mark a Technical Concept Specification Update `approved` unless the Architect explicitly approves that transition.
- After finishing this Shape operation, YOU MUST ask whether to prepare and submit a commit for the accepted Technical Concept update diff.
- YOU MUST NOT create a commit unless the Architect explicitly approves committing the current diff.
- After the commit boundary is resolved, YOU MUST ask whether to proceed to the next Shape workflow step.
- YOU MUST NOT proceed to downstream propagation or any other next Shape workflow step unless the Architect explicitly approves proceeding.

## Artifact Rules
Operate only in `02-tech-concept.md` under `## Updates`.

Use the Technical Concept update structure already defined by the template:
- `#### Update: <name>`
- `- **Status:** draft | approved`
- `- **Date:** YYYY-MM-DD`
- `**Context**`
- `**Change / decision**`
- `**Impact**`

Apply these lifecycle rules:
- the approved Technical Concept baseline is immutable
- approved updates are append-only and must not be silently rewritten
- updates are appended in chronological order
- only updates with status `approved` are considered effective

This skill may:
- append a new update under `## Updates`
- continue refining an existing draft update
- change an update status between `draft` and `approved` based on explicit user confirmation

This skill must not:
- rewrite the approved Technical Concept baseline inline
- silently edit prior approved updates
- use `## Important Decisions` in the Implementation Plan as a substitute for a real design update when the change belongs in the Technical Concept
- imply downstream propagation has already happened unless a separate step performs it

## Outputs
This skill should produce:
- a new or refined Technical Concept Specification Update under `## Updates`
- an accurate update status of `draft` or `approved`
- a short note on likely downstream implications when relevant
- a repository state that is ready to be committed once the selected Technical Concept update state is accepted
- a proposed commit message when the accepted Technical Concept update state is suitable for checkpointing
- a clear likely next step

## Completion Signals
This skill is complete when:
- the change is recorded under `## Updates` using the canonical update structure
- it is clear whether the update is still `draft` or already `approved`
- baseline immutability has been preserved
- any meaningful downstream consequence for implementation planning or PRD alignment is visible rather than implied
- the resulting Technical Concept update state is clear enough to serve as a commit checkpoint before downstream propagation continues
- the accepted checkpoint is clear enough that the agent can propose a commit cleanly
- the next likely workflow step is stated plainly

## Guardrails
- Do not rewrite the approved Technical Concept baseline
- Do not silently modify older approved updates
- Do not create multiple competing draft updates when one should be continued
- YOU MUST NOT mark an update `approved` without explicit Architect acceptance
- Do not imply that the Implementation Plan already reflects the update unless that propagation step has happened
- YOU MUST NOT proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- continue `update technical concept` if the change is still incomplete or awaiting acceptance
- propose a commit message and offer to create the commit if the current Technical Concept update state is accepted and the user wants a checkpoint
- `update implementation plan` if the approved design update changes execution planning
- `update prd` if the design change revealed a requirement-level issue

Prefer `update implementation plan` when a newly approved Technical Concept update changes slices or execution intent, the commit boundary is resolved, and the Architect explicitly approves proceeding.
