# show status

## Purpose
Display the current Shape workflow state in a compact, user-friendly form so the user can quickly understand active context, artifact status, structural warnings, and the most likely next action.

## Artifact resolution and compatibility
Read `.shape/config.json` before resolving artifacts. Filenames below are fresh-install defaults; use configured `featuresRoot` and `artifacts.productSpecification`, `artifacts.technicalSpecification`, and `artifacts.implementationPlan` values instead when present. Older configurations may use `prd` and `technicalConcept` keys. Existing `01-prd.md`, `02-tech-concept.md`, and “Slice Plan” headings remain valid; interpret them as Product Specification, Technical Specification, and Iteration without renaming files or rewriting existing documents solely for terminology.

For any specification input, read its `## Source` when present and follow the referenced document and relevant sections, including approved source-revision updates. A reference artifact is valid without the full authored template. If the source is inaccessible or materially changed since review, surface the gap and pause dependent work until it is resolved; do not infer readiness from the link or status alone. Read `.shape/workflow-templates/specification-reference-template.md` for reference and revision rules.

## When to Use
Use this skill when the user wants to inspect current Shape state, understand what is active, or decide what to do next.

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
- whether no active feature is currently selected because the last feature was completed

### Core artifacts
For the resolved feature, inspect:
- `01-product-specification.md`
- `02-technical-specification.md`
- `03-implementation-plan.md`

Read or infer where practical:
- whether each artifact exists
- current status
- obvious structural validity
- whether required sections appear to be present

### Implementation state
When an Implementation Plan exists, inspect where practical:
- overall plan status: `draft | approved | done`
- feature-level execution structure through Iterations
- whether Iterations exist
- per-Iteration status where available: `draft | approved | done`
- iteration-level execution through task completion and batch state
- whether unfinished Iterations remain
- whether execution tasks exist
- whether the feature is completed because the Implementation Plan is `done`
- whether there are obvious signs that review, approval, commit, or iteration closure is the likely next step

## Output Structure
Present status in a compact structure that is easy to scan.

Recommended sections:
- Active feature
- Artifacts
- Implementation state
- Warnings
- Likely next step

## Decision Logic for Next Step
Suggest the next likely step based on the best available evidence.

Examples:
- no feature selected but one obvious in-progress feature exists → `pick up feature`
- no feature selected and only completed features are visible → `initiate feature` or explicitly inspect a completed feature
- feature exists but Product Specification is missing or draft → `create product specification`
- Product Specification approved and Technical Specification not approved → `create technical specification`
- Product Specification and Technical Specification approved but Implementation Plan missing or draft → `plan implementation`
- plan is `approved` and next Iteration still `draft` → `plan iteration`
- Iteration `approved` and ready for coding → `implement batch`
- Iteration `approved` with implemented but unapproved work → continue `implement batch` for review and approval handling
- Iteration `approved` with approved but uncommitted work → continue `implement batch` if the user wants to commit that approved batch
- Iteration `approved` with all tasks done and committed → `finish iteration`
- code appears implemented for a selected batch but not yet validated → continue `implement batch`
- approved batch appears uncommitted → continue `implement batch` if commit is desired
- all Iterations `done` but plan not closed → `finish feature`
- Implementation Plan is `done` and no further change flow is requested → `initiate feature` or explicit update flow on the completed feature

## Behavior Principles
- Optimize for orientation, not exhaustiveness
- Keep the result compact and decision-useful
- Surface missing prerequisites explicitly
- Prefer plain language over internal jargon when possible
- Make the next step obvious
- Treat Implementation Plan `done` as the canonical signal that a feature is completed

## Workflow Boundary Rules

- YOU MUST treat status reporting as orientation, not permission to start the next Shape workflow step.
- YOU MUST NOT modify artifacts, mark statuses, or create commits while showing status.
- YOU MUST ask whether to proceed before starting the likely next Shape workflow step.
- YOU MUST NOT start the likely next Shape workflow step unless the human explicitly approves proceeding.

## Completion Criteria
This skill is complete when the user can answer all of the following quickly:
- What feature is active?
- Which artifacts exist and what state are they in?
- Are there any structural warnings?
- What is the next likely workflow step?

## Guardrails
- Do not dump raw file listings when a summary is enough
- Do not hide structural problems or missing artifacts
- Do not end with status alone; always include the most likely next step
- YOU MUST NOT proceed to the next workflow step without explicit approval
