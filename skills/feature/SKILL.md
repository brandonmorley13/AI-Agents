---
name: feature
description: >
  Scaffold a new feature with the right shape — a feature-scoped @MainActor @Observable model,
  a protocol-fronted repository, a top-level view, and tests. Use this skill whenever the user wants to
  "build a new feature", "scaffold a feature", "add a feature called X", "create a feature module",
  "start a new feature", or any request that involves bootstrapping a fresh feature folder in the app.
  The skill enforces the no-new-fields-on-the-legacy-model rule and ends by invoking the code-reviewer
  subagent.
---

# Feature scaffold

You are scaffolding a new feature in the app. The user has provided (or implied) a feature name — call it `<Feature>` below.

## Before generating anything

Read in this order:
1. The root rule file (`CLAUDE.md` or equivalent)
2. The conventions doc
3. `templates/Observable-Model.swift`
4. `templates/SwiftUI-View.swift`

## Produce

1. `Features/<Feature>/<Feature>Model.swift` — `@MainActor @Observable` feature model conforming to a `<Feature>Managing` protocol.
2. `Features/<Feature>/<Feature>Repository.swift` — Protocol + `Live<Feature>Repository` + `Preview<Feature>Repository`.
3. `Features/<Feature>/<Feature>View.swift` — Top-level view that consumes the protocol via `.environment(_:)`.
4. `Tests/<Feature>ModelTests.swift` — tests against the Preview repository.

## Rules to enforce

- **No new fields on the legacy root state object**, if the project has one and it's documented as frozen. The feature owns its own state.
- All remote I/O goes through the shared data manager via the new repository — never directly.
- Logger: the project's data-category logger (or network-category for network paths).
- Strings: go through the platform's localization mechanism everywhere user-facing.
- Errors: dedicated `<Feature>Error` enum + dedicated error view for the user-facing surface.
- Accessibility labels on every interactive element.
- No hardcoded font/color/spacing — reference design tokens.

## After producing the files

Invoke the `code-reviewer` subagent to score the diff against the root rule set. Surface any violations and offer fixes.

End the response with a Conventional Commits message: `feat(<feature>): scaffold feature module`.
