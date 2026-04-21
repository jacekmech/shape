# update prd

## Purpose
Add a new PRD Specification Update or continue refining an existing draft update after the PRD baseline is already `ready`, while preserving append-only change handling and Product Owner ownership of requirement-level changes.

## When to Use
Use this skill when the user needs to record a requirement change, correction, clarification, or newly discovered information after the PRD baseline is already ready.

Typical triggers:
- “update prd”
- “record this requirement change”
- “add a PRD update”
- “continue the draft PRD update”
- “mark this PRD change ready”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- requirement-level change, correction, or newly discovered information

Helpful but optional:
- the intended update name
- an existing draft update already present under `## Updates`
- related downstream impact on Technical Concept or Implementation Plan

## Preconditions
Before updating the PRD:
- resolve the active feature and locate `01-prd.md`
- confirm the PRD baseline status is already `ready`
- inspect `## Updates` for existing draft and ready updates
- determine whether an existing draft update should be continued instead of creating a new one

This skill is for post-readiness PRD evolution.
If the PRD baseline is still `draft`, requirement work belongs in `create prd` instead.

## Behavior
Treat PRD changes after readiness as append-only Specification Updates.

Prefer continuing an existing draft update when it matches the current change.
Shape strongly prefers at most one draft PRD update at a time because multiple concurrent drafts increase ambiguity and drift risk.

When no suitable draft update exists:
- append a new update under `## Updates`
- give it a clear name
- set the date
- keep its status accurate as `draft` or `ready`

When refining an update:
- clarify the context that caused the change
- state the requirement change or decision explicitly
- describe the downstream impact plainly enough for later propagation

The responsible role remains the Product Owner.
The agent may draft or refine update language, but should not silently finalize requirement intent without clear user confirmation.

Only mark the update `ready` when the Product Owner explicitly accepts it as effective.

## Artifact Rules
Operate only in `01-prd.md` under `## Updates`.

Use the PRD update structure already defined by the template:
- `#### Update: <name>`
- `- **Status:** draft | ready`
- `- **Date:** YYYY-MM-DD`
- `**Context**`
- `**Change / decision**`
- `**Impact**`

Apply these lifecycle rules:
- the ready PRD baseline is immutable
- ready updates are append-only and must not be silently rewritten
- updates are appended in chronological order
- only updates with status `ready` are considered effective

This skill may:
- append a new update under `## Updates`
- continue refining an existing draft update
- change an update status between `draft` and `ready` based on explicit user confirmation

This skill must not:
- rewrite the ready PRD baseline inline
- silently edit prior ready updates
- create a generic note outside the update structure
- imply downstream propagation has already happened unless a separate step performs it

## Outputs
This skill should produce:
- a new or refined PRD Specification Update under `## Updates`
- an accurate update status of `draft` or `ready`
- a short note on likely downstream implications when relevant
- a repository state that is ready to be committed once the selected PRD update state is accepted
- a clear likely next step

## Completion Signals
This skill is complete when:
- the change is recorded under `## Updates` using the canonical update structure
- it is clear whether the update is still `draft` or already `ready`
- baseline immutability has been preserved
- any meaningful downstream consequence is visible rather than implied
- the resulting PRD update state is clear enough to serve as a commit checkpoint before downstream propagation continues
- the next likely workflow step is stated plainly

## Guardrails
- Do not rewrite the ready PRD baseline
- Do not silently modify older ready updates
- Do not create multiple competing draft updates when one should be continued
- Do not mark an update `ready` without explicit Product Owner acceptance
- Do not imply that Technical Concept or Implementation Plan already reflect the update unless that propagation step has happened
- Do not proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- continue `update prd` if the change is still incomplete or awaiting acceptance
- commit changes if moving to another workflow step
- `update technical concept` if the ready PRD update has design implications
- `show status` if the user needs orientation on downstream impact

Prefer `update technical concept` when a newly ready PRD update changes technical design expectations.
