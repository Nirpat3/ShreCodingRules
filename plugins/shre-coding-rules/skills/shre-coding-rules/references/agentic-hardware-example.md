# Agentic Hardware Example

This reference preserves the original layered-system flavor that motivated the shared rules.

Core ideas taken from that example:

- gateway or boundary layers are the only place where hardware or vendor execution should happen
- orchestration layers must stay policy-aware and bounded
- UI layers should expose real backend capabilities instead of inventing behavior
- specs and implementation should move together
- milestone-based delivery matters more than disconnected docs

Example project-specific boundaries:

- `gateway` is the execution layer
- `agent` is the orchestration layer
- `apps/admin-ui` is the configuration and diagnostics surface
- `apps/checkout-ui` is the live transaction surface
- `packages/shared` owns contracts and canonical models

This example should stay in `references/`, not in the main skill body, so the skill remains reusable across non-hardware repositories too.
