# Shared Coding Rules

## Purpose

This is the common coding contract that every model and coding agent should follow before making changes in a repository.

It is intended to be:

- model-agnostic
- repo-portable
- strict on architecture and safety
- practical for day-to-day implementation work

This file is the source of truth. Model-specific files should point to it instead of duplicating it.

## 1. Non-Negotiables

- Read the local rules before acting.
- Follow the current milestone, architecture, and delivery plan before editing code.
- Keep backend and frontend responsibilities separate.
- Keep secrets and sensitive credentials server-side.
- Keep one clear write area per agent where possible.
- Keep evidence for visible, deployable, or risky changes.
- Make exceptions explicit, narrow, and time-bound.
- Do not treat docs-only work as shipped implementation.

## 2. Architecture Boundaries

- Respect the repo's declared architecture layers.
- Keep UI concerns in UI layers.
- Keep orchestration, policy, and workflow logic in service layers.
- Keep transport, adapter, and vendor-specific execution at boundary layers.
- Keep shared types, contracts, and schemas in a shared contract layer.

Hard rules:

- UI code must not contain infrastructure or hardware execution logic.
- Shared packages must not depend on apps.
- Service layers must not bypass approved boundary layers.
- Vendor-specific logic belongs at the adapter or integration edge, not in UI or shared layers.

## 3. Flow Discipline

Implementation should preserve the intended system flow:

```text
UI / SDK
  -> API or orchestration layer
  -> command or workflow layer
  -> adapter or integration layer
  -> vendor SDK, protocol, or external service
```

For agent-enabled work:

```text
Intent
  -> policy check
  -> approval check if needed
  -> tool selection
  -> bounded execution
  -> observation
  -> trace or audit record
```

## 4. Delivery Discipline

- Work against a milestone, roadmap, or scoped implementation target.
- Prefer vertical slices over disconnected partial work.
- State which milestone or scoped outcome a change belongs to.
- Backend and services own workflow truth and final state transitions.
- Frontends render state and collect input; they should not invent backend truth.
- Do not ship risky automation before diagnostics, permissions, traces, and rollback paths are in place.

## 5. File and Package Organization

- Keep entry points thin.
- Put domain logic in library or service modules.
- Use explicit package boundaries.
- Prefer public entry points over deep internal imports.
- Do not create hidden cross-package coupling.

## 6. Coding Style

- Prefer explicit interfaces and discriminated unions.
- Prefer small modules with single-purpose functions.
- Keep route handlers and controllers thin.
- Prefer pure functions for normalization, mapping, planning, and validation.
- Keep mutable runtime state localized.
- Use comments sparingly and only when intent is not obvious from the code.

## 7. Contract Discipline

- Reuse canonical shared contracts instead of redefining them.
- Keep specs and implementation aligned in the same change.
- Include correlation IDs, trace IDs, or equivalent request identifiers on command-like operations where relevant.
- Do not hardcode the same contract behavior in multiple layers.

## 8. Error Handling

- Normalize errors before returning them to callers.
- Do not leak raw vendor or low-level infrastructure errors directly to UI consumers.
- Do not silently swallow failures.
- Make degraded states explicit.

## 9. Testing and Verification

Before closing work:

- build or typecheck affected packages
- run tests where they exist
- verify the changed flow end to end where practical
- update specs when behavior changes
- call out assumptions that were not verified

Visible or deployable changes should have evidence:

- build output
- typecheck or test output
- screenshots or recordings for UI work when useful

## 10. Frontend Standards

- Actions shown in UI must map to real backend capabilities.
- UI should not invent backend behavior just to complete a mock.
- Risk, readiness, and state should be visible without deep navigation.

## 11. Safety Standards

- Treat payment, security, credentials, identity, and destructive operations as high risk by default.
- Do not bypass approval, audit, or policy requirements.
- Do not place secrets into client bundles, screenshots, logs, or fixtures.
- Do not let agents mutate state outside approved tools and APIs.

## 12. Model Guidance

Every model follows this same contract first.

Typical best fit:

- Codex-style agent: repo-local edits, implementation, API wiring, tests
- Claude-style agent: architecture, policy, synthesis, milestone framing
- Gemini-style agent: alternate review, cross-checking, broad inspection

If a task needs a broader-access or differently specialized model, document the reason before work starts.

## 13. Forbidden Shortcuts

- No boundary bypasses.
- No fake backend behavior presented as complete product behavior.
- No contract divergence without updating the relevant spec.
- No docs-only delivery for implementation milestones.
- No hidden side effects in layers that should remain declarative or read-only.

## 14. How To Apply This In A Repo

When adapting this file into a project:

1. Keep this shared contract as the baseline.
2. Add repo-specific architecture boundaries in local docs.
3. Point `AGENTS.md`, `CODEX.md`, `CLAUDE.md`, and `GEMINI.md` to this file.
4. Add project-specific specs, milestone docs, and safety rules beside it.
5. Avoid copying the full rule set into multiple model files.
