# initiate feature

## Purpose
Create the initial Shape feature workspace in the repository, scaffold the core artifact files using Shape conventions, inspect repository readiness for agent-assisted delivery, and orient the user toward the next workflow step.

## When to Use
Use this skill when the user wants to start a new Shape feature, create a new feature folder, scaffold the three core artifacts, or establish a feature as a new delivery unit in the repository.

Typical triggers:
- “start a new feature”
- “initiate feature”
- “create the feature workspace”
- “set up Shape docs for this feature”
- “scaffold a new Shape feature”

## Inputs
Expected inputs:
- Feature intent or short description
- Optional preferred feature identifier
- Optional preferred feature slug
- Repository root or relevant artifact root if known
- Any repository-specific location override for the default `features/` root

Helpful but optional:
- Existing ticket title
- Existing feature brief
- Existing repository guidance files or references

## Preconditions
Before proceeding, confirm or infer:
- The user intends to create a **new** feature, not resume an existing one
- The repository contains or can contain Shape artifacts
- The target feature folder does not already exist, unless the user clearly wants to reuse or repair it

This skill should not silently overwrite an existing feature folder.

## Outputs
This skill should produce:
- A new feature folder
- `01-prd.md`
- `02-tech-concept.md`
- `03-implementation-plan.md`
- A concise repository readiness assessment
- A clear likely next step

## Repository and Naming Rules
Default Shape layout:

```text
features/
  <feature-id>-<feature-slug>/
    01-prd.md
    02-tech-concept.md
    03-implementation-plan.md
```

Use these rules:
- Prefer one feature folder per feature
- Prefer a stable feature identifier plus short slug
- Use predictable core filenames exactly as defined by Shape
- Respect repository-specific root overrides when they are already established
- Do not invent alternative filenames unless the repository already requires them

Recommended folder pattern:

```text
<feature-id>-<feature-slug>
```

Examples:
- `202604-contact-form`
- `202604-csv-import-validation`

## Artifact Scaffolding Rules
Create all three core files at feature initiation time.

### PRD file
Create `01-prd.md` using the canonical PRD structure.
Initial state:
- `Status: draft`
- current date
- title set from the feature name
- section structure present, even if content is still skeletal

### Technical Concept file
Create `02-tech-concept.md` using the canonical Technical Concept structure.
Initial state:
- `Status: draft`
- current date
- title set from the feature name
- section structure present

### Implementation Plan file
Create `03-implementation-plan.md` using the canonical Implementation Plan structure.
Initial state:
- `Status: draft`
- current date
- title set from the feature name
- empty or placeholder execution content is acceptable at this stage

Do not prematurely mark any artifact as `ready`.

## Repository Readiness Check
This skill must inspect repository readiness for agent-assisted delivery.

Look for agent-facing guidance such as:
- `AGENTS.md`
- `CLAUDE.md`
- `GEMINI.md`
- contributor docs
- engineering docs referenced from agent-facing files
- repository docs that define conventions, commands, or architecture

Assess readiness using Shape’s three-level model:
- **ready enough**
- **degraded**
- **high risk**

Check for evidence of:
- repository structure guidance
- test, lint, build, and formatting commands
- coding conventions
- architectural constraints or preferred patterns
- expected location for feature artifacts

## Readiness Behavior
Behavior by readiness level:

### Ready enough
Proceed normally.
Summarize the useful guidance found.

### Degraded
Proceed only after clearly warning the user that delivery quality and predictability are reduced.
State the most important gaps.

### High risk
Give a stronger warning.
State that agent-assisted delivery is materially less reliable.
Do not pretend the repository is prepared if it is not.

This skill should not hard-block feature initiation solely because readiness is incomplete, but it should make the consequences explicit.

## Interaction Style
When feature identity is incomplete:
- infer sensible defaults when possible
- ask only the minimum necessary question if a critical ambiguity remains
- avoid turning setup into a long naming exercise

When a strong default is available:
- propose it clearly
- proceed with minimal friction

## Completion Criteria
This skill is complete when:
- the new feature folder is resolved
- all three core artifact files exist
- each file starts in `draft`
- repository readiness has been assessed and reported
- the user can immediately proceed to the next meaningful Shape step

## Likely Next Steps
Usually suggest one of:
- `create prd`
- `show status`
- `show capabilities`

Prefer `create prd` as the default next step unless the user first needs orientation or repository issues need attention.

## Guardrails
- Do not overwrite an existing feature folder silently
- Do not mark documents `ready` during scaffolding
- Do not skip repository readiness reporting
- Do not invent non-Shape artifact filenames unless repository constraints require it
- Do not bury the next step; state it plainly