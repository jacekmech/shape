# .shape

This folder contains repository-local Shape support files.

Contents:

- `config.json` — persistent repository-level Shape configuration
- `workspace.json` — transient local Shape workspace state
- `.gitignore` — keeps transient Shape state out of version control
- `workflow-templates/` — installed Shape workflow templates
- `generated/` — generated agent instruction snippets

This folder supports the workflow, but it does not contain the actual feature artifacts.

Agent-native skills are installed outside `.shape/`, for example under `.codex/skills/`, `.claude/skills/`, `.agents/skills/`, or `.opencode/skills/` depending on the selected installer.

`workspace.json` may legitimately contain `"activeFeature": null`, including as the normal state after `finish feature` closes a completed feature.

Feature artifacts should live under the configured feature root, for example:

```text
features/<feature-id>-<feature-slug>/
```
