# Shape Manual

**Practical guide for using Shape in day-to-day software development**

This document explains how to use Shape to deliver a feature with an AI coding agent.

It assumes Shape is already installed and the repository already includes agent-facing guidance. If you need the conceptual introduction first, read `basic-concepts.md`. If you need installation and repository setup guidance, read `installation.md`.

---

## 1. Quick start

A normal Shape flow looks like this:

1. **initiate feature**
2. **create prd**
3. **create technical concept**
4. **plan implementation**
5. **plan slice**
6. **implement batch**
7. **finish slice**
8. Repeat until done
9. **finish feature**

At the beginning of the workflow, Shape creates the feature workspace. As the work moves forward, the workflow produces the **Product Requirements Definition (PRD)**, the **Technical Concept**, the **Implementation Plan**, **Slice Plans**, and the code delivered through implementation batches. Together, these are the outputs of the workflow: structured feature artifacts that define and guide the work, and the code generated along the way.

The workflow also keeps repository and artifact boundaries explicit. Baseline artifacts are created and approved deliberately. Implementation work is reviewed before it is treated as complete. Approved implementation is committed only on explicit instruction before new batch work begins. This keeps both the feature artifacts and the repository in a clean, understandable state as the work moves forward.

When something changes after the PRD or Technical Concept is already approved:
- **update prd**
- **update technical concept**
- **update implementation plan**

That is the full workflow.

---

## 2. The only concepts you really need

### Feature
The unit of work.

### PRD
Defines what the feature should do.

### Technical Concept
Defines the design and implementation direction.

### Implementation Plan
Breaks feature implementation into deliverable slices, defines the feature execution structure, and tracks feature-level execution.

### Slice Plan
Breaks slice implementation into implementation tasks, defines the slice execution structure, and tracks slice-level execution.

### Task
A small executable step inside a Slice Plan.

### Batch
A small selected group of tasks implemented together and then reviewed by the developer.

### Specification Update
An append-only change added to an approved PRD or approved Technical Concept.

If these concepts are clear, the rest of Shape is straightforward.

---

## 3. Status values

### PRD
- `draft`
- `approved`

### Technical Concept
- `draft`
- `approved`

### Implementation Plan
- `draft`
- `approved`
- `done`

### Slice Plans
- `draft`
- `approved`
- `done`

### Specification Updates
- `draft`
- `approved`

Use them literally:
- `draft` means still being refined
- `approved` means accepted for downstream use or as the execution baseline
- `done` means the execution described by the artifact has been completed, reviewed, committed where needed, and validated

For Slice Plans, use them literally as well:
- `draft` means the Slice Plan exists but has not yet been planned in enough detail for execution
- `approved` means the Slice Plan task breakdown is accepted and ready for execution
- `done` means the Slice Plan was explicitly reviewed and closed in `finish slice`

Keep Implementation Plan status and Slice Plan status separate:
- the Implementation Plan tracks feature-level execution through Slice Plans
- each Slice Plan tracks slice-level execution through Tasks and Batches
- progress is reflected through Slice Plan status and Task/Batch state, not through an `in progress` artifact status

---

## 4. The normal workflow

### 4.1 Initiate feature

**Skill:** `initiate feature`

This step is for starting a new feature inside Shape and creating the working area for it. The user should ask the agent to initiate the feature when the work does not yet have a Shape feature folder.

Expected result:
- feature folder created
- PRD file created
- Technical Concept file created
- Implementation Plan file created
- repository ready for the feature to be committed as an explicit starting boundary

Use this when:
- starting a new feature
- formalizing work that currently exists only in notes or tickets
- creating the structure before collaborative work begins

Typical prompts:
- Initiate a new Shape feature for bulk report export
- Start a feature called dataset quality dashboard

---

### 4.2 Create PRD

**Skill:** `create prd`

This step is for turning the feature idea into a clear requirement document. The user should give the agent the available requirement input and ask it to draft or refine the PRD until it is good enough for technical design.

Good input includes:
- rough notes
- ticket text
- user flows
- constraints
- acceptance criteria
- a larger draft prepared outside Shape

Do not be artificially minimal if you already have a decent write-up. Shape works better when the agent gets substantial requirement input early.

A PRD is ready to approve when:
- the goal is clear
- the main flow is understandable
- requirements are concrete enough for design
- out-of-scope items are visible
- important ambiguities are resolved or clearly listed

Then mark the PRD `approved` and commit it as the accepted baseline.

Typical prompts:
- Create a PRD for this feature from the notes below
- Continue refining the PRD and tell me what is still ambiguous
- Mark the PRD approved if it is complete enough for technical design

---

### 4.3 Create Technical Concept

**Skill:** `create technical concept`

This step is for turning the approved PRD into a repository-aware design. The user should ask the agent to create the Technical Concept from the PRD, the repository structure, and the repository guidance, then refine it until implementation can begin without guessing.

The Technical Concept should be repository-aware. It should reflect:
- current code structure
- local patterns
- architecture constraints
- validation commands
- implementation boundaries that already exist in the repo

