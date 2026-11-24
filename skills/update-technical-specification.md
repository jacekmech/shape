# update technical specification

## Purpose
Add a new Technical Specification Specification Update or continue refining an existing draft Technical Specification update after the baseline is already `approved` while preserving append-only change handling.

## Artifact resolution and compatibility
Read `.shape/config.json` before resolving artifacts. Filenames below are fresh-install defaults; use configured `featuresRoot` and `artifacts.productSpecification`, `artifacts.technicalSpecification`, and `artifacts.implementationPlan` values instead when present. Older configurations may use `prd` and `technicalConcept` keys. Existing `01-prd.md`, `02-tech-concept.md`, and “Slice Plan” headings remain valid; interpret them as Product Specification, Technical Specification, and Iteration without renaming files or rewriting existing documents solely for terminology.

For any specification input, read its `## Source` when present and follow the referenced document and relevant sections, including approved source-revision updates. A reference artifact is valid without the full authored template. If the source is inaccessible or materially changed since review, surface the gap and pause dependent work until it is resolved; do not infer readiness from the link or status alone. Read `.shape/workflow-templates/specification-reference-template.md` for reference and revision rules.

## When to Use
Use this skill when the user needs to record a design change, correction, clarified constraint, or newly discovered technical information after the Technical Specification baseline is already approved.

Typical triggers:
- “update technical specification”
- “record this design change”
- “add a technical specification update”
- “continue the draft technical update”
- “mark this design update approved”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- design-level change, correction, or newly discovered technical information

Helpful but optional:
- the intended update name
- an existing draft update already present under `## Updates`
- related downstream impact on the Implementation Plan or Product Specification

## Preconditions
Before updating the Technical Specification:
- resolve the active feature and locate `02-technical-specification.md`
- confirm the Technical Specification baseline status is already `approved`
- inspect `## Updates` for existing draft and approved updates
- inspect repository guidance or codebase context when the change is driven by actual implementation or repository constraints
- determine whether an existing draft update should be continued instead of creating a new one

This skill is for post-approval Technical Specification evolution.
If the Technical Specification baseline is still `draft`, design work belongs in `create technical specification` instead.

## Referenced source changes
For a reference artifact, read the source and compare it with the last approved revision before proposing a change. Record the old and proposed source revisions (or reviewed dates), affected scope, change summary, and downstream impact under `## Updates`. Keep the baseline link and prior approved updates intact. The latest approved source-revision update defines the effective source; draft updates do not. Do not edit the external document unless separately authorized. If a mutable source has changed and the approved version cannot be retrieved, pause dependent work until the change is reviewed and reconciled. Do not claim a source was checked when it could not be accessed.

## Behavior
Treat Technical Specification changes after readiness as append-only Specification Updates.

Prefer continuing an existing draft update when it matches the current change.
Shape strongly prefers at most one draft update per target document at a time because multiple concurrent drafts increase ambiguity and drift risk.

When no suitable draft update exists:
- append a new update under `## Updates`
- give it a clear name
- set the date
- keep its status accurate as `draft` or `approved`

When refining an update:
- explain the context that caused the design change
- state the design change or decision explicitly
- describe the impact on execution planning, repository alignment, interfaces, validation, or risk where relevant

The agent may draft or refine update language, but should not silently finalize uncertain design intent without clear user confirmation.

Only mark the update `approved` when the user explicitly accepts it as effective.

## Workflow Boundary Rules

- If explicit approval is still missing, YOU MUST pause for the user's review before changing a Technical Specification Specification Update from `draft` to `approved`.
- YOU MUST NOT mark a Technical Specification Specification Update `approved` unless the user explicitly approves that transition.
- Review the accepted Technical Specification update diff. When commit consent is still needed, YOU MUST report the new status and propose each commit with its subject and scope in the same reply. End with one yes/no question asking whether to create the proposed commit or commits.
- Create and report the scoped commit or commits only when the user explicitly authorizes committing the current changes. Approval of the status change alone leaves commit consent pending.
- After the commit boundary is resolved, YOU MUST ask whether to proceed to the next Shape workflow step.
- YOU MUST NOT proceed to downstream propagation or any other next Shape workflow step unless the user explicitly approves proceeding.

## Artifact Rules
Operate only in `02-technical-specification.md` under `## Updates`.

Use the Technical Specification update structure already defined by the template:
- `#### Update: <name>`
- `- **Status:** draft | approved`
- `- **Date:** YYYY-MM-DD`
- `**Context**`
- `**Change / decision**`
- `**Impact**`

Apply these lifecycle rules:
- the approved Technical Specification baseline is immutable
- approved updates are append-only and must not be silently rewritten
- updates are appended in chronological order
- only updates with status `approved` are considered effective

This skill may:
- append a new update under `## Updates`
- continue refining an existing draft update
- change an update status between `draft` and `approved` based on explicit user confirmation

This skill must not:
- rewrite the approved Technical Specification baseline inline
- silently edit prior approved updates
- use `## Important Decisions` in the Implementation Plan as a substitute for a real design update when the change belongs in the Technical Specification
- imply downstream propagation has already happened unless a separate step performs it

## Outputs
This skill should produce:
- a new or refined Technical Specification Specification Update under `## Updates`
- an accurate update status of `draft` or `approved`
- a short note on likely downstream implications when relevant
- a repository state that is ready to be committed once the selected Technical Specification update state is accepted
- a proposed commit message when the accepted Technical Specification update state is suitable for checkpointing
- a clear likely next step

## Completion Signals
This skill is complete when:
- the change is recorded under `## Updates` using the canonical update structure
- it is clear whether the update is still `draft` or already `approved`
- baseline immutability has been preserved
- any meaningful downstream consequence for implementation planning or Product Specification alignment is visible rather than implied
- the resulting Technical Specification update state is clear enough to serve as a commit checkpoint before downstream propagation continues
- the accepted checkpoint is clear enough that the agent can propose a commit cleanly
- the next likely workflow step is stated plainly

## Guardrails
- Do not rewrite the approved Technical Specification baseline
- Do not silently modify older approved updates
- Do not create multiple competing draft updates when one should be continued
- YOU MUST NOT mark an update `approved` without explicit acceptance from the user
- Do not imply that the Implementation Plan already reflects the update unless that propagation step has happened
- YOU MUST NOT proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- continue `update technical specification` if the change is still incomplete or awaiting acceptance
- `update implementation plan` if the approved design update changes execution planning
- `update product specification` if the design change revealed a requirement-level issue

Prefer `update implementation plan` when a newly approved Technical Specification update changes Iterations or execution intent, the commit boundary is resolved, and the user explicitly approves proceeding.

## Follow-up Questions

- When a follow-up is needed, put one question in its own final paragraph after any summary, findings, checks, or links. Do the same when pausing for input.
- Use yes/no for a single named action. Ask for approval, commit consent, and permission to start the next step at their respective checkpoints.
- If the answer requires a choice or missing detail, give context first and ask directly for the input. End with the result when no input is needed and there is no concrete next action to offer.
