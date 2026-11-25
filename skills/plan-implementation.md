# plan implementation

## Purpose
Create the initial Implementation Plan from the approved Product Specification and approved Technical Specification, break feature implementation into deliverable Iterations, and set up execution so that implementation can continue iteration by iteration through small, reviewable batches.

## Artifact resolution and compatibility
Read `.shape/config.json` before resolving artifacts. Filenames below are fresh-install defaults; use configured `featuresRoot` and `artifacts.productSpecification`, `artifacts.technicalSpecification`, and `artifacts.implementationPlan` values instead when present. Older configurations may use `prd` and `technicalConcept` keys. Existing `01-prd.md`, `02-tech-concept.md`, and “Slice Plan” headings remain valid; interpret them as Product Specification, Technical Specification, and Iteration without renaming files or rewriting existing documents solely for terminology.

For any specification input, read its `## Source` when present and follow the referenced document and relevant sections, including approved source-revision updates. A reference artifact is valid without the full authored template. If the source is inaccessible or materially changed since review, surface the gap and pause dependent work until it is resolved; do not infer readiness from the link or status alone. Read `.shape/workflow-templates/specification-reference-template.md` for reference and revision rules.

## When to Use
Use this skill when the user wants to begin implementation planning for a feature whose Product Specification and Technical Specification are already approved, or when the existing Implementation Plan is still only a scaffold and needs to become a real execution document.

Typical triggers:
- “plan implementation”
- “start implementation planning”
- “create the implementation plan”
- “begin implementation”
- “set up iterations for execution”

## Inputs
Expected inputs:
- active feature reference or resolved feature folder
- approved Product Specification in `01-product-specification.md`
- approved Technical Specification in `02-technical-specification.md`
- relevant codebase context

Helpful but optional:
- existing draft content in `03-implementation-plan.md`
- implementation constraints already agreed by the user
- known repository areas likely to matter first

## Preconditions
Before creating or refining the Implementation Plan, resolve the active feature and its artifact paths. YOU MUST verify that both specification files exist at their resolved paths in the feature folder. If either file is missing, report its path and pause planning until the corresponding `create product specification` or `create technical specification` step establishes the approved local artifact. When both are missing, resolve the Product Specification first.

Once both files exist:
- confirm the Product Specification status is `approved`
- confirm the Technical Specification status is `approved`
- inspect any approved updates in the Product Specification or Technical Specification that materially affect execution
- inspect the codebase enough to shape realistic initial Iterations

If the Product Specification or Technical Specification is still `draft`, surface that clearly and redirect to the appropriate upstream skill.

## Behavior
Create or refine the Implementation Plan into an execution-ready control document for feature implementation.

During initialization:
- start from the Product Specification’s proposed delivery iterations and technical feasibility findings; explain splits, merges, or reordering and preserve traceability to product outcomes
- do not treat the product proposal as approved executable Iterations; create the refined Iterations in `draft`
- summarize the development objective from the approved Product Specification and Technical Specification
- define the feature implementation breakdown as an initial set of deliverable Iterations
- create initial Iterations in `draft`
- keep iterations reviewable and practical rather than overly broad
- do not add implementation tasks

This skill should reinforce Shape’s execution discipline:
- each new iteration should normally begin in a fresh agent session
- fresh execution sessions should normally begin with `pick up feature` unless the active feature is already unambiguous
- execution will later proceed through Iterations and batches selected by the user
- approved batches may be committed within `implement batch`, but only on explicit instruction from the user before the next batch begins

The agent may propose Iterations and execution order, but should not silently decide implementation strategy where the user needs to choose trade-offs or sequencing.

Set the Implementation Plan to `approved` when the feature-level breakdown and execution framing are accepted as the execution baseline.
The Implementation Plan remains `approved` during execution and moves to `done` only when all Iterations are done and the feature is finished.

## Workflow Boundary Rules

- If explicit approval is still missing, YOU MUST pause for the user's review before changing the Implementation Plan from `draft` to `approved`.
- YOU MUST NOT mark the Implementation Plan `approved` unless the user explicitly approves that transition.
- Review the accepted Implementation Plan diff. When commit consent is still needed, YOU MUST report the new status and propose each commit with its subject and scope in the same reply. End with one yes/no question asking whether to create the proposed commit or commits.
- Create and report the scoped commit or commits only when the user explicitly authorizes committing the current changes. Approval of the status change alone leaves commit consent pending.
- After the commit boundary is resolved, YOU MUST ask whether to proceed to the next Shape workflow step.
- YOU MUST NOT proceed to the next Shape workflow step unless the user explicitly approves proceeding.

