# show status

## Purpose
Display the current Shape workflow state in a compact, user-friendly form so the user can quickly understand active context, artifact status, repository readiness, structural warnings, and the most likely next action.

## When to Use
Use this skill when the user wants to inspect current Shape state, understand what is active, check readiness, or decide what to do next.

Typical triggers:
- “show status”
- “where are we in Shape?”
- “what is the current workflow state?”
- “what’s active right now?”
- “what should I do next?”

## Inputs
Expected inputs:
- optional active feature reference
- optional repository root or Shape root override

This skill should still be useful even if the user gives no further detail.

## What to Inspect
Inspect the following where available:

### Active feature context
- currently active feature, if one is already resolved
- likely candidate feature if active context is not yet set
- feature folder path

### Core artifacts
For the resolved feature, inspect:
- `01-prd.md`
- `02-tech-concept.md`
- `03-implementation-plan.md`

Read or infer where practical:
- whether each artifact exists
- current status
- obvious structural validity
- whether required sections appear to be present

### Implementation state
When an Implementation Plan exists, inspect where practical:
- overall plan status: `draft | ready | in progress | done`
- whether slices exist
- whether unfinished slices remain
- whether execution tasks exist
- whether there are obvious signs that review, approval, commit, or slice closure is the likely next step

### Repository readiness
Surface repository readiness for agent-assisted delivery.
Check for:
- agent-facing guidance files
- development and validation commands
- coding conventions
- architecture guidance
- feature artifact location clarity

Use Shape’s readiness levels:
- **ready enough**
- **degraded**
- **high risk**

## Output Structure
Present status in a compact structure that is easy to scan.

Recommended sections:
- Active feature
- Artifacts
- Implementation state
- Repository readiness
- Warnings
- Likely next step

## Decision Logic for Next Step
Suggest the next likely step based on the best available evidence.

Examples:
- no feature selected but one obvious in-progress feature exists → `pick up feature`
- feature exists but PRD is missing or draft → `create prd`
- PRD ready and Technical Concept not ready → `create technical concept`
- PRD and Technical Concept ready but Implementation Plan missing or draft → `plan implementation`
- plan ready and slice not yet broken down → `prepare slice`
- code appears implemented for a selected batch but not yet validated → `review batch`
- approved batch appears uncommitted → `commit batch`
- all slices complete but plan not closed → `finish implementation`

## Behavior Principles
- Optimize for orientation, not exhaustiveness
- Keep the result compact and decision-useful
- Surface missing prerequisites explicitly
- Prefer plain language over internal jargon when possible
- Make the next step obvious

## Completion Criteria
This skill is complete when the user can answer all of the following quickly:
- What feature is active?
- Which artifacts exist and what state are they in?
- Is the repository ready enough for agent-assisted work?
- Are there any structural warnings?
- What is the next likely workflow step?

## Guardrails
- Do not dump raw file listings when a summary is enough
- Do not hide structural problems or missing artifacts
- Do not report repository readiness vaguely; classify it explicitly when possible
- Do not end with status alone; always include the most likely next step