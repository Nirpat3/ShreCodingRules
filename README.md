# ShreCodingRules

Shared coding rules packaged for cross-model use.

This repository provides:

- a canonical shared coding contract in `docs/shared-coding-rules.md`
- root entry files for common agents and models
- a Codex plugin with a reusable `shre-coding-rules` skill

## Layout

```text
ShreCodingRules/
├── AGENTS.md
├── CODEX.md
├── CLAUDE.md
├── GEMINI.md
├── docs/
│   └── shared-coding-rules.md
├── .agents/plugins/marketplace.json
└── plugins/
    └── shre-coding-rules/
        ├── .codex-plugin/plugin.json
        └── skills/
            └── shre-coding-rules/
                ├── SKILL.md
                ├── agents/openai.yaml
                └── references/
```

## Intent

Use this repo when you want one ruleset that multiple models can follow without duplicating the same instructions across `AGENTS.md`, `CODEX.md`, `CLAUDE.md`, and similar files.

## Apply To A New Project

Run:

```bash
./scripts/apply_to_project.sh /path/to/target-repo
```

This will:

- copy `docs/shared-coding-rules.md`
- copy `AGENTS.md`, `CODEX.md`, `CLAUDE.md`, and `GEMINI.md`
- install the local `shre-coding-rules` plugin into `plugins/shre-coding-rules`
- install `.agents/plugins/marketplace.json`

Use `--force` only when you explicitly want to replace an existing setup.

## Default New Project Command

Run:

```bash
new-shre-project <project-name>
```

Optional GitHub remote creation:

```bash
new-shre-project <project-name> --github --private
new-shre-project <project-name> --github --public
```

This command is backed by `scripts/create_project.sh` and is intended to be the default way to start new repositories.
