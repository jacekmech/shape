# create technical specification

## Purpose
Create or refine the Technical Specification baseline for the active feature from the Product Specification, codebase, repository guidance, and technical context so that implementation planning can begin from a stable design baseline.

## Artifact resolution and compatibility
Read `.shape/config.json` before resolving artifacts. Filenames below are fresh-install defaults; use configured `featuresRoot` and `artifacts.productSpecification`, `artifacts.technicalSpecification`, and `artifacts.implementationPlan` values instead when present. Older configurations may use `prd` and `technicalConcept` keys. Existing `01-prd.md`, `02-tech-concept.md`, and “Slice Plan” headings remain valid; interpret them as Product Specification, Technical Specification, and Iteration without renaming files or rewriting existing documents solely for terminology.

For any specification input, read its `## Source` when present and follow the referenced document and relevant sections, including approved source-revision updates. A reference artifact is valid without the full authored template. If the source is inaccessible or materially changed since review, surface the gap and pause dependent work until it is resolved; do not infer readiness from the link or status alone. Read `.shape/workflow-templates/specification-reference-template.md` for reference and revision rules.

## When to Use
Use this skill when the user wants to start the Technical Specification, continue technical design work, turn existing design notes into the Shape Technical Specification structure, or decide whether the Technical Specification should be approved for implementation planning.

Typical triggers:
- “create technical specification”
- “draft the technical specification”
- “continue technical design”
- “turn these design notes into the technical specification”
- “approve the technical specification”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- approved Product Specification in `01-product-specification.md`
- relevant codebase context
- repository guidance

Helpful but optional:
- existing draft content in `02-technical-specification.md`
- architectural notes or constraints prepared outside Shape
- implementation direction already agreed by the user

## Preconditions
Before editing the Technical Specification baseline:
- resolve the active feature, locate `01-product-specification.md`, and resolve the expected path of `02-technical-specification.md`
- inspect the Product Specification and confirm the requirement baseline is `approved`, including any approved updates that materially affect design
- inspect repository guidance that shapes architecture, structure, commands, and preferred boundaries
- if the Technical Specification file exists, inspect its content and status

This skill should operate on the Technical Specification baseline only while its status is `draft`.
If the Product Specification is not yet `approved`, this skill should not proceed and should redirect upstream to `create product specification` or `update product specification` as appropriate.
If the Technical Specification baseline is already `approved`, this skill should not rewrite it and should redirect design changes to `update technical specification`.

## Choose authored or referenced specification
Before drafting, explain that Shape can draft a Technical Specification or reference an existing one by name, repository path, or URL. If the choice is still open, end the reply with “Which existing Technical Specification, if any, should Shape reference?” Honor a choice already made during initiation.

- Resolve a supplied document name using available repository or connected sources; ask for a path or URL only if ambiguous or unavailable.
- When referencing an existing document, YOU MUST create or update the Technical Specification file in the feature folder using `.shape/workflow-templates/specification-reference-template.md`. If the local file is missing, create it as `draft`. Record its title, Shape status, date, source link, relevant scope, and reviewed revision or date. Do not copy the document or require empty authored-template sections.
- Read the source and assess readiness for the feature. External approval alone does not approve the Shape artifact; Architect acceptance is still required. Keep it `draft` while material gaps or access problems remain.
- Add only necessary local supplements, keeping the external source authoritative within its stated scope. Identify conflicts for human resolution rather than silently overriding it.
- Reference mode replaces the full section requirements below. Both modes retain `## Header` and `## Updates` and follow the same approval and append-only lifecycle.

## Behavior
Work with the user iteratively to turn product requirements and repository context into a structured Technical Specification baseline.

For authored mode, use either drafting approach:
- absorb a larger user-provided technical draft, design notes, or architectural constraints into the template structure
- refine incrementally through focused design questions when material gaps remain

Prefer larger existing technical input when available instead of forcing the user through unnecessary question-by-question drafting.

During refinement:
- assess the proposed product delivery iterations for feasibility and dependencies; record recommended refinements without silently changing approved product scope
- translate Product Specification intent into architecture, flow, interfaces, and validation expectations
- explicitly align the design with repository guidance and local code organization
- surface requirement-level gaps that may require a Product Specification update rather than silently compensating for them
- keep the design operational enough to guide implementation planning rather than drifting into vague architecture prose
- follow Technical Specification structure when clarifying the technical design

The responsible role remains the Architect.
The agent may structure, suggest, and refine, but should not silently finalize uncertain design intent on the user’s behalf.

