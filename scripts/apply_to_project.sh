#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 <target-project-path> [--force]" >&2
  exit 1
fi

TARGET_ROOT="$(cd "$1" && pwd)"
FORCE_MODE="${2:-}"
SOURCE_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if [[ ! -d "$TARGET_ROOT" ]]; then
  echo "Target project path does not exist: $TARGET_ROOT" >&2
  exit 1
fi

copy_file() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [[ -e "$dest" && "$FORCE_MODE" != "--force" ]]; then
    echo "Refusing to overwrite existing file without --force: $dest" >&2
    exit 1
  fi

  cp "$src" "$dest"
}

copy_dir() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [[ -e "$dest" ]]; then
    if [[ "$FORCE_MODE" != "--force" ]]; then
      echo "Refusing to overwrite existing directory without --force: $dest" >&2
      exit 1
    fi
    rm -rf "$dest"
  fi

  cp -R "$src" "$dest"
}

copy_file "$SOURCE_ROOT/AGENTS.md" "$TARGET_ROOT/AGENTS.md"
copy_file "$SOURCE_ROOT/CODEX.md" "$TARGET_ROOT/CODEX.md"
copy_file "$SOURCE_ROOT/CLAUDE.md" "$TARGET_ROOT/CLAUDE.md"
copy_file "$SOURCE_ROOT/GEMINI.md" "$TARGET_ROOT/GEMINI.md"
copy_file "$SOURCE_ROOT/docs/shared-coding-rules.md" "$TARGET_ROOT/docs/shared-coding-rules.md"

copy_dir "$SOURCE_ROOT/plugins/shre-coding-rules" "$TARGET_ROOT/plugins/shre-coding-rules"
copy_file "$SOURCE_ROOT/.agents/plugins/marketplace.json" "$TARGET_ROOT/.agents/plugins/marketplace.json"

echo "Applied ShreCodingRules to $TARGET_ROOT"
echo "Installed plugin: $TARGET_ROOT/plugins/shre-coding-rules"
echo "Assigned shared rules to AGENTS/CODEX/CLAUDE/GEMINI entry files"
