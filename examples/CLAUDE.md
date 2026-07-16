# CLAUDE.md — Example Project

> **Project:** A generic mobile app. This file is a worked example of the routing-table pattern described in the harness README — copy the shape, not the specifics.

This file is the **always-loaded slim core**: invariants + a routing table. Don't expand it — push detail into `docs/*.md` and the per-folder `CLAUDE.md` leaves, loaded on demand.

---

## Routing — read the leaf/doc for the area you're touching

| Working in… | Read first | Then if needed |
|---|---|---|
| any feature folder | that folder's `CLAUDE.md` leaf | the domain doc below |
| the third-party integration layer | `Integration/CLAUDE.md` | `docs/INTEGRATION_REFERENCE.md`, `docs/BACKEND.md`, `docs/SECURITY.md` |
| the backend / remote-data layer | `Backend/CLAUDE.md` | `docs/BACKEND.md` |
| the AI surface | `AI/CLAUDE.md` | `docs/AI.md` |
| security, auth, crypto | `Core/Security/CLAUDE.md` | `docs/SECURITY.md`, compliance TL;DRs |
| theme, any UI | `Core/Theme/CLAUDE.md` | `docs/ACCESSIBILITY.md`, `docs/THEME.md` |
| logging, audit | `Core/Logging/CLAUDE.md` | — |
| data models | `Data/CLAUDE.md` | `docs/CONVENTIONS.md` |
| onboarding / age-gate | `Features/Onboarding/CLAUDE.md` | the minors/compliance policy |
| server functions | `Backend/functions/CLAUDE.md` | `docs/BACKEND.md` |
| conventions, deps, layout | `docs/CONVENTIONS.md` | — |
| performance / budgets | `docs/PERFORMANCE.md` | — |
| retention, deletion, export | `docs/DATA_LIFECYCLE.md` | the retention policy |

## Token discipline

- **Leaf-first.** When a folder has a `CLAUDE.md`, read it before any root doc. It already summarizes the rules for that area.
- **Policy is layered.** Each compliance doc opens with a **TL;DR for agents**. Read the TL;DR; load the full policy only when the change actually edits that policy area.
- **Locate before reading.** Grep/Glob to find the lines; read with an offset/limit. Full reads only for files under ~200 lines or on security/data/money/auth-critical paths.
- **Subagents/audits run only when explicitly invoked** (a slash command or a direct request). Don't spawn a reviewer proactively.

## Platform baseline

Fill in: language version, strict-concurrency mode, minimum OS target, package manager.

## Architecture

Fill in: state-management pattern, how cross-cutting services are exposed (protocol-fronted singletons, DI container, etc.), and which legacy types (if any) are frozen for new fields.

## Data flow

Fill in: what's local-only, what's the remote source of truth, and the rule for how a third-party connection's credentials are handled (e.g., "the client never holds a long-lived token").

## Security

Fill in: secrets storage mechanism, strong-auth gating rule, transport-security baseline, encryption-at-rest approach, and the regulatory regimes that apply.

## AI

Fill in: which model tiers are used for which task, where consent is captured, and how PII is sanitized before a model call.

## Anti-patterns this project refuses to generate

List the specific patterns that keep showing up and getting rejected — force-unwraps in the wrong place, a logger bypass, a new singleton that skips the protocol-fronting convention, a hardcoded design-token value, whatever your own incident-to-rule loop has surfaced.

## When in doubt

- Conflict with a compliance policy → **policy wins**; update this file to match in the same change.
- Conflict with this file → surface it; propose follow-the-rule vs. deviate-with-justification. Never silently deviate.
- Need to know the codebase → **read the file**, don't guess from the filename.
- Money / data / auth / AI / security path with ambiguity → **ask**.

## Workflow

- `.claude/skills/` — invocable workflows. Slash entry points; run them **on request**, not automatically.
- `.claude/agents/` — specialist subagents (model-pinned for cost).
- `.claude/templates/` — starting shapes for views, models, server functions, feature folders.
- `docs/PROCESSES/` — eval harness, incident→rule loop, ADR workflow.