A Technical Concept is ready to approve when:
- the solution direction is clear
- the design is coherent
- repository alignment is explicit enough
- important risks and trade-offs are visible
- implementation planning can start without guessing the design

Then mark the Technical Concept `approved` and commit it as the accepted design baseline.

Typical prompts:
- Create a Technical Concept for the active feature using the repository guidance
- Continue refining the Technical Concept and call out design risks
- Mark the Technical Concept approved if it is coherent enough for implementation planning

---

### 4.4 Plan implementation

**Skill:** `plan implementation`

This step is for creating the first usable feature execution structure. The user should ask the agent to plan implementation only after the PRD and Technical Concept are approved.

The first version should include:
- the objective
- deliverable slices represented as initial Slice Plans
- the feature execution structure
- `status: approved`

Do not try to fully task the entire feature upfront. Shape works better when the Implementation Plan breaks feature implementation into slices first, and each Slice Plan later breaks one slice into Tasks. At this stage the Implementation Plan is created and approved, but Slice Plans remain untasked and start in `draft` until they are prepared.

Typical prompts:
- Plan implementation for the active feature
- Create the initial Implementation Plan from the approved PRD and Technical Concept

---

### 4.5 Pick up feature

**Skill:** `pick up feature`

This step is for re-establishing the active feature in a fresh session. The user should ask the agent to pick up the feature whenever work is being resumed and the active feature is not already obvious.

This matters when:
- multiple features exist
- you are resuming work after a break
- the session starts in the middle of implementation

The point is simple: do not make the agent guess the active feature.

Typical prompts:
- Pick up the active feature
- Show status for the active feature

---

### 4.6 Plan slice

**Skill:** `plan slice`

This step is for turning the next slice into a concrete Slice Plan with executable implementation tasks. The user should ask the agent to prepare only the next unfinished Slice Plan, not the whole remaining feature.

A good slice:
- has a clear boundary
- fits into one focused session
- is small enough to understand and validate as a unit
- does not depend on broad hidden context

A good task list:
- is concrete
- is easy to batch selectively
- does not mix unrelated work excessively

This step records the approved slice execution structure in the Implementation Plan, but does not start coding yet.

When this step is approved, the selected Slice Plan moves from `draft` to `approved`.
The Implementation Plan does not change status merely because Slice Plan approval happened.
Implementation progress is inferred later from completed tasks and committed batches.

Typical prompts:
- Prepare the next slice
- Break slice 2 into executable implementation tasks
- Refine the next unfinished slice for execution

---

### 4.7 Implement batch

**Skill:** `implement batch`

This step is for executing a deliberately small piece of prepared work and carrying that same batch through review handoff, revision if needed, approval handling, task completion updates, and commit.

Important:
- the developer decides the batch boundary
- the batch should stay small enough for one focused review
- implementation completion is not the same as approval
- after implementation, the agent should ask for review rather than treating the work as accepted
- revisions may happen within the same selected batch without opening a new batch
- only after explicit approval should the agent mark the selected tasks done in the Implementation Plan
- completed tasks under an approved Slice Plan show that slice implementation is underway
- Slice Plan and Implementation Plan statuses do not change during batch implementation
- commit requires explicit user instruction if the agent is to create it, but commit is still part of completing the batch workflow before the next batch begins
- code changes may be accompanied by Implementation Plan updates such as `Relevant Files` or important implementation decisions
- within the same operation, implementation may temporarily be in one of several explicit states: awaiting review, under revision, awaiting approval, or approved but still awaiting commit
- the operation is not complete until the approved batch is committed, either by the user or by the agent on explicit instruction

Typical prompts:
- Implement tasks 1 and 2 from the approved Slice Plan as one batch
- Implement only the selected tasks and stop for review
- Implement this batch, then wait for my approval before marking anything done
- Implement this batch and commit it only if I explicitly approve and ask you to commit

---

### 4.8 Finish slice

**Skill:** `finish slice`

This step is for closing the current slice after all of its tasks have been implemented, explicitly approved, and committed where needed. The user should ask the agent to finish the slice only when the slice objective is actually complete.

The normal precondition is that the Slice Plan is already `approved` and all its tasks are complete.

Confirm that:
- the slice goal is met
- the resulting behavior works
- the implementation still matches the intended boundary
- the approved batch work for the Slice Plan that should be committed is already committed

Then explicitly transition the Slice Plan from `approved` to `done` and commit the updated Implementation Plan.

Typical prompts:
- Finish the current slice
- Check whether the slice objective is complete and move it to done if confirmed

---

### 4.9 Repeat slice by slice

For each new slice:
- start a fresh session
- pick up feature
- plan slice so the Slice Plan becomes `approved`
- implement batch through review, approval, plan-state update, and commit
- finish slice so the Slice Plan explicitly moves to `done`

That repeated microcycle is the heart of Shape.

---

### 4.10 Finish feature

**Skill:** `finish feature`

This step is for closing the full implementation workflow once all Slice Plans are done. The user should ask the agent to finish the feature only when the Implementation Plan reflects reality and there are no unresolved execution gaps.

