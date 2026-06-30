# initiate feature

## Purpose
Create the initial Shape feature workspace in the repository, scaffold the core artifact files using Shape conventions, and orient the user toward the next workflow step.

## When to Use
Use this skill when the user wants to start a new Shape feature, create a new feature folder, scaffold the three core artifacts, or establish a feature as a new unit of work in the repository.

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
- A repository state that is ready to be committed as the feature-initiation checkpoint
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

Do not prematurely mark any artifact as `approved`.

## Workflow Boundary Rules

- YOU MUST stop for human review after scaffolding the feature workspace.
- YOU MUST NOT mark any scaffolded artifact `approved` during feature initiation.
- After finishing this Shape operation, YOU MUST ask whether to prepare and submit a commit for the accepted feature-initiation diff.
- YOU MUST NOT create a commit unless the human explicitly approves committing the current diff.
- After the commit boundary is resolved, YOU MUST ask whether to proceed to the next Shape workflow step.
- YOU MUST NOT proceed to `create prd` or any other next Shape workflow step unless the human explicitly approves proceeding.

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
- the workspace is clearly ready for the user or agent to create the feature-initiation commit
- a commit can be proposed cleanly as the feature-initiation checkpoint
- the user can immediately proceed to the next meaningful Shape step

## Guardrails
- Do not overwrite an existing feature folder silently
- YOU MUST NOT mark documents `approved` during scaffolding
- Do not invent non-Shape artifact filenames unless repository constraints require it
- Do not bury the next step; state it plainly
- YOU MUST NOT proceed to the next workflow step without explicit approval

## Likely Next Steps
Usually suggest:
- propose a commit message and offer to create the feature-initiation commit if the user wants to checkpoint the new workspace now
- `create prd`
- `show status`
- `show capabilities`

Prefer `create prd` as the default next step once the commit boundary is resolved and the human explicitly approves proceeding.
