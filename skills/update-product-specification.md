# update product specification

## Purpose
Add a new Product Specification Specification Update or continue refining an existing draft update after the Product Specification baseline is already `approved`, while preserving append-only change handling and Product Owner ownership of requirement-level changes.

## Artifact resolution and compatibility
Read `.shape/config.json` before resolving artifacts. Filenames below are fresh-install defaults; use configured `featuresRoot` and `artifacts.productSpecification`, `artifacts.technicalSpecification`, and `artifacts.implementationPlan` values instead when present. Older configurations may use `prd` and `technicalConcept` keys. Existing `01-prd.md`, `02-tech-concept.md`, and “Slice Plan” headings remain valid; interpret them as Product Specification, Technical Specification, and Iteration without renaming files or rewriting existing documents solely for terminology.

For any specification input, read its `## Source` when present and follow the referenced document and relevant sections, including approved source-revision updates. A reference artifact is valid without the full authored template. If the source is inaccessible or materially changed since review, surface the gap and pause dependent work until it is resolved; do not infer readiness from the link or status alone. Read `.shape/workflow-templates/specification-reference-template.md` for reference and revision rules.

## When to Use
Use this skill when the user needs to record a requirement change, correction, clarification, or newly discovered information after the Product Specification baseline is already approved.

Typical triggers:
- “update product specification”
- “record this requirement change”
- “add a Product Specification update”
- “continue the draft Product Specification update”
- “mark this Product Specification change approved”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- requirement-level change, correction, or newly discovered information

Helpful but optional:
- the intended update name
- an existing draft update already present under `## Updates`
- related downstream impact on Technical Specification or Implementation Plan

## Preconditions
Before updating the Product Specification:
- resolve the active feature and locate `01-product-specification.md`
- confirm the Product Specification baseline status is already `approved`
- inspect `## Updates` for existing draft and approved updates
- determine whether an existing draft update should be continued instead of creating a new one

This skill is for post-approval Product Specification evolution.
If the Product Specification baseline is still `draft`, requirement work belongs in `create product specification` instead.

## Referenced source changes
For a reference artifact, read the source and compare it with the last approved revision before proposing a change. Record the old and proposed source revisions (or reviewed dates), affected scope, change summary, and downstream impact under `## Updates`. Keep the baseline link and prior approved updates intact. The latest approved source-revision update defines the effective source; draft updates do not. Do not edit the external document unless separately authorized. If a mutable source has changed and the approved version cannot be retrieved, pause dependent work until the change is reviewed and reconciled. Do not claim a source was checked when it could not be accessed.

## Behavior
Treat Product Specification changes after readiness as append-only Specification Updates.

Prefer continuing an existing draft update when it matches the current change.
Shape strongly prefers at most one draft Product Specification update at a time because multiple concurrent drafts increase ambiguity and drift risk.

When no suitable draft update exists:
- append a new update under `## Updates`
- give it a clear name
- set the date
- keep its status accurate as `draft` or `approved`

When refining an update:
- clarify the context that caused the change
- state the requirement change or decision explicitly
- describe the downstream impact plainly enough for later propagation

The responsible role remains the Product Owner.
The agent may draft or refine update language, but should not silently finalize requirement intent without clear user confirmation.

Only mark the update `approved` when the Product Owner explicitly accepts it as effective.

## Workflow Boundary Rules

- If explicit approval is still missing, YOU MUST stop for Product Owner review before changing a Product Specification Specification Update from `draft` to `approved`.
- YOU MUST NOT mark a Product Specification Specification Update `approved` unless the Product Owner explicitly approves that transition.
- Review the accepted Product Specification update diff. When commit consent is still needed, YOU MUST report the new status and propose each commit with its subject and scope in the same reply. End with one yes/no question asking whether to create the proposed commit or commits.
- Create and report the scoped commit or commits only when the Product Owner explicitly authorizes committing the current changes. Approval of the status change alone leaves commit consent pending.
- After the commit boundary is resolved, YOU MUST ask whether to proceed to the next Shape workflow step.
- YOU MUST NOT proceed to downstream propagation or any other next Shape workflow step unless the Product Owner explicitly approves proceeding.

## Artifact Rules
Operate only in `01-product-specification.md` under `## Updates`.

Use the Product Specification update structure already defined by the template:
- `#### Update: <name>`
- `- **Status:** draft | approved`
- `- **Date:** YYYY-MM-DD`
- `**Context**`
- `**Change / decision**`
- `**Impact**`

Apply these lifecycle rules:
- the approved Product Specification baseline is immutable
- approved updates are append-only and must not be silently rewritten
- updates are appended in chronological order
- only updates with status `approved` are considered effective

This skill may:
- append a new update under `## Updates`
- continue refining an existing draft update
- change an update status between `draft` and `approved` based on explicit user confirmation

This skill must not:
- rewrite the approved Product Specification baseline inline
- silently edit prior approved updates
- create a generic note outside the update structure
- imply downstream propagation has already happened unless a separate step performs it

## Outputs
This skill should produce:
- a new or refined Product Specification Specification Update under `## Updates`
- an accurate update status of `draft` or `approved`
- a short note on likely downstream implications when relevant
- a repository state that is ready to be committed once the selected Product Specification update state is accepted
- a proposed commit message when the accepted Product Specification update state is suitable for checkpointing
- a clear likely next step

## Completion Signals
This skill is complete when:
- the change is recorded under `## Updates` using the canonical update structure
- it is clear whether the update is still `draft` or already `approved`
- baseline immutability has been preserved
- any meaningful downstream consequence is visible rather than implied
- the resulting Product Specification update state is clear enough to serve as a commit checkpoint before downstream propagation continues
- the accepted checkpoint is clear enough that the agent can propose a commit cleanly
- the next likely workflow step is stated plainly

## Guardrails
- Do not rewrite the approved Product Specification baseline
- Do not silently modify older approved updates
- Do not create multiple competing draft updates when one should be continued
- YOU MUST NOT mark an update `approved` without explicit Product Owner acceptance
- Do not imply that Technical Specification or Implementation Plan already reflect the update unless that propagation step has happened
- YOU MUST NOT proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- continue `update product specification` if the change is still incomplete or awaiting acceptance
- `update technical specification` if the approved Product Specification update has design implications
- `show status` if the user needs orientation on downstream impact

Prefer `update technical specification` when a newly approved Product Specification update changes technical design expectations, the commit boundary is resolved, and the Product Owner explicitly approves proceeding.

## Follow-up Questions

- When a follow-up is needed, put one question in its own final paragraph after any summary, findings, checks, or links. Do the same when pausing for input.
- Use yes/no for a single named action. Ask for approval, commit consent, and permission to start the next step at their respective checkpoints.
- If the answer requires a choice or missing detail, give context first and ask directly for the input. End with the result when no input is needed and there is no concrete next action to offer.
