# update implementation plan

## Purpose
Apply relevant approved updates from the Product Specification and/or Technical Specification to the Implementation Plan so that execution stays aligned with effective upstream changes without rewriting `done` work or blurring execution boundaries.

## Artifact resolution and compatibility
Read `.shape/config.json` before resolving artifacts. Filenames below are fresh-install defaults; use configured `featuresRoot` and `artifacts.productSpecification`, `artifacts.technicalSpecification`, and `artifacts.implementationPlan` values instead when present. Older configurations may use `prd` and `technicalConcept` keys. Existing `01-prd.md`, `02-tech-concept.md`, and “Slice Plan” headings remain valid; interpret them as Product Specification, Technical Specification, and Iteration without renaming files or rewriting existing documents solely for terminology.

For any specification input, read its `## Source` when present and follow the referenced document and relevant sections, including approved source-revision updates. A reference artifact is valid without the full authored template. If the source is inaccessible or materially changed since review, surface the gap and pause dependent work until it is resolved; do not infer readiness from the link or status alone. Read `.shape/workflow-templates/specification-reference-template.md` for reference and revision rules.

## When to Use
Use this skill when the user wants to propagate approved specification updates into execution planning, add new Iterations required by approved updates, or adjust `draft` or `approved` Iterations before the affected work has started.

Typical triggers:
- “update implementation plan”
- “propagate this approved update into the plan”
- “reflect the new design update in execution planning”
- “adjust the plan for this approved spec change”
- “add iterations for the approved update”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- approved Implementation Plan in `03-implementation-plan.md`
- one or more approved updates in `01-product-specification.md` and/or `02-technical-specification.md`

Helpful but optional:
- the specific approved update to propagate
- known affected Iterations
- implementation constraints already discovered during execution

## Preconditions
Before updating the Implementation Plan:
- resolve the active feature and locate `01-product-specification.md`, `02-technical-specification.md`, and `03-implementation-plan.md`
- inspect approved updates in the Product Specification and Technical Specification that materially affect execution
- inspect current plan status and Iteration state
- identify whether the affected work is still `draft`, already `approved`, or already `done`

This skill should only propagate effective upstream changes.
Draft specification updates should not be treated as execution truth.

## Behavior
Update the Implementation Plan inline to reflect approved upstream changes.

When an approved update changes execution shape:
- add new Iterations if new work is required
- adjust existing `draft` or `approved` Iterations when their scope or ordering must change before execution starts
- keep the execution model small, explicit, and reviewable

Respect Shape’s execution boundaries:
- `done` Iterations should not be rewritten
- `approved` Iterations with completed tasks should not be reshaped in ways that invalidate active execution
- implementation tasks should not be rewritten by this skill
- downstream propagation should remain explicit rather than implied

If an approved update affects work that has already started:
- surface the conflict clearly
- prefer adding new Iterations or notes that account for the changed iteration direction
- avoid silently reinterpreting already executed or active work

The responsible role remains the Developer.
The agent may propose execution reshaping, but should not silently decide how to absorb significant trade-offs without developer confirmation.

## Workflow Boundary Rules

- If explicit approval is still missing, YOU MUST stop for Developer review before treating Implementation Plan propagation changes as accepted.
- YOU MUST NOT apply accepted execution-shape changes, new Iterations, or revised Iteration descriptions as final unless the Developer explicitly approves them.
- Review the accepted Implementation Plan update diff. When commit consent is still needed, YOU MUST report the accepted changes and propose each commit with its subject and scope in the same reply. End with one yes/no question asking whether to create the proposed commit or commits.
- Create and report the scoped commit or commits only when the Developer explicitly authorizes committing the current changes. Approval of the changes alone leaves commit consent pending.
- After the commit boundary is resolved, YOU MUST ask whether to proceed to the next Shape workflow step.
- YOU MUST NOT proceed to Iteration approval, batch implementation, or any other next Shape workflow step unless the Developer explicitly approves proceeding.

## Artifact Rules
Read the approved Product Specification and Technical Specification updates as upstream inputs.
Update only the Implementation Plan in `03-implementation-plan.md`.

Work against these sections:
- `## Iterations`
- `## Execution Order`
- `## Relevant Files`
- `## Notes`

Apply these rules:
- the Implementation Plan is updated inline rather than through append-only updates
- only approved Product Specification or Technical Specification updates are effective for propagation
- new Iterations may be appended during implementation
- only `draft` Iterations or `approved` Iterations without completed tasks may be updated
- `approved` Iterations with completed tasks, `done` Iterations, and any Implementation Tasks must not be rewritten by this skill
- `## Relevant Files` may be refreshed when upcoming execution areas changed

This skill may:
- append new Iterations
- update existing `draft` or not-yet-started `approved` Iteration descriptions
- adjust execution order for work that has not started
- refresh `## Relevant Files` to reflect upcoming execution reality
- add clarifying notes when propagation creates constraints or sequencing implications

This skill must not:
- modify Implementation Tasks under `## Execution Order`
- mark Iterations or tasks done
- rewrite `done` or already-started `approved` Iterations as if no work has happened
- treat draft upstream updates as effective

## Outputs
This skill should produce:
- an updated Implementation Plan aligned to approved upstream changes
- any new or revised `draft` or not-yet-started `approved` Iterations needed for execution
- surfaced warnings when propagation is constrained by already-started or `done` work
- a repository state that is ready to be committed as the planning-update checkpoint
- a proposed commit message when the accepted planning update is suitable for checkpointing
- a clear likely next step

## Completion Signals
This skill is complete when:
- the Implementation Plan reflects the relevant approved upstream changes
- any new work is visible through Iterations rather than implied in prose alone
- protected boundaries around already-started work, `done` work, and tasks were preserved
- any propagation constraints are surfaced clearly
- the resulting plan update is clear enough to be committed before further execution planning continues
- the accepted checkpoint is clear enough that the agent can propose a commit cleanly
- the next likely workflow step is stated plainly

## Guardrails
- Do not propagate draft Product Specification or Technical Specification updates as if they were effective
- Do not rewrite Implementation Tasks through this skill
- Do not silently reinterpret closed or already-started Iterations
- Do not use `## Relevant Files` as a substitute for actual iteration or Iteration updates when execution shape changed
- Do not hide conflicts between approved updates and already-started work
- YOU MUST NOT proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- `plan iteration` if the updated plan now has a clear next `draft` Iteration
- continue `update implementation plan` if propagation impact is still being resolved
- `update technical specification` or `update product specification` if the upstream change is still incomplete

Prefer `plan iteration` once the updated plan has a clear next `draft` Iteration to refine, the commit boundary is resolved, and the Developer explicitly approves proceeding.

## Follow-up Questions

- When a follow-up is needed, put one question in its own final paragraph after any summary, findings, checks, or links. Do the same when pausing for input.
- Use yes/no for a single named action. Ask for approval, commit consent, and permission to start the next step at their respective checkpoints.
- If the answer requires a choice or missing detail, give context first and ask directly for the input. End with the result when no input is needed and there is no concrete next action to offer.
