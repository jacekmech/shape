#!/usr/bin/env bash

set -euo pipefail

SCRIPT_NAME="$(basename "$0")"
OVERWRITE=0

usage() {
    cat <<'USAGE'
Usage:
  install-claude.sh [--overwrite] <shape-root> <target-root>

Arguments:
  <shape-root>   Path to the Shape source repository
  <target-root>  Path to the target repository where Shape should be installed

Options:
  --overwrite    Replace the existing Shape installation in <target-root> while
                 preserving feature folders and .shape/workspace.json

What this script does:
  1. Installs the generic Shape layer into <target-root>/.shape/
  2. Copies workflow templates into <target-root>/.shape/workflow-templates/
  3. Installs Claude-native skills into <target-root>/.claude/skills/
  4. Generates a pasteable CLAUDE.md snippet at:
       <target-root>/.shape/generated/claude-shape-snippet.md

What this script does NOT do:
  - It does not patch CLAUDE.md
  - It does not commit any changes
  - It does not overwrite existing files unless --overwrite is provided

Expected Shape source layout:
  <shape-root>/
    config-templates/
      README.md
      gitignore
      config.json
      workspace.json
    workflow-templates/
    skills/

Examples:
  install-claude.sh ~/src/shape ~/src/my-app
  install-claude.sh . ../demo-repo
  install-claude.sh --overwrite . ../demo-repo
USAGE
}

fail() {
    echo "ERROR: $*" >&2
    exit 1
}

info() {
    echo "==> $*"
}

warn() {
    echo "WARNING: $*" >&2
}

require_dir() {
    local path="$1"
    local label="$2"
    [[ -d "$path" ]] || fail "$label does not exist or is not a directory: $path"
}

require_file() {
    local path="$1"
    local label="$2"
    [[ -f "$path" ]] || fail "$label is missing: $path"
}

copy_if_missing() {
    local src="$1"
    local dest="$2"

    if [[ -e "$dest" ]]; then
        warn "Skipping existing file: $dest"
    else
        mkdir -p "$(dirname "$dest")"
        cp "$src" "$dest"
        info "Copied: $dest"
    fi
}

copy_managed_file() {
    local src="$1"
    local dest="$2"
    local preserve_existing="${3:-0}"

    if [[ -e "$dest" ]]; then
        if [[ "$preserve_existing" -eq 1 ]]; then
            warn "Preserving existing file: $dest"
            return
        fi

        if [[ "$OVERWRITE" -eq 1 ]]; then
            mkdir -p "$(dirname "$dest")"
            cp "$src" "$dest"
            info "Overwritten: $dest"
        else
            warn "Skipping existing file: $dest"
        fi
    else
        mkdir -p "$(dirname "$dest")"
        cp "$src" "$dest"
        info "Copied: $dest"
    fi
}

remove_path_if_exists() {
    local path="$1"
    local label="$2"

    if [[ -e "$path" ]]; then
        rm -rf "$path"
        info "Removed existing $label: $path"
    fi
}

list_managed_skills() {
    local config_file="$1"

    [[ -f "$config_file" ]] || return 0

    awk '
        /"managed"[[:space:]]*:[[:space:]]*\[/ {
            in_managed = 1
        }

        in_managed {
            line = $0

            while (match(line, /"([^"]+)"/)) {
                value = substr(line, RSTART + 1, RLENGTH - 2)
                if (value != "managed") {
                    print value
                }
                line = substr(line, RSTART + RLENGTH)
            }

            if ($0 ~ /\]/) {
                exit
            }
        }
    ' "$config_file"
}

trim() {
    local value="$1"
    value="${value#"${value%%[![:space:]]*}"}"
    value="${value%"${value##*[![:space:]]}"}"
    printf '%s' "$value"
}

extract_skill_title() {
    local src_file="$1"
    local title

    title="$(awk '
        /^# / {
            sub(/^# /, "", $0)
            print
            exit
        }
    ' "$src_file")"

    printf '%s' "$(trim "$title")"
}

extract_skill_purpose() {
    local src_file="$1"
    local purpose

    purpose="$(awk '
        BEGIN {
            in_purpose = 0
        }

        /^## Purpose[[:space:]]*$/ {
            in_purpose = 1
            next
        }

        /^## / {
            if (in_purpose) {
                exit
            }
        }

        {
            if (in_purpose) {
                if ($0 ~ /^[[:space:]]*$/) {
                    next
                }

                line = $0
                sub(/^[[:space:]]*-[[:space:]]*/, "", line)
                sub(/^[[:space:]]*\*[[:space:]]*/, "", line)
                gsub(/^[[:space:]]+|[[:space:]]+$/, "", line)

                if (line != "") {
                    print line
                    exit
                }
            }
        }
    ' "$src_file")"

    printf '%s' "$(trim "$purpose")"
}

