# implement batch

## Purpose
Implement the task batch the user selects and explicitly approves for execution. Support review and revision of that batch, update execution state only after the user approves the implemented work, and carry the approved changes through commit.

## Artifact resolution and compatibility
Read `.shape/config.json` before resolving artifacts. Filenames below are fresh-install defaults; use configured `featuresRoot` and `artifacts.productSpecification`, `artifacts.technicalSpecification`, and `artifacts.implementationPlan` values instead when present. Older configurations may use `prd` and `technicalConcept` keys. Existing `01-prd.md`, `02-tech-concept.md`, and “Slice Plan” headings remain valid; interpret them as Product Specification, Technical Specification, and Iteration without renaming files or rewriting existing documents solely for terminology.

For any specification input, read its `## Source` when present and follow the referenced document and relevant sections, including approved source-revision updates. A reference artifact is valid without the full authored template. If the source is inaccessible or materially changed since review, surface the gap and pause dependent work until it is resolved; do not infer readiness from the link or status alone. Read `.shape/workflow-templates/specification-reference-template.md` for reference and revision rules.

## When to Use
Use this skill when the user wants to implement one or more selected implementation tasks from the active Iteration, produce the code changes for a small batch, and prepare the result for developer review.

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
- task batch explicitly selected by the user

Helpful but optional:
- preferred validation commands
- known repository constraints or relevant files for the batch
- recent review feedback on prior iterations of the same batch
- whether commit should happen in this same flow if the batch is later explicitly approved

## Preconditions
Before implementing a batch:
- resolve the active feature and locate `03-implementation-plan.md`
- inspect the selected Iteration and tasks in `## Execution Order`
- confirm the selected Iteration is `approved`
- confirm the batch is explicitly selected and approved by the user
- confirm the previous approved batch, if any, has already been committed before starting a new one

This skill should work from an explicit batch definition.
If the next tasks are still open for selection, ask the user which tasks to include in the batch.

## Behavior
Implement only the selected batch in code, then keep the workflow inside that same batch until the user either requests revision, explicitly approves it, or completes the commit boundary for that approved batch.

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
- suggest an upstream update or future iteration adjustment when appropriate

After implementation:
- conclude with the required `## Batch Summary` handoff section described below
- make the current state explicit as `awaiting review` or `under revision`
- if the user requests revisions, continue only within the same selected batch unless a new batch is explicitly chosen

### Batch Summary handoff

Include a concise `## Batch Summary` section that is self-contained and suitable to copy into a fresh session. Keep the section in this order:

- **Implemented:** a coarse-grained, skimmable bullet list of the completed work. Describe outcomes or areas changed, rather than repeating every edit or file.
- Immediately below that list, one brief sentence naming the implemented task numbers and pointing to the Iteration and `03-implementation-plan.md` that define them. For example: `Implemented tasks 1 and 2 from Iteration 3 in [03-implementation-plan.md](path/to/03-implementation-plan.md).`
- Close the section with the current-state sentence, such as: `The batch is ready and awaiting your review and approval.` Do not explicitly frame this section as a code-review request.

Do not duplicate this content elsewhere in the response. Keep the handoff short enough to scan in about five seconds while retaining the task and plan reference needed to recover the execution context.

Place the follow-up below the handoff in its own final paragraph. When the batch is ready for review, ask “Do you approve this batch?” Once the batch is approved and awaiting commit consent, use the commit proposal below.

Only after the user explicitly approves the batch may this skill:
- mark the relevant tasks done in `## Execution Order`
- leave Iteration and Implementation Plan status unchanged unless a separate validation step moves the Iteration to `done`
- refresh `## Relevant Files` when accepted implementation changed what matters next
- update `## Important Decisions` when accepted implementation introduced decisions worth preserving
- state clearly that the batch is `approved but awaiting commit`

### Commit proposal and execution

Use the configured feature root and resolved feature folder paths to identify Shape artifacts. Files inside Shape feature folders are Shape artifacts. All other files are non-Shape changes, including code, tests, configuration, and documentation outside those folders.

- After marking approved tasks done, review the scoped diff. If commit consent is still needed, YOU MUST report the task changes and propose the commit subject and scope in the same reply. End with one yes/no question asking whether to create the proposed commit or commits.
- If the approved scope contains both kinds of changes, YOU MUST keep two commits in the sequence. When proposing them, list the codebase commit first and the Shape artifact commit second, with a subject and scope for each. One consent question covers both in that order. If only one kind of change remains to commit, propose one commit.
- The Shape commit subject MUST identify the Shape artifact changes. Use `shape:` when it fits the repository's commit conventions. A subject such as `Record Shape batch completion` also makes the scope clear.
- YOU MUST NOT commit merely because the batch was approved
- If the user already explicitly authorized the scoped commit or commits, proceed and report the result.
- Inspect what will enter each commit. Keep both commits scoped to the approved changes and surface any unrelated staged or unstaged changes before committing. Preserve those unrelated changes.
- If both commits are needed, the user also explicitly approves closing the Iteration, and the final batch is its only pending checkpoint, include closure in the Shape commit's proposed scope. Validate closure using `finish iteration`. After the codebase commit succeeds, mark the Iteration `done` and include that change with the final task updates in the Shape commit.
- If either commit fails, report what succeeded and what remains. If the codebase commit succeeded, retain it and resume from the pending Shape commit. Report the batch as `committed` only when all required commits have succeeded.

Treat commit as part of completing this operation:
- YOU MUST NOT treat `approved and marked done` as the final completion state of `implement batch`
- YOU MUST NOT move to the next batch or workflow operation until the approved batch has been committed, either by the user or by the agent on explicit instruction

This skill may update the live Implementation Plan during execution and approval handling, but it must preserve the approval boundary:
- YOU MUST NOT mark tasks done merely because code was written
- YOU MUST NOT treat the batch as approved
- YOU MUST NOT treat implementation completion as approval
- YOU MUST NOT treat approval as commit
- YOU MUST NOT treat approved-but-uncommitted work as a completed `implement batch` outcome

## Workflow Boundary Rules

- YOU MUST pause for the user's review after implementing the selected batch.
- YOU MUST NOT mark tasks done until the user explicitly approves the implemented batch.
- After marking approved tasks done, YOU MUST follow the commit proposal and execution rules above.
- YOU MUST NOT create a commit unless the user explicitly approves committing the current diff.
- YOU MUST resolve the approved batch commit boundary before starting another batch or moving to another Shape step. The explicitly approved Iteration closure described above may be recorded in the final batch's Shape commit after the codebase commit succeeds.
- After the commit boundary is resolved, YOU MUST ask whether to proceed to the next Shape workflow step.
- YOU MUST NOT proceed to the next Shape workflow step unless the user explicitly approves proceeding.

## Artifact Rules
Read the Implementation Plan in `03-implementation-plan.md` to confirm selected tasks and execution context.

Apply these rules:
- execution occurs against the selected batch only
- batches are not explicitly represented in the Implementation Plan
- task completion is finalized only after explicit approval from the user
- `## Relevant Files` should reflect resulting implementation state rather than becoming a historical changelog
- `## Important Decisions` should capture implementation-time decisions that matter for subsequent iterations or future review
- these implementation-plan updates do not by themselves imply approval of the batch
- implementation progress is inferred from approved task completion under an approved Iteration
- the Implementation Plan remains `approved` until all Iterations are `done` and the feature is finished

This skill may:
- change repository code and related files needed to complete the selected batch
- run relevant checks when appropriate
- update `## Relevant Files` in `03-implementation-plan.md`
- update `## Important Decisions` in `03-implementation-plan.md`
- mark approved tasks done in `## Execution Order` after explicit approval
- create the required scoped commits for the approved batch after explicit user instruction
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
- a self-contained `## Batch Summary` handoff with coarse-grained implemented-work bullets, the implemented task numbers and their Iteration/Implementation Plan reference, and the current state
- any checks run and their results
- an explicit current state such as awaiting review, under revision, awaiting approval, approved but awaiting commit, or committed
- a separate yes/no approval question when the batch is ready for the user's review
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
- YOU MUST include the `## Batch Summary` handoff and report the current batch state
- YOU MUST NOT proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- continue `implement batch` if the user requests a revision of the same selected tasks
- explicit approval review on the current batch
- explicit commit instruction for the approved batch
- commit changes if commit instruction approved and moving to another workflow step
- `finish iteration` if the iteration is fully complete and the approved work has been committed

Prefer continuing `implement batch` as the same-batch review and revision loop until approval is explicit. Prefer `finish iteration` only after the approved batch commit boundary is resolved and the user explicitly approves proceeding.

## Follow-up Questions

- When a follow-up is needed, put one question in its own paragraph after the summary, findings, checks, or links. Put it before any final **Commits** block. Otherwise, keep the question in the final paragraph, including when pausing for input.
- When reporting completed commits for the current operation, YOU MUST end the final reply with a **Commits** block. List each commit's short hash and exact, unabridged Git subject in creation order.
- Include a passive hint only for commits the user authorized before seeing their exact subjects. Put “The commit message can be adjusted if needed.” directly beneath the eligible entry, or put “Either commit message can be adjusted if needed.” beneath the list when both commits qualify. Omit the hint for commits whose subjects the user saw before consenting.
- Use yes/no for a single named action. Ask for approval, commit consent, and permission to start the next step at their respective checkpoints.
- If the answer requires a choice or missing detail, give context first and ask directly for the input. End with the result when no input is needed and there is no concrete next action to offer.
