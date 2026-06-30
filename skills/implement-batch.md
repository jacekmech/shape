# implement batch

## Purpose
Execute an explicitly approved developer-selected batch of implementation tasks in code, support review and revision on that same batch, update execution state only after explicit developer approval, and carry the batch through commit without silently expanding scope or collapsing approval boundaries.

## When to Use
Use this skill when the user wants to implement one or more selected implementation tasks from the active Slice Plan, produce the code changes for a small batch, and prepare the result for developer review.

Typical triggers:
- “implement batch”
- “implement these tasks”
- “do the next batch”
- “code the selected tasks”
- “execute this batch”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- Implementation Plan with prepared tasks in `03-implementation-plan.md`
- explicit developer-selected task batch

Helpful but optional:
- preferred validation commands
- known repository constraints or relevant files for the batch
- recent review feedback on prior iterations of the same batch
- whether commit should happen in this same flow if the batch is later explicitly approved

## Preconditions
Before implementing a batch:
- resolve the active feature and locate `03-implementation-plan.md`
- inspect the selected Slice Plan and tasks in `## Execution Order`
- confirm the selected Slice Plan is `approved`
- confirm the batch is explicitly selected and approved by the Developer
- confirm the previous approved batch, if any, has already been committed before starting a new one

This skill should work from an explicit batch definition.
If the next tasks are not selected yet, redirect to developer batch selection rather than silently choosing scope.

## Behavior
Implement only the selected batch in code, then keep the workflow inside that same batch until the Developer either requests revision, explicitly approves it, or completes the commit boundary for that approved batch.

During execution:
- stay within the selected task scope
- do not select or reorder tasks
- keep the batch small enough for a single high-quality developer review step
- use repository guidance and local validation expectations when changing code
- update `## Relevant Files` to reflect the resulting implementation state when the touched file map changed materially
- update `## Important Decisions` when implementation introduced decisions, clarifications, or trade-offs worth preserving for subsequent execution

If execution reveals issues outside the selected batch:
- surface them clearly
- avoid silently expanding the batch
- suggest an upstream update or future slice adjustment when appropriate

After implementation:
- summarize the selected-task coverage clearly
- ask the Developer to review the batch
- make the current state explicit as `awaiting review` or `under revision`
- if the Developer requests revisions, continue only within the same selected batch unless a new batch is explicitly chosen

Only after the Developer explicitly approves the batch may this skill:
- mark the relevant tasks done in `## Execution Order`
- leave Slice Plan and Implementation Plan artifact status unchanged unless a separate validation step moves the Slice Plan to `done`
- refresh `## Relevant Files` when accepted implementation changed what matters next
- update `## Important Decisions` when accepted implementation introduced decisions worth preserving
- state clearly that the batch is `approved but awaiting commit`

Commit remains a separate consent boundary inside the same skill flow:
- YOU MUST NOT commit merely because the batch was approved
- commit only if the Developer explicitly instructs you to commit
- keep the commit scoped to the approved batch
- surface unrelated-change contamination before committing
- state clearly when the batch is `approved but awaiting commit`
- state clearly when the batch is `committed`

Treat commit as part of completing this operation:
- YOU MUST NOT treat `approved and marked done` as the final completion state of `implement batch`
- YOU MUST NOT move to the next batch or workflow operation until the approved batch has been committed, either by the Developer or by the agent on explicit instruction

This skill may update the live Implementation Plan during execution and approval handling, but it must preserve the approval boundary:
- YOU MUST NOT mark tasks done merely because code was written
- YOU MUST NOT treat the batch as approved
- YOU MUST NOT treat implementation completion as approval
- YOU MUST NOT treat approval as commit
- YOU MUST NOT treat approved-but-uncommitted work as a completed `implement batch` outcome

The responsible role remains the Developer.
The agent implements the selected work, supports review, and can perform the commit, but approval and commit consent still come from the Developer.

## Workflow Boundary Rules

- YOU MUST stop for Developer review after implementing the selected batch.
- YOU MUST NOT mark tasks done until the Developer explicitly approves the implemented batch.
- After marking approved tasks done, YOU MUST ask whether to prepare and submit a commit for the approved batch diff.
- YOU MUST NOT create a commit unless the Developer explicitly approves committing the current diff.
- YOU MUST NOT start another batch, finish the slice, or move to any other Shape workflow step until the approved batch commit boundary is resolved.
- After the commit boundary is resolved, YOU MUST ask whether to proceed to the next Shape workflow step.
- YOU MUST NOT proceed to the next Shape workflow step unless the Developer explicitly approves proceeding.

## Artifact Rules
Read the Implementation Plan in `03-implementation-plan.md` to confirm selected tasks and execution context.

Apply these rules:
- execution occurs against the selected batch only
- batches are not explicitly represented in the Implementation Plan
- task completion is finalized only after explicit developer approval
- `## Relevant Files` should reflect resulting implementation state rather than becoming a historical changelog
- `## Important Decisions` should capture implementation-time decisions that matter for subsequent slices or future review
- these implementation-plan updates do not by themselves imply approval of the batch
- implementation progress is inferred from approved task completion under an approved Slice Plan
- the Implementation Plan remains `approved` until all Slice Plans are `done` and the feature is finished

This skill may:
- change repository code and related files needed to complete the selected batch
- run relevant checks when appropriate
- update `## Relevant Files` in `03-implementation-plan.md`
- update `## Important Decisions` in `03-implementation-plan.md`
- mark approved tasks done in `## Execution Order` after explicit approval
- create a repository commit for the approved batch after explicit user instruction
- prepare a concise mapping from selected tasks to implemented changes

This skill must not:
- select or reorder tasks
- mark tasks approved or done before explicit approval
- begin work on the next batch
- imply that review, approval, or commit already happened
- YOU MUST NOT commit without explicit user instruction

## Outputs
This skill should produce:
- code changes for the selected batch
- any resulting `03-implementation-plan.md` updates needed to reflect implementation state or approved task completion
- a clear summary of what was implemented against the selected tasks
- any checks run and their results
- an explicit current state such as awaiting review, under revision, awaiting approval, approved but awaiting commit, or committed
- an explicit review request until approval happens
- a clear likely next step

## Completion Signals
This skill is complete when:
- the selected batch has been implemented in code
- the result is described clearly enough for focused developer review
- approval state is still shown correctly until explicit approval happens
- any approved task completion updates occur only after explicit approval
- any commit happens only after explicit user instruction when the agent is the one creating it
- the approved batch has crossed its commit boundary before the workflow moves on
- the next likely workflow action is stated plainly

## Guardrails
- YOU MUST NOT silently expand beyond the selected batch
- YOU MUST NOT mark tasks done before explicit approval
- YOU MUST NOT present same-session implementation as approval
- YOU MUST NOT present approval as commit
- YOU MUST NOT treat approved-but-uncommitted work as a finished `implement batch`
- YOU MUST NOT start a new batch before the current approved batch is committed
- YOU MUST NOT end without clearly asking for review and approval
- YOU MUST NOT proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- continue `implement batch` if the developer requests a revision of the same selected tasks
- explicit approval review on the current batch
- explicit commit instruction for the approved batch
- commit changes if commit instruction approved and moving to another workflow step
- `finish slice` if the slice is fully complete and the approved work has been committed

Prefer continuing `implement batch` as the same-batch review and revision loop until approval is explicit. Prefer `finish slice` only after the approved batch commit boundary is resolved and the Developer explicitly approves proceeding.
