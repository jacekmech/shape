# Shape Installation

This document explains how to install Shape into a target repository.

It covers the installation structure, the minimal repository-level Shape configuration, and the agent-specific integration layers required to make Shape usable in practice.

This is an installation and configuration manual, not a workflow usage manual.

---

## Shape Repository Layout

The Shape repository defines and distributes the workflow artifacts required for installation. This section covers the parts of the repository relevant to that process.

The files described here fall into two categories: **installation payload artifacts**, which are copied or adapted into target repositories, and **source-repository-only support artifacts**, which are used to design, document, or generate the skill set within Shape itself.

```text
shape/
├── installation.md
├── skills/
│   ├── README.md
│   ├── skill-design-principles.md
│   ├── codex-generation-prompt.md
│   ├── claude-generation-prompt.md
│   ├── gemini-generation-prompt.md
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
- `skills/codex-generation-prompt.md` is a **source-repository-only artifact** used to help generate or extend Codex-oriented skill files consistently
- `skills/claude-generation-prompt.md` is a **source-repository-only artifact** used to help generate or extend Claude-oriented skill files consistently
- `skills/gemini-generation-prompt.md` is a **source-repository-only artifact** used to help generate or extend Gemini-oriented skill files consistently
- `skills/skill-design-principles.md` is a **source-repository-only artifact** describing how to create and review skill files in the Shape repository
- the individual skill files under `skills/` are the actual skill-definition artifacts that may later be adapted into agent-specific installed formats
- `workflow-templates/` contains the canonical workflow artifact templates
- `config-templates/` contains starter repository-level Shape configuration files for the target repository `.shape/` folder

---

## Installation Model

Shape installation has two layers:

### 1. Generic Shape layer
This is the agent-independent part of the installation.

It includes:
- the `.shape/` folder in the target repository
- `config.json`
- `workspace.json`
- `gitignore`
- workflow templates
- the feature artifact layout used by Shape

This layer defines how Shape is represented in the repository, regardless of which coding agent is used.

### 2. Agent-specific integration layer
This is the part that adapts Shape to a specific coding agent.

It includes:
- the project-level instruction file expected by the agent
- the skill packaging format expected by the agent
- any agent-specific conventions required for discovery and execution

This document currently defines Codex-specific, Claude-specific, Gemini-specific, and OpenCode-specific integration layers.
Additional agent-specific sections can be added later without changing the generic Shape layer.

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
- optionally, agent-specific installed support artifacts where appropriate

### Persistent vs transient

Persistent and shared:
- `.shape/config.json`
- `.shape/workflow-templates/`
- optional `.shape/README.md`

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

`skills.managed` declares the Shape skills supported by the repository.
It is the repository-local inventory used for workflow orientation features such as `show capabilities`.

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

These steps install the agent-independent Shape layer.

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

## Codex-Specific Integration

Codex uses its own project guidance and skill packaging model.

For Codex, Shape should be integrated through:

- a repository-level `AGENTS.md`
- Codex-native skills packaged in the layout expected by Codex
- the generic `.shape/` installation described above

The generic Shape skill markdown files in the Shape repository are design-level skill definitions.
For Codex installation, they should be adapted into Codex's native skill packaging rather than copied as flat markdown files unchanged.

### Codex-specific repository additions

A Codex-oriented target repository will therefore typically include:

```text
target-repo/
├── AGENTS.md
├── .shape/
│   ├── README.md
│   ├── .gitignore
│   ├── config.json
│   ├── workspace.json
│   └── workflow-templates/
├── .codex/
│   └── skills/
│       └── <skill-name>/
│           └── SKILL.md
├── features/
└── ...
```

This section describes the Codex-specific additions only.
The `.shape/` configuration and feature layout remain the same as in the generic installation model.

---

## Codex-Specific Installation Steps

### Scripted installation

Where Bash is available, Shape installation for Codex can be bootstrapped with:

```bash
bin/install-codex.sh <shape-root> <target-root>
```

This script:
- installs the generic Shape layer into `.shape/`
- copies workflow templates into `.shape/workflow-templates/`
- installs Codex-native skills into `.codex/skills/`
- generates a pasteable Shape snippet under `.shape/generated/`

It does not:
- patch `AGENTS.md`
- commit changes
- overwrite existing files silently

The rest of this section describes the equivalent manual installation process.

### 1. Install the generic Shape layer first

Complete all steps from **Generic Installation Steps** before adding Codex-specific files.

### 2. Add `AGENTS.md`

Create a repository-level `AGENTS.md` file for Codex.

Its role is to:
- tell Codex that the repository uses Shape
- point Codex to the `.shape/` configuration
- point Codex to the feature artifact conventions
- point Codex to the installed Codex-native skills when relevant

### 3. Prepare Codex-native skills

Do not assume the flat markdown files in the Shape repository can be used directly as installed Codex skills.

Instead, adapt the approved Shape skill definitions into the Codex-native skill structure expected by Codex.

### 4. Install Codex-native skills

Install the Codex-formatted skills into the repository location used for Codex skill discovery.

The exact directory layout should follow the Codex-native skill model, for example:

```text
.codex/skills/<skill-name>/SKILL.md
```

### 5. Reference Shape from `AGENTS.md`

Ensure that `AGENTS.md` makes the following discoverable to Codex:
- the repository uses Shape
- `.shape/config.json` defines the feature root and artifact filenames
- `.shape/config.json` declares the repository Shape skill inventory
- `.shape/workspace.json` is transient local state
- `.shape/workflow-templates/` contains the canonical workflow templates
- feature artifacts live under the configured feature root
- Codex-native skills are installed in the configured Codex skill location

### 6. Start using Shape with Codex

Once both layers are installed:
- the generic Shape layer
- the Codex-specific integration layer

the repository is ready for Shape-driven work with Codex.

The normal next actions are:
- inspect the installed Codex guidance
- inspect available skills
- initiate a feature
- or pick up an existing feature

---

## Claude-Specific Integration

Claude Code uses its own persistent project instruction file and skill packaging model.

For Claude, Shape should be integrated through:

- a repository-level `CLAUDE.md`
- Claude-native skills packaged in the layout expected by Claude
- the generic `.shape/` installation described above

The generic Shape skill markdown files in the Shape repository are design-level skill definitions.
For Claude installation, they should be adapted into Claude's native skill packaging rather than copied as flat markdown files unchanged.

### Claude-specific repository additions

A Claude-oriented target repository will therefore typically include:

```text
target-repo/
├── CLAUDE.md
├── .shape/
│   ├── README.md
│   ├── .gitignore
│   ├── config.json
│   ├── workspace.json
│   └── workflow-templates/
├── .claude/
│   └── skills/
│       └── <skill-name>/
│           └── SKILL.md
├── features/
└── ...
```

This section describes the Claude-specific additions only.
The `.shape/` configuration and feature layout remain the same as in the generic installation model.

---

## Claude-Specific Installation Steps

### Scripted installation

Where Bash is available, Shape installation for Claude can be bootstrapped with:

```bash
bin/install-claude.sh <shape-root> <target-root>
```

This script:
- installs the generic Shape layer into `.shape/`
- copies workflow templates into `.shape/workflow-templates/`
- installs Claude-native skills into `.claude/skills/`
- generates a pasteable Shape snippet under `.shape/generated/`

It does not:
- patch `CLAUDE.md`
- commit changes
- overwrite existing files silently

The rest of this section describes the equivalent manual installation process.

### 1. Install the generic Shape layer first

Complete all steps from **Generic Installation Steps** before adding Claude-specific files.

### 2. Add `CLAUDE.md`

Create a repository-level `CLAUDE.md` file for Claude.

Its role is to:
- tell Claude that the repository uses Shape
- point Claude to the `.shape/` configuration
- point Claude to the feature artifact conventions
- point Claude to the installed Claude-native skills when relevant

If the repository already uses a shared `AGENTS.md` file, `CLAUDE.md` may import it and then add the Shape-specific Claude guidance below it.

### 3. Prepare Claude-native skills

Do not assume the flat markdown files in the Shape repository can be used directly as installed Claude skills.

Instead, adapt the approved Shape skill definitions into the Claude-native skill structure expected by Claude.
This adaptation includes both:
- the Claude skill directory layout
- the `SKILL.md` internal structure expected by Claude

### 4. Install Claude-native skills

Install the Claude-formatted skills into the repository location used for Claude skill discovery.

The exact directory layout should follow the Claude-native skill model, for example:

```text
.claude/skills/<skill-name>/SKILL.md
```

### 5. Reference Shape from `CLAUDE.md`

Ensure that `CLAUDE.md` makes the following discoverable to Claude:
- the repository uses Shape
- `.shape/config.json` defines the feature root and artifact filenames
- `.shape/config.json` declares the repository Shape skill inventory
- `.shape/workspace.json` is transient local state
- `.shape/workflow-templates/` contains the canonical workflow templates
- feature artifacts live under the configured feature root
- Claude-native skills are installed in the configured Claude skill location

### 6. Start using Shape with Claude

Once both layers are installed:
- the generic Shape layer
- the Claude-specific integration layer

the repository is ready for Shape-driven work with Claude.

The normal next actions are:
- inspect the installed Claude guidance
- inspect available skills
- initiate a feature
- or pick up an existing feature

---

## Gemini-Specific Integration

Gemini CLI uses its own persistent project instruction file and a native Agent Skills mechanism.

For Gemini, Shape should be integrated through:

- a repository-level `GEMINI.md`
- Gemini-native skills installed in the layout expected by Gemini
- the generic `.shape/` installation described above

The generic Shape skill markdown files in the Shape repository are design-level skill definitions.
For Gemini installation, they should be adapted into Gemini's native skill packaging rather than copied as flat markdown files unchanged.

## Gemini-Specific Installation Steps

### Scripted installation

Where Bash is available, Shape installation for Gemini can be bootstrapped with:

```bash
bin/install-gemini.sh <shape-root> <target-root>
```

This script:
- installs the generic Shape layer into `.shape/`
- copies workflow templates into `.shape/workflow-templates/`
- installs Gemini-native skills into `.agents/skills/`
- generates a pasteable Shape snippet under `.shape/generated/`

It does not:
- patch `GEMINI.md`
- commit changes
- overwrite existing files silently

The rest of this section describes the equivalent manual installation process.

### 1. Install the generic Shape layer first

Complete all steps from **Generic Installation Steps** before adding Gemini-specific files.

### 2. Add `GEMINI.md`

Create a repository-level `GEMINI.md` file for Gemini.

Its role is to:
- tell Gemini that the repository uses Shape
- point Gemini to the `.shape/` configuration
- point Gemini to the feature artifact conventions
- point Gemini to the installed Gemini-native skills when relevant

### 3. Prepare Gemini-native skills

Do not assume the flat markdown files in the Shape repository can be used directly as installed Gemini skills.

Instead, adapt the approved Shape skill definitions into the Gemini-native skill structure expected by Gemini.

### 4. Install Gemini-native skills

Install the Gemini-formatted skills into the repository location used for Gemini skill discovery.

The preferred cross-agent installation root is:

```text
.agents/skills/<skill-name>/SKILL.md
```

An alternative Gemini-specific layout is:

```text
.gemini/skills/<skill-name>/SKILL.md
```

### 5. Reference Shape from `GEMINI.md`

Ensure that `GEMINI.md` makes the following discoverable to Gemini:
- the repository uses Shape
- `.shape/config.json` defines the feature root and artifact filenames
- `.shape/config.json` declares the repository Shape skill inventory
- `.shape/workspace.json` is transient local state
- `.shape/workflow-templates/` contains the canonical workflow templates
- feature artifacts live under the configured feature root
- Gemini-native skills are installed in the configured Gemini skill location

### 6. Start using Shape with Gemini

Once both layers are installed:
- the generic Shape layer
- the Gemini-specific integration layer

the repository is ready for Shape-driven work with Gemini.

The normal next actions are:
- inspect the installed Gemini guidance
- inspect available skills
- initiate a feature
- or pick up an existing feature

---

## OpenCode-Specific Integration

OpenCode uses its own persistent project guidance and native skill packaging model.

For OpenCode, Shape should be integrated through:

- a repository-level `AGENTS.md`
- OpenCode-native skills packaged in the layout expected by OpenCode
- the generic `.shape/` installation described above

The generic Shape skill markdown files in the Shape repository are design-level skill definitions.
For OpenCode installation, they should be adapted into OpenCode's native skill packaging rather than copied as flat markdown files unchanged.

### OpenCode-specific repository additions

An OpenCode-oriented target repository will therefore typically include:

```text
target-repo/
├── AGENTS.md
├── .shape/
│   ├── README.md
│   ├── .gitignore
│   ├── config.json
│   ├── workspace.json
│   └── workflow-templates/
├── .opencode/
│   └── skills/
│       └── <skill-name>/
│           └── SKILL.md
├── features/
└── ...
```

This section describes the OpenCode-specific additions only.
The `.shape/` configuration and feature layout remain the same as in the generic installation model.

---

## OpenCode-Specific Installation Steps

### Scripted installation

Where Bash is available, Shape installation for OpenCode can be bootstrapped with:

```bash
bin/install-opencode.sh <shape-root> <target-root>
```

This script:
- installs the generic Shape layer into `.shape/`
- copies workflow templates into `.shape/workflow-templates/`
- installs OpenCode-native skills into `.opencode/skills/`
- generates a pasteable Shape snippet under `.shape/generated/`

It does not:
- patch `AGENTS.md`
- configure model or provider settings
- commit changes
- overwrite existing files silently

The rest of this section describes the equivalent manual installation process.

### 1. Install the generic Shape layer first

Complete all steps from **Generic Installation Steps** before adding OpenCode-specific files.

### 2. Add `AGENTS.md`

Create a repository-level `AGENTS.md` file for OpenCode.

Its role is to:
- tell OpenCode that the repository uses Shape
- point OpenCode to the `.shape/` configuration
- point OpenCode to the feature artifact conventions
- point OpenCode to the installed OpenCode-native skills when relevant

If the repository already uses `AGENTS.md` for another agent, add the Shape-specific OpenCode guidance to that same file rather than creating a second repository guidance file.

### 3. Prepare OpenCode-native skills

Do not assume the flat markdown files in the Shape repository can be used directly as installed OpenCode skills.

Instead, adapt the approved Shape skill definitions into the OpenCode-native skill structure expected by OpenCode.
This adaptation includes both:
- the OpenCode skill directory layout
- the `SKILL.md` internal structure expected by OpenCode

### 4. Install OpenCode-native skills

Install the OpenCode-formatted skills into the repository location used for OpenCode skill discovery.

The exact directory layout should follow the OpenCode-native skill model, for example:

```text
.opencode/skills/<skill-name>/SKILL.md
```

### 5. Reference Shape from `AGENTS.md`

Ensure that `AGENTS.md` makes the following discoverable to OpenCode:
- the repository uses Shape
- `.shape/config.json` defines the feature root and artifact filenames
- `.shape/config.json` declares the repository Shape skill inventory
- `.shape/workspace.json` is transient local state
- `.shape/workflow-templates/` contains the canonical workflow templates
- feature artifacts live under the configured feature root
- OpenCode-native skills are installed in the configured OpenCode skill location
- model and provider selection remain part of the user's OpenCode setup rather than the repository Shape installation

### 6. Start using Shape with OpenCode

Once both layers are installed:
- the generic Shape layer
- the OpenCode-specific integration layer

the repository is ready for Shape-driven work with OpenCode.

The normal next actions are:
- inspect the installed OpenCode guidance
- inspect available skills
- initiate a feature
- or pick up an existing feature

## Notes

- `.shape/config.json` is intentionally small in v1
- `.shape/config.json` may also declare the repository-supported Shape skill inventory
- `.shape/workspace.json` should remain lightweight and local
- actual feature artifacts are not stored under `.shape/`
- agent-specific integration should be documented in separate sections rather than mixed into the generic Shape layer
- Codex support uses `AGENTS.md` and `.codex/skills/`
- Claude support uses `CLAUDE.md` and `.claude/skills/`
- Gemini support uses `GEMINI.md` and `.agents/skills/` or `.gemini/skills/`
- OpenCode support uses `AGENTS.md` and `.opencode/skills/`