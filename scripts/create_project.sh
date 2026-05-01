#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  create_project.sh <project-name-or-path> [--github] [--public|--private] [--force]

Examples:
  create_project.sh MyApp
  create_project.sh /Users/aibot/Documents/Projects/MyApp --github --public
EOF
}

if [[ $# -lt 1 ]]; then
  usage >&2
  exit 1
fi

PROJECT_ARG=""
CREATE_GITHUB=0
VISIBILITY="private"
FORCE_MODE=0

for arg in "$@"; do
  case "$arg" in
    --github)
      CREATE_GITHUB=1
      ;;
    --public)
      VISIBILITY="public"
      ;;
    --private)
      VISIBILITY="private"
      ;;
    --force)
      FORCE_MODE=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      if [[ -z "$PROJECT_ARG" ]]; then
        PROJECT_ARG="$arg"
      else
        echo "Unexpected argument: $arg" >&2
        exit 1
      fi
      ;;
  esac
done

if [[ -z "$PROJECT_ARG" ]]; then
  echo "Project path or name is required." >&2
  exit 1
fi

SOURCE_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEFAULT_PARENT="/Users/aibot/Documents/Projects"

if [[ "$PROJECT_ARG" = /* ]]; then
  TARGET_ROOT="$PROJECT_ARG"
else
  TARGET_ROOT="$DEFAULT_PARENT/$PROJECT_ARG"
fi

PROJECT_NAME="$(basename "$TARGET_ROOT")"

if [[ -e "$TARGET_ROOT" && "$FORCE_MODE" -ne 1 ]]; then
  if [[ -d "$TARGET_ROOT" ]] && [[ -z "$(find "$TARGET_ROOT" -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
    :
  else
    echo "Target already exists and is not empty: $TARGET_ROOT" >&2
    echo "Use --force only when you explicitly want to overwrite the ShreCodingRules-managed files." >&2
    exit 1
  fi
fi

mkdir -p "$TARGET_ROOT"

if [[ ! -d "$TARGET_ROOT/.git" ]]; then
  git init "$TARGET_ROOT" >/dev/null
fi

if [[ ! -f "$TARGET_ROOT/README.md" ]]; then
  cat > "$TARGET_ROOT/README.md" <<EOF
# $PROJECT_NAME

This project was bootstrapped with ShreCodingRules.
EOF
fi

if [[ "$FORCE_MODE" -eq 1 ]]; then
  "$SOURCE_ROOT/scripts/apply_to_project.sh" "$TARGET_ROOT" --force
else
  "$SOURCE_ROOT/scripts/apply_to_project.sh" "$TARGET_ROOT"
fi

if [[ "$CREATE_GITHUB" -eq 1 ]]; then
  if ! command -v gh >/dev/null 2>&1; then
    echo "GitHub CLI is not installed; skipping remote creation." >&2
    exit 1
  fi

  if ! gh auth status >/dev/null 2>&1; then
    echo "GitHub CLI is not authenticated; skipping remote creation." >&2
    exit 1
  fi

  if ! git -C "$TARGET_ROOT" remote get-url origin >/dev/null 2>&1; then
    if [[ "$VISIBILITY" = "public" ]]; then
      gh repo create "$PROJECT_NAME" --public --source "$TARGET_ROOT" --remote origin >/dev/null
    else
      gh repo create "$PROJECT_NAME" --private --source "$TARGET_ROOT" --remote origin >/dev/null
    fi
  fi
fi

echo "Created project scaffold at $TARGET_ROOT"
echo "Applied ShreCodingRules to AGENTS/CODEX/CLAUDE/GEMINI"

if [[ "$CREATE_GITHUB" -eq 1 ]]; then
  echo "GitHub remote configured for $PROJECT_NAME"
fi
