# Codex Prompt for Generating Shape Skill Files

Use this prompt when asking Codex to generate additional Shape skill files for the Shape workflow.

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
   - `workflow-templates/prd-template.md`
   - `workflow-templates/technical-concept-template.md`
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
- `create-prd.md`
- `update-prd.md`
- `prepare-slice.md`

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
- `review batch` must not replace developer approval
- `commit batch` remains a distinct step
- PRD and Technical Concept updates remain append-only after readiness

### 3. Be artifact-aware
Ground each skill in:
- the actual Shape documents
- actual section names from the templates
- actual repository layout rules

Do not write generic assistant prompts detached from artifacts.

### 4. Preserve human ownership
The skill must support the responsible role, not replace it.

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
- PRD `## Updates`
- Technical Concept `## Repository Alignment`
- Implementation Plan `## Execution Order`
- Implementation Plan `## Relevant Files`

### Respect document lifecycle rules
- PRD baseline becomes immutable after readiness
- Technical Concept baseline becomes immutable after readiness
- updates are append-only
- only ready updates are effective
- Implementation Plan is updated inline

### Respect implementation review boundaries
- tasks are marked done only after explicit developer approval
- approved batches should be committed before the next batch begins

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
- Does it preserve Shape responsibility boundaries?
- Is it grounded in real artifacts and real sections?
- Does it match the structure and tone of approved examples?
- Does it define guardrails clearly?
- Does it make the next likely workflow step obvious?

If the answer to any of these is no, revise the file before finishing.
