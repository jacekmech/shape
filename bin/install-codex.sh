#!/usr/bin/env bash

set -euo pipefail

SCRIPT_NAME="$(basename "$0")"

usage() {
    cat <<'EOF'
Usage:
  install-codex.sh <shape-root> <target-root>

Arguments:
  <shape-root>   Path to the Shape source repository
  <target-root>  Path to the target repository where Shape should be installed

What this script does:
  1. Installs the generic Shape layer into <target-root>/.shape/
  2. Copies workflow templates into <target-root>/.shape/workflow-templates/
  3. Installs Codex-native skills into <target-root>/.codex/skills/
  4. Generates a pasteable AGENTS.md snippet at:
       <target-root>/.shape/generated/agents-codex-snippet.md

What this script does NOT do:
  - It does not patch AGENTS.md
  - It does not commit any changes
  - It does not overwrite existing files silently

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
  install-codex.sh ~/src/shape ~/src/my-app
  install-codex.sh . ../demo-repo
EOF
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

install_codex_skill() {
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
        warn "Skipping existing Codex skill: $skill_md"
        return
    fi

    {
        echo "---"
        echo "name: $skill_name"
        echo "description: $skill_description"
        echo "---"
        echo
        cat "$src_file"
    } > "$skill_md"

    info "Installed Codex skill: $skill_md"
}

generate_agents_snippet() {
    local snippet_path="$1"

    mkdir -p "$(dirname "$snippet_path")"

    cat > "$snippet_path" <<'EOF'
<!-- Shape / Codex integration: start -->

## Shape workflow

This repository uses the Shape workflow for AI-assisted software delivery.

When working in this repository:

- Read `.shape/config.json` to understand the configured Shape feature root and canonical artifact filenames.
- Treat `.shape/workspace.json` as transient local workspace state. Do not rely on it as committed project state.
- Use `.shape/workflow-templates/` as the canonical source for workflow artifact templates.
- Treat feature folders under the configured feature root as the primary Shape delivery units.
- Use installed Codex skills from `.codex/skills/` when a matching Shape workflow operation applies.

Shape feature artifacts typically include:
- `01-prd.md`
- `02-tech-concept.md`
- `03-implementation-plan.md`

Do not invent alternative artifact naming or layout if the configured Shape files already exist.

<!-- Shape / Codex integration: end -->
EOF

    info "Generated AGENTS.md snippet: $snippet_path"
}

main() {
    if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
        usage
        exit 0
    fi

    [[ $# -eq 2 ]] || {
        usage
        echo >&2
        fail "Expected exactly 2 arguments: <shape-root> <target-root>"
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
    local target_codex_skills="$target_root/.codex/skills"

    info "Installing generic Shape layer"
    mkdir -p "$target_shape"
    mkdir -p "$target_shape_workflow_templates"

    copy_if_missing "$shape_config_templates/README.md" "$target_shape/README.md"
    copy_if_missing "$shape_config_templates/gitignore" "$target_shape/.gitignore"
    copy_if_missing "$shape_config_templates/config.json" "$target_shape/config.json"
    copy_if_missing "$shape_config_templates/workspace.json" "$target_shape/workspace.json"

    info "Installing workflow templates"
    while IFS= read -r -d '' template_file; do
        copy_if_missing "$template_file" "$target_shape_workflow_templates/$(basename "$template_file")"
    done < <(find "$shape_workflow_templates" -maxdepth 1 -type f -name '*.md' -print0)

    info "Installing Codex-native skills"
    mkdir -p "$target_codex_skills"
    while IFS= read -r -d '' skill_file; do
        local base_name
        base_name="$(basename "$skill_file")"

        case "$base_name" in
            README.md|skill-design-principles.md|codex-generation-prompt.md)
                info "Skipping source-repo-only artifact: $base_name"
                ;;
            *)
                install_codex_skill "$skill_file" "$target_codex_skills"
                ;;
        esac
    done < <(find "$shape_skills" -maxdepth 1 -type f -name '*.md' -print0)

    info "Generating AGENTS.md snippet"
    generate_agents_snippet "$target_shape_generated/agents-codex-snippet.md"

    echo
    info "Shape + Codex installation complete"
    echo
    echo "Installed generic Shape files under:"
    echo "  $target_shape"
    echo
    echo "Installed Codex-native skills under:"
    echo "  $target_codex_skills"
    echo
    echo "Generated AGENTS.md snippet at:"
    echo "  $target_shape_generated/agents-codex-snippet.md"
    echo
    echo "Next steps:"
    echo "  1. Review .shape/config.json"
    echo "  2. Review installed skills under .codex/skills/"
    echo "  3. Paste the generated snippet into $target_root/AGENTS.md"
}

main "$@"