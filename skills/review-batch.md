# review batch

## Purpose
Summarize and inspect an implemented batch against the selected tasks so the Developer can review it clearly, request adjustments if needed, and explicitly decide whether to approve it.

## When to Use
Use this skill when the user wants to review completed batch work, inspect the diff against the selected tasks, or determine whether the implemented batch is ready for explicit developer approval.

Typical triggers:
- “review batch”
- “review the implemented tasks”
- “show me what changed in this batch”
- “check this batch against the plan”
- “is this batch ready for approval?”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- Implementation Plan with the selected tasks in `03-implementation-plan.md`
- implemented but not yet finalized batch changes

Helpful but optional:
- the specific selected batch if multiple prepared tasks exist
- prior review feedback on this same batch
- known risk areas the developer wants inspected first

## Preconditions
Before reviewing a batch:
- resolve the active feature and locate `03-implementation-plan.md`
- inspect the selected tasks in `## Execution Order`
- inspect the implemented diff or changed files for the batch
- identify whether the batch is still awaiting review, awaiting approval, or already approved but uncommitted

This is a developer-led review step.
The skill should support review and approval, not replace them.

## Behavior
Review the implemented batch against the selected task intent.

During review support:
- map the implemented changes back to the selected tasks
- surface obvious mismatches, omissions, risks, or scope expansion
- keep the result compact enough for focused developer validation
- make approval state explicit rather than implied

If the batch does not yet satisfy the selected tasks:
- state what still needs adjustment
- keep the batch in review or revision state
- do not mark tasks done

If the Developer explicitly approves the batch:
- mark the relevant tasks done in `## Execution Order`
- if approval marks the first completed task in a `ready` slice, transition that slice to `in progress`
- if this is the first slice entering `in progress`, update the Implementation Plan status to `in progress`
- update `## Relevant Files` when accepted implementation changed the working file map for upcoming slices
- make it clear that commit is now the normal required next boundary

The responsible role remains the Developer.
The agent may summarize, inspect, and update the plan after explicit approval, but should not silently treat review completion as approval.

## Artifact Rules
Read the Implementation Plan in `03-implementation-plan.md` and the implemented code changes for the selected batch.

Work against these sections when approval is explicit:
- `## Execution Order`
- `## Relevant Files`
- `## Notes`

Apply these rules:
- tasks should be marked done only after developer approval of the implemented batch
- the first approved completed task in a `ready` slice moves that slice to `in progress`
- the Implementation Plan moves to `in progress` only when execution has actually begun through approved task completion
- `## Relevant Files` should reflect accepted implementation state and likely future usefulness
- `## Relevant Files` should not become a full file inventory or historical changelog

This skill may:
- summarize the implemented batch against the selected tasks
- surface risks, gaps, and scope deviations
- mark approved tasks done after explicit developer approval
- transition the selected slice to `in progress` when the approved task state makes that true
- refresh `## Relevant Files` after approval when the accepted batch changed what matters next

This skill must not:
- approve the batch on the developer’s behalf
- mark tasks done before explicit approval
- imply commit already happened
- start selecting or implementing the next batch

## Outputs
This skill should produce:
- a compact review-oriented summary of the batch
- explicit status such as awaiting review, awaiting approval, or approved but awaiting commit
- any Implementation Plan updates that become valid only after explicit approval
- slice status updates when approved task completion changes the slice lifecycle
- a clear likely next step

## Completion Signals
This skill is complete when:
- the implemented batch is understandable against the selected tasks
- approval state is explicit
- approved tasks are marked done only when the developer explicitly approved the batch
- slice state is updated correctly when approval starts execution on that slice
- the next likely workflow action is stated plainly

## Guardrails
- Do not present agent review support as a substitute for developer approval
- Do not mark tasks done before explicit approval
- Do not hide scope drift or missing task coverage
- Do not let the workflow advance to the next batch before commit
- Do not end review support without stating the current review state clearly
- Do not proceed to the next workflow action without explicit approval

## Likely Next Step
Usually suggest one of:
- `commit batch` if the batch is approved but not yet committed
- continue `implement batch` if adjustments are still needed on the same selected tasks

Prefer `commit batch` once the Developer has explicitly approved the batch.
