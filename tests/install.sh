#!/usr/bin/env bash
# Integration checks use only the installers' existing Bash/POSIX toolchain.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TEST_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/shape-tests.XXXXXXXX")"
trap 'rm -rf -- "$TEST_ROOT"' EXIT

fail() { echo "FAIL: $*" >&2; exit 1; }
assert_contains() { grep -Fq -- "$2" "$1" || fail "Missing '$2' in $1"; }
skills_dir() {
    case "$1" in
        codex) echo '.codex/skills';;
        claude) echo '.claude/skills';;
        gemini) echo '.agents/skills';;
        opencode) echo '.opencode/skills';;
    esac
}
install() {
    local agent="$1" target="$2"
    shift 2
    bash "$ROOT/bin/install-$agent.sh" "$@" "$ROOT" "$target" > "$TEST_ROOT/install.log" 2>&1 || {
        cat "$TEST_ROOT/install.log" >&2
        fail "$agent installation failed"
    }
}
expect_failure() {
    local agent="$1" target="$2"
    if bash "$ROOT/bin/install-$agent.sh" --overwrite "$ROOT" "$target" > "$TEST_ROOT/install.log" 2>&1; then
        fail "Expected $agent installation to fail"
    fi
}
legacy_config() {
    cat > "$1" <<'JSON'
{"version":1,"featuresRoot":"custom docs/features","artifacts":{"prd":"requirements.md","technicalConcept":"design.md","implementationPlan":"delivery.md","extra":"notes.md"},"skills":{"managed":["create-prd","update-prd","create-technical-concept","update-technical-concept","plan-slice","finish-slice","initiate-feature","old-custom-shape-skill"],"customSetting":true},"custom":{"array":[1,-2.5e+3,null,false,{"quoted":"a\"b","unicode":"\u2603","path":"a\\b"}]}}
JSON
}
seed_docs() {
    mkdir -p "$1/custom docs/features/ongoing" "$1/docs/implementation" "$1/.shape"
    printf '# Approved PRD\nStatus: approved\nOriginal product wording\n' > "$1/custom docs/features/ongoing/requirements.md"
    printf '# Technical Concept\nStatus: approved\n' > "$1/custom docs/features/ongoing/design.md"
    printf '# Slice Plans\n- Slice 1: approved\n- [x] task\n' > "$1/custom docs/features/ongoing/delivery.md"
    printf 'Existing project documentation\n' > "$1/docs/implementation/README.md"
    printf '{"activeFeature":"custom docs/features/ongoing","extra":true}\n' > "$1/.shape/workspace.json"
    printf 'User agent instructions\n' > "$1/AGENTS.md"
}
assert_project_preserved() {
    diff -r "$1/custom docs" "$2/custom docs" || fail 'Feature documents changed'
    diff -r "$1/docs" "$2/docs" || fail 'Project documentation changed'
    cmp "$1/.shape/workspace.json" "$2/.shape/workspace.json" || fail 'Workspace state changed'
    cmp "$1/AGENTS.md" "$2/AGENTS.md" || fail 'Agent instructions changed'
}
for agent in codex claude gemini opencode; do
    target="$TEST_ROOT/fresh $agent"
    mkdir -p "$target"
    install "$agent" "$target"
    config="$target/.shape/config.json"
    cmp "$ROOT/config-templates/config.json" "$config" || fail 'Fresh config does not retain standard two-space JSON formatting'
    grep -Fxq '  "skills": {' "$target/.shape/installations/$agent.json" || fail 'Installation inventory is not indented'
    assert_contains "$config" '"featuresRoot": "docs/implementation"'
    assert_contains "$config" '"version": 2'
    assert_contains "$config" '"shapeVersion": "0.4"'
    assert_contains "$config" '"productSpecification": "01-product-specification.md"'
    native="$target/$(skills_dir "$agent")"
    [[ -f "$native/create-product-specification/SKILL.md" && -f "$native/plan-iteration/SKILL.md" && -f "$native/review-code/SKILL.md" ]] || fail 'Missing new skills'
    assert_contains "$native/review-code/SKILL.md" 'Perform a code review'
    [[ $(find "$native" -name SKILL.md | wc -l) -eq 15 ]] || fail 'Incomplete managed skill set'
    for skill in "$native"/*; do
        grep -Eq "^name: \"?$(basename "$skill")\"?$" "$skill/SKILL.md" || fail 'Skill metadata name does not match its directory'
    done
    [[ -f "$target/.shape/workflow-templates/specification-reference-template.md" ]] || fail 'Missing reference template'
    if bash "$ROOT/bin/install-$agent.sh" "$ROOT" "$target" > "$TEST_ROOT/install.log" 2>&1; then fail 'Reinstall without overwrite succeeded'; fi
    cp -R "$target" "$target snapshot"
    install "$agent" "$target" --overwrite
    diff -r "$target" "$target snapshot" || fail 'Repeated installation is not idempotent'

    target="$TEST_ROOT/legacy $agent"
    mkdir -p "$target/.shape"
    seed_docs "$target"
    legacy_config "$target/.shape/config.json"
    native="$target/$(skills_dir "$agent")"
    for skill in create-prd update-prd create-technical-concept update-technical-concept plan-slice finish-slice initiate-feature old-custom-shape-skill unrelated; do
        mkdir -p "$native/$skill"
        printf 'Original skill\n' > "$native/$skill/SKILL.md"
    done
    mkdir -p "$target/.shape/workflow-templates"
    printf 'Old template\n' > "$target/.shape/workflow-templates/prd-template.md"
    cp -R "$target" "$target snapshot"
    install "$agent" "$target" --overwrite
    assert_project_preserved "$target" "$target snapshot"
    config="$target/.shape/config.json"
    assert_contains "$config" '"featuresRoot": "custom docs/features"'
    assert_contains "$config" '"productSpecification": "requirements.md"'
    assert_contains "$config" '"technicalSpecification": "design.md"'
    assert_contains "$config" '"implementationPlan": "delivery.md"'
    assert_contains "$config" '"extra": "notes.md"'
    assert_contains "$config" '"customSetting": true'
    cat > "$TEST_ROOT/expected-array.json" <<'JSON'
    "array": [
      1,
      -2.5e+3,
      null,
      false,
      {
        "quoted": "a\"b",
        "unicode": "\u2603",
        "path": "a\\b"
      }
    ]
JSON
    sed -n '/^    "array": \[/,/^    ]/p' "$config" > "$TEST_ROOT/actual-array.json"
    cmp "$TEST_ROOT/expected-array.json" "$TEST_ROOT/actual-array.json" || fail 'Nested upgrade settings lost formatting or values'
    for skill in create-prd update-prd create-technical-concept update-technical-concept plan-slice finish-slice old-custom-shape-skill; do
        [[ ! -e "$native/$skill" ]] || fail "Obsolete skill remains: $skill"
    done
    [[ ! -e "$target/.shape/workflow-templates/prd-template.md" ]] || fail 'Old template remains'
    cmp "$native/unrelated/SKILL.md" "$target snapshot/$(skills_dir "$agent")/unrelated/SKILL.md" || fail 'Unrelated skill modified'
    assert_contains "$native/initiate-feature/SKILL.md" 'Existing specifications'
    install "$agent" "$target" --overwrite
    assert_project_preserved "$target" "$target snapshot"
    echo "PASS: $agent fresh install, upgrade, preservation, obsolete removal, repeat install"
done

# A shared config may already be updated when another agent is upgraded.
target="$TEST_ROOT/multi"
mkdir -p "$target/.shape"
legacy_config "$target/.shape/config.json"
for agent in codex claude gemini opencode; do
    native="$target/$(skills_dir "$agent")"
    for skill in create-prd plan-slice; do
        mkdir -p "$native/$skill"
        printf 'Old skill\n' > "$native/$skill/SKILL.md"
    done
done
for agent in codex claude gemini opencode; do
    install "$agent" "$target" --overwrite
    native="$target/$(skills_dir "$agent")"
    [[ ! -e "$native/create-prd" && ! -e "$native/plan-slice" ]] || fail 'Sequential upgrade left retired skills'
    [[ -f "$target/.shape/installations/$agent.json" ]] || fail 'Missing per-agent inventory'
done
[[ $(find "$target/.shape/generated" -type f | wc -l) -eq 4 ]] || fail 'Another agent snippet was removed'
# A future removed skill survives only in this agent's installation inventory.
printf '{"skills":{"managed":["retired-for-this-agent"]}}\n' > "$target/.shape/installations/codex.json"
mkdir -p "$target/.codex/skills/retired-for-this-agent"
install codex "$target" --overwrite
[[ ! -e "$target/.codex/skills/retired-for-this-agent" ]] || fail 'Per-agent obsolete skill remains'
echo 'PASS: sequential multi-agent upgrades and per-agent inventory'

# Invalid or missing metadata must fail before any target mutation.
for scenario in missing malformed missing-inventory unsafe-name conflict future-version bad-manifest; do
    target="$TEST_ROOT/failure-$scenario"
    mkdir -p "$target/.shape" "$target/.codex/skills/create-prd"
    legacy_config "$target/.shape/config.json"
    printf 'Keep me\n' > "$target/.codex/skills/create-prd/SKILL.md"
    case "$scenario" in
        missing) mv "$target/.shape/config.json" "$target/config-backup.json";;
        malformed) printf '{invalid}\n' > "$target/.shape/config.json";;
        missing-inventory) printf '{"version":1,"skills":{}}\n' > "$target/.shape/config.json";;
        unsafe-name) printf '{"skills":{"managed":["../../docs"]}}\n' > "$target/.shape/config.json";;
        conflict) sed 's/"prd":"requirements.md"/"prd":"requirements.md","productSpecification":"other.md"/' "$target/.shape/config.json" > "$target/config"; mv "$target/config" "$target/.shape/config.json";;
        future-version) sed 's/"version":1/"version":999/' "$target/.shape/config.json" > "$target/config"; mv "$target/config" "$target/.shape/config.json";;
        bad-manifest) mkdir -p "$target/.shape/installations"; printf '[]\n' > "$target/.shape/installations/codex.json";;
    esac
    cp -R "$target" "$target snapshot"
    expect_failure codex "$target"
    diff -r "$target" "$target snapshot" || fail "Target changed after failed validation: $scenario"
done
# Preserve arbitrary settings even with escaped schema keys and compact JSON.
target="$TEST_ROOT/escaped"
mkdir -p "$target/.shape"
legacy_config "$target/.shape/config.json"
sed 's/"prd"/"pr\\u0064"/' "$target/.shape/config.json" > "$target/config"
mv "$target/config" "$target/.shape/config.json"
install codex "$target" --overwrite
assert_contains "$target/.shape/config.json" '"productSpecification": "requirements.md"'
echo 'PASS: validation failures leave targets unchanged; escaped JSON keys supported'

# Incomplete source checkouts and unowned destinations fail before replacement.
source_copy="$TEST_ROOT/source"
mkdir -p "$source_copy"
cp -R "$ROOT/bin" "$ROOT/config-templates" "$ROOT/workflow-templates" "$ROOT/skills" "$source_copy/"
mv "$source_copy/skills/finish-feature.md" "$source_copy/missing-skill.md"
target="$TEST_ROOT/incomplete-source"
mkdir -p "$target/.shape"
legacy_config "$target/.shape/config.json"
cp -R "$target" "$target snapshot"
if bash "$source_copy/bin/install-codex.sh" --overwrite "$source_copy" "$target" > "$TEST_ROOT/install.log" 2>&1; then
    fail 'Incomplete source accepted'
fi
diff -r "$target" "$target snapshot" || fail 'Incomplete source changed the target'
target="$TEST_ROOT/collision"
mkdir -p "$target/.codex/skills/create-product-specification"
printf 'Not owned by Shape\n' > "$target/.codex/skills/create-product-specification/SKILL.md"
cp -R "$target" "$target snapshot"
expect_failure codex "$target"
diff -r "$target" "$target snapshot" || fail 'Unowned skill destination changed'
echo 'PASS: incomplete source and unowned skill collision leave targets unchanged'
echo 'All installer checks passed.'
