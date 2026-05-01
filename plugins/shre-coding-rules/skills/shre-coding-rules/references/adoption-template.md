# Shared Rules Adoption Template

Use this pattern when adapting a repository to shared coding rules.

## Minimum Files

```text
AGENTS.md
CODEX.md
CLAUDE.md
GEMINI.md
docs/shared-coding-rules.md
```

## Recommended Process

1. Write or refine `docs/shared-coding-rules.md`.
2. Keep repo-specific boundaries and milestone references in that file or nearby docs.
3. Reduce `AGENTS.md`, `CODEX.md`, `CLAUDE.md`, and `GEMINI.md` to short routing files.
4. Remove duplicate rule copies unless an integration requires a local subset.
5. Validate that every model entry file resolves back to the same contract.

## Recommended Entry File Shape

```md
# <Model> Workspace Rules

Start with:

- `AGENTS.md`
- `docs/shared-coding-rules.md`

Follow the shared coding contract before making changes.
```
