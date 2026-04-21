# update technical concept

## Purpose
Add a new Technical Concept Specification Update or continue refining an existing draft Technical Concept update after the baseline is already `ready`, while preserving append-only change handling and Architect ownership of design-level changes.

## When to Use
Use this skill when the user needs to record a design change, correction, clarified constraint, or newly discovered technical information after the Technical Concept baseline is already ready.

Typical triggers:
- “update technical concept”
- “record this design change”
- “add a tech concept update”
- “continue the draft technical update”
- “mark this design update ready”

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
- confirm the Technical Concept baseline status is already `ready`
- inspect `## Updates` for existing draft and ready updates
- inspect repository guidance or codebase context when the change is driven by actual implementation or repository constraints
- determine whether an existing draft update should be continued instead of creating a new one

This skill is for post-readiness Technical Concept evolution.
If the Technical Concept baseline is still `draft`, design work belongs in `create technical concept` instead.

## Behavior
Treat Technical Concept changes after readiness as append-only Specification Updates.

Prefer continuing an existing draft update when it matches the current change.
Shape strongly prefers at most one draft update per target document at a time because multiple concurrent drafts increase ambiguity and drift risk.

When no suitable draft update exists:
- append a new update under `## Updates`
- give it a clear name
- set the date
- keep its status accurate as `draft` or `ready`

When refining an update:
- explain the context that caused the design change
- state the design change or decision explicitly
- describe the impact on execution planning, repository alignment, interfaces, validation, or risk where relevant

The responsible role remains the Architect.
The agent may draft or refine update language, but should not silently finalize uncertain design intent without clear user confirmation.

Only mark the update `ready` when the Architect explicitly accepts it as effective.

## Artifact Rules
Operate only in `02-tech-concept.md` under `## Updates`.

Use the Technical Concept update structure already defined by the template:
- `#### Update: <name>`
- `- **Status:** draft | ready`
- `- **Date:** YYYY-MM-DD`
- `**Context**`
- `**Change / decision**`
- `**Impact**`

Apply these lifecycle rules:
- the ready Technical Concept baseline is immutable
- ready updates are append-only and must not be silently rewritten
- updates are appended in chronological order
- only updates with status `ready` are considered effective

This skill may:
- append a new update under `## Updates`
- continue refining an existing draft update
- change an update status between `draft` and `ready` based on explicit user confirmation

This skill must not:
- rewrite the ready Technical Concept baseline inline
- silently edit prior ready updates
- use `## Important Decisions` in the Implementation Plan as a substitute for a real design update when the change belongs in the Technical Concept
- imply downstream propagation has already happened unless a separate step performs it

## Outputs
This skill should produce:
- a new or refined Technical Concept Specification Update under `## Updates`
- an accurate update status of `draft` or `ready`
- a short note on likely downstream implications when relevant
- a repository state that is ready to be committed once the selected Technical Concept update state is accepted
- a clear likely next step

## Completion Signals
This skill is complete when:
- the change is recorded under `## Updates` using the canonical update structure
- it is clear whether the update is still `draft` or already `ready`
- baseline immutability has been preserved
- any meaningful downstream consequence for implementation planning or PRD alignment is visible rather than implied
- the resulting Technical Concept update state is clear enough to serve as a commit checkpoint before downstream propagation continues
- the next likely workflow step is stated plainly

## Guardrails
- Do not rewrite the ready Technical Concept baseline
- Do not silently modify older ready updates
- Do not create multiple competing draft updates when one should be continued
- Do not mark an update `ready` without explicit Architect acceptance
- Do not imply that the Implementation Plan already reflects the update unless that propagation step has happened
- Do not proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- continue `update technical concept` if the change is still incomplete or awaiting acceptance
- commit changes if moving to another workflow step
- `update implementation plan` if the ready design update changes execution planning
- `update prd` if the design change revealed a requirement-level issue

Prefer `update implementation plan` when a newly ready Technical Concept update changes slices or execution intent.
