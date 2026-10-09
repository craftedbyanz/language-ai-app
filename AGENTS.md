# Language AI Mobile — Engineering Contract

## Project Mission

Build a production-quality language-learning client for:

- Android
- iPhone
- iPad
- macOS

The backend is developed in a separate repository.

This repository owns only the mobile/desktop Flutter client.

Feature-first
MVVM/UDF
Pragmatic Hexagonal
Selective DDD

domain = pure Dart
design_system ↛ features
core ↛ features
presentation ↛ generated API

Riverpod
typed go_router
design-system/ source of truth
no raw design values
no automatic commits

## Source of Truth

UI/UX specification:

- `design-system/`

For normal product implementation, `design-system/` is authoritative.

`references/gramago/` is frozen forensic research only.

Do not inspect or derive implementation decisions from
`references/gramago/` during normal development unless an explicitly
documented design decision requires forensic verification.

## Technology Baseline

Use:

- Flutter stable
- modern Dart
- Riverpod for state management and dependency injection
- go_router with typed routes
- OpenAPI-generated client for backend contracts
- custom Flutter implementation of our canonical design system

Do not introduce another state-management, routing, or DI framework
without an ADR and explicit approval.

## Architecture

The project uses:

Feature-First Modular Architecture
+ MVVM / Unidirectional Data Flow
+ pragmatic Hexagonal boundaries
+ selective DDD

Do not implement textbook Clean Architecture ceremony.

Use domain and use-case layers only when actual business complexity
requires them.

## Dependency Direction

Global direction:

app
→ features
→ design_system / core

Within a sufficiently complex feature:

presentation
→ application (optional)
→ domain
← data

Rules:

- `domain` must be pure Dart.
- `domain` must not depend on Flutter, Riverpod, Dio, JSON, storage SDKs,
  generated API code, or platform plugins.
- `design_system` must never import feature code.
- `core` must never import feature code.
- presentation must never import generated API clients directly.
- generated code must never contain handwritten business logic.
- one feature must not deep-import another feature's internals.

If cross-feature behavior is required, expose an intentional public contract
or move the shared concept to the correct architectural boundary.

## Data Architecture

Repository is the source-of-truth boundary for application data.

External systems are accessed through services/adapters.

Expected flow:

View
→ ViewModel
→ Repository or UseCase
→ Repository
→ Service/Adapter
→ OpenAPI client / Storage / Platform

Generated OpenAPI code belongs under:

`lib/generated/api/`

Treat generated code as disposable output.

Never hand-edit generated files.

## Backend Authority

The backend is authoritative for server-owned business rules, including
where applicable:

- grading
- scoring
- conversation AI
- lesson completion
- entitlement
- server validation
- server-owned SRS scheduling

Do not duplicate server thresholds or business rules in the client when
the API can return the resolved semantic result.

The client owns:

- presentation
- interaction state
- navigation
- device preferences
- drafts
- adaptive layout
- safe local cache
- optimistic UI where explicitly safe

## State Management

Prefer:

- Riverpod `Notifier` for synchronous shared feature/application state
- Riverpod `AsyncNotifier` for asynchronous lifecycle-aware state
- local Flutter state for truly local ephemeral widget state
- sealed Dart state machines for finite workflow/domain states

Avoid multiple booleans representing mutually exclusive workflow states.

Prefer sealed classes and exhaustive pattern matching.

Do not use StateNotifier as the default for new code.

## Side Effects and Retry

Automatic retries are acceptable for safe/idempotent reads.

Do not automatically retry non-idempotent side effects such as:

- submitting an answer
- sending a conversation message
- creating a resource
- uploading
- purchases
- destructive mutations

Mutation retry behavior must be explicit.

## Design System

Canonical specification:

`design-system/`

Flutter implementation:

`lib/design_system/`

Expected direction:

design-system/TOKENS.json
→ generated typed Dart tokens
→ Flutter theme/primitives
→ components
→ patterns
→ feature screens

Do not parse `TOKENS.json` at runtime.

Do not hardcode design values when a canonical token exists.

Avoid raw:

- colors
- spacing
- radii
- typography values
- layout breakpoints

in feature code.

Production color profile is the default.
Fidelity mode is explicit opt-in only.

Answer palette colors must always use their canonical
background/foreground pair.

## Adaptive UI

The application is adaptive-first.

Target:

- Android phones
- iPhone
- iPad
- resizable macOS windows

Layout decisions must depend primarily on available window space,
not device identity.

Use canonical window-size classes and layout tokens.

Do not scatter checks such as:

`Platform.isMacOS`
`isTablet`
`isIPad`

for ordinary layout decisions.

Platform checks are allowed only for real platform capabilities or policy.

Interactive UI must consider:

- touch
- mouse
- trackpad
- hover
- keyboard focus
- Enter / Space activation
- Escape dismissal
- Tab traversal
- resizable windows

## Routing

Use typed go_router routes.

Avoid string route construction throughout feature code.

Navigation chrome may adapt by window size while semantic routes remain stable.

## Code Quality

Prefer:

- immutable state
- explicit types
- composition over inheritance
- small cohesive widgets
- small cohesive classes
- constructor dependency injection
- descriptive domain names
- exhaustive switches
- const where appropriate

Avoid premature generic abstractions.

Do not introduce generic classes such as:

- BaseViewModel
- BaseRepository
- BaseService
- BaseUseCase
- BaseScreen

until multiple real use cases prove the abstraction.

## Forbidden Dumping Grounds

Do not create root-level architectural dumping grounds such as:

- `utils/`
- `helpers/`
- `common/`
- `misc/`
- `managers/`

Place code according to ownership:

- business capability → feature
- reusable visual system → design_system
- cross-cutting technical infrastructure → core

## Dependencies

Do not add a package merely because it is popular or convenient.

Before adding a dependency, establish:

1. the concrete requirement,
2. why Flutter/Dart or existing dependencies do not solve it,
3. maintenance/platform implications.

Do not introduce without explicit architectural justification:

- GetX
- Bloc
- GetIt
- Injectable
- another router
- another DI system
- another HTTP stack
- a local database

## Testing

Architecture must remain testable with fakes.

Expected testing layers:

- domain unit tests
- repository/service tests
- ViewModel/provider tests
- widget tests
- design-system golden tests
- integration tests for critical user flows

Critical reusable design-system components should support visual/golden
validation across relevant size classes.

## Localization

Do not hardcode user-facing product UI strings.

Use the canonical localization system.

Backend-provided lesson/content text is not necessarily application chrome
localization.

## Security and Privacy

Never commit secrets.

Never log:

- credentials
- auth tokens
- passwords
- sensitive user content
- unnecessary personally identifiable data

Sensitive credentials belong in platform-secure storage.

## Git

Do not commit, push, rewrite history, or create tags unless the user
explicitly asks.

Do not alter unrelated staged changes.

## Change Discipline

Before changing architecture:

- inspect the existing implementation,
- preserve established boundaries,
- check relevant ADRs,
- explain why the existing approach is insufficient.

Significant architecture changes require an ADR.

Do not silently replace established project conventions.

## Definition of Done

For implementation work:

- code formats successfully
- static analysis passes
- relevant tests pass
- architecture boundaries remain valid
- no unexplained arbitrary design values are introduced
- no unrelated files are modified
- generated files are regenerated rather than manually edited

Report validation performed and any remaining limitations.
