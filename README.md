# Shape

A lightweight, artifact-driven workflow for AI-assisted software delivery.

Shape is designed to help structure software feature delivery when working with AI coding agents. It focuses on clear feature artifacts, bounded execution units for AI, bounded review units for developers, and explicit skill-based workflow support so that work can move quickly without becoming chaotic.

## Repository guide

- [`overview.md`](./overview.md) — short introduction to the concept, main ideas, and why Shape exists
- [`installation.md`](./installation.md) — installation and configuration guide for setting up Shape in a target repository, including the generic Shape layer and agent-specific integration sections
- [`manual.md`](./manual.md) — practical guide for using Shape in day-to-day software delivery
- [`design.md`](./design.md) — the full workflow specification
- [`workflow-templates/`](./workflow-templates/) — standalone templates for the core Shape workflow artifacts
  - [`prd-template.md`](./workflow-templates/prd-template.md)
  - [`technical-concept-template.md`](./workflow-templates/technical-concept-template.md)
  - [`implementation-plan-template.md`](./workflow-templates/implementation-plan-template.md)
- [`config-templates/`](./config-templates/) — starter repository-level Shape configuration files for the target repository `.shape/` folder
- [`skills/`](./skills/) — Shape skill files and skill design guidance
  - [`README.md`](./skills/README.md) — skill design principles
  - [`skill-generation-prompt.md`](./skills/skill-generation-prompt.md) — prompt to generate additional Shape skill files
  - individual skill files — one file per workflow skill

## Current status

Shape is currently in beta for v0.1. This version is focused on correctness and greenfield feature delivery: establishing the core workflow, validating that the artifact model holds up in real use, and making the workflow reliable across supported agents.

Support has been implemented for Codex, Claude Code, Gemini CLI, and OpenCode. The first round of reference feature implementation has been completed, and the move from beta to final version is coming soon.

The next versions are expected to expand Shape in several important directions: smoother installation and integration through more polished agent-specific setup or plugin-style support where that makes sense, broader workflow coverage for more real-world delivery situations such as work on existing features, iterative enhancement, and refactoring, and tighter control of context usage so that the workflow adds as little overhead as possible while still preserving its structure and guidance.

## License

MIT