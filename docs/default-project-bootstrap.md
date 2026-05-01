# Default Project Bootstrap

Use `ShreCodingRules` as the default starting point for every new project.

## Default Command

```bash
new-shre-project <project-name>
```

Examples:

```bash
new-shre-project InventoryGateway
new-shre-project InventoryGateway --github --private
new-shre-project /Users/aibot/Documents/Projects/InventoryGateway --github --public
```

## What It Does

1. Creates the target project directory.
2. Initializes git if needed.
3. Seeds a minimal `README.md` when one does not exist.
4. Applies `ShreCodingRules`.
5. Installs the local `shre-coding-rules` plugin and marketplace file.
6. Assigns the shared contract to `AGENTS.md`, `CODEX.md`, `CLAUDE.md`, and `GEMINI.md`.
7. Optionally creates a GitHub remote through `gh`.

## Policy

New projects should start with this scaffold instead of ad hoc `git init` plus manual rule copying.
