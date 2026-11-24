# finish iteration

## Purpose
Validate an `approved` Iteration and transition it to `done` in the Implementation Plan once its tasks are completed, explicitly approved, and committed where needed.

## Artifact resolution and compatibility
Read `.shape/config.json` before resolving artifacts. Filenames below are fresh-install defaults; use configured `featuresRoot` and `artifacts.productSpecification`, `artifacts.technicalSpecification`, and `artifacts.implementationPlan` values instead when present. Older configurations may use `prd` and `technicalConcept` keys. Existing `01-prd.md`, `02-tech-concept.md`, and “Slice Plan” headings remain valid; interpret them as Product Specification, Technical Specification, and Iteration without renaming files or rewriting existing documents solely for terminology.

For any specification input, read its `## Source` when present and follow the referenced document and relevant sections, including approved source-revision updates. A reference artifact is valid without the full authored template. If the source is inaccessible or materially changed since review, surface the gap and pause dependent work until it is resolved; do not infer readiness from the link or status alone. Read `.shape/workflow-templates/specification-reference-template.md` for reference and revision rules.

## When to Use
Use this skill when the user wants to close an `approved` Iteration whose tasks are completed, confirm that the iteration objective was actually met, or transition the Iteration to `done` in the Implementation Plan after its approved batches have been committed where needed.

Typical triggers:
- “finish iteration”
- “close this iteration”
- “mark the iteration done”
- “validate the approved iteration”
- “is this iteration ready to close?”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- active Iteration or selected Iteration in `03-implementation-plan.md`
- completed approved work for that Iteration, committed where needed

Helpful but optional:
- specific iteration objective to validate against
- recent implementation decisions that affect iteration closure
- known follow-up work for the next iteration

## Preconditions
Before finishing an Iteration:
- resolve the active feature and locate `03-implementation-plan.md`
- identify the selected Iteration, defaulting to the approved Iteration with completed tasks when the context is clear
- verify that the Iteration is currently `approved`
- verify that the Iteration tasks are completed
- verify that any approved batches for the Iteration that should be committed have already been committed, subject to the final-batch procedure below
- inspect whether the iteration objective appears satisfied

This skill should close only validated Iterations.
If the Iteration is still `draft`, if tasks remain open, or if approved work that should be committed is still uncommitted, surface that clearly instead of marking the Iteration `done`.

### Closure with the final batch

When the Developer explicitly approves closure and the final approved batch is the only pending checkpoint, validate the Iteration and verify that all its tasks are complete. If both codebase and Shape changes remain, use the `implement batch` commit proposal for both. Propose the codebase commit first and the Shape commit second, with closure listed in the Shape commit's scope. Wait for the codebase commit to succeed before marking the Iteration `done`. The Shape commit then records the final batch's artifact updates and Iteration closure together. When the final batch is already committed and only closure changes remain, propose a single commit with a subject that identifies the Shape artifact change. Use `shape:` when it fits repository conventions.

## Behavior
Validate the selected iteration against its intended objective and task completion state.

During Iteration validation:
- confirm the iteration objective is actually met
- confirm the task list reflects completed approved work
- surface any remaining gap instead of forcing closure
- keep the iteration boundary explicit so the next iteration starts from a clean state

If iteration completion changes what future work should focus on:
- refresh `## Relevant Files` to keep fresh-session pickup useful
- keep the section selective and forward-looking rather than historical

The responsible role remains the Developer.
The agent may help validate and update the plan. The final-batch procedure still requires explicit approval of closure and a successful codebase commit before the Iteration status changes.

## Workflow Boundary Rules

- YOU MUST stop for Developer review before changing an Iteration from `approved` to `done`.
- YOU MUST NOT mark an Iteration `done` unless the Developer explicitly approves closing that Iteration.
- After finishing this Shape operation, YOU MUST ask whether to prepare and submit a commit for the accepted Iteration closure diff, unless that commit is already covered by explicit consent for the final-batch proposal.
- YOU MUST NOT create a commit unless the Developer explicitly approves committing the current diff.
- After the commit boundary is resolved, YOU MUST ask whether to proceed to the next Shape workflow step.
- YOU MUST NOT proceed to planning the next Iteration, finishing the feature, or any other next Shape workflow step unless the Developer explicitly approves proceeding.

## Artifact Rules
Update only the Implementation Plan in `03-implementation-plan.md`.

Work against these sections:
- `## Iterations`
- `## Execution Order`
- `## Relevant Files`
- `## Notes`

Apply these rules:
- Iteration completion requires completed tasks and committed approved batches, with the final batch's Shape changes allowed in the closure commit as described above
- the Iteration status in `## Iterations` should change from `approved` to `done` only after validated completion
- the corresponding Iteration line in `## Execution Order` should already reflect completed tasks before closure
- `## Relevant Files` may be pruned or refreshed when iteration completion changes what is useful for subsequent iterations

This skill may:
- transition the selected Iteration from `approved` to `done` in `## Iterations`
- ensure Iteration state is reflected consistently in the Implementation Plan
- refresh `## Relevant Files` for upcoming execution
- add a short note when it clarifies what the next iteration should pick up

This skill must not:
- mark an Iteration `done` while tasks are still open
- close an Iteration that has not yet reached `approved`
- close an Iteration with uncommitted approved batch work outside the final-batch procedure above
- use iteration closure to hide incomplete work
- mark the whole implementation done unless all Iterations are `done`

## Outputs
This skill should produce:
- a validated Iteration transitioned to `done` in the Implementation Plan
- any helpful `## Relevant Files` or note updates for the next iteration
- a repository state that is ready to be committed as the iteration-completion checkpoint
- a proposed commit message when the accepted iteration-closure state is suitable for checkpointing
- a clear likely next step

## Completion Signals
This skill is complete when:
- the selected iteration is validated against its objective
- the Iteration is transitioned from `approved` to `done` only after task completion and commit boundaries are satisfied
- the Implementation Plan reflects the closed Iteration clearly
- the iteration-closure state is ready to be committed before the workflow moves on
- the accepted checkpoint is clear enough that the agent can propose a commit cleanly
- the next likely workflow action is stated plainly

## Guardrails
- YOU MUST NOT close an Iteration with open tasks
- YOU MUST verify the required codebase commits before marking the Iteration `done`
- YOU MUST NOT use iteration closure as a shortcut for unresolved review or approval state
- YOU MUST NOT leave the next execution step implicit once an iteration is closed
- YOU MUST NOT mark implementation done unless all Iterations are `done` and validated

## Likely Next Step
Usually suggest one of:
- propose a commit message and offer to create the commit if the iteration-closure checkpoint is accepted and the user wants to record it now
- `plan iteration` for the next `draft` Iteration
- `finish feature` if all Iterations are now `done` and validated
- `update implementation plan` if iteration completion exposed a needed execution reshaping

Prefer `plan iteration` when more Iterations remain and the next one is still `draft`, the commit boundary is resolved, and the Developer explicitly approves proceeding.

## Follow-up Questions

- When a follow-up is needed, put one question in its own final paragraph after any summary, findings, checks, or links. Do the same when pausing for input.
- Use yes/no for a single named action. Ask for approval, commit consent, and permission to start the next step at their respective checkpoints.
- If the answer requires a choice or missing detail, give context first and ask directly for the input. End with the result when no input is needed and there is no concrete next action to offer.
