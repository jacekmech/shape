# create product specification

## Purpose
Create or refine the Product Specification baseline for the active feature until it is usable as a downstream artifact, while keeping the document aligned to the canonical Product Specification template and preserving Product Owner ownership of requirement correctness.

## Artifact resolution and compatibility
Read `.shape/config.json` before resolving artifacts. Filenames below are fresh-install defaults; use configured `featuresRoot` and `artifacts.productSpecification`, `artifacts.technicalSpecification`, and `artifacts.implementationPlan` values instead when present. Older configurations may use `prd` and `technicalConcept` keys. Existing `01-prd.md`, `02-tech-concept.md`, and “Slice Plan” headings remain valid; interpret them as Product Specification, Technical Specification, and Iteration without renaming files or rewriting existing documents solely for terminology.

For any specification input, read its `## Source` when present and follow the referenced document and relevant sections, including approved source-revision updates. A reference artifact is valid without the full authored template. If the source is inaccessible or materially changed since review, surface the gap and pause dependent work until it is resolved; do not infer readiness from the link or status alone. Read `.shape/workflow-templates/specification-reference-template.md` for reference and revision rules.

## When to Use
Use this skill when the user wants to start the Product Specification, continue drafting it, convert larger requirement input into the Shape Product Specification structure, or decide whether the Product Specification should be approved for downstream handoff.

Typical triggers:
- “create product specification”
- “draft the Product Specification”
- “continue Product Specification work”
- “turn these notes into the Product Specification”
- “approve the Product Specification”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- feature intent, notes, ticket text, or other requirement input

Helpful but optional:
- an existing Product Specification draft in `01-product-specification.md`
- a larger requirement write-up prepared outside Shape
- explicit Product Owner decisions on open questions

## Preconditions
Before editing the Product Specification baseline:
- resolve the active feature and the expected path of `01-product-specification.md`
- if the file exists, inspect its content and status and confirm the baseline is still in baseline-creation mode
- invite larger user-provided requirement input if the Product Specification is sparse or still mostly skeletal

This skill should operate on the baseline Product Specification only while its status is `draft`.
If the Product Specification baseline is already `approved`, this skill should not rewrite it and should redirect requirement changes to `update product specification`.

## Choose authored or referenced specification
Before drafting, explain that Shape can draft a Product Specification or reference an existing one by name, repository path, or URL. If the choice is still open, end the reply with “Which existing Product Specification, if any, should Shape reference?” Honor a choice already made during initiation.

- Resolve a supplied document name using available repository or connected sources; ask for a path or URL only if ambiguous or unavailable.
- When referencing an existing document, YOU MUST create or update the Product Specification file in the feature folder using `.shape/workflow-templates/specification-reference-template.md`. If the local file is missing, create it as `draft`. Record its title, Shape status, date, source link, relevant scope, and reviewed revision or date. Do not copy the document or require empty authored-template sections.
- Read the source and assess readiness for the feature. External approval alone does not approve the Shape artifact; Product Owner acceptance is still required. Keep it `draft` while material gaps or access problems remain.
- Add only necessary local supplements, keeping the external source authoritative within its stated scope. Identify conflicts for human resolution rather than silently overriding it.
- Reference mode replaces the full section requirements below. Both modes retain `## Header` and `## Updates` and follow the same approval and append-only lifecycle.

## Behavior
Work with the user iteratively to turn requirement input into a structured Product Specification baseline.

For authored mode, use either drafting approach:
- absorb a larger user-provided draft or notes into the template structure
- refine incrementally through targeted clarification questions when the input is incomplete

Prefer larger existing input when available instead of forcing narrow question-by-question drafting from scratch.

During refinement:
- produce a first proposal of delivery iterations, each with outcome, scope, acceptance criteria, and sequencing dependencies; keep it provisional and free of implementation tasks
- if a referenced source already contains this proposal, link to that section; otherwise add `## Proposed Delivery Iterations` as a small local supplement
- identify missing, ambiguous, or conflicting requirements
- suggest clearer wording when the requirement intent is unstable
- keep the document operational and downstream-usable rather than verbose for its own sake
- distinguish unresolved questions from accepted baseline content
- follow Product Specification structure when clarifying requirements