fallback_skill_name_from_filename() {
    local src_file="$1"
    local base_name

    base_name="$(basename "$src_file" .md)"
    printf '%s' "${base_name//-/ }"
}

yaml_escape() {
    local value="$1"
    value="${value//\/\\}"
    value="${value//\"/\\\"}"
    printf '%s' "$value"
}

install_claude_skill() {
    local src_file="$1"
    local skills_root="$2"

    local base_name skill_dir skill_md skill_name skill_description
    base_name="$(basename "$src_file" .md)"
    skill_dir="$skills_root/$base_name"
    skill_md="$skill_dir/SKILL.md"

    skill_name="$(extract_skill_title "$src_file")"
    skill_description="$(extract_skill_purpose "$src_file")"

    if [[ -z "$skill_name" ]]; then
        skill_name="$(fallback_skill_name_from_filename "$src_file")"
        warn "Falling back to filename-derived skill name for: $src_file"
    fi

    if [[ -z "$skill_description" ]]; then
        skill_description="Shape workflow skill: $skill_name"
        warn "Falling back to generic skill description for: $src_file"
    fi

    mkdir -p "$skill_dir"

    if [[ -e "$skill_md" ]]; then
        warn "Skipping existing Claude skill: $skill_md"
        return
    fi

    {
        echo "---"
        echo "name: \"$(yaml_escape "$skill_name")\""
        echo "description: \"$(yaml_escape "$skill_description")\""
        echo "---"
        echo
        cat "$src_file"
    } > "$skill_md"

    info "Installed Claude skill: $skill_md"
}

generate_claude_snippet() {
    local snippet_path="$1"
    local target_root="$2"

    mkdir -p "$(dirname "$snippet_path")"

    {
        if [[ -f "$target_root/AGENTS.md" ]]; then
            echo "@AGENTS.md"
            echo
        fi

        cat <<'SNIPPET'
<!-- Shape / Claude integration: start -->

## Shape workflow

This repository uses the Shape workflow for AI-assisted software delivery.

Shape is a step-by-step workflow with explicit approval boundaries.

When working in this repository:

- Follow the default Shape step order unless the user explicitly asks for another supported Shape operation.
- Treat each Shape operation as a separate boundary.
- Do not move to the next Shape operation without explicit user approval.
- Do not silently combine multiple Shape operations into one step.
- After a Shape operation updates workflow artifacts, stop and let the user review and commit the result, or explicitly ask you to commit it.
- `implement batch` is the special exception: it ends with code and any resulting Implementation Plan updates ready for review, not approved, not committed.
- Review, marking tasks done, and commit are handled by the later explicit Shape steps.

Default Shape step order:
1. initiate feature
2. create prd
3. create technical concept
4. plan implementation
5. plan slice
6. implement batch
7. review batch
8. commit batch
9. finish slice
10. finish implementation

Before acting:

- Read `.shape/config.json` to understand the configured Shape feature root and canonical artifact filenames.
- Treat `.shape/workspace.json` as transient local workspace state. Do not rely on it as committed project state.
- Use `.shape/workflow-templates/` as the canonical source for workflow artifact templates.
- Treat feature folders under the configured feature root as the primary Shape delivery units.
- Use installed Claude Code skills from `.claude/skills/` when a matching Shape workflow operation applies.

Shape feature artifacts typically include:
- `01-prd.md`
- `02-tech-concept.md`
- `03-implementation-plan.md`

Do not invent alternative artifact naming or layout if the configured Shape files already exist.

<!-- Shape / Claude integration: end -->
SNIPPET
    } > "$snippet_path"

    info "Generated CLAUDE.md snippet: $snippet_path"
}

main() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                usage
                exit 0
                ;;
            --overwrite)
                OVERWRITE=1
                shift
                ;;
            --)
                shift
                break
                ;;
            -*)
                usage
                echo >&2
                fail "Unknown option: $1"
                ;;
            *)
                break
                ;;
        esac
    done

    [[ $# -eq 2 ]] || {
        usage
        echo >&2
        fail "Expected <shape-root> and <target-root>"
    }

    local shape_root target_root
    shape_root="$(cd "$1" && pwd)"
    target_root="$(cd "$2" && pwd)"

    require_dir "$shape_root" "Shape source root"
    require_dir "$target_root" "Target root"

    local shape_config_templates="$shape_root/config-templates"
    local shape_workflow_templates="$shape_root/workflow-templates"
    local shape_skills="$shape_root/skills"

    require_dir "$shape_config_templates" "Shape config-templates"
    require_dir "$shape_workflow_templates" "Shape workflow-templates"
    require_dir "$shape_skills" "Shape skills"

    require_file "$shape_config_templates/README.md" "config-templates/README.md"
    require_file "$shape_config_templates/gitignore" "config-templates/gitignore"
    require_file "$shape_config_templates/config.json" "config-templates/config.json"
    require_file "$shape_config_templates/workspace.json" "config-templates/workspace.json"

    local target_shape="$target_root/.shape"
    local target_shape_generated="$target_shape/generated"
    local target_shape_workflow_templates="$target_shape/workflow-templates"
    local target_claude_skills="$target_root/.claude/skills"
    local target_shape_config="$target_shape/config.json"

    if [[ "$OVERWRITE" -eq 1 ]]; then
        info "Preparing overwrite of existing Shape + Claude installation"
        remove_path_if_exists "$target_shape/README.md" "Shape file"
        remove_path_if_exists "$target_shape/.gitignore" "Shape file"
        remove_path_if_exists "$target_shape/config.json" "Shape file"
        remove_path_if_exists "$target_shape_workflow_templates" "workflow templates"
        remove_path_if_exists "$target_shape_generated" "generated snippets"

        while IFS= read -r skill_name; do
            [[ -n "$skill_name" ]] || continue
            remove_path_if_exists "$target_claude_skills/$skill_name" "Claude skill"
        done < <(
            {
                list_managed_skills "$target_shape_config"
                list_managed_skills "$shape_config_templates/config.json"
                find "$shape_skills" -maxdepth 1 -type f -name '*.md' -printf '%f\n' \
                    | sed -E 's/\.md$//'
            } | grep -vE '^(README|skill-design-principles|codex-generation-prompt|claude-generation-prompt)$' | sort -u
        )
    fi

    info "Installing generic Shape layer"
    mkdir -p "$target_shape"
    mkdir -p "$target_shape_workflow_templates"

    copy_managed_file "$shape_config_templates/README.md" "$target_shape/README.md"
    copy_managed_file "$shape_config_templates/gitignore" "$target_shape/.gitignore"
    copy_managed_file "$shape_config_templates/config.json" "$target_shape/config.json"
    copy_managed_file "$shape_config_templates/workspace.json" "$target_shape/workspace.json" 1

    info "Installing workflow templates"
    while IFS= read -r -d '' template_file; do
        copy_if_missing "$template_file" "$target_shape_workflow_templates/$(basename "$template_file")"
    done < <(find "$shape_workflow_templates" -maxdepth 1 -type f -name '*.md' -print0)

    info "Installing Claude-native skills"
    mkdir -p "$target_claude_skills"
    while IFS= read -r -d '' skill_file; do
        local base_name
        base_name="$(basename "$skill_file")"

        case "$base_name" in
            README.md|skill-design-principles.md|codex-generation-prompt.md|claude-generation-prompt.md)
                info "Skipping source-repo-only artifact: $base_name"
                ;;
            *)
                install_claude_skill "$skill_file" "$target_claude_skills"
                ;;
        esac
    done < <(find "$shape_skills" -maxdepth 1 -type f -name '*.md' -print0)

    info "Generating CLAUDE.md snippet"
    generate_claude_snippet "$target_shape_generated/claude-shape-snippet.md" "$target_root"

    echo
    info "Shape + Claude installation complete"
    echo
    echo "Installed generic Shape files under:"
    echo "  $target_shape"
    echo
    echo "Installed Claude-native skills under:"
    echo "  $target_claude_skills"
    echo
    echo "Generated CLAUDE.md snippet at:"
    echo "  $target_shape_generated/claude-shape-snippet.md"
    echo
    echo "Next steps:"
    echo "  1. Review .shape/config.json"
    echo "  2. Review installed skills under .claude/skills/"
    echo "  3. Paste the generated snippet into $target_root/CLAUDE.md"
}

main "$@"
