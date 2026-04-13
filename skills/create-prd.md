# create prd

## Purpose
Create or refine the PRD baseline for the active feature until it is usable as a downstream artifact, while keeping the document aligned to the canonical PRD template and preserving Product Owner ownership of requirement correctness.

## When to Use
Use this skill when the user wants to start the PRD, continue drafting it, convert larger requirement input into the Shape PRD structure, or decide whether the PRD is ready for downstream handoff.

Typical triggers:
- “create prd”
- “draft the PRD”
- “continue PRD work”
- “turn these notes into the PRD”
- “make the PRD ready”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- feature intent, notes, ticket text, or other requirement input

Helpful but optional:
- an existing PRD draft in `01-prd.md`
- a larger requirement write-up prepared outside Shape
- explicit Product Owner decisions on open questions

## Preconditions
Before editing the PRD baseline:
- resolve the active feature and locate `01-prd.md`
- confirm the PRD baseline is still in baseline-creation mode rather than append-only update mode
- inspect the current PRD content and status
- invite larger user-provided requirement input if the PRD is sparse or still mostly skeletal

This skill should operate on the baseline PRD only while its status is `draft`.
If the PRD baseline is already `ready`, this skill should not rewrite it and should redirect requirement changes to `update prd`.

## Behavior
Work with the user iteratively to turn requirement input into a structured PRD baseline.

Use two valid drafting modes:
- absorb a larger user-provided draft or notes into the template structure
- refine incrementally through targeted clarification questions when the input is incomplete

Prefer larger existing input when available instead of forcing narrow question-by-question drafting from scratch.

During refinement:
- identify missing, ambiguous, or conflicting requirements
- suggest clearer wording when the requirement intent is unstable
- keep the document operational and downstream-usable rather than verbose for its own sake
- distinguish unresolved questions from accepted baseline content

The responsible role remains the Product Owner.
The agent may structure, suggest, and refine, but should not silently decide uncertain requirement intent on the user’s behalf.

The PRD may remain `draft` while gaps still matter.
Set it to `ready` only when the Product Owner explicitly accepts the baseline as ready for downstream use.

## Artifact Rules
Read and update only the PRD baseline in `01-prd.md`.

Use the canonical PRD section structure:
- `## Header`
- `## Goal`
- `## Flow`
- `## Requirements`
- `## Acceptance Criteria`
- `## UX Notes`
- `## Non-Functional Requirements`
- `## Notes`
- `## Out of Scope`
- `## Updates`

Apply these lifecycle rules:
- baseline work is mutable only while the PRD status is `draft`
- once the PRD status is `ready`, baseline content becomes immutable
- requirement changes after readiness belong under `## Updates` through `update prd`
- `## Updates` must remain present even if no updates exist yet

This skill may:
- create missing baseline content in `01-prd.md`
- restructure draft requirement input into the template sections
- change PRD status between `draft` and `ready` based on explicit user acceptance

This skill must not:
- silently rewrite a `ready` PRD baseline
- append or finalize post-readiness updates as if they were baseline edits
- remove the canonical PRD sections
- mark the PRD `ready` without clear user confirmation

## Outputs
This skill should produce:
- a PRD baseline in `01-prd.md` aligned to the PRD template
- updated PRD status of `draft` or `ready`
- surfaced gaps or open questions when readiness is not yet justified
- a clear likely next step

## Completion Signals
This skill is complete when:
- `01-prd.md` exists and follows the canonical PRD structure
- the current baseline content is coherent enough for its current status
- the document status accurately reflects whether the PRD is still being refined or is accepted as ready
- any unresolved questions are visible rather than hidden in vague wording
- the next likely workflow action is stated plainly

## Guardrails
- Do not treat post-readiness changes as baseline edits
- Do not mark the PRD `ready` without explicit Product Owner acceptance
- Do not leave the PRD detached from the canonical section structure
- Do not bury open questions inside definitive-looking requirements
- Do not drift into technical design; keep this artifact requirement-focused

## Likely Next Step
Usually suggest one of:
- continue `create prd` if material gaps remain
- `create technical concept` if the PRD is `ready`
- `show status` if the user needs orientation before moving downstream

Prefer `create technical concept` once the PRD baseline is explicitly accepted as `ready`.
