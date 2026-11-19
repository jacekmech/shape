# plan iteration

## Purpose
Prepare a selected `draft` Iteration for execution by breaking its scope into executable tasks, recording any agreed pre-execution decisions, and preserving developer control over task scope and sequencing.

## Artifact resolution and compatibility
Read `.shape/config.json` before resolving artifacts. Filenames below are fresh-install defaults; use configured `featuresRoot` and `artifacts.productSpecification`, `artifacts.technicalSpecification`, and `artifacts.implementationPlan` values instead when present. Older configurations may use `prd` and `technicalConcept` keys. Existing `01-prd.md`, `02-tech-concept.md`, and “Slice Plan” headings remain valid; interpret them as Product Specification, Technical Specification, and Iteration without renaming files or rewriting existing documents solely for terminology.

For any specification input, read its `## Source` when present and follow the referenced document and relevant sections, including approved source-revision updates. A reference artifact is valid without the full authored template. If the source is inaccessible or materially changed since review, surface the gap and pause dependent work until it is resolved; do not infer readiness from the link or status alone. Read `.shape/workflow-templates/specification-reference-template.md` for reference and revision rules.

## When to Use
Use this skill when the user wants to refine a `draft` Iteration for execution, break one iteration into implementation tasks, or make the next Iteration `approved` for a small developer-selected execution batch.

Typical triggers:
- “plan iteration”
- “break down the next iteration”
- “refine this iteration into tasks”
- “approve the iteration for execution”
- “add tasks for the next iteration”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- approved Implementation Plan in `03-implementation-plan.md`
- selected Iteration, or permission to default to the next unfinished Iteration

Helpful but optional:
- specific constraints on batch size or execution order
- known code areas likely to be touched first
- recent implementation learnings that affect task breakdown

## Preconditions
Before preparing an Iteration:
- resolve the active feature and locate `03-implementation-plan.md`
- inspect the current Iterations and execution order
- identify the selected Iteration, defaulting to the next unfinished one when appropriate
- confirm the Iteration is still `draft` and not already fully broken down

In a fresh execution session, this skill should normally begin after `pick up feature` unless the active feature is already unambiguous.

## Behavior
Refine one selected Iteration into a reviewable iteration execution proposal.

During refinement:
- keep the iteration within practical agent context limits
- break iteration implementation into tasks granular enough for execution and review
- preserve a clean connection between iteration goal and task list
- avoid turning one Iteration into a full feature plan rewrite
- identify decisions or clarifications that should be preserved in `## Important Decisions` before execution begins

Use the Developer as the control point for scope:
- default to the next unfinished Iteration unless the user chose a different one
- propose a task breakdown the developer can adjust
- propose any `## Important Decisions` additions the developer should approve before execution
- keep task batches implicitly selectable later rather than embedding batch definitions in the plan

This skill should reinforce Shape’s execution discipline:
- each new iteration should normally begin in a fresh agent session
- the next likely step after iteration preparation is selecting a small execution batch
- approved planning transitions the selected Iteration from `draft` to `approved`
- Implementation Plan status does not change merely because an Iteration was approved

The responsible role remains the Developer.
The agent may propose task breakdowns and pre-execution decisions, but should not silently over-expand scope or reorder execution without developer confirmation when the change is material.

Only after the Developer approves the planning changes should this skill record the agreed tasks, transition the selected Iteration from `draft` to `approved`, and apply any agreed `## Important Decisions` updates in the Implementation Plan.
It must not proceed to implementation without explicit approval.

## Workflow Boundary Rules

- YOU MUST stop for Developer review before changing an Iteration from `draft` to `approved`.
- YOU MUST NOT transition an Iteration to `approved` unless the Developer explicitly approves the task breakdown and related planning changes.
- After finishing this Shape operation, YOU MUST ask whether to prepare and submit a commit for the accepted iteration-planning diff.
- YOU MUST NOT create a commit unless the Developer explicitly approves committing the current diff.
- After the commit boundary is resolved, YOU MUST ask whether to proceed to the next Shape workflow step.
- YOU MUST NOT proceed to `implement batch` or any other next Shape workflow step unless the Developer explicitly approves proceeding.

## Artifact Rules
Update only the Implementation Plan in `03-implementation-plan.md`.

Work against these sections:
- `## Execution Order`
- `## Important Decisions`
- `## Relevant Files`
- `## Notes`

Apply these rules:
- Iteration status is maintained explicitly in `## Iterations`
- tasks belong under the selected Iteration in `## Execution Order`
- tasks are appended continuously during execution planning
- batches are not explicitly represented in the document
- `## Relevant Files` may be refreshed to support fresh-session pickup for the prepared iteration
- `## Iterations` should remain the high-level structure and should not be replaced by task detail

This skill may:
- add implementation tasks beneath the selected Iteration
- transition the selected Iteration from `draft` to `approved` after explicit approval
- add agreed pre-execution entries to `## Important Decisions`
- clarify Iteration sequencing in `## Execution Order`
- refresh `## Relevant Files` for the upcoming Iteration
- add notes that help the next execution step stay obvious

This skill must not:
- mark tasks or Iterations done
- move an Iteration to `done`
- embed explicit batch structures in the plan
- prepare multiple Iterations at once
- let the task list grow so large that the iteration stops fitting a focused session
- record unapproved planning decisions as if they were already accepted

## Outputs
This skill should produce:
- a selected Iteration with executable implementation tasks in `## Execution Order`
- a selected Iteration transitioned to `approved` after approved planning
- any agreed pre-execution decisions recorded in `## Important Decisions`
- any helpful `## Relevant Files` updates for the upcoming execution context
- a repository state that is ready to be committed once the Developer accepts the planning changes for the Iteration
- a proposed commit message when the accepted iteration-planning state is suitable for checkpointing
- a clear likely next step

## Completion Signals
This skill is complete when:
- one selected `draft` Iteration has a bounded, execution-ready task list for its iteration
- that selected Iteration is clearly in `approved` state after approval
- task granularity supports later small-batch selection and focused review
- the iteration still fits practical agent context limits
- the approved planning state is clear enough to serve as a repository checkpoint before implementation begins
- the accepted checkpoint is clear enough that the agent can propose a commit cleanly
- the next likely workflow step is stated plainly

## Guardrails
- Do not refine an iteration so broadly that it no longer fits a fresh focused session
- Do not treat task drafting as task completion
- Do not add explicit batch representation to the document
- Do not reorder major execution structure without surfacing that to the developer
- Do not stop at task creation alone; orient the user toward the next batch-selection step
- YOU MUST NOT proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- continue `plan iteration` if the breakdown is still too broad or unclear
- propose a commit message and offer to create the commit if the current iteration-planning state is accepted and the user wants a checkpoint
- `implement batch` after the developer selects a small subset of tasks
- `update implementation plan` if the plan no longer matches effective upstream changes

Prefer `implement batch` once the Iteration has a clear, small, reviewable starting batch, the commit boundary is resolved, and the Developer explicitly approves proceeding.

## Follow-up Questions

- When a follow-up is needed, put one question in its own final paragraph after any summary, findings, checks, or links. Do the same when pausing for input.
- Use yes/no for a single named action. Ask for approval, commit consent, and permission to start the next step at their respective checkpoints.
- If the answer requires a choice or missing detail, give context first and ask directly for the input. End with the result when no input is needed and there is no concrete next action to offer.
