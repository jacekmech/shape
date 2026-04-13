# finish implementation

## Purpose
Conclude implementation for the active feature after all slices are completed and validated by marking the Implementation Plan as `done` and making the finished state explicit.

## When to Use
Use this skill when the user wants to finalize feature implementation, close the Implementation Plan after all slice work is complete, or confirm that implementation has actually reached the `done` state.

Typical triggers:
- “finish implementation”
- “finalize implementation”
- “mark the plan done”
- “close out this feature implementation”
- “is implementation complete?”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- completed Implementation Plan in `03-implementation-plan.md`

Helpful but optional:
- confirmation that the final slice was just validated
- any final notes about follow-up work outside the current feature scope

## Preconditions
Before finishing implementation:
- resolve the active feature and locate `03-implementation-plan.md`
- verify that all slices are marked completed
- verify that slice validation is complete
- verify that the Implementation Plan reflects full execution progress
- confirm there is no remaining open batch, review, approval, or commit boundary blocking completion

This skill should conclude implementation only when the feature is actually implemented in code and the plan reflects that state.
If unfinished slices or unresolved execution boundaries remain, surface that clearly instead of marking the plan `done`.

## Behavior
Validate overall implementation completion and close the Implementation Plan.

During completion:
- confirm all slices are completed and validated
- confirm the plan status should now move to `done`
- surface any residual structural warning rather than silently closing an incomplete plan
- keep the final state compact and clear

The responsible role remains the Developer.
The agent may help verify completion and update the artifact, but should not silently finalize implementation if meaningful execution work is still unresolved.

## Artifact Rules
Update only the Implementation Plan in `03-implementation-plan.md`.

Work against these sections:
- `## Header`
- `## Slices`
- `## Notes`

Apply these rules:
- implementation ends when all slices are completed and validated
- the Implementation Plan status is set to `done` only at that point
- the plan should reflect full progress at completion
- finishing implementation does not rewrite upstream PRD or Technical Concept artifacts

This skill may:
- set plan status to `done`
- add a short completion note when it clarifies that implementation is finished
- surface any remaining mismatch if completion is not yet justified

This skill must not:
- mark the plan `done` while any slice remains open
- hide unfinished review, approval, or commit boundaries
- use finalization to compensate for stale or inaccurate plan state
- reopen completed slices as part of completion unless a real inconsistency must be surfaced first

## Outputs
This skill should produce:
- an Implementation Plan marked `done`
- a clear statement that implementation is complete, or a clear warning if it is not yet justified
- a clear likely next step

## Completion Signals
This skill is complete when:
- all slices are complete and validated
- the Implementation Plan status is correctly set to `done`
- the finished implementation state is explicit and not ambiguous
- the next likely workflow action is stated plainly

## Guardrails
- Do not mark implementation done with open slices
- Do not ignore unresolved batch, review, approval, or commit boundaries
- Do not use finalization to paper over inaccurate plan state
- Do not confuse “mostly complete” with `done`
- Do not end without stating whether implementation is truly complete

## Likely Next Step
Usually suggest one of:
- `show status` if the user wants a final workflow snapshot
- `pick up feature` only if the user intends to inspect the completed feature again in a later session

Prefer `show status` as the default follow-up once implementation is finalized.
