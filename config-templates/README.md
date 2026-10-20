# .shape

This folder contains repository-local Shape support files.

Contents:

- `config.json` — persistent repository-level Shape configuration
- `workspace.json` — transient local Shape workspace state
- `.gitignore` — keeps transient Shape state out of version control
- `workflow-templates/` — installed Shape workflow templates
- `installations/` — per-agent installed skill inventories and release versions; commit these for reliable upgrades
- `generated/` — generated agent instruction snippets

This folder supports the workflow, but it does not contain the actual feature artifacts.

Agent-native skills are installed outside `.shape/`, for example under `.codex/skills/`, `.claude/skills/`, `.agents/skills/`, or `.opencode/skills/` depending on the selected installer.

`workspace.json` may legitimately contain `"activeFeature": null`, including as the normal state after `finish feature` closes a completed feature.

Feature artifacts should live under the configured feature root, for example:

```text
docs/implementation/<feature-id>-<feature-slug>/
```

Fresh installs use configuration schema `version: 2` and `shapeVersion: "0.4"`. Upgrades preserve the configured root, artifact filenames, and custom settings while migrating legacy `prd` and `technicalConcept` artifact keys. Existing documents and workspace state are not migrated. New skills understand legacy PRD, Technical Concept, and Slice Plan artifacts.

The source `retired-skills.json` lists historical Shape skill names removed during upgrades, including when another agent has already updated the shared configuration. Each installer also records its own inventory under `installations/` so future removals remain traceable.
