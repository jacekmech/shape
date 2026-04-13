# record implementation decision

## Purpose
Capture an implementation-time clarification, trade-off, or cross-slice decision in the Implementation Plan so that later execution remains aligned without overusing upstream specification updates.

## When to Use
Use this skill when the user wants to document an implementation-time decision discovered during coding or review that matters for future execution but does not justify a PRD or Technical Concept update.

Typical triggers:
- “record implementation decision”
- “document this implementation trade-off”
- “note this coding decision in the plan”
- “capture this clarification for later slices”
- “add this execution decision”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- the implementation-time decision, clarification, or trade-off to record

Helpful but optional:
- why the decision was made
- cross-slice implications
- related files or code areas

## Preconditions
Before recording a decision:
- resolve the active feature and locate `03-implementation-plan.md`
- inspect `## Important Decisions`
- confirm the decision belongs at implementation level rather than in the PRD or Technical Concept

If the discovered issue changes requirements or design baseline, surface that clearly and redirect to `update prd` or `update technical concept` instead of burying it here.

## Behavior
Record the decision in the Implementation Plan so future execution has the needed context.

Use this section for:
- clarifications not worth updating the Technical Concept
- trade-offs discovered during coding
- cross-slice implications that later execution should remember

Keep the entry operational and concise.
The point is to preserve execution context, not to create a second design document.

The responsible role remains the Developer.
The agent may draft the decision entry, but should not silently downgrade a real requirement or design change into an implementation note just because it is easier to record here.

## Artifact Rules
Update only the Implementation Plan in `03-implementation-plan.md`.

Work against these sections:
- `## Important Decisions`
- `## Notes` when a short execution note is useful in addition to the recorded decision

Apply these rules:
- `## Important Decisions` captures implementation-time decisions made during execution
- use it for clarifications not worth updating the Technical Concept, trade-offs discovered during coding, and cross-slice implications
- keep entries compact and useful for later execution
- do not use this section as a substitute for PRD or Technical Concept updates when the baseline artifacts actually changed

This skill may:
- append a new decision entry
- refine an unhelpfully vague existing draft note into a clearer implementation decision
- add a short supporting note when it improves upcoming execution clarity

This skill must not:
- rewrite the PRD or Technical Concept through the Implementation Plan
- hide a requirement-level or design-level change inside `## Important Decisions`
- turn the section into a long historical narrative
- mark tasks or slices done

## Outputs
This skill should produce:
- an implementation decision recorded in `## Important Decisions`
- any short note needed to keep the execution consequence obvious
- a clear likely next step

## Completion Signals
This skill is complete when:
- the implementation decision is recorded clearly enough to guide later execution
- the decision is stored in the correct artifact section
- any need for an upstream spec update has been surfaced rather than hidden
- the next likely workflow action is stated plainly

## Guardrails
- Do not use `## Important Decisions` as a shortcut for real PRD or Technical Concept changes
- Do not record vague observations that have no execution consequence
- Do not let the section grow into a second changelog
- Do not mark workflow progress complete just because a decision was documented
- Do not stop at documentation alone; orient the user toward the next execution step

## Likely Next Step
Usually suggest one of:
- `review batch` if the decision was recorded during review and approval is still pending
- `commit batch` if the batch is already approved and only the checkpoint remains
- `prepare slice` or `implement batch` depending on what execution step comes next

Prefer the immediate blocked execution step rather than treating documentation as the end of the workflow.
