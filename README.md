# Shape

A lightweight, artifact-driven workflow for AI-assisted software delivery.

Shape is designed to help structure software feature delivery when working with AI coding agents. It focuses on clear feature artifacts, bounded execution units for AI, and bounded review units for developers so that work can move quickly without becoming chaotic.

## Read this first

- [`overview.md`](./overview.md) — short introduction to the concept, main ideas, and why Shape exists
- [`design.md`](./design.md) — the full workflow specification
- [`templates/`](./templates/) — standalone templates for the core Shape artifacts
  - [`prd-template.md`](./templates/prd-template.md)
  - [`technical-concept-template.md`](./templates/technical-concept-template.md)
  - [`implementation-plan-template.md`](./templates/implementation-plan-template.md)

## What Shape is

Shape is a workflow for delivering software features with AI assistance through a small set of persistent artifacts and explicit execution boundaries.

Its core ideas include:

- **append-only artifact evolution** to keep changes explicit and traceable
- **Slices** as execution units sized for practical AI context limits
- **Batches** as review units sized for practical developer validation limits

Shape is intentionally lightweight. It aims to provide enough structure to improve reliability and clarity without turning AI-assisted delivery into heavyweight process.

## Current status

Shape is currently in specification phase and is initially designed around greenfield feature delivery, with broader delivery scenarios to follow.

Support is intended for Codex, Claude Code, and Gemini, with Codex planned first and soon.

This repository currently focuses on:

- the workflow design
- the core feature artifact templates
- a shareable overview of the concept

Skills, local Shape configuration, and working-state conventions are planned as follow-up layers.

## Repository structure

```text
.
├── overview.md
├── design.md
├── templates/
│   ├── prd-template.md
│   ├── technical-concept-template.md
│   └── implementation-plan-template.md
└── LICENSE
```

## License

MIT