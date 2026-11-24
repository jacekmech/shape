# pick up feature

## Purpose
Resolve and select an existing Shape feature as the active working context so that subsequent operations act on the correct feature artifacts with minimal friction.

## Artifact resolution and compatibility
Read `.shape/config.json` before resolving artifacts. Filenames below are fresh-install defaults; use configured `featuresRoot` and `artifacts.productSpecification`, `artifacts.technicalSpecification`, and `artifacts.implementationPlan` values instead when present. Older configurations may use `prd` and `technicalConcept` keys. Existing `01-prd.md`, `02-tech-concept.md`, and “Slice Plan” headings remain valid; interpret them as Product Specification, Technical Specification, and Iteration without renaming files or rewriting existing documents solely for terminology.

For any specification input, read its `## Source` when present and follow the referenced document and relevant sections, including approved source-revision updates. A reference artifact is valid without the full authored template. If the source is inaccessible or materially changed since review, surface the gap and pause dependent work until it is resolved; do not infer readiness from the link or status alone. Read `.shape/workflow-templates/specification-reference-template.md` for reference and revision rules.

## When to Use
Use this skill when the user wants to resume work on an existing feature, continue a Shape workflow in a fresh session, or set the active feature before performing another operation.

Typical triggers:
- “pick up feature”
- “resume work on this feature”
- “continue implementation”
- “open the in-progress feature”
- “set the active Shape feature”

This skill is especially important at the beginning of a fresh execution session.

## Inputs
Expected inputs:
- Feature name, ID, slug, or partial folder reference

Helpful but optional:
- Current stage or intended next operation
- Whether the user wants the most recent, active, or in-progress feature
- Known feature root override if the repository does not use `docs/implementation/`

## Preconditions
Before resolving a feature:
- Search the repository for Shape feature folders
- Identify candidate folders using the expected Shape layout
- Check whether the core artifact files exist

Expected artifact pattern:

```text
<feature-root>/<feature-id>-<feature-slug>/
  01-product-specification.md
  02-technical-specification.md
  03-implementation-plan.md
```

## Resolution Rules
Prefer deterministic resolution in this order:

1. Exact user-provided feature folder match
2. Exact match on feature ID
3. Exact or near-exact match on slug
4. Single unfinished feature that is the obvious candidate
5. Most likely unfinished candidate based on current workflow state

For default resume behavior, treat a feature as unfinished only when its Implementation Plan is missing, `draft`, or `approved`.
Treat a feature whose Implementation Plan is `done` as completed rather than resumable by default.

When a single unfinished feature is the obvious candidate, resolve it with minimal friction.
Prefer a short confirmation over a heavy selection ritual.

Example:
- “I found one unfinished feature: `202604-contact-form`. I’ll use that.”

When multiple plausible candidates exist:
- list the plausible features briefly
- ask which feature to pick up

When all candidate features appear completed:
- do not silently reactivate one
- state that there is no active unfinished feature to resume by default
- ask which action the user wants when both inspecting a completed feature and starting a new one are plausible

## What to Validate
After resolving a candidate feature, inspect:
- whether `01-product-specification.md` exists
- whether `02-technical-specification.md` exists
- whether `03-implementation-plan.md` exists
- current document statuses when easily available
- whether the Implementation Plan is already `done`
- whether the folder appears structurally valid for Shape

## Output
This skill should produce:
- the resolved active feature
- the resolved core artifact paths
- any structural warnings
- the most likely next step based on workflow state

## Workflow Guidance Logic
Use current artifact state to suggest the next likely step.

Examples:
- Product Specification missing or still early → `create product specification`
- Product Specification approved, Technical Specification draft or missing → `create technical specification`
- Product Specification and Technical Specification approved, Implementation Plan missing or draft → `plan implementation`
- next Iteration is still `draft` → `plan iteration`
- Iteration is `approved` and waiting for execution selection → `implement batch`
- Iteration is `approved` and active work is awaiting review, approval handling, revision, or commit → use `review code` for an independent assessment when wanted, otherwise continue `implement batch`
- Iteration is `approved` with all tasks done and committed → `finish iteration`
- all Iterations are `done` and plan nearly complete → `finish feature`
- Implementation Plan is `done` → treat the feature as completed unless the user explicitly wants to inspect completed work

## Fresh-Session Behavior
Shape expects each new iteration to normally begin in a fresh agent session.
In such sessions, this skill should usually run before implementation work unless the active feature is already unambiguous.

This skill should support that behavior by making feature pickup quick, not ceremonial.

## Workflow Boundary Rules

- YOU MUST treat feature pickup as orientation, not permission to start the next Shape workflow step.
- YOU MUST ask whether to proceed before starting the likely next Shape workflow step.
- YOU MUST NOT start the likely next Shape workflow step unless the user explicitly approves proceeding.
- YOU MUST NOT modify artifacts, mark statuses, or create commits as part of pickup unless the user explicitly requests a separate supported Shape operation.

## Completion Criteria
This skill is complete when:
- one feature is clearly resolved as active
- core artifacts are located or structural issues are surfaced
- the user can continue without ambiguity
- the next likely workflow step is stated clearly

## Guardrails
- Do not silently pick an ambiguous feature when multiple strong candidates exist
- Do not silently reactivate a completed feature as the default resume target
- Do not pretend a broken feature structure is valid; surface warnings clearly
- Do not force a complex selection flow when one obvious unfinished feature exists
- Do not stop at “feature selected”; always orient the user toward the next likely step
- YOU MUST NOT start the next workflow step without explicit approval

## Follow-up Questions

- When a follow-up is needed, put one question in its own final paragraph after any summary, findings, checks, or links. Do the same when pausing for input.
- Use yes/no for a single named action. Ask for approval, commit consent, and permission to start the next step at their respective checkpoints.
- If the answer requires a choice or missing detail, give context first and ask directly for the input. End with the result when no input is needed and there is no concrete next action to offer.
