# ADR-0007: Package workspace, web and platform boundaries

- Status: Accepted
- Date: 2026-10-12

## Context

The client now targets browser delivery in addition to Android, iOS/iPadOS and
macOS. The canonical design system and future authentication/network transport
must be reusable and independently testable without weakening the existing
feature-first boundaries.

## Decision

Use a Dart Pub Workspace with three internal packages:

- `lingua_design_system`: Flutter UI tokens, primitives, components and patterns.
- `lingua_auth`: pure-Dart authentication session contracts and coordination.
- `lingua_networking`: Dio construction and transport interceptors.

The application remains the composition root. Networking exposes token callback
contracts and never imports auth, preventing a dependency cycle. Auth does not
choose a persistence plugin; secure mobile storage and the web credential policy
remain application adapters selected when the backend contract is known.

Fold/posture APIs are platform adapters. The design system consumes layout
geometry and available constraints, not a device plugin. Android can use
`MediaQuery.displayFeatures`; an iOS-specific package may be evaluated when a
supported device and concrete acceptance criteria exist.

Dio only replays safe read requests after token refresh by default. Mutations
must explicitly opt into replay. Login/refresh requests opt out of authentication
through request metadata.

## Consequences

- Package boundaries and tests are independently analyzable.
- The root keeps a shared dependency resolution and lockfile.
- Design token generation now targets the design-system package.
- Web builds require backend CORS and an explicit credential-storage policy.
- Package extraction adds public API and CI maintenance responsibilities.
