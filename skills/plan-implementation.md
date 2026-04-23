# plan implementation

## Purpose
Create the initial Implementation Plan from the ready PRD and ready Technical Concept, define the first set of execution slices, and set up implementation so that execution can continue through small, reviewable batches.

## When to Use
Use this skill when the user wants to begin implementation planning for a feature whose PRD and Technical Concept are already ready, or when the existing Implementation Plan is still only a scaffold and needs to become a real execution document.

Typical triggers:
- “plan implementation”
- “start implementation planning”
- “create the implementation plan”
- “begin implementation”
- “set up slices for execution”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- ready PRD in `01-prd.md`
- ready Technical Concept in `02-tech-concept.md`
- relevant codebase context

Helpful but optional:
- existing draft content in `03-implementation-plan.md`
- implementation constraints already agreed by the developer
- known repository areas likely to matter first

## Preconditions
Before initiating implementation:
- resolve the active feature and locate `01-prd.md`, `02-tech-concept.md`, and `03-implementation-plan.md`
- confirm the PRD status is `ready`
- confirm the Technical Concept status is `ready`
- inspect any ready updates in the PRD or Technical Concept that materially affect execution
- inspect the codebase enough to shape realistic initial slices

Implementation planning should not begin from unstable upstream artifacts.
If the PRD or Technical Concept is still `draft`, surface that clearly and redirect to the appropriate upstream skill.

## Behavior
Create or refine the Implementation Plan into an execution-ready control document.

During initialization:
- summarize the delivery objective from the ready PRD and Technical Concept
- define an initial set of slices small enough for focused execution sessions
- create initial slices in `draft`
- keep slices reviewable and practical rather than overly broad
- do not add implementation tasks

This skill should reinforce Shape’s execution discipline:
- each new Slice should normally begin in a fresh agent session
- fresh execution sessions should normally begin with `pick up feature` unless the active feature is already unambiguous
- execution will later proceed through slices and developer-selected batches
- approved batches may be committed within `implement batch`, but only on explicit developer instruction before the next batch begins

The responsible role remains the Developer.
The agent may propose slices, and execution order, but should not silently decide implementation strategy where the developer needs to choose trade-offs or sequencing.

Set the Implementation Plan to `ready` when the initial slices and execution framing are accepted as ready for execution.
Do not set it to `in progress` merely because planning work occurred; that transition belongs when active execution begins.

## Artifact Rules
Read and update only the Implementation Plan in `03-implementation-plan.md`, using the ready PRD and ready Technical Concept as upstream inputs.

Use the canonical Implementation Plan section structure:
- `## Header`
- `## Objective`
- `## Slices`
- `## Execution Order`
- `## Important Decisions`
- `## Relevant Files`
- `## Notes`

Apply these rules:
- the Implementation Plan is a live inline document rather than an append-only update artifact
- `## Slices` should define the initial high-level execution structure using explicit slice status entries
- initial slices created by this skill should start in `draft`
- `## Execution Order` should establish slice ordering, but implementation tasks must remain empty until `plan slice`
- `## Relevant Files` should stay selective and useful for fresh-session pickup rather than becoming a full file inventory
- no explicit batch representation should be added to the document

This skill may:
- create or refine `## Objective`
- define initial slices in `## Slices`
- establish corresponding slice entries in `## Execution Order`
- seed `## Relevant Files` with a compact working file map when useful
- change plan status between `draft` and `ready` based on explicit developer acceptance

This skill must not:
- start marking slices
- treat batch boundaries as document structure
- rewrite the PRD or Technical Concept as part of implementation kickoff
- mark the plan `in progress` or `done`

## Outputs
This skill should produce:
- an Implementation Plan in `03-implementation-plan.md` aligned to the Implementation Plan template
- initial slices in `draft` ready for later refinement
- updated plan status of `draft` or `ready`
- a repository state that is ready to be committed once the Developer accepts the initial plan structure
- a clear likely next step

## Completion Signals
This skill is complete when:
- `03-implementation-plan.md` reflects the ready PRD and ready Technical Concept
- initial slices exist and are small enough to support focused execution sessions
- `## Execution Order` contains the execution skeleton without prematurely turning into task-level detail
- the plan status accurately reflects whether execution planning is still being refined or is accepted as ready
- the resulting planning state is clear enough to serve as a repository checkpoint before slice refinement begins
- the next likely workflow step is stated plainly

## Guardrails
- Do not start planning implementation from draft upstream artifacts
- Do not collapse slice planning into immediate batch execution
- Do not add implementation tasks so early that slice boundaries become unclear
- Do not turn `## Relevant Files` into a historical changelog or full repository inventory
- Do not mark the plan `in progress` merely because the plan now exists
- Do not proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- continue `plan implementation` if slice structure is still unstable
- commit changes if moving to another workflow step
- `plan slice` if the Implementation Plan is `ready`
- `update technical concept` or `update prd` if implementation planning exposed a real upstream gap

Prefer `plan slice` once the Implementation Plan is explicitly accepted as `ready`.
