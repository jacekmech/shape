# Prompt for Generating Shape Skill Files

Use this prompt when asking agent to generate additional Shape skill files for the Shape workflow.

---

## Objective

Generate one or more Shape skill files as standalone markdown documents under `/skills/`, following:

- the Shape workflow specification
- the Shape artifact templates
- the approved example skill files already present in the repository
- `skills/README.md`

The goal is to extend the skill set consistently, not invent a new style.

---

## Required Inputs

Before generating skills, use the following repository sources as the source of truth:

1. the Shape specification document
   - `design.md`
2. the artifact templates:
   - `workflow-templates/specification-reference-template.md`
   - `workflow-templates/product-specification-template.md`
   - `workflow-templates/technical-specification-template.md`
   - `workflow-templates/implementation-plan-template.md`
3. the skill design standard:
   - `skills/README.md`
4. approved example skills already present in:
   - `skills/`

Do not generate skills from memory alone.  
Use the local repository files as the canonical reference.

---

## What You Are Generating

Generate one markdown file per requested skill under `/skills/`.

Use stable kebab-case filenames derived from the skill name.

Examples:
- `show-capabilities.md`
- `create-product-specification.md`
- `update-product-specification.md`
- `plan-iteration.md`

Each file should represent exactly one Shape skill.

Do not bundle multiple skills into one file.

---

## Required Skill Design Rules

Follow these rules strictly:

### 1. One skill = one Shape operation
Do not merge adjacent operations unless explicitly instructed.

### 2. Preserve Shape workflow boundaries
Examples:
- `implement batch` must not imply approval
- `implement batch` includes review handling and commit as part of the same operation, but explicit approval from the user and explicit commit consent must remain separate
- Product Specification and Technical Specification updates remain append-only after readiness

### 3. Be artifact-aware
Ground each skill in:
- the actual Shape documents
- actual section names from the templates
- actual repository layout rules

Do not write generic assistant prompts detached from artifacts.

### 4. Preserve human ownership
The skill must preserve the user's decisions about approval, commit consent, and progression to the next workflow step.

### 5. Keep style consistent with approved examples
Match:
- structure
- tone
- level of detail
- specificity
- naming

### 6. Make the next likely step obvious
Each skill should end in a way that makes workflow continuation clear.

---

## Required File Structure

Unless a strong reason exists otherwise, each generated skill file should use this structure:

1. `# <Skill Name>`
2. `## Purpose`
3. `## When to Use`
4. `## Inputs`
5. `## Preconditions`
6. `## Behavior`
7. `## Artifact Rules`
8. `## Outputs`
9. `## Completion Signals`
10. `## Guardrails`
11. `## Likely Next Step`

Use this structure consistently across generated skills.

---

## Content Rules

### Write for execution
Each file should describe how the agent should behave during the workflow step.

### Be specific
State:
- what the skill reads
- what it may create or update
- what it must not modify
- what confirmation is required
- what completion looks like

### Use actual template sections
Examples:
- Product Specification `## Updates`
- Technical Specification `## Repository Alignment`
- Implementation Plan `## Execution Order`
- Implementation Plan `## Relevant Files`

### Respect document lifecycle rules
- Product Specification baseline becomes immutable after readiness
- Technical Specification baseline becomes immutable after readiness
- updates are append-only
- only approved updates are effective
- Implementation Plan is updated inline

### Respect implementation review boundaries
- tasks are marked done only after explicit approval from the user
- `implement batch` is not complete until the approved batch is committed
- the agent may create the required commits only on explicit instruction from the user before the next batch begins

### Propose commits at accepted checkpoints
- Treat an explicit request for a specific status change as approval for that transition once its preconditions are met.
- Require the agent to review the scoped diff at an accepted checkpoint. If commit consent is still needed, report the status or accepted changes and propose the commit subject and scope in the same reply, ending with one question asking whether to create the proposed commit or commits.
- Require explicit consent for the current commit scope. When it is already given, create the authorized commit. End the final reply reporting completed commits with a **Commits** block listing their short hashes and exact, unabridged Git subjects in creation order. Add a passive hint only for commits authorized before their exact subjects were shown to the user. Use “The commit message can be adjusted if needed.” beneath the eligible entry, or “Either commit message can be adjusted if needed.” beneath the list when both qualify.
- Split the approved diff by the configured Shape feature folder paths. For mixed changes, require a single proposal and consent question covering two scoped commits, codebase first and Shape artifacts second. Use a clear Shape subject, with `shape:` where repository conventions support it.
- Allow explicitly approved and validated Iteration closure in the final batch's Shape commit after the codebase commit succeeds.

### Place follow-up questions
- Include this guidance in each generated skill. When there is a decision to make or information to provide, place one follow-up question in its own paragraph after the summary, findings, checks, or links. Put it before the final **Commits** block when reporting completed commits. Otherwise, keep the question in the final paragraph, including when pausing for input mid-operation.
- Use a yes/no question for a single named action. Ask for review approval, commit consent, and permission for the next operation at their respective checkpoints.
- If the user must choose among options or supply a detail, present the context before asking for the specific input.
- End with the result when no user decision or input is needed and there is no concrete next action to offer.

### Keep tone operational
Avoid:
- marketing tone
- generic motivational prose
- vague workflow descriptions

Prefer:
- explicit constraints
- practical execution guidance
- crisp completion criteria

---

## What Not to Do

Do not:

- invent new Shape operations
- collapse multiple operations into one file
- rewrite the document templates
- change repository layout conventions
- turn a skill into a full workflow overview
- silently loosen approval boundaries
- use fuzzy wording where Shape defines a hard rule

---

## Generation Process

For each requested skill:

1. inspect the Shape spec and relevant templates
2. inspect approved example skill files for style consistency
3. generate the new skill file
4. ensure filename matches skill name
5. ensure the content follows `skills/README.md`
6. do a consistency pass against existing approved skills

---

## Output Requirements

When asked to generate skills:

- create the files directly under `/skills/`
- do not place generated content only in chat unless explicitly requested
- preserve consistent markdown formatting
- keep the files concise but operationally complete

If asked for multiple skills, generate them in a small batch.

---

## Review Checklist

Before considering a generated skill complete, check:

- Does it map to exactly one Shape operation?
- Does it preserve the user's approval, commit consent, and next-step decisions?
- Is it grounded in real artifacts and real sections?
- Does it match the structure and tone of approved examples?
- Does it define guardrails clearly?
- Does it make the next likely workflow step obvious?
- Does it put applicable follow-ups last and use yes/no for a single proposed action?

If the answer to any of these is no, revise the file before finishing.

Honor configured paths and legacy artifact names on existing installations. For specification workflows, support independent authored/reference modes, an explicit offer to use existing documents by name/path/URL, source revision review, and append-only source updates. Include the provisional delivery outline in the Product Specification or its linked source; refine it during implementation planning.
