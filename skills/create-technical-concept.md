# create technical concept

## Purpose
Create or refine the Technical Concept baseline for the active feature from the PRD, codebase, repository guidance, and technical context so that implementation planning can begin from a stable design baseline.

## When to Use
Use this skill when the user wants to start the Technical Concept, continue technical design work, turn existing design notes into the Shape Technical Concept structure, or decide whether the Technical Concept is ready for implementation planning.

Typical triggers:
- “create technical concept”
- “draft the technical concept”
- “continue technical design”
- “turn these design notes into the tech concept”
- “make the technical concept ready”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- ready PRD in `01-prd.md`
- relevant codebase context
- repository guidance

Helpful but optional:
- existing draft content in `02-tech-concept.md`
- architectural notes or constraints prepared outside Shape
- implementation direction already agreed by the user

## Preconditions
Before editing the Technical Concept baseline:
- resolve the active feature and locate `01-prd.md` and `02-tech-concept.md`
- inspect the PRD and confirm the requirement baseline is `ready`, including any ready updates that materially affect design
- inspect repository guidance that shapes architecture, structure, commands, and preferred boundaries
- inspect the current Technical Concept content and status

This skill should operate on the Technical Concept baseline only while its status is `draft`.
If the PRD is not yet `ready`, this skill should not proceed and should redirect upstream to `create prd` or `update prd` as appropriate.
If the Technical Concept baseline is already `ready`, this skill should not rewrite it and should redirect design changes to `update technical concept`.

## Behavior
Work with the user iteratively to turn product requirements and repository context into a structured Technical Concept baseline.

Use two valid drafting modes:
- absorb a larger user-provided technical draft, design notes, or architectural constraints into the template structure
- refine incrementally through focused design questions when material gaps remain

Prefer larger existing technical input when available instead of forcing the user through unnecessary question-by-question drafting.

During refinement:
- translate PRD intent into architecture, flow, interfaces, and validation expectations
- explicitly align the design with repository guidance and local code organization
- surface requirement-level gaps that may require a PRD update rather than silently compensating for them
- keep the design operational enough to guide implementation planning rather than drifting into vague architecture prose
- follow Technical Concept structure when clarifying the technical design

The responsible role remains the Architect.
The agent may structure, suggest, and refine, but should not silently finalize uncertain design intent on the user’s behalf.

The Technical Concept may remain `draft` while important design gaps, constraints, or trade-offs remain unresolved.
Set it to `ready` only when the Architect explicitly accepts it as ready for implementation planning.

## Artifact Rules
Read and update only the Technical Concept baseline in `02-tech-concept.md`.

Use the canonical Technical Concept section structure:
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
- baseline work is mutable only while the Technical Concept status is `draft`
- once the Technical Concept status is `ready`, baseline content becomes immutable
- design changes after readiness belong under `## Updates` through `update technical concept`
- `## Repository Alignment` must be filled from actual repository guidance, not left as a generic placeholder when repository constraints materially shape the solution
- `## Updates` must remain present even if no updates exist yet

This skill may:
- create or refine baseline design content in `02-tech-concept.md`
- restructure draft technical input into the template sections
- change Technical Concept status between `draft` and `ready` based on explicit user acceptance

This skill must not:
- silently rewrite a `ready` Technical Concept baseline
- hide repository constraints by omitting `## Repository Alignment`
- convert requirement ambiguity into silent design assumptions when a PRD update is the correct response
- mark the Technical Concept `ready` without clear user confirmation

## Outputs
This skill should produce:
- a Technical Concept baseline in `02-tech-concept.md` aligned to the Technical Concept template
- updated Technical Concept status of `draft` or `ready`
- surfaced design gaps, risks, or PRD misalignments when readiness is not yet justified
- a repository state that is ready to be committed when the Architect accepts the current Technical Concept change set
- a clear likely next step

## Completion Signals
This skill is complete when:
- `02-tech-concept.md` exists and follows the canonical Technical Concept structure
- the current baseline content is coherent enough for its current status
- repository guidance is explicitly reflected in `## Repository Alignment`
- the document status accurately reflects whether the Technical Concept is still being refined or is accepted as ready
- the resulting Technical Concept state is clear enough that the current document change can be committed without ambiguity
- the next likely workflow action is stated plainly

## Guardrails
- Do not treat post-readiness design changes as baseline edits
- Do not mark the Technical Concept `ready` without explicit Architect acceptance
- Do not skip repository alignment when local guidance materially affects the solution
- Do not silently absorb requirement-level uncertainty that should be pushed back to the PRD
- Do not drift into implementation task planning; keep this artifact at the design baseline level
- Do not proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- continue `create technical concept` if material design gaps remain
- commit changes if moving to another workflow step
- `update prd` if requirement-level issues were discovered
- `plan implementation` if the Technical Concept is `ready`

Prefer `plan implementation` once both the PRD and Technical Concept are explicitly accepted as `ready`.
