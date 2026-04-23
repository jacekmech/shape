# plan slice

## Purpose
Turn a selected `draft` implementation slice into a concrete, reviewable execution proposal by defining executable implementation tasks, recording any agreed pre-execution decisions, and preserving developer control over task scope and sequencing.

## When to Use
Use this skill when the user wants to refine a `draft` slice for execution, break it into implementation tasks, or make the next slice `ready` for a small developer-selected execution batch.

Typical triggers:
- “plan slice”
- “break down the next slice”
- “refine this slice into tasks”
- “make the slice ready for execution”
- “add tasks for the next slice”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- ready or in-progress Implementation Plan in `03-implementation-plan.md`
- selected slice, or permission to default to the next unfinished slice

Helpful but optional:
- specific constraints on batch size or execution order
- known code areas likely to be touched first
- recent implementation learnings that affect task breakdown

## Preconditions
Before preparing a slice:
- resolve the active feature and locate `03-implementation-plan.md`
- inspect the current slices and execution order
- identify the selected slice, defaulting to the next unfinished one when appropriate
- confirm the slice is still `draft` and not already fully broken down

In a fresh execution session, this skill should normally begin after `pick up feature` unless the active feature is already unambiguous.

## Behavior
Refine one selected slice into a reviewable execution proposal.

During refinement:
- keep the slice within practical agent context limits
- break work into tasks granular enough for execution and review
- preserve a clean connection between slice goal and task list
- avoid turning one slice into a full feature plan rewrite
- identify decisions or clarifications that should be preserved in `## Important Decisions` before execution begins

Use the Developer as the control point for scope:
- default to the next unfinished slice unless the user chose a different one
- propose a task breakdown the developer can adjust
- propose any `## Important Decisions` additions the developer should approve before execution
- keep task batches implicitly selectable later rather than embedding batch definitions in the plan

This skill should reinforce Shape’s execution discipline:
- each new Slice should normally begin in a fresh agent session
- the next likely step after slice preparation is selecting a small execution batch
- approved planning transitions the selected slice from `draft` to `ready`
- Implementation Plan status moves from `ready` to `in progress` when the first approved task is marked done during execution, not merely because tasks were drafted

The responsible role remains the Developer.
The agent may propose task breakdowns and pre-execution decisions, but should not silently over-expand scope or reorder execution without developer confirmation when the change is material.

Only after the Developer approves the planning changes should this skill record the agreed tasks, transition the selected slice from `draft` to `ready`, and apply any agreed `## Important Decisions` updates in the Implementation Plan.
It must not proceed to implementation without explicit approval.

## Artifact Rules
Update only the Implementation Plan in `03-implementation-plan.md`.

Work against these sections:
- `## Execution Order`
- `## Important Decisions`
- `## Relevant Files`
- `## Notes`

Apply these rules:
- slice status is maintained explicitly in `## Slices`
- tasks belong under the selected slice in `## Execution Order`
- tasks are appended continuously during execution planning
- batches are not explicitly represented in the document
- `## Relevant Files` may be refreshed to support fresh-session pickup for the prepared slice
- `## Slices` should remain the high-level structure and should not be replaced by task detail

This skill may:
- add implementation tasks beneath the selected slice
- transition the selected slice from `draft` to `ready` after explicit approval
- add agreed pre-execution entries to `## Important Decisions`
- clarify slice sequencing in `## Execution Order`
- refresh `## Relevant Files` for the upcoming slice
- add notes that help the next execution step stay obvious

This skill must not:
- mark tasks or slices done
- move a slice to `in progress` or `done`
- embed explicit batch structures in the plan
- prepare multiple slices at once
- let the task list grow so large that the slice stops fitting a focused session
- record unapproved planning decisions as if they were already accepted

## Outputs
This skill should produce:
- a selected slice with executable implementation tasks in `## Execution Order`
- a selected slice transitioned to `ready` after approved planning
- any agreed pre-execution decisions recorded in `## Important Decisions`
- any helpful `## Relevant Files` updates for the upcoming execution context
- a repository state that is ready to be committed once the Developer accepts the planning changes for the slice
- a clear likely next step

## Completion Signals
This skill is complete when:
- one selected `draft` slice has a bounded, execution-ready task list
- that selected slice is clearly in `ready` state after approval
- task granularity supports later small-batch selection and focused review
- the slice still fits practical agent context limits
- the approved planning state is clear enough to serve as a repository checkpoint before implementation begins
- the next likely workflow step is stated plainly

## Guardrails
- Do not refine a slice so broadly that it no longer fits a fresh focused session
- Do not treat task drafting as task completion
- Do not add explicit batch representation to the document
- Do not reorder major execution structure without surfacing that to the developer
- Do not stop at task creation alone; orient the user toward the next batch-selection step
- Do not proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- continue `plan slice` if the breakdown is still too broad or unclear
- commit changes if moving to another workflow step
- `implement batch` after the developer selects a small subset of tasks
- `update implementation plan` if the plan no longer matches effective upstream changes

Prefer `implement batch` once the slice has a clear, small, reviewable starting batch.