The responsible role remains the Product Owner.
The agent may structure, suggest, and refine, but should not silently decide uncertain requirement intent on the user’s behalf.

The Product Specification may remain `draft` while gaps still matter.
Set it to `approved` only when the Product Owner explicitly accepts the baseline for downstream use.

## Workflow Boundary Rules

- If explicit approval is still missing, YOU MUST stop for Product Owner review before changing the Product Specification from `draft` to `approved`.
- YOU MUST NOT mark the Product Specification `approved` unless the Product Owner explicitly approves that transition.
- Review the accepted Product Specification diff. When commit consent is still needed, YOU MUST report the new status and propose each commit with its subject and scope in the same reply. End with one yes/no question asking whether to create the proposed commit or commits.
- Create and report the scoped commit or commits only when the Product Owner explicitly authorizes committing the current changes. Approval of the status change alone leaves commit consent pending.
- After the commit boundary is resolved, YOU MUST ask whether to proceed to the next Shape workflow step.
- YOU MUST NOT proceed to the next Shape workflow step unless the Product Owner explicitly approves proceeding.

## Artifact Rules
Update only the Product Specification baseline in `01-product-specification.md`.

For authored mode, use the canonical Product Specification section structure:
- `## Header`
- `## Goal`
- `## Flow`
- `## Requirements`
- `## Acceptance Criteria`
- `## Proposed Delivery Iterations`
- `## UX Notes`
- `## Non-Functional Requirements`
- `## Notes`
- `## Out of Scope`
- `## Updates`

Apply these lifecycle rules:
- baseline work is mutable only while the Product Specification status is `draft`
- once the Product Specification status is `approved`, baseline content becomes immutable
- requirement changes after approval belong under `## Updates` through `update product specification`
- `## Updates` must remain present even if no updates exist yet

This skill may:
- create missing baseline content in `01-product-specification.md`
- restructure draft requirement input into the template sections
- change Product Specification status between `draft` and `approved` based on explicit user acceptance

This skill must not:
- silently rewrite an `approved` Product Specification baseline
- append or finalize post-approval updates as if they were baseline edits
- remove required sections for the selected authored or reference mode
- mark the Product Specification `approved` without clear user confirmation

## Outputs
This skill should produce:
- a Product Specification baseline in `01-product-specification.md` aligned to the selected authored or reference template
- updated Product Specification status of `draft` or `approved`
- surfaced gaps or open questions when readiness is not yet justified
- a repository state that is ready to be committed when the Product Owner accepts the current Product Specification change set
- a proposed commit message when the accepted Product Specification state is suitable for checkpointing
- a clear likely next step

## Completion Signals
This skill is complete when:
- `01-product-specification.md` exists and follows the selected authored or reference structure
- a proposed delivery outline is present locally or in the linked source
- the current baseline content is coherent enough for its current status
- the document status accurately reflects whether the Product Specification is still being refined or is approved
- any unresolved questions are visible rather than hidden in vague wording
- the resulting Product Specification state is clear enough that the current document change can be committed without ambiguity
- the accepted checkpoint is clear enough that the agent can propose a commit cleanly
- the next likely workflow action is stated plainly

## Guardrails
- Do not treat post-approval changes as baseline edits
- YOU MUST NOT mark the Product Specification `approved` without explicit Product Owner acceptance
- Keep the Product Specification aligned with the selected authored or reference structure
- Do not bury open questions inside definitive-looking requirements
- Do not drift into technical design; keep this artifact requirement-focused
- YOU MUST NOT proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- continue `create product specification` if material gaps remain
- `create technical specification` if the Product Specification is `approved`
- `show status` if the user needs orientation before moving downstream

Prefer `create technical specification` once the Product Specification baseline is explicitly accepted as `approved`, the commit boundary is resolved, and the Product Owner explicitly approves proceeding.

## Follow-up Questions

- When a follow-up is needed, put one question in its own final paragraph after any summary, findings, checks, or links. Do the same when pausing for input.
- Use yes/no for a single named action. Ask for approval, commit consent, and permission to start the next step at their respective checkpoints.
- If the answer requires a choice or missing detail, give context first and ask directly for the input. End with the result when no input is needed and there is no concrete next action to offer.
