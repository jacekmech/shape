# Shape

**A lightweight, artifact-driven workflow for AI-assisted software delivery**  
*3-minute read*

Shape is a workflow for building software features with an AI coding agent in a way that stays structured, reviewable, and usable in real engineering work.

It is designed for teams or individuals who want AI assistance to be productive without turning delivery into prompt chaos, oversized sessions, or hard-to-review output. Shape gives the work a simple structure: a feature is defined through a small set of documents, implementation is broken into execution units that fit AI context, and delivered code is grouped into review units that fit developer attention.

The goal is not to replace engineering judgment. The goal is to make human intent clearer, make agent execution more reliable, and make iteration faster without losing control.

## Why Shape exists

AI coding agents can generate useful code quickly, but software delivery breaks down when the surrounding workflow is vague.

In practice, the failure modes are familiar:

- requirements drift while implementation moves ahead
- design decisions remain implicit or disappear into chat history
- agent sessions grow too large and lose focus
- code lands in chunks that are awkward for a developer to review
- late changes create silent divergence between intent, design, and implementation

Shape addresses this by making the workflow explicit, lightweight, and artifact-driven.

It gives both the human and the agent a shared operational model for how a feature moves from idea to reviewed implementation.

## Core idea

Shape uses a **feature** as the main delivery unit. Each feature is supported by three core artifacts:

- a **PRD** describing what should be built
- a **Technical Concept** describing how it should be built
- an **Implementation Plan** describing how implementation is split into executable steps

These artifacts are not disposable notes. They are the shared working memory of the feature.

Implementation then progresses through two deliberately different execution boundaries:

- a **Slice** is a unit of work sized to fit within a focused AI execution session
- a **Batch** is a unit of completed work sized to fit within a focused developer review step

This distinction is central to Shape.

AI agents and human reviewers do not operate well at the same granularity. Shape treats this as a workflow design constraint rather than something to work around informally.

## What is different about Shape

### 1. Append-only artifact updates

Shape treats feature documents as persistent, evolving delivery artifacts rather than static specs that must always be rewritten into a clean final form.

When new learnings appear, they are incorporated through explicit updates instead of silent replacement. This makes changes traceable, preserves earlier intent, and reduces the risk of hidden drift across requirements, design, and implementation.

This approach became much more practical with AI assistance.

Without AI, maintaining structured append-only artifacts often felt too heavy for the speed of delivery. With AI, the cost drops significantly: updates can be drafted quickly, aligned across documents faster, and kept readable with less manual effort.

That makes append-only evolution not just practical, but useful. It improves traceability while also giving the agent better context about how and why the feature changed.

### 2. Explicit care for LLM context: the Slice

Shape assumes that reliable AI execution depends on keeping work inside a manageable context boundary.

A **Slice** is the unit used for this. It is intentionally small enough to be handled in a single focused agent session with a clear objective, limited ambiguity, and bounded implementation scope.

This is one of Shape’s core ideas: workflow quality improves when execution units are designed around practical agent context limits instead of pretending that an entire feature should be implemented in one continuous conversation.

### 3. Explicit care for developer context: the Batch

Shape also assumes that human review quality depends on bounded cognitive load.

A **Batch** groups completed implementation work into a reviewable unit that a developer can validate without diff fatigue, context switching overload, or blurred acceptance decisions.

This is the second key boundary in the workflow. Slices optimize for agent execution. Batches optimize for human validation.

Together, they let implementation move fast without forcing either the AI or the developer to work in units that are too large for reliable judgment.

## How Shape works

At a high level, Shape follows a simple flow:

1. define the feature and create its core artifacts
2. refine requirements and technical design
3. split implementation into slices
4. execute slices in focused agent sessions
5. group completed work into reviewable batches
6. review, approve, and commit accepted batches
7. reflect important discoveries back into the artifacts through explicit updates

The workflow is intentionally lightweight, but it is not casual. It aims to keep the structure just strong enough that both the user and the agent stay oriented.

Shape also assumes that repository context matters. Good feature artifacts improve feature-level intent, but agent-facing repository guidance improves implementation consistency, validation reliability, and alignment with local engineering conventions.

## What Shape is trying to optimize for

Shape is designed to optimize for a combination that is hard to achieve with ad hoc prompting alone:

- fast iteration
- explicit intent
- controlled change handling
- reviewable implementation progress
- better use of AI context
- better use of developer attention

It is intentionally collaborative. The human remains responsible for direction, judgment, and acceptance. The AI helps produce artifacts and code within a workflow that keeps both sides aligned.

Shape structures and amplifies human intent. Clear thinking in — clear software out.

## Current status

Shape is currently in specification phase and is initially designed around greenfield feature delivery, with broader delivery scenarios to follow.

The workflow is being prepared for public use incrementally. Support is intended for Codex, Claude Code, and Gemini, with Codex planned first and soon. Core workflow concepts and document templates come first. Skills, local Shape configuration, and working-state conventions are planned as follow-up layers.

## In one sentence

Shape is a lightweight workflow for AI-assisted software delivery that uses evolving feature artifacts, AI-sized execution slices, and human-sized review batches to make delivery faster without making it chaotic.
