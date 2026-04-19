# Shape Installation

This document explains how to install Shape into a target repository.

Shape installation is straightforward: the Shape repository provides the workflow templates, configuration, and skill definitions, and an installation script copies the generic Shape layer into your target project repository, then adds the agent-specific integration layer required by the selected coding agent.

This is an installation and configuration guide, not a workflow usage guide.

---

## Quick Start

Use the installation script for your agent. Each script:
- installs the generic Shape layer into the target repository
- copies workflow templates into `.shape/workflow-templates/`
- installs agent-native skills in the layout expected by the selected agent
- generates a pasteable Shape snippet under `.shape/generated/`

The scripts do not:
- patch `AGENTS.md`, `CLAUDE.md`, or `GEMINI.md` automatically
- commit changes
- overwrite existing files silently

### Codex

```bash
bin/install-codex.sh <shape-root> <target-root>
```

Then paste the generated snippet into `AGENTS.md`.

### Claude Code

```bash
bin/install-claude.sh <shape-root> <target-root>
```

Then paste the generated snippet into `CLAUDE.md`.

### Gemini CLI

```bash
bin/install-gemini.sh <shape-root> <target-root>
```

Then paste the generated snippet into `GEMINI.md`.

### OpenCode

```bash
bin/install-opencode.sh <shape-root> <target-root>
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
│   ├── skill-design-principles.md
│   ├── codex-generation-prompt.md
│   └── *.md
├── workflow-templates/
│   ├── prd-template.md
│   ├── technical-concept-template.md
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
- `skills/codex-generation-prompt.md` is a **source-repository-only artifact** used to help generate or skill files consistently
- `skills/skill-design-principles.md` is a **source-repository-only artifact** describing how to create and review skill files in the Shape repository
- the individual skill files under `skills/` are the actual skill-definition artifacts that may later be adapted into agent-specific installed formats
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
│   └── workflow-templates/
│       ├── prd-template.md
│       ├── technical-concept-template.md
│       └── implementation-plan-template.md
├── features/
│   └── <feature-id>-<feature-slug>/
│       ├── 01-prd.md
│       ├── 02-tech-concept.md
│       └── 03-implementation-plan.md
└── ...
```

### Purpose of `.shape/`

The `.shape/` folder is the repository-local installation root for Shape support files.

It contains:
- persistent Shape configuration
- transient local Shape workspace state
- installed workflow templates
- optionally, agent-specific generated support artifacts where appropriate

### Persistent vs transient

Persistent and shared:
- `.shape/config.json`
- `.shape/workflow-templates/`
- `.shape/README.md`

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

Default v1 example:

```json
{
  "version": 1,
  "featuresRoot": "features",
  "artifacts": {
    "prd": "01-prd.md",
    "technicalConcept": "02-tech-concept.md",
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

`skills.managed` declares the Shape skills supported by the repository. It is the repository-local inventory used for workflow orientation features such as `show capabilities`.

### `.shape/workspace.json`

Transient local Shape workspace state.

This file should not be committed.

Purpose:
- track the active local feature context
- support fresh-session pickup
- keep local Shape state small and explicit

Default v1 example:

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
  "featuresRoot": "features"
}
```

If the repository uses a different location, update it there.

### 5. Confirm artifact naming

Check `.shape/config.json` and confirm that the canonical filenames match the target repository expectations.

Default filenames:
- `01-prd.md`
- `02-tech-concept.md`
- `03-implementation-plan.md`

### 6. Create the feature root if needed

If the repository does not already have the configured feature root, create it.

Default:

```text
features/
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
├── features/
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
├── features/
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
├── features/
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
├── features/
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