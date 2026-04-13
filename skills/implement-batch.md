# implement batch

## Purpose
Execute a developer-selected batch of implementation tasks in code and hand the result off for review and approval without crossing the approval boundary or silently expanding batch scope.

## When to Use
Use this skill when the user wants to implement one or more selected implementation tasks from the active slice, produce the code changes for a small batch, and prepare the result for developer review.

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

## Preconditions
Before implementing a batch:
- resolve the active feature and locate `03-implementation-plan.md`
- inspect the selected slice and tasks in `## Execution Order`
- confirm the batch is explicitly selected by the developer
- confirm the previous approved batch, if any, has already been committed before starting a new one

This skill should work from an explicit batch definition.
If the next tasks are not selected yet, redirect to developer batch selection rather than silently choosing scope.

## Behavior
Implement only the selected batch in code.

During execution:
- stay within the selected task scope
- do not select or reorder tasks
- keep the batch small enough for a single high-quality developer review step
- use repository guidance and local validation expectations when changing code

If execution reveals issues outside the selected batch:
- surface them clearly
- avoid silently expanding the batch
- suggest an upstream update or future slice adjustment when appropriate

This skill may update temporary execution state if needed, but it must preserve the review boundary:
- do not mark tasks done merely because code was written
- do not treat the batch as approved
- do not treat `## Relevant Files` changes as accepted until review confirms the batch

The responsible role remains the Developer.
The agent implements the selected work, but approval still happens afterward through review.

## Artifact Rules
Read the Implementation Plan in `03-implementation-plan.md` to confirm selected tasks and execution context.

Apply these rules:
- execution occurs against the selected batch only
- batches are not explicitly represented in the Implementation Plan
- task completion is finalized only after developer approval during review
- any proposed `## Relevant Files` update should reflect touched areas but should be finalized only after review

This skill may:
- change repository code and related files needed to complete the selected batch
- run relevant checks when appropriate
- prepare a concise mapping from selected tasks to implemented changes
- prepare a proposed `## Relevant Files` update for later review

This skill must not:
- select or reorder tasks
- mark tasks approved or done
- begin work on the next batch
- imply that review or commit already happened

## Outputs
This skill should produce:
- code changes for the selected batch
- a clear summary of what was implemented against the selected tasks
- any checks run and their results
- an explicit handoff to review as the next step

## Completion Signals
This skill is complete when:
- the selected batch has been implemented in code
- the result is described clearly enough for focused developer review
- approval state is still correctly shown as awaiting review or approval
- the next likely workflow action is stated plainly

## Guardrails
- Do not silently expand beyond the selected batch
- Do not mark tasks done merely because implementation finished
- Do not present same-session implementation as approval
- Do not start a new batch before the current approved batch is committed
- Do not end without clearly asking for review and approval

## Likely Next Step
Usually suggest one of:
- `review batch`
- continue `implement batch` if the developer requests a revision of the same selected tasks
- `record implementation decision` if execution revealed a clarification or trade-off worth capturing

Prefer `review batch` as the default next step once the selected batch has been implemented.
