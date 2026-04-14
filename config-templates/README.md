# .shape

This folder contains repository-local Shape support files.

Contents:

- `config.json` — persistent repository-level Shape configuration
- `workspace.json` — transient local Shape workspace state
- `.gitignore` — keeps transient Shape state out of version control
- `skills/` — installed Shape skill files
- `workflow-templates/` — installed Shape workflow templates

This folder supports the workflow, but it does not contain the actual feature artifacts.

Feature artifacts should live under the configured feature root, for example:

```text
features/<feature-id>-<feature-slug>/
```
