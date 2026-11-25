# initiate feature

## Purpose
Create the initial Shape feature workspace in the repository, scaffold the core artifact files using Shape conventions, and orient the user toward the next workflow step.

## Artifact resolution and compatibility
Read `.shape/config.json` before resolving artifacts. Filenames below are fresh-install defaults; use configured `featuresRoot` and `artifacts.productSpecification`, `artifacts.technicalSpecification`, and `artifacts.implementationPlan` values instead when present. Older configurations may use `prd` and `technicalConcept` keys. Existing `01-prd.md`, `02-tech-concept.md`, and “Slice Plan” headings remain valid; interpret them as Product Specification, Technical Specification, and Iteration without renaming files or rewriting existing documents solely for terminology.

For any specification input, read its `## Source` when present and follow the referenced document and relevant sections, including approved source-revision updates. A reference artifact is valid without the full authored template. If the source is inaccessible or materially changed since review, surface the gap and pause dependent work until it is resolved; do not infer readiness from the link or status alone. Read `.shape/workflow-templates/specification-reference-template.md` for reference and revision rules.

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
- Any repository-specific location override for the default `docs/implementation/` root

Helpful but optional:
- Names, repository paths, or URLs of existing Product and/or Technical Specifications
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
- `01-product-specification.md`
- `02-technical-specification.md`
- `03-implementation-plan.md`
- A repository state that is ready to be committed as the feature-initiation checkpoint
- A clear likely next step

## Repository and Naming Rules
Default Shape layout:

```text
docs/implementation/
  <feature-id>-<feature-slug>/
    01-product-specification.md
    02-technical-specification.md
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

## Existing specifications
Before scaffolding, explain that Shape can draft either specification or reference an existing one by document name, repository path, or URL. If the choice is still open, end the reply with “Which existing specifications, if any, should Shape reference?”

Resolve names against available sources. Ask for clarification only when a name is ambiguous or cannot be resolved. Choose authored or reference mode independently for each specification. For supplied documents, use the reference template and record the source link, relevant scope, and revision/date where available. Keep these artifacts `draft`. The corresponding create-specification step assesses source readiness and handles approval. Record unresolved source details as open questions in the reference artifact.

## Artifact Scaffolding Rules
YOU MUST create all three core files in the feature folder at initiation, even when one or both specifications already exist elsewhere. For each referenced specification, YOU MUST create the corresponding local file using the reference template at the resolved artifact path.

### Product Specification file
Create `01-product-specification.md` using the canonical Product Specification structure, or the reference template when an existing source is supplied.
Initial state:
- `Status: draft`
- current date
- title set from the feature name
- selected authored or reference section structure present, even if content is still skeletal

### Technical Specification file
Create `02-technical-specification.md` using the canonical Technical Specification structure, or the reference template when an existing source is supplied.
Initial state:
- `Status: draft`
- current date
- title set from the feature name
- selected authored or reference section structure present

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
- Review the accepted feature-initiation diff. When commit consent is still needed, YOU MUST report the accepted changes and propose each commit with its subject and scope in the same reply. End with one yes/no question asking whether to create the proposed commit or commits.
- Create and report the scoped commit or commits only when the user explicitly authorizes committing the current changes. Approval of the changes alone leaves commit consent pending.
- After the commit boundary is resolved, YOU MUST ask whether to proceed to the next Shape workflow step.
- YOU MUST NOT proceed to `create product specification` or any other next Shape workflow step unless the user explicitly approves proceeding.

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
- all three core artifact files exist in the feature folder, including a reference file for each specification supplied from elsewhere
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
- `create product specification`
- `show status`
- `show capabilities`

Prefer `create product specification` as the default next step once the commit boundary is resolved and the user explicitly approves proceeding.

## Follow-up Questions

- When a follow-up is needed, end the reply with one question in its own paragraph after the summary, findings, checks, links, and any **Commits** block and adjustment hint.
- When reporting completed commits for the current operation, YOU MUST put a **Commits** block at the end of the summary. List each commit's short hash and exact, unabridged Git subject in creation order.
- Include a passive hint only for commits the user authorized before seeing their exact subjects. Put “The commit message can be adjusted if needed.” directly beneath the eligible entry, or put “Either commit message can be adjusted if needed.” beneath the list when both commits qualify. Omit the hint for commits whose subjects the user saw before consenting.
- Use yes/no for a single named action. Ask for approval, commit consent, and permission to start the next step at their respective checkpoints.
- If the answer requires a choice or missing detail, give context first and ask directly for the input. End with the result when no input is needed and there is no concrete next action to offer.
