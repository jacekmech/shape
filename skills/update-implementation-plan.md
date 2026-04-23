# update implementation plan

## Purpose
Apply relevant ready updates from the PRD and/or Technical Concept to the Implementation Plan so that execution stays aligned with effective upstream changes without rewriting `done` work or blurring execution boundaries.

## When to Use
Use this skill when the user wants to propagate ready specification updates into execution planning, add new slices required by ready updates, or adjust `draft` or `ready` slices before the affected work has started.

Typical triggers:
- “update implementation plan”
- “propagate this ready update into the plan”
- “reflect the new design update in execution planning”
- “adjust the plan for this approved spec change”
- “add slices for the ready update”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- ready Implementation Plan in `03-implementation-plan.md`
- one or more ready updates in `01-prd.md` and/or `02-tech-concept.md`

Helpful but optional:
- the specific ready update to propagate
- known affected slices
- implementation constraints already discovered during execution

## Preconditions
Before updating the Implementation Plan:
- resolve the active feature and locate `01-prd.md`, `02-tech-concept.md`, and `03-implementation-plan.md`
- inspect ready updates in the PRD and Technical Concept that materially affect execution
- inspect current plan status and slice state
- identify whether the affected work is still `draft` or `ready`, already `in progress`, or already `done`

This skill should only propagate effective upstream changes.
Draft specification updates should not be treated as execution truth.

## Behavior
Update the Implementation Plan inline to reflect ready upstream changes.

When a ready update changes execution shape:
- add new slices if new work is required
- adjust existing `draft` or `ready` slices when their scope or ordering must change
- keep the execution model small, explicit, and reviewable

Respect Shape’s execution boundaries:
- `done` slices should not be rewritten
- `in progress` slices should not be reshaped in ways that invalidate active execution
- implementation tasks should not be rewritten by this skill
- downstream propagation should remain explicit rather than implied

If a ready update affects work that has already started:
- surface the conflict clearly
- prefer adding new slices or notes that account for the changed direction
- avoid silently reinterpreting already executed or active work

The responsible role remains the Developer.
The agent may propose execution reshaping, but should not silently decide how to absorb significant trade-offs without developer confirmation.

## Artifact Rules
Read the ready PRD and Technical Concept updates as upstream inputs.
Update only the Implementation Plan in `03-implementation-plan.md`.

Work against these sections:
- `## Slices`
- `## Execution Order`
- `## Relevant Files`
- `## Notes`

Apply these rules:
- the Implementation Plan is updated inline rather than through append-only updates
- only ready PRD or Technical Concept updates are effective for propagation
- new slices may be appended during implementation
- only `draft` or `ready` slices may be updated
- `in progress` slices, `done` slices, and any Implementation Tasks must not be rewritten by this skill
- `## Relevant Files` may be refreshed when upcoming execution areas changed

This skill may:
- append new slices
- update existing `draft` or `ready` slice descriptions
- adjust execution order for work that has not started
- refresh `## Relevant Files` to reflect upcoming execution reality
- add clarifying notes when propagation creates constraints or sequencing implications

This skill must not:
- modify Implementation Tasks under `## Execution Order`
- mark slices or tasks done
- rewrite `done` or `in progress` slices as if no work has happened
- treat draft upstream updates as effective

## Outputs
This skill should produce:
- an updated Implementation Plan aligned to ready upstream changes
- any new or revised `draft` or `ready` slices needed for execution
- surfaced warnings when propagation is constrained by `in progress` or `done` work
- a repository state that is ready to be committed as the planning-update checkpoint
- a clear likely next step

## Completion Signals
This skill is complete when:
- the Implementation Plan reflects the relevant ready upstream changes
- any new work is visible through slices rather than implied in prose alone
- protected boundaries around `in progress` work, `done` work, and tasks were preserved
- any propagation constraints are surfaced clearly
- the resulting plan update is clear enough to be committed before further execution planning continues
- the next likely workflow step is stated plainly

## Guardrails
- Do not propagate draft PRD or Technical Concept updates as if they were effective
- Do not rewrite Implementation Tasks through this skill
- Do not silently reinterpret closed or in-progress slices
- Do not use `## Relevant Files` as a substitute for actual slice updates when execution shape changed
- Do not hide conflicts between ready updates and already-started work
- Do not proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- `plan slice` if the updated plan now has a clear next `draft` slice
- commit changes if moving to another workflow step
- continue `update implementation plan` if propagation impact is still being resolved
- `update technical concept` or `update prd` if the upstream change is still incomplete

Prefer `plan slice` once the updated plan has a clear next slice ready for refinement.
