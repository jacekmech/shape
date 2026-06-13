# Shape

A lightweight, artifact-driven workflow for AI-assisted software development.

Shape is designed to help structure software feature development when working with AI coding agents. It focuses on clear feature artifacts, bounded execution units for AI, bounded review units for developers, and explicit skill-based workflow support so that work can move quickly without becoming chaotic.

## Repository guide

- [`quick-start.md`](./quick-start.md) — short introduction to the concept, a short example explaining how Shape works
- [`installation.md`](./installation.md) — installation and configuration guide for setting up Shape in a target repository, including the generic Shape layer and agent-specific integration sections
- [`manual.md`](./manual.md) — practical guide for using Shape in day-to-day software development
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

## Version History

- `v0.2` (current): terminology and documentation cleanup around software development wording, overview structure, status naming, and stronger workflow step-boundary guidance
- `v0.1`: initial version with PRD, Technical Concept, and Implementation Plan support; basic skill set in place; fully functional

## License

MIT
