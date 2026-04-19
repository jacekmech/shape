# Shape

**A lightweight, artifact-driven workflow for AI-assisted software delivery**  
*3-minute read*

Shape is a workflow for building software features with an AI coding agent in a way that stays structured, reviewable, and usable in real engineering work.

It is designed for teams or individuals who want AI assistance to be productive without turning delivery into prompt chaos, oversized sessions, or hard-to-review output. Shape gives the work a simple structure: a feature is defined through a small set of documents, implementation is broken into execution units that fit AI context, and delivered code is grouped into review units that fit developer attention.

The goal is not to replace engineering judgment. The goal is to make human intent clearer, agent execution more reliable, and iteration faster without losing control.

**Shape structures and amplifies human intent. Clear thinking in — clear software out.**

## Why Shape exists

The problem is no longer that AI coding is unavailable. The problem is that, in many teams, it is being adopted faster than the surrounding delivery model can absorb.

The result is familiar: capable tools produce promising results locally, but without a repeatable way to turn that into reliable team execution. Requirements drift, design decisions disappear into chat history, sessions grow too large, reviews become unmanageable, and important changes fail to propagate cleanly.

The gap is not in the tooling. It is in the workflow around it — the work of making AI-assisted delivery repeatable, reviewable, and traceable.
Shape is a response to that gap. Not more process, heavier control, or larger planning rituals — but a workflow that is explicit, lightweight, and artifact-driven.

## Core idea

Shape is an AI-assisted software delivery workflow built around the **feature** as its main unit of delivery.

For each feature, Shape maintains a small set of core artifacts, created and updated by the AI agent under human guidance, that act as shared working memory for both human and agent:

- a **Product Requirements Description** describing what should be built
- a **Technical Concept** describing how it should be built
- an **Implementation Plan** describing how implementation is split into executable steps

These are not disposable notes. They preserve intent, design, and execution structure in a form that can be reused, updated, and reviewed throughout delivery.

Shape also defines two deliberately different execution boundaries:

- a **Slice** is a unit of work sized to fit a focused AI execution session
- a **Batch** is a unit of completed work sized to fit a focused developer review step

This distinction is central to Shape. AI agents and human reviewers do not work well at the same granularity. Shape treats that as a workflow design constraint instead of leaving it to improvisation.

## What is different about Shape

### 1. It treats AI delivery as a workflow problem, not only a tooling problem

Better models and better agents help, but they do not by themselves create reliable delivery. Shape starts from the assumption that the missing piece in many teams is not capability, but operating structure.

Its focus is therefore not the agent alone, but the delivery model around it: how intent is recorded, how work is split, how changes are tracked, and how results are reviewed.

### 2. Append-only artifact updates

Shape treats feature documents as persistent, evolving delivery artifacts rather than static specs that must always be rewritten into a clean final form.

When new learnings appear, they are incorporated through explicit updates instead of silent replacement. This makes changes traceable, preserves earlier intent, and reduces the risk of hidden drift across requirements, design, and implementation.

AI makes this far more practical. Maintaining structured artifacts used to feel too heavy for the speed of delivery. With AI, updates can be drafted, aligned, and compressed with much less manual effort.

### 3. Explicit care for LLM context: the Slice

Shape assumes that reliable AI execution depends on keeping work inside a manageable context boundary.

A **Slice** is intentionally small enough to be handled in a single focused agent session with a clear objective, limited ambiguity, and bounded implementation scope.

One of Shape’s core ideas is that workflow quality improves when execution units are designed around practical agent context limits instead of pretending that an entire feature should be implemented in one continuous conversation.

### 4. Explicit care for developer context: the Batch

Shape also assumes that review quality depends on bounded cognitive load.

A **Batch** groups completed implementation work into a reviewable unit that a developer can validate without diff fatigue, context switching overload, or blurred acceptance decisions.

Slices optimize for agent execution. Batches optimize for human validation.

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

The workflow is intentionally lightweight. It aims to keep the structure just strong enough for both human and agent to stay oriented throughout delivery. In practice, Shape is applied through a small set of workflow skills and repository conventions installed into the agent environment, so the workflow becomes part of day-to-day execution rather than a separate document the team has to remember to follow.

Shape also assumes that repository context matters. Good feature artifacts improve feature-level intent, but agent-facing repository guidance improves implementation consistency, validation reliability, and alignment with local engineering conventions.

## In one sentence

Shape is a lightweight workflow for AI-assisted software delivery that uses evolving feature artifacts, AI-sized execution slices, and human-sized review batches to make delivery faster, more repeatable, and more traceable without turning it into chaos.