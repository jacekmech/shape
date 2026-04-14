# Shape

A lightweight, artifact-driven workflow for AI-assisted software delivery.

Shape is designed to help structure software feature delivery when working with AI coding agents. It focuses on clear feature artifacts, bounded execution units for AI, bounded review units for developers, and explicit skill-based workflow support so that work can move quickly without becoming chaotic.

## Read this first

- [`overview.md`](./overview.md) — short introduction to the concept, main ideas, and why Shape exists
- [`design.md`](./design.md) — the full workflow specification
- [`templates/`](./templates/) — standalone templates for the core Shape artifacts
  - [`prd-template.md`](./templates/prd-template.md)
  - [`technical-concept-template.md`](./templates/technical-concept-template.md)
  - [`implementation-plan-template.md`](./templates/implementation-plan-template.md)
- [`skills/`](./skills/) — Shape skill files and skill design guidance
  - [`README.md`](./skills/README.md) — how the skills folder is organized and how skills map to Shape operations
  - skill design principles — the design standard used to create and review Shape skills
  - individual skill files — one file per workflow skill

## What Shape is

Shape is a workflow for delivering software features with AI assistance through a small set of persistent artifacts, explicit execution boundaries, and installable workflow skills.

Its core ideas include:

- **append-only artifact evolution** to keep changes explicit and traceable
- **Slices** as execution units sized for practical AI context limits
- **Batches** as review units sized for practical developer validation limits
- **skills** as reusable workflow capabilities aligned with Shape operations and repository artifacts

Shape is intentionally lightweight. It aims to provide enough structure to improve reliability and clarity without turning AI-assisted delivery into heavyweight process.

## Current status

Shape is currently in specification phase and is initially designed around greenfield feature delivery, with broader delivery scenarios to follow.

Support is intended for Codex, Claude Code, and Gemini, with Codex planned first.

This repository currently focuses on:

- the workflow design
- the core feature artifact templates
- the initial skill model and skill design guidance
- a shareable overview of the concept

Local Shape configuration and working-state conventions are planned as follow-up layers.

## Repository structure

```text
.
├── overview.md
├── design.md
├── templates/
│   ├── prd-template.md
│   ├── technical-concept-template.md
│   └── implementation-plan-template.md
├── skills/
│   ├── README.md
│   ├── skill-design-principles.md
│   └── *.md
└── LICENSE
```

## License

MIT