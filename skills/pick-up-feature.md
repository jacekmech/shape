# pick up feature

## Purpose
Resolve and select an existing Shape feature as the active working context so that subsequent operations act on the correct feature artifacts with minimal friction.

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
- Known feature root override if the repository does not use `features/`

## Preconditions
Before resolving a feature:
- Search the repository for Shape feature folders
- Identify candidate folders using the expected Shape layout
- Check whether the core artifact files exist

Expected artifact pattern:

```text
<feature-root>/<feature-id>-<feature-slug>/
  01-prd.md
  02-tech-concept.md
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
- present a short, clean choice
- keep the list compact
- avoid forcing the user through unnecessary detail

When all candidate features appear completed:
- do not silently reactivate one
- state that there is no active unfinished feature to resume by default
- ask whether the user wants to inspect a completed feature or start a new one

## What to Validate
After resolving a candidate feature, inspect:
- whether `01-prd.md` exists
- whether `02-tech-concept.md` exists
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
- PRD missing or still early → `create prd`
- PRD approved, Technical Concept draft or missing → `create technical concept`
- PRD and Technical Concept approved, Implementation Plan missing or draft → `plan implementation`
- next Slice Plan is still `draft` → `plan slice`
- Slice Plan is `approved` and waiting for execution selection → `implement batch`
- Slice Plan is `approved` and active work is awaiting review, approval handling, revision, or commit → continue `implement batch`
- Slice Plan is `approved` with all tasks done and committed → `finish slice`
- all Slice Plans are `done` and plan nearly complete → `finish feature`
- Implementation Plan is `done` → treat the feature as completed unless the user explicitly wants to inspect completed work

## Fresh-Session Behavior
Shape expects each new slice to normally begin in a fresh agent session.
In such sessions, this skill should usually run before implementation work unless the active feature is already unambiguous.

This skill should support that behavior by making feature pickup quick, not ceremonial.

## Workflow Boundary Rules

- YOU MUST treat feature pickup as orientation, not permission to start the next Shape workflow step.
- YOU MUST ask whether to proceed before starting the likely next Shape workflow step.
- YOU MUST NOT start the likely next Shape workflow step unless the human explicitly approves proceeding.
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