The Technical Specification may remain `draft` while important design gaps, constraints, or trade-offs remain unresolved.
Set it to `approved` only when the Architect explicitly accepts it for implementation planning.

## Workflow Boundary Rules

- If explicit approval is still missing, YOU MUST stop for Architect review before changing the Technical Specification from `draft` to `approved`.
- YOU MUST NOT mark the Technical Specification `approved` unless the Architect explicitly approves that transition.
- Review the accepted Technical Specification diff. When commit consent is still needed, YOU MUST report the new status and propose each commit with its subject and scope in the same reply. End with one yes/no question asking whether to create the proposed commit or commits.
- Create and report the scoped commit or commits only when the Architect explicitly authorizes committing the current changes. Approval of the status change alone leaves commit consent pending.
- After the commit boundary is resolved, YOU MUST ask whether to proceed to the next Shape workflow step.
- YOU MUST NOT proceed to the next Shape workflow step unless the Architect explicitly approves proceeding.

## Artifact Rules
Update only the Technical Specification baseline in `02-technical-specification.md`.

For authored mode, use the canonical Technical Specification section structure:
- `## Header`
- `## Overview`
- `## Repository Alignment`
- `## Architecture`
- `## Flow`
- `## Interfaces`
- `## Data & Validation`
- `## Frontend / Backend Notes`
- `## Testing Notes`
- `## Risks & Trade-offs`
- `## Notes`
- `## Out of Scope`
- `## Updates`

Apply these lifecycle rules:
- baseline work is mutable only while the Technical Specification status is `draft`
- once the Technical Specification status is `approved`, baseline content becomes immutable
- design changes after approval belong under `## Updates` through `update technical specification`
- `## Repository Alignment` must be filled from actual repository guidance, not left as a generic placeholder when repository constraints materially shape the solution
- `## Updates` must remain present even if no updates exist yet

This skill may:
- create or refine baseline design content in `02-technical-specification.md`
- restructure draft technical input into the template sections
- change Technical Specification status between `draft` and `approved` based on explicit user acceptance

This skill must not:
- silently rewrite an `approved` Technical Specification baseline
- hide repository constraints; use `## Repository Alignment` in authored mode or a local supplement in reference mode
- convert requirement ambiguity into silent design assumptions when a Product Specification update is the correct response
- mark the Technical Specification `approved` without clear user confirmation

## Outputs
This skill should produce:
- a Technical Specification baseline in `02-technical-specification.md` aligned to the selected authored or reference template
- updated Technical Specification status of `draft` or `approved`
- surfaced design gaps, risks, or Product Specification misalignments when readiness is not yet justified
- a repository state that is ready to be committed when the Architect accepts the current Technical Specification change set
- a proposed commit message when the accepted Technical Specification state is suitable for checkpointing
- a clear likely next step

## Completion Signals
This skill is complete when:
- `02-technical-specification.md` exists and follows the selected authored or reference structure
- the current baseline content is coherent enough for its current status
- repository guidance is reflected in `## Repository Alignment`, the referenced source, or a local supplement
- the document status accurately reflects whether the Technical Specification is still being refined or is approved
- the resulting Technical Specification state is clear enough that the current document change can be committed without ambiguity
- the accepted checkpoint is clear enough that the agent can propose a commit cleanly
- the next likely workflow action is stated plainly

## Guardrails
- Do not treat post-approval design changes as baseline edits
- YOU MUST NOT mark the Technical Specification `approved` without explicit Architect acceptance
- Do not skip repository alignment when local guidance materially affects the solution
- Do not silently absorb requirement-level uncertainty that should be pushed back to the Product Specification
- Do not drift into implementation task planning; keep this artifact at the design baseline level
- YOU MUST NOT proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- continue `create technical specification` if material design gaps remain
- `update product specification` if requirement-level issues were discovered
- `plan implementation` if the Technical Specification is `approved`

Prefer `plan implementation` once both the Product Specification and Technical Specification are explicitly accepted as `approved`, the commit boundary is resolved, and the Architect explicitly approves proceeding.

## Follow-up Questions

- When a follow-up is needed, put one question in its own final paragraph after any summary, findings, checks, or links. Do the same when pausing for input.
- Use yes/no for a single named action. Ask for approval, commit consent, and permission to start the next step at their respective checkpoints.
- If the answer requires a choice or missing detail, give context first and ask directly for the input. End with the result when no input is needed and there is no concrete next action to offer.
