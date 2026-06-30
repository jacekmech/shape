# finish slice

## Purpose
Validate an `approved` Slice Plan and transition it to `done` in the Implementation Plan once its tasks are completed, explicitly approved, and committed where needed.

## When to Use
Use this skill when the user wants to close an `approved` Slice Plan whose tasks are completed, confirm that the slice objective was actually met, or transition the Slice Plan to `done` in the Implementation Plan after its approved batches have been committed where needed.

Typical triggers:
- “finish slice”
- “close this slice”
- “mark the slice plan done”
- “validate the approved slice plan”
- “is this slice ready to close?”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- active Slice Plan or selected Slice Plan in `03-implementation-plan.md`
- completed approved work for that Slice Plan, committed where needed

Helpful but optional:
- specific slice objective to validate against
- recent implementation decisions that affect slice closure
- known follow-up work for the next slice

## Preconditions
Before finishing a Slice Plan:
- resolve the active feature and locate `03-implementation-plan.md`
- identify the selected Slice Plan, defaulting to the approved Slice Plan with completed tasks when the context is clear
- verify that the Slice Plan is currently `approved`
- verify that the Slice Plan tasks are completed
- verify that any approved batches for the Slice Plan that should be committed have already been committed
- inspect whether the slice objective appears satisfied

This skill should close only validated Slice Plans.
If the Slice Plan is still `draft`, if tasks remain open, or if approved work that should be committed is still uncommitted, surface that clearly instead of marking the Slice Plan `done`.

## Behavior
Validate the selected slice against its intended objective and task completion state.

During Slice Plan validation:
- confirm the slice objective is actually met
- confirm the task list reflects completed approved work
- surface any remaining gap instead of forcing closure
- keep the slice boundary explicit so the next slice starts from a clean state

If slice completion changes what future work should focus on:
- refresh `## Relevant Files` to keep fresh-session pickup useful
- keep the section selective and forward-looking rather than historical

The responsible role remains the Developer.
The agent may help validate and update the plan, but should not silently close a Slice Plan that still has unresolved work or approved changes that should be committed but are still uncommitted.

## Workflow Boundary Rules

- YOU MUST stop for Developer review before changing a Slice Plan from `approved` to `done`.
- YOU MUST NOT mark a Slice Plan `done` unless the Developer explicitly approves closing that Slice Plan.
- After finishing this Shape operation, YOU MUST ask whether to prepare and submit a commit for the accepted Slice Plan closure diff.
- YOU MUST NOT create a commit unless the Developer explicitly approves committing the current diff.
- After the commit boundary is resolved, YOU MUST ask whether to proceed to the next Shape workflow step.
- YOU MUST NOT proceed to planning the next Slice Plan, finishing the feature, or any other next Shape workflow step unless the Developer explicitly approves proceeding.

## Artifact Rules
Update only the Implementation Plan in `03-implementation-plan.md`.

Work against these sections:
- `## Slice Plans`
- `## Execution Order`
- `## Relevant Files`
- `## Notes`

Apply these rules:
- Slice Plan completion happens only after its tasks are completed and approved batches that should be committed are committed
- the Slice Plan status in `## Slice Plans` should change from `approved` to `done` only after validated completion
- the corresponding Slice Plan line in `## Execution Order` should already reflect completed tasks before closure
- `## Relevant Files` may be pruned or refreshed when slice completion changes what is useful for subsequent slices

This skill may:
- transition the selected Slice Plan from `approved` to `done` in `## Slice Plans`
- ensure Slice Plan state is reflected consistently in the Implementation Plan
- refresh `## Relevant Files` for upcoming execution
- add a short note when it clarifies what the next slice should pick up

This skill must not:
- mark a Slice Plan `done` while tasks are still open
- close a Slice Plan that has not yet reached `approved`
- close a Slice Plan before approved batches that should be committed are committed
- use slice closure to hide incomplete work
- mark the whole implementation done unless all Slice Plans are `done`

## Outputs
This skill should produce:
- a validated Slice Plan transitioned to `done` in the Implementation Plan
- any helpful `## Relevant Files` or note updates for the next slice
- a repository state that is ready to be committed as the slice-completion checkpoint
- a proposed commit message when the accepted slice-closure state is suitable for checkpointing
- a clear likely next step

## Completion Signals
This skill is complete when:
- the selected slice is validated against its objective
- the Slice Plan is transitioned from `approved` to `done` only after task completion and commit boundaries are satisfied
- the Implementation Plan reflects the closed Slice Plan clearly
- the slice-closure state is ready to be committed before the workflow moves on
- the accepted checkpoint is clear enough that the agent can propose a commit cleanly
- the next likely workflow action is stated plainly

## Guardrails
- YOU MUST NOT close a Slice Plan with open tasks
- YOU MUST NOT close a Slice Plan before approved work that should be committed is committed
- YOU MUST NOT use slice closure as a shortcut for unresolved review or approval state
- YOU MUST NOT leave the next execution step implicit once a slice is closed
- YOU MUST NOT mark implementation done unless all Slice Plans are `done` and validated

## Likely Next Step
Usually suggest one of:
- propose a commit message and offer to create the commit if the slice-closure checkpoint is accepted and the user wants to record it now
- `plan slice` for the next `draft` Slice Plan
- `finish feature` if all Slice Plans are now `done` and validated
- `update implementation plan` if slice completion exposed a needed execution reshaping

Prefer `plan slice` when more Slice Plans remain and the next one is still `draft`, the commit boundary is resolved, and the Developer explicitly approves proceeding.