## Artifact Rules
Write only to the Implementation Plan in `03-implementation-plan.md`. Read the approved Product Specification and approved Technical Specification as upstream inputs.

Use the canonical Implementation Plan section structure:
- `## Header`
- `## Objective`
- `## Iterations`
- `## Execution Order`
- `## Important Decisions`
- `## Relevant Files`
- `## Notes`

Apply these rules:
- the Implementation Plan is a live inline document rather than an append-only update artifact
- YOU MUST link to both feature-local specifications under `## Relevant Files`. Replace direct links to external specifications that serve as the plan's upstream references with links to the corresponding local artifacts. Resolve external sources through the local artifacts' `## Source` sections and approved updates.
- `## Iterations` should define the feature implementation breakdown using explicit Iteration status entries
- initial Iterations created by this skill should start in `draft`
- `## Execution Order` should establish Iteration ordering, but implementation tasks must remain empty until `plan iteration`
- `## Relevant Files` should stay selective and useful for fresh-session pickup rather than becoming a full file inventory
- no explicit batch representation should be added to the document

This skill may:
- create or refine `## Objective`
- define initial Iterations in `## Iterations`
- establish corresponding Iteration entries in `## Execution Order`
- seed `## Relevant Files` with a compact working file map when useful
- change plan status between `draft` and `approved` based on explicit acceptance from the user

This skill must not:
- start approving or completing Iterations
- treat batch boundaries as document structure
- rewrite the Product Specification or Technical Specification as part of implementation kickoff
- mark the plan `done`

## Outputs
This skill should produce:
- an Implementation Plan in `03-implementation-plan.md` aligned to the Implementation Plan template
- initial Iterations in `draft` that represent the feature implementation breakdown and are ready for later refinement
- updated plan status of `draft` or `approved`
- a repository state that is ready to be committed once the user accepts the initial plan structure
- a proposed commit message when the accepted planning state is suitable for checkpointing
- a clear likely next step

## Completion Signals
This skill is complete when:
- `03-implementation-plan.md` reflects and links to the approved Product Specification and approved Technical Specification in the feature folder
- initial Iterations exist, represent deliverable iterations, and are small enough to support focused execution sessions
- `## Execution Order` contains the execution skeleton without prematurely turning into task-level detail
- the plan status accurately reflects whether execution planning is still being refined or is approved as the execution baseline
- the resulting planning state is clear enough to serve as a repository checkpoint before Iteration refinement begins
- the accepted checkpoint is clear enough that the agent can propose a commit cleanly
- the next likely workflow step is stated plainly

## Guardrails
- Do not start planning implementation from draft upstream artifacts
- Do not collapse Iteration approval into immediate batch execution
- Do not add implementation tasks so early that iteration boundaries become unclear
- Do not turn `## Relevant Files` into a historical changelog or full repository inventory
- Do not mark the plan `done` merely because the initial plan now exists
- YOU MUST NOT proceed to the next workflow step without explicit approval

## Likely Next Step
Usually suggest:
- continue `plan implementation` if Iteration structure is still unstable
- `plan iteration` if the Implementation Plan is `approved`
- `update technical specification` or `update product specification` if implementation planning exposed a real upstream gap

Prefer `plan iteration` once the Implementation Plan is explicitly accepted as `approved`, the commit boundary is resolved, and the user explicitly approves proceeding.

## Follow-up Questions

- When a follow-up is needed, end the reply with one question in its own paragraph after the summary, findings, checks, links, and any **Commits** block and adjustment hint.
- When reporting completed commits for the current operation, YOU MUST put a **Commits** block at the end of the summary. List each commit's short hash and exact, unabridged Git subject in creation order.
- Include a passive hint only for commits the user authorized before seeing their exact subjects. Put “The commit message can be adjusted if needed.” directly beneath the eligible entry, or put “Either commit message can be adjusted if needed.” beneath the list when both commits qualify. Omit the hint for commits whose subjects the user saw before consenting.
- Use yes/no for a single named action. Ask for approval, commit consent, and permission to start the next step at their respective checkpoints.
- If the answer requires a choice or missing detail, give context first and ask directly for the input. End with the result when no input is needed and there is no concrete next action to offer.
