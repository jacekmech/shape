# Shape

A lightweight, artifact-driven workflow for AI-assisted software development.

Shape is designed to help structure software feature development when working with AI coding agents. It focuses on clear feature artifacts, bounded execution units for AI, bounded review units for developers, and explicit skill-based workflow support so that work can move quickly without becoming chaotic.

## Repository guide

- [`quick-start.md`](./quick-start.md) — short introduction to the concept, a short example explaining how Shape works
- [`basic-concepts.md`](./basic-concepts.md) — the core conceptual model and status vocabulary for understanding Shape
- [`installation.md`](./installation.md) — installation and configuration guide for setting up Shape in a target repository, including the generic Shape layer and agent-specific integration sections
- [`manual.md`](./manual.md) — practical guide for using Shape in day-to-day software development
- [`design.md`](./design.md) — the full workflow specification
- [`workflow-templates/`](./workflow-templates/) — standalone templates for the core Shape workflow artifacts
  - [`product-specification-template.md`](./workflow-templates/product-specification-template.md)
  - [`technical-specification-template.md`](./workflow-templates/technical-specification-template.md)
  - [`specification-reference-template.md`](./workflow-templates/specification-reference-template.md) — link to an existing product or technical document
  - [`implementation-plan-template.md`](./workflow-templates/implementation-plan-template.md)
- [`config-templates/`](./config-templates/) — starter repository-level Shape configuration files for the target repository `.shape/` folder
- [`skills/`](./skills/) — Shape skill files and skill design guidance
  - [`README.md`](./skills/README.md) — skill design principles
  - [`skill-generation-prompt.md`](./skills/skill-generation-prompt.md) — prompt to generate additional Shape skill files
  - individual skill files — one file per workflow skill

## Version History

- `v0.4` (current): Product and Technical Specifications, delivery Iterations, `docs/implementation` defaults, existing-document references, and upgrade-safe installation with obsolete skill removal
- `v0.3`: unified artifact state flows around Implementation Plans and Slice Plans, refreshed installation guidance and install script behavior, and removed repository readiness checks to keep Shape focused on feature workflow
- `v0.2`: terminology and documentation cleanup around software development wording, overview structure, status naming, and stronger workflow step-boundary guidance
- `v0.1`: initial version with PRD, Technical Concept, and Implementation Plan support; basic skill set in place; fully functional

Upgrade existing projects with `--overwrite`; see [installation and v0.4 upgrade guidance](./installation.md#upgrading-to-v04). Existing documentation and configured paths are preserved.

## License

MIT