At this point, confirm that:
- all Slice Plans are `done`
- the Implementation Plan matches the actual state of the work
- there are no unresolved execution gaps
- draft updates are not being mistaken for accepted changes
- the repository is in a clean completed state for the feature

Then mark the Implementation Plan `done` and clear `.shape/workspace.json` so `activeFeature` becomes `null`.

Typical prompts:
- Finish the active feature
- Check completion state and mark the Implementation Plan done if everything is complete

The Implementation Plan is the canonical feature-completion artifact.
PRD and Technical Concept remain `approved` after completion; they do not gain a separate `done` state.

---

## 5. Handling change

**Skills:** `update prd`, `update technical concept`, `update implementation plan`

Once the PRD or Technical Concept is approved, do not quietly rewrite the baseline.

Use a **Specification Update**.

Each update contains:
- Name
- Status
- Date
- Context
- Change / decision
- Impact

### Update PRD when the change affects
- feature behavior
- scope
- user-facing rules
- requirement-level expectations

### Update Technical Concept when the change affects
- architecture
- interfaces
- technical constraints
- design assumptions
- responsibility boundaries

### Update Implementation Plan when approved spec changes affect execution
Typical examples:
- add a new Slice Plan
- adjust a `draft` or not-yet-started `approved` Slice Plan
- change execution order
- refresh notes or relevant files

Only **approved** updates are effective.

A strong default is to keep at most one draft update per target document whenever possible. Multiple drafts in the same document create confusion quickly.

Typical prompts:
- Add a PRD update for this newly discovered requirement
- Add a Technical Concept update for the validation change
- Apply the approved updates to the Implementation Plan

---

## 6. The rules that make Shape work

These rules matter more than any prompt wording.

### 1. Always work against a concrete feature
Do not let the session drift into “some work around this area.” Use a feature folder and its documents.

### 2. Keep PRD and Technical Concept stable after approval
Do not silently rewrite them. Use Specification Updates.

### 3. Use the Implementation Plan as the live execution document
This is the document that should reflect current work.

It should reflect both:
- feature-level execution structure and Implementation Plan status
- slice-level execution structure and Slice Plan status
- task and batch progress inside approved Slice Plans

### 4. Start each new slice in a fresh session
This is one of the most important Shape disciplines.

### 5. Keep slices small
A slice should fit into one focused execution session.

### 6. Keep batches even smaller
A batch should fit into one careful human review.

### 7. Review before approval
The agent implementing a batch does not mean the batch is approved.

### 8. Commit before the next batch
Do not stack approved work without a commit boundary.

### 9. Keep artifact and repository boundaries explicit
Approved baselines, reviewed batches, and committed checkpoints should stay clearly separated.

If a team keeps only these rules, Shape already works well.

---

## 7. Session discipline

Shape gets much of its value from session discipline.

### Good practice
- start by resolving the active feature
- read the current documents before acting
- begin each new slice in a fresh session
- move Slice Plans through `draft -> approved -> done` explicitly
- select batches deliberately
- stop for review after implementation
- commit approved work before moving on
- keep approved artifacts and repository checkpoints clean and explicit

### Weak practice
- relying on long chat history instead of the documents
- implementing multiple slices in one wandering session
- letting the agent expand scope silently
- treating “implemented” as equal to “approved”
- piling up several approved-but-uncommitted changes
- forgetting to propagate accepted design or requirement changes

The documents are not decoration. They are the working memory and control surface of the workflow.

---

## 8. Daily checklist

Concrete navigation skills are also available whenever needed:
- `pick up feature`
- `show status`
- `show capabilities`

### Starting a session
- run or invoke **`pick up feature`** if the active feature is not already obvious
- read the current documents
- use **`show status`** if you need the current workflow state and next likely step
- use **`show capabilities`** if you want a reminder of what Shape can do at this point

### Before implementation
- confirm PRD and Technical Concept are approved
- prepare only the next Slice Plan and move it to `approved`
- choose only a small batch

### After implementation
- review the diff carefully
- request adjustments if needed
- approve explicitly only when satisfied
- mark tasks done only after approval
- treat completed tasks under an approved Slice Plan as the signal that execution has begun
- commit the approved batch before starting another one

### When something new is learned
- use **`update prd`** if it changes requirements
- use **`update technical concept`** if it changes design
- use **`update implementation plan`** if execution needs to change

### Closing a slice
- confirm the slice goal is actually complete
- confirm the approved work is already committed
- explicitly move the Slice Plan from `approved` to `done`
- start the next slice in a fresh session

---

## 9. Final summary

Shape is intentionally small, but it is not vague.

It works when you keep a few things disciplined:
- one feature at a time
- stable baseline specs
- explicit late change handling
- slice-by-slice execution
- batch-by-batch review
- fresh sessions for new slices
- human approval as the real control boundary
- explicit commit boundaries before new batch work
- concrete skills that keep the conversation aligned with known workflow guardrails

Use it this way and Shape stays easy to operate while still giving you structure, traceability, and better AI-assisted development quality.
