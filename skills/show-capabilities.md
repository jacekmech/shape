# show capabilities

## Purpose
Display the currently supported Shape skills in a compact, user-friendly form so the user can see what operations are available now and which ones are most relevant for the current workflow state.

## When to Use
Use this skill when the user wants to understand what Shape can do in this repository, which operations are available in the current stage, or what the valid next actions are.

Typical triggers:
- “show capabilities”
- “what can Shape do?”
- “what skills are available?”
- “what can I do next in this workflow?”
- “show the available operations”

## Inputs
Expected inputs:
- optional active feature reference
- optional repository root or Shape root override

Helpful but optional:
- current stage the user cares about
- whether the user wants the full inventory or only currently relevant actions

## Preconditions
Before presenting capabilities:
- inspect the repository for installed Shape skill files under `skills/`
- inspect the active feature context if one is already resolved or can be inferred cheaply
- inspect current artifact availability where needed to avoid suggesting impossible next steps
- prefer the canonical Shape skill inventory from `design.md` over ad hoc repository guesses

If no active feature is resolved, this skill should still be usable.

## Behavior
Present capabilities in plain language rather than as a raw file listing.

When useful, group the result by workflow stage:
- orientation
- PRD
- Technical Concept
- implementation

Call out the currently most relevant operations based on the best available state evidence.

Examples:
- no feature context yet: emphasize `initiate feature`, `pick up feature`, and `show status`
- feature exists but PRD is still `draft`: emphasize `create prd`
- PRD is `ready` and Technical Concept is missing or `draft`: emphasize `create technical concept`
- implementation is active: emphasize the implementation skill most likely needed next rather than dumping the full list first

Keep the result concise and easy to scan.
The goal is orientation and workflow discoverability, not exhaustive theory.

## Artifact Rules
This skill may read:
- `design.md` for the canonical skill inventory
- `skills/` to see which skill files are present in the repository
- `01-prd.md`, `02-tech-concept.md`, and `03-implementation-plan.md` for relevance cues when an active feature is available

This skill must not:
- create or modify any Shape artifact
- invent unsupported operations not present in the workflow inventory
- imply that a missing skill file is implemented if it is not present in `skills/`

When the repository skill set is incomplete, distinguish clearly between:
- workflow operations defined by Shape
- skill files currently present in this repository

## Outputs
This skill should produce:
- a compact list of currently supported Shape skills in the repository
- optional grouping by stage when that improves readability
- a short note on the most relevant current actions
- a clear likely next step

## Completion Signals
This skill is complete when:
- the user can quickly see what Shape operations are available here
- the distinction between available skills and merely possible future workflow operations is clear
- the currently most relevant actions are easy to identify
- the next likely step is stated plainly

## Guardrails
- Do not dump a raw directory listing without interpretation
- Do not invent new operations or aliases that are not grounded in Shape
- Do not hide missing skill coverage when the repository only implements part of the inventory
- Do not present every operation as equally relevant when workflow state makes the next step obvious
- Do not end with capabilities alone; connect them to the current state when possible

## Likely Next Step
Usually suggest one of:
- `initiate feature`
- `pick up feature`
- `show status`
- the single stage-specific operation that best matches the current artifact state

Prefer the most workflow-relevant action over a generic inventory recap.
