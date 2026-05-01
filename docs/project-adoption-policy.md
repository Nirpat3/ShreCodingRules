# Project Adoption Policy

Every new coding project should adopt `ShreCodingRules` before implementation begins.

## Required Baseline

Each project should contain:

- `docs/shared-coding-rules.md`
- `AGENTS.md`
- `CODEX.md`
- `CLAUDE.md`
- `GEMINI.md`

For Codex plugin support, each project should also contain:

- `plugins/shre-coding-rules/`
- `.agents/plugins/marketplace.json`

## Operating Rule

When a new repository is created:

1. Apply `ShreCodingRules`.
2. Install the `shre-coding-rules` plugin into the repo.
3. Point all model entry files back to `docs/shared-coding-rules.md`.
4. Add repo-specific architecture, milestone, and safety deltas beside the shared baseline instead of duplicating the entire contract.

## Enforcement Intent

No project should start with separate, drifting copies of model rules.

The shared contract should be the first layer, and project-specific rules should be local deltas on top of it.
