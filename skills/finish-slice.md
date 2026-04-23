# finish slice

## Purpose
Validate an `in progress` slice and transition it to `done` in the Implementation Plan once its tasks are completed, explicitly approved, and committed where needed.

## When to Use
Use this skill when the user wants to close an `in progress` slice whose tasks are completed, confirm that the slice objective was actually met, or transition the slice to `done` in the Implementation Plan after its approved batches have been committed where needed.

Typical triggers:
- “finish slice”
- “close this slice”
- “mark the slice done”
- “validate the `in progress` slice”
- “is this slice ready to close?”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- active slice or selected slice in `03-implementation-plan.md`
- completed approved work for that slice, committed where needed

Helpful but optional:
- specific slice objective to validate against
- recent implementation decisions that affect slice closure
- known follow-up work for the next slice

## Preconditions
Before finishing a slice:
- resolve the active feature and locate `03-implementation-plan.md`
- identify the selected slice, defaulting to the active `in progress` slice when the context is clear
- verify that the slice is currently `in progress`
- verify that the slice tasks are completed
- verify that any approved batches for the slice that should be committed have already been committed
- inspect whether the slice objective appears satisfied

This skill should close only validated slices.
If the slice is still `draft` or `ready`, if tasks remain open, or if approved work that should be committed is still uncommitted, surface that clearly instead of marking the slice `done`.

## Behavior
Validate the selected slice against its intended objective and task completion state.

During slice validation:
- confirm the slice objective is actually met
- confirm the task list reflects completed approved work
- surface any remaining gap instead of forcing closure
- keep the slice boundary explicit so the next slice starts from a clean state

If slice completion changes what future work should focus on:
- refresh `## Relevant Files` to keep fresh-session pickup useful
- keep the section selective and forward-looking rather than historical

The responsible role remains the Developer.
The agent may help validate and update the plan, but should not silently close a slice that still has unresolved work or approved changes that should be committed but are still uncommitted.

## Artifact Rules
Update only the Implementation Plan in `03-implementation-plan.md`.

Work against these sections:
- `## Slices`
- `## Execution Order`
- `## Relevant Files`
- `## Notes`

Apply these rules:
- slice completion happens only after its tasks are completed and approved batches that should be committed are committed
- the slice status in `## Slices` should change from `in progress` to `done` only after validated completion
- the corresponding slice line in `## Execution Order` should already reflect completed tasks before closure
- `## Relevant Files` may be pruned or refreshed when slice completion changes what is useful for subsequent slices

This skill may:
- transition the selected slice from `in progress` to `done` in `## Slices`
- ensure slice state is reflected consistently in the Implementation Plan
- refresh `## Relevant Files` for upcoming execution
- add a short note when it clarifies what the next slice should pick up

This skill must not:
- mark a slice `done` while tasks are still open
- close a slice that has not yet reached `in progress`
- close a slice before approved batches that should be committed are committed
- use slice closure to hide incomplete work
- mark the whole implementation done unless all slices are `done`

## Outputs
This skill should produce:
- a validated slice transitioned to `done` in the Implementation Plan
- any helpful `## Relevant Files` or note updates for the next slice
- a repository state that is ready to be committed as the slice-completion checkpoint
- a clear likely next step

## Completion Signals
This skill is complete when:
- the selected slice is validated against its objective
- the slice is transitioned from `in progress` to `done` only after task completion and commit boundaries are satisfied
- the Implementation Plan reflects the closed slice clearly
- the slice-closure state is ready to be committed before the workflow moves on
- the next likely workflow action is stated plainly

## Guardrails
- Do not close a slice with open tasks
- Do not close a slice before approved work that should be committed is committed
- Do not use slice closure as a shortcut for unresolved review or approval state
- Do not leave the next execution step implicit once a slice is closed
- Do not mark implementation done unless all slices are `done` and validated

## Likely Next Step
Usually suggest one of:
- `plan slice` for the next `draft` slice
- `finish feature` if all slices are now `done` and validated
- `update implementation plan` if slice completion exposed a needed execution reshaping

Prefer `plan slice` when more slices remain and the next one is ready to refine.
