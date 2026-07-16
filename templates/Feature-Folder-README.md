# <Feature>

## Purpose
One-line description of what this feature does.

## Files
- `<Feature>Model.swift` — `@MainActor @Observable` feature state.
- `<Feature>Repository.swift` — Protocol + Live + Preview implementations.
- `<Feature>View.swift` — Top-level view.
- (others as needed)

## Dependencies
- Remote data via a `RemoteDataManaging` protocol
- Third-party connection via a `ThirdPartyConnectionManaging` protocol (if applicable)
- AI via an `AIServiceProtocol` (if applicable)

## State
What's stored in `<Feature>Model`. What's persisted remotely. What's local-only.

## Tests
- `<Feature>ModelTests.swift` — unit tests against `<Feature>Repository.preview`.
- UI tests in the project's UI-test target if a critical flow.

## Migration notes
If this feature replaced a slice of a legacy root state object, link the relevant ADR.
