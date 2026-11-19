# review code

## Purpose
Perform a code review of the current working-tree changes for a completed implementation batch, using its Batch Summary and defining Iteration as context, and report actionable issues without modifying code or workflow state.

## Artifact resolution and compatibility
Read `.shape/config.json` before resolving artifacts. Use the configured `featuresRoot` and Implementation Plan filename. For an existing feature, inspect its folder before creating or editing files. Use the configured plan path if present; otherwise resolve the existing `03-implementation-plan.md` or configured legacy equivalent. Legacy “Slice Plan” headings mean Iterations. Do not rename or rewrite existing documents solely for terminology.

For any specification input, read its `## Source` when present and follow the referenced document and relevant sections, including approved source-revision updates. A reference artifact is valid without the full authored template. If the source is inaccessible or materially changed since review, report that review context is incomplete; do not infer intended behavior from the link or status alone. Read `.shape/workflow-templates/specification-reference-template.md` for reference and revision rules.

## When to Use
Use this skill when the user asks for a code review, asks to inspect the current changes or working tree, or provides a Batch Summary from `implement batch` for independent assessment.

Typical triggers:
- “review the code”
- “code review”
- “review these changes”
- “inspect the working tree”
- a pasted `## Batch Summary`

## Inputs
Expected inputs:
- the Batch Summary from `implement batch`, including implemented task numbers and its Iteration/Implementation Plan reference
- the repository working tree containing the batch changes

Helpful but optional:
- an explicit diff range or base commit
- focused files, risks, or validation commands
- relevant review feedback from an earlier pass

## Preconditions
Before reviewing:
- read the supplied Batch Summary and resolve its referenced Iteration and Implementation Plan
- inspect the implemented task definitions in `## Execution Order`
- inspect the working-tree diff and any relevant surrounding code
- identify unrelated changes or an incomplete diff boundary before drawing conclusions about the batch

If the Batch Summary, referenced plan, or reviewable diff is unavailable, state the missing context and ask for it. Do not silently substitute a different scope.

## Behavior
Review the selected batch against its stated tasks, iteration intent, repository guidance, and relevant behavior in the surrounding code. Prioritize defects that are introduced by the reviewed changes and that have a concrete impact.

Run relevant existing checks when they help substantiate the review. Report a failed check as a finding only when its failure is attributable to the reviewed batch.

Use these priorities:
- `P1`: a correctness, security, data-loss, or availability defect that should block acceptance
- `P2`: a significant defect or missed requirement that should be fixed before acceptance
- `P3`: a lower-risk issue that improves reliability, maintainability, or edge-case handling

For every finding:
- report it as a bullet whose first text is the priority in brackets, for example: `- [P1] Rejects valid requests when ...`
- include a precise file and line reference when one exists
- explain the triggering condition and concrete impact
- keep the finding limited to an actionable issue introduced by, or materially exposed in, the reviewed batch

Do not report praise, general summaries, hypothetical concerns without evidence, style preferences without a material effect, or issues that predate the batch unless the user asks for a broader review.

## Workflow Boundary Rules

- YOU MUST treat this as a read-only assessment.
- YOU MUST NOT modify code, workflow artifacts, task checkboxes, statuses, or workspace state.
- YOU MUST NOT approve the batch, mark tasks done, create a commit, or advance the workflow.
- YOU MUST NOT treat an absence of findings as developer approval.
- YOU MUST surface an unclear or contaminated review boundary rather than attributing unrelated changes to the selected batch.

The responsible role remains the Developer. This skill provides an independent assessment; the Developer retains review, approval, and commit decisions.

## Artifact Rules
Read the Implementation Plan referenced by the Batch Summary, especially:
- `## Iterations`
- `## Execution Order`
- `## Important Decisions`
- `## Relevant Files`

This skill may read repository guidance, source specifications, the relevant code, and validation results when needed to substantiate a finding.

This skill must not create or update any Shape artifact.

## Outputs
This skill should produce:
- a `## Findings` section containing only actionable findings, each as a `[P1]`, `[P2]`, or `[P3]` bullet
- `No issues found.` when there are no actionable findings
- a brief note when review context or scope is incomplete
- a clear statement that no code or workflow state was changed

## Completion Signals
This skill is complete when:
- the review scope is grounded in the Batch Summary, referenced tasks, and available diff
- each reported issue has an appropriate priority, location, trigger, and impact
- no findings are reported when no actionable issue is supported by the evidence
- no code, artifact, approval, or commit state was changed

## Guardrails
- YOU MUST NOT report a finding without evidence in the reviewed code or its execution context
- YOU MUST NOT use priorities other than `P1`, `P2`, and `P3`
- YOU MUST NOT begin a finding bullet with anything other than its bracketed priority
- YOU MUST NOT conflate review findings with developer approval or workflow progress
- YOU MUST NOT modify the working tree as part of the review

## Likely Next Step
Usually suggest:
- address reported findings through the same `implement batch` revision loop
- if no issues are found, let the Developer decide whether to approve the batch

Do not proceed to revision, approval, commit, or another Shape workflow step without explicit Developer instruction. End a completed review with the findings or outcome when no input is needed. If review context is missing, ask for the specific missing item on the last line.

## Follow-up Questions

- When a follow-up is needed, put one question in its own final paragraph after any summary, findings, checks, or links. Do the same when pausing for input.
- Use yes/no for a single named action. Ask for approval, commit consent, and permission to start the next step at their respective checkpoints.
- If the answer requires a choice or missing detail, give context first and ask directly for the input. End with the result when no input is needed and there is no concrete next action to offer.
