#!/usr/bin/env bash
# Shared upgrade preparation. Sourced by the agent-specific installers.

prepare_shape_install() {
    local agent="$1" skills_root="$2" source_root="$3" target_root="$4"
    local config="$target_root/.shape/config.json"
    local manifest="$target_root/.shape/installations/$agent.json"
    local has_old=0 has_manifest=0 name path snippet

    # Do not follow redirected installation roots when replacing managed files.
    for path in "$target_root/.shape" "$(dirname "$skills_root")" "$skills_root" \
        "$target_root/.shape/installations" "$target_root/.shape/generated" \
        "$target_root/.shape/workflow-templates"; do
        [[ ! -L "$path" ]] || fail "Installation directory must not be a symlink: $path"
        [[ ! -e "$path" || -d "$path" ]] || fail "Expected an installation directory: $path"
    done
    if [[ -e "$target_root/.shape" && ! -f "$config" ]]; then
        fail "Existing .shape/config.json is missing. Restore it before upgrading so project paths and the old skill inventory can be preserved."
    fi
    [[ ! -L "$config" && ! -L "$manifest" ]] || fail "Shape config and installation inventory must not be symlinks"
    [[ ! -e "$manifest" || -f "$manifest" ]] || fail "Invalid installation inventory: $manifest"
    [[ -f "$config" ]] && has_old=1
    [[ -f "$manifest" ]] && has_manifest=1
    case "$agent" in
        codex) snippet="agents-codex-snippet.md" ;;
        *) snippet="$agent-shape-snippet.md" ;;
    esac
    path="$target_root/.shape/generated/$snippet"
    [[ ! -L "$path" && ( ! -e "$path" || -f "$path" ) ]] || fail "Invalid generated snippet destination: $path"
    for name in product-specification technical-specification implementation-plan specification-reference; do
        require_file "$source_root/workflow-templates/$name-template.md" "workflow template: $name"
    done

    SHAPE_INSTALL_STAGE="$(mktemp -d "${TMPDIR:-/tmp}/shape-install.XXXXXXXX")"
    trap 'rm -rf -- "$SHAPE_INSTALL_STAGE"' EXIT
    printf '{}\n' > "$SHAPE_INSTALL_STAGE/empty.json"
    local old_input="$SHAPE_INSTALL_STAGE/empty.json" manifest_input="$SHAPE_INSTALL_STAGE/empty.json"
    [[ "$has_old" -eq 0 ]] || old_input="$config"
    [[ "$has_manifest" -eq 0 ]] || manifest_input="$manifest"
    awk -v has_old="$has_old" -v has_manifest="$has_manifest" \
        -v merged_file="$SHAPE_INSTALL_STAGE/config.json" \
        -v manifest_file="$SHAPE_INSTALL_STAGE/manifest.json" \
        -v install_file="$SHAPE_INSTALL_STAGE/install.txt" \
        -v cleanup_file="$SHAPE_INSTALL_STAGE/cleanup.txt" \
        -f "$source_root/bin/install-config.awk" \
        "$source_root/config-templates/config.json" "$old_input" "$manifest_input" \
        "$source_root/config-templates/retired-skills.json" || fail "Configuration validation failed; installation was not changed."

    # Validate the entire source skill set and destinations before removal begins.
    while IFS= read -r name; do
        require_file "$source_root/skills/$name.md" "managed skill: $name"
        if [[ -e "$skills_root/$name" || -L "$skills_root/$name" ]]; then
            grep -Fxq "$name" "$SHAPE_INSTALL_STAGE/cleanup.txt" || \
                fail "Skill destination is not owned by the previous Shape inventory: $skills_root/$name"
        fi
    done < "$SHAPE_INSTALL_STAGE/install.txt"
    for path in "$target_root/.shape/workspace.json" "$target_root/.shape/README.md" "$target_root/.shape/.gitignore"; do
        [[ ! -L "$path" ]] || fail "Managed file must not be a symlink: $path"
        [[ ! -e "$path" || -f "$path" ]] || fail "Expected a file: $path"
    done
}

finish_shape_install() {
    local agent="$1" target_shape="$2"
    cp "$SHAPE_INSTALL_STAGE/config.json" "$target_shape/config.json"
    mkdir -p "$target_shape/installations"
    cp "$SHAPE_INSTALL_STAGE/manifest.json" "$target_shape/installations/$agent.json"
}
