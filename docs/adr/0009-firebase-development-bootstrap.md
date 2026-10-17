# ADR-0009: Firebase development bootstrap

- Status: Accepted
- Date: 2026-10-18

## Context

The user selected Firebase and created development project `hifive-dev-8189c`.
The client previously had no external service initialization. The existing
pure-Dart auth gateway assumes backend-owned refresh tokens, so it cannot
directly represent Firebase SDK-owned sessions without a separate contract change.

## Decision

Add official `firebase_core` and `firebase_auth` SDKs to the root Flutter client.
They provide native Firebase initialization and authentication capabilities absent
from Flutter and existing dependencies. Keep Firebase out of domain packages,
design-system code and presentation. Riverpod remains the DI/state framework.

Development bootstrap creates a named `hifive-development` Firebase app with
FlutterFire-generated options, then injects that app into the composition root.
The auth SDK provider always uses this explicit app; it never selects a native
default app. Widget tests/local roots require no native Firebase initialization.
Staging/production continue as local previews, with no configured Firebase
provider and no fallback to dev options. Native generated resources currently
describe dev only; they are not a production Firebase/release configuration.

Firebase Auth will own session persistence and token refresh. Do not manufacture
refresh tokens to fit `AuthGateway`, or connect the legacy session store in
parallel. This bootstrap does not change that package's public contracts. A real
auth feature will require a pure-Dart SDK-session contract and repository adapter,
localized UI, typed routes and lifecycle tests before using these capabilities.

Keep database and server business logic in the separate backend repository under
ADR-0004. Do not add the Firestore client SDK, local database, generated API or
server endpoints before their concrete contracts exist.

## Consequences

- FlutterFire generated files/native registrations must be regenerated.
- Firebase adds native dependencies and platform build/signing maintenance.
- macOS needs outgoing network access and a Keychain access group. Real signed
  auth persistence must be validated on target devices before release.
- iOS and macOS currently share the same bundle identifier, so FlutterFire maps
  them to one Firebase Apple app. Separate identifiers require a later decision.
- Native flavors/build configurations and separate Firebase projects are required
  before production Firebase is enabled; current Dart entrypoints are not flavors.
- No login UI, backend access, database synchronization or grading is implemented
  by this infrastructure change.
