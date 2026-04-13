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
4. Single in-progress feature that is the obvious candidate
5. Most likely candidate based on current workflow state

When a single in-progress feature is the obvious candidate, resolve it with minimal friction.
Prefer a short confirmation over a heavy selection ritual.

Example:
- “I found one in-progress feature: `202604-contact-form`. I’ll use that.”

When multiple plausible candidates exist:
- present a short, clean choice
- keep the list compact
- avoid forcing the user through unnecessary detail

## What to Validate
After resolving a candidate feature, inspect:
- whether `01-prd.md` exists
- whether `02-tech-concept.md` exists
- whether `03-implementation-plan.md` exists
- current document statuses when easily available
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
- PRD ready, Technical Concept draft or missing → `create technical concept`
- PRD and Technical Concept ready, Implementation Plan missing or draft → `initiate implementation`
- Implementation Plan ready or in progress with unfinished slices → `prepare slice`, `review batch`, or other implementation continuation step
- All slices done and plan nearly complete → `finish implementation`

## Fresh-Session Behavior
Shape expects each new Slice to normally begin in a fresh agent session.
In such sessions, this skill should usually run before implementation work unless the active feature is already unambiguous.

This skill should support that behavior by making feature pickup quick, not ceremonial.

## Completion Criteria
This skill is complete when:
- one feature is clearly resolved as active
- core artifacts are located or structural issues are surfaced
- the user can continue without ambiguity
- the next likely workflow step is stated clearly

## Guardrails
- Do not silently pick an ambiguous feature when multiple strong candidates exist
- Do not pretend a broken feature structure is valid; surface warnings clearly
- Do not force a complex selection flow when one obvious in-progress feature exists
- Do not stop at “feature selected”; always orient the user toward the next likely step