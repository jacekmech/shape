# Shape Installation

This document explains how to install Shape into a target repository.

Shape installation is straightforward: the Shape repository provides the workflow templates, configuration, and skill definitions, and an installation script copies the generic Shape layer into your target project repository, then adds the agent-specific integration layer required by the selected coding agent.

This is an installation and configuration guide, not a workflow usage guide.

---

## Quick Start

The installers require Bash and standard POSIX tools, including `awk`. No Python, Node.js, `jq`, or additional packages are required. Keep the `bin/` helpers alongside the installer scripts in the Shape source checkout.

Use the installation script for your agent. Each script:
- installs the generic Shape layer into the target repository
- copies workflow templates into `.shape/workflow-templates/`
- installs agent-native skills in the layout expected by the selected agent
- generates a pasteable Shape snippet under `.shape/generated/`

The scripts do not:
- patch `AGENTS.md`, `CLAUDE.md`, or `GEMINI.md` automatically
- commit changes
- overwrite an existing Shape installation unless `--overwrite` is provided

Installation behavior:
- if Shape is not installed in the target repository, the script installs it
- if Shape is already installed and `--overwrite` is not provided, the script stops with a clear message
- if Shape is already installed and `--overwrite` is provided, the script replaces the managed Shape installation while preserving feature folders and `.shape/workspace.json`

During overwrite, the script validates configuration and source skills before changing the installation. It removes the selected agent's previously managed skills using both `.shape/config.json` and `.shape/installations/<agent>.json`, plus the known retired names in the source `config-templates/retired-skills.json`. It then installs the complete current skill set. Unrelated skills are preserved; an unowned destination collision stops installation.

### Upgrading to v0.4

Run your agent's installer with `--overwrite`. Repeat for each agent installed in the project. Per-agent inventories and the retired-name list allow sequential upgrades even after the shared config has already changed.

- Existing feature documents, documentation folders, and `.shape/workspace.json` remain unchanged. No documents are moved, renamed, or rewritten.
- `featuresRoot`, configured artifact filenames, and custom configuration fields are preserved. Legacy `artifacts.prd` and `artifacts.technicalConcept` keys become `productSpecification` and `technicalSpecification`, retaining their values.
- New installations default to `docs/implementation`, `01-product-specification.md`, and `02-technical-specification.md`. Existing installations retain their configured locations, including `features/` and legacy filenames.
- Configuration schema `version` becomes `2`; `shapeVersion` records `0.4`. These are distinct from Git release tags. The managed skill inventory is replaced with the current set.
- Shape-owned templates and the selected agent's generated integration snippet are refreshed. Other agents' snippets and inventories remain intact.
- Missing or invalid existing configuration/inventories stop the upgrade before replacement. Restore the previous metadata and retry; the installer does not guess where existing documents belong. Conflicting old/new artifact keys also require resolution first.

After upgrading, replace the existing Shape integration block in `AGENTS.md`, `CLAUDE.md`, or `GEMINI.md` with the freshly generated snippet. The installer does not edit these files automatically. Use the new skill names; new skills recognize existing PRD, Technical Concept, and Slice Plan artifacts without requiring a documentation migration.

To verify installer behavior in an isolated temporary directory, run:

```bash
bash tests/install.sh
```

This covers all four agents, fresh installations, upgrades, document/configuration preservation, obsolete skill removal, repeated installation, sequential agent upgrades, and failures before mutation.

### Codex

```bash
bin/install-codex.sh <shape-root> <target-root>
bin/install-codex.sh --overwrite <shape-root> <target-root>
```

Then paste the generated snippet into `AGENTS.md`.

### Claude Code

```bash
bin/install-claude.sh <shape-root> <target-root>
bin/install-claude.sh --overwrite <shape-root> <target-root>
```

Then paste the generated snippet into `CLAUDE.md`.

### Gemini CLI

```bash
bin/install-gemini.sh <shape-root> <target-root>
bin/install-gemini.sh --overwrite <shape-root> <target-root>
```

Then paste the generated snippet into `GEMINI.md`.

### OpenCode

```bash
bin/install-opencode.sh <shape-root> <target-root>
bin/install-opencode.sh --overwrite <shape-root> <target-root>
```

Then paste the generated snippet into `AGENTS.md`.

---

## Installation Model

Shape installation has two layers.

### 1. Generic Shape layer

This is the agent-independent part of the installation.

It includes:
- the `.shape/` folder in the target repository
- `config.json`
- `workspace.json`
- `.gitignore`
- workflow templates

This layer defines how Shape is represented in the repository, regardless of which coding agent is used.

### 2. Agent-specific integration layer

This is the part that adapts Shape to a specific coding agent.

It includes:
- the project-level instruction file expected by the agent
- the skill packaging format expected by the agent
- any agent-specific conventions required for discovery and execution

This document currently defines Codex-specific, Claude-specific, Gemini-specific, and OpenCode-specific integration layers. Additional agent-specific sections can be added later without changing the generic Shape layer.

---

## Shape Repository Layout

The Shape repository defines and distributes the workflow artifacts required for installation. The files described here fall into two categories: **installation payload artifacts**, which are copied or adapted into target repositories, and **source-repository-only support artifacts**, which are used to design, document, or generate the skill set within Shape itself.

```text
shape/
├── installation.md
├── skills/
│   ├── README.md
│   ├── skill-generation-prompt.md
│   └── *.md
├── workflow-templates/
│   ├── product-specification-template.md
│   ├── technical-specification-template.md
│   └── implementation-plan-template.md
└── config-templates/
    ├── README.md
    ├── gitignore
    ├── config.json
    └── workspace.json
```

### Purpose of these areas

- `skills/` contains Shape skill definitions and skill-related guidance used to prepare agent-specific installations
- `skills/README.md` is a **source-repository-only artifact** describing how the skills folder is organized and how skills relate to Shape operations
- `skills/skill-generation-prompt.md` is a **source-repository-only artifact** used to help generate skill files consistently
- the individual managed skill files under `skills/` are the actual skill-definition artifacts adapted into agent-specific installed formats
- `config-templates/config.json` is the authoritative inventory of managed skills installed into target repositories
- `workflow-templates/` contains the canonical workflow artifact templates
- `config-templates/` contains starter repository-level Shape configuration files for the target repository `.shape/` folder

---

## Generic Target Repository Layout

The generic Shape installation layout in a target repository is:

```text
target-repo/
├── .shape/
│   ├── README.md
│   ├── .gitignore
│   ├── config.json
│   ├── workspace.json
│   ├── generated/
│   └── workflow-templates/
│       ├── product-specification-template.md
│       ├── technical-specification-template.md
│       └── implementation-plan-template.md
├── docs/implementation/
│   └── <feature-id>-<feature-slug>/
│       ├── 01-product-specification.md
│       ├── 02-technical-specification.md
│       └── 03-implementation-plan.md
└── ...
```

### Purpose of `.shape/`

The `.shape/` folder is the repository-local installation root for Shape support files.

It contains:
- persistent Shape configuration
- transient local Shape workspace state
- installed workflow templates
- generated agent-specific instruction snippets under `.shape/generated/`

### Persistent vs transient

Persistent and shared:
- `.shape/config.json`
- `.shape/workflow-templates/`
- `.shape/README.md`
- `.shape/generated/`

Transient and local:
- `.shape/workspace.json`

The local/transient boundary is enforced through `.shape/.gitignore`.

---

## Generic Configuration Files

### `.shape/config.json`

Persistent repository-level Shape configuration.

This file should be committed.

Purpose:
- define where feature folders live
- define the canonical artifact filenames
- declare the Shape skill inventory expected by the repository
- provide a stable repository-level Shape contract

Default schema v2 example (skill list abbreviated):

```json
{
  "version": 2,
  "shapeVersion": "0.4",
  "featuresRoot": "docs/implementation",
  "artifacts": {
    "productSpecification": "01-product-specification.md",
    "technicalSpecification": "02-technical-specification.md",
    "implementationPlan": "03-implementation-plan.md"
  },
  "skills": {
    "managed": [
      "initiate-feature",
      "..."
    ]
  }
}
```

`shapeVersion` records the installed Shape release; `version` describes the configuration schema. `.shape/installations/<agent>.json` stores that agent’s installed skill inventory and release version and should be committed.

`skills.managed` declares the Shape skills supported by the repository. It is the repository-local inventory used for workflow orientation features such as `show capabilities`.

### `.shape/workspace.json`

Transient local Shape workspace state.

This file should not be committed.

Purpose:
- track the active local feature context
- support fresh-session pickup
- keep local Shape state small and explicit
- support clearing the active feature after a completed feature is closed

Default schema v2 example (skill list abbreviated):

```json
{
  "activeFeature": null
}
```

### `.shape/.gitignore`

This file keeps local workspace state out of version control.

Default content:

```gitignore
workspace.json
```

---

## Generic Installation Steps

These steps describe the generic Shape layer that all installation scripts apply.

### 1. Create the `.shape/` folder in the target repository

Create:

```text
.shape/
```

### 2. Copy the starter config files

Copy these files from the Shape repository into the target repository `.shape/` folder:

```text
config-templates/README.md      -> .shape/README.md
config-templates/gitignore      -> .shape/.gitignore
config-templates/config.json    -> .shape/config.json
config-templates/workspace.json -> .shape/workspace.json
```

### 3. Copy the workflow templates

Copy the workflow templates into:

```text
.shape/workflow-templates/
```

These are the canonical templates used by Shape when creating feature artifacts.

### 4. Confirm the repository feature root

Check `.shape/config.json` and confirm that `featuresRoot` matches the target repository layout.

Default:

```json
{
  "featuresRoot": "docs/implementation"
}
```

If the repository uses a different location, update it there.

### 5. Confirm artifact naming

Check `.shape/config.json` and confirm that the canonical filenames match the target repository expectations.

Default filenames:
- `01-product-specification.md`
- `02-technical-specification.md`
- `03-implementation-plan.md`

### 6. Create the feature root if needed

If the repository does not already have the configured feature root, create it.

Default:

```text
docs/implementation/
```

At this point, the generic Shape layer is installed.

---

## Agent-Specific Integration

The generic Shape layer is the same across agents. What changes is the repository guidance file and the installed skill location.

### Codex

Codex uses:
- `AGENTS.md`
- `.codex/skills/<skill-name>/SKILL.md`

Script:

```bash
bin/install-codex.sh <shape-root> <target-root>
```

Typical target layout:

```text
target-repo/
├── AGENTS.md
├── .shape/
├── .codex/
│   └── skills/
│       └── <skill-name>/
│           └── SKILL.md
├── docs/implementation/
└── ...
```

After running the script, paste the generated Shape snippet into `AGENTS.md`.

---

### Claude Code

Claude Code uses:
- `CLAUDE.md`
- `.claude/skills/<skill-name>/SKILL.md`

Script:

```bash
bin/install-claude.sh <shape-root> <target-root>
```

Typical target layout:

```text
target-repo/
├── CLAUDE.md
├── .shape/
├── .claude/
│   └── skills/
│       └── <skill-name>/
│           └── SKILL.md
├── docs/implementation/
└── ...
```

After running the script, paste the generated Shape snippet into `CLAUDE.md`.

---

### Gemini CLI

Gemini CLI uses:
- `GEMINI.md`
- `.agents/skills/<skill-name>/SKILL.md`

Script:

```bash
bin/install-gemini.sh <shape-root> <target-root>
```

Typical target layout:

```text
target-repo/
├── GEMINI.md
├── .shape/
├── .agents/
│   └── skills/
│       └── <skill-name>/
│           └── SKILL.md
├── docs/implementation/
└── ...
```

After running the script, paste the generated Shape snippet into `GEMINI.md`.

---

### OpenCode

OpenCode uses:
- `AGENTS.md`
- `.opencode/skills/<skill-name>/SKILL.md`

Script:

```bash
bin/install-opencode.sh <shape-root> <target-root>
```

Typical target layout:

```text
target-repo/
├── AGENTS.md
├── .shape/
├── .opencode/
│   └── skills/
│       └── <skill-name>/
│           └── SKILL.md
├── docs/implementation/
└── ...
```

After running the script, paste the generated Shape snippet into `AGENTS.md`.

Model and provider selection remain part of the user's OpenCode setup rather than the repository Shape installation.

---

## Notes

- `.shape/config.json` is intentionally small in v1
- `.shape/workspace.json` should remain lightweight and local
- actual feature artifacts are not stored under `.shape/`
- agent-specific integration should remain separate from the generic Shape layer
- Codex support uses `AGENTS.md` and `.codex/skills/`
- Claude support uses `CLAUDE.md` and `.claude/skills/`
- Gemini support uses `GEMINI.md` and `.agents/skills/`
- OpenCode support uses `AGENTS.md` and `.opencode/skills/`
