<!--
Sync Impact Report
- Version change: unratified template -> 1.0.0
- Modified principles:
  - Placeholder Principle 1 -> I. Flutter Client Scope and Pinned Toolchain
  - Placeholder Principle 2 -> II. Feature-First MVVM/UDF Architecture
  - Placeholder Principle 3 -> III. Enforced Dependency Boundaries
  - Placeholder Principle 4 -> IV. Riverpod State and Typed Navigation
  - Placeholder Principle 5 -> V. Canonical Design System and Adaptive UI
- Added principles:
  - VI. Deliberate Simplicity and Dependencies
  - VII. Verifiable Quality and User-Controlled Git
- Added sections:
  - Product and Technical Constraints
  - Development Workflow and Quality Gates
- Removed sections: none; placeholder sections were resolved in place
- Follow-up TODOs: none
-->
# Language AI Mobile Constitution

## Core Principles

### I. Flutter Client Scope and Pinned Toolchain
This repository MUST contain only the Flutter client for Android, iPhone, iPad, and native macOS.
Backend implementation belongs in its separate repository. Development and validation MUST use the
Flutter stable version pinned by `.fvmrc` through `fvm flutter` and `fvm dart`; contributors MUST
NOT rely on a global Flutter or Dart installation or change the pin without explicit approval.

Rationale: a single client boundary and reproducible SDK eliminate backend duplication and
toolchain-dependent behavior across supported platforms.

### II. Feature-First MVVM/UDF Architecture
Product capabilities MUST be organized as feature-first vertical slices using MVVM and
unidirectional data flow. Hexagonal boundaries MUST be introduced pragmatically around real
external systems. Domain models and application/use-case layers MUST be added only when business
complexity or meaningful orchestration requires them; selective DDD MUST NOT become textbook Clean
Architecture ceremony. Views dispatch intent, ViewModels expose immutable state, and repositories
form the application data source-of-truth boundary.

Rationale: ownership remains clear while simple features stay small and complex behavior remains
testable.

### III. Enforced Dependency Boundaries
The global dependency direction MUST remain `app -> features -> design_system / core`. `core` and
`design_system` MUST NOT import features, and features MUST NOT import `app`. Within a complex
feature, dependencies MUST follow `presentation -> application (optional) -> domain <- data`.
Domain code MUST be pure Dart and MUST NOT depend on Flutter, Riverpod, Dio, JSON, storage SDKs,
generated API code, or platform plugins. Presentation MUST NOT import generated API clients.
Generated OpenAPI output under `lib/generated/api/` MUST remain disposable and contain no
handwritten business logic. Cross-feature access MUST use an intentional public contract rather
than deep imports.

Rationale: mechanically checkable dependency direction protects domain portability, feature
ownership, and replaceable external adapters.

### IV. Riverpod State and Typed Navigation
Riverpod MUST be the state-management and dependency-injection mechanism. Shared synchronous state
MUST use `Notifier`, shared asynchronous lifecycle-aware state MUST use `AsyncNotifier`, and truly
local ephemeral widget state MUST remain local. Finite workflows MUST use sealed states rather than
mutually exclusive booleans. Automatic retries MAY be enabled only for safe, idempotent reads;
mutation retry MUST require explicit intent. Navigation MUST use typed `go_router` routes, and
feature code MUST NOT construct route strings. Semantic routes MUST remain independent of adaptive
navigation chrome.

Rationale: one lifecycle-aware state model and typed semantic routes keep flows deterministic,
testable, and resilient to layout changes.

### V. Canonical Design System and Adaptive UI
`design-system/` MUST be the canonical UI/UX source of truth. Its precedence rules and
`IMPLEMENTATION_CONTRACT.md` are binding. `references/gramago/` MUST remain frozen forensic evidence
and MUST NOT inform normal implementation unless a documented design decision explicitly authorizes
verification. Canonical JSON tokens MUST be generated into typed Dart at build time and MUST NOT be
parsed at runtime. Features MUST NOT introduce arbitrary colors, spacing, radii, typography,
shadows, icon sizes, control dimensions, motion, or breakpoints when canonical tokens exist;
approved exceptions MUST follow the design-system contract. Answer palette background and
foreground colors MUST remain canonical pairs, and production color behavior MUST be the default.

Layouts MUST adapt primarily to available window width through canonical compact, regular, and wide
size classes rather than device identity. Platform checks are permitted only for actual platform
capability or policy. Interactive UI MUST support the applicable touch, mouse, trackpad, hover,
keyboard, focus, dismissal, traversal, semantics, contrast, and resizable-window requirements in
the canonical design system.

Rationale: one traceable visual contract produces consistent, accessible behavior across phones,
tablets, and desktop windows.

### VI. Deliberate Simplicity and Dependencies
Implementations MUST prefer immutable state, explicit types, composition, small cohesive units,
constructor injection, exhaustive switches, and `const` where appropriate. Generic `Base*`
architectures, root-level dumping grounds, empty layers, alternate state/DI/routing frameworks,
HTTP stacks, databases, and other infrastructure MUST NOT be introduced before multiple real use
cases or a concrete requirement justify them. Every new package MUST document the requirement, why
Flutter/Dart or existing dependencies are insufficient, and its maintenance and platform impact.
Significant architecture changes MUST have an accepted ADR and explicit approval.

Rationale: the repository pays complexity and maintenance costs only when demonstrated product
needs justify them.

### VII. Verifiable Quality and User-Controlled Git
Every implementation change MUST format successfully, pass static analysis, preserve architecture
checks, pass generated-token verification, and pass relevant automated tests. Generated artifacts
MUST be regenerated rather than hand-edited, and their freshness MUST be verified. Tests MUST use
fakes at architectural boundaries and cover the layer appropriate to actual complexity, including
domain, repository/service, provider/ViewModel, widget, golden, and critical integration coverage
where those layers exist. Reusable design-system components MUST receive visual validation at
relevant size classes. Validation performed and any remaining limitations MUST be reported.

Commits, pushes, history rewrites, and tags MUST remain user-controlled and MUST NOT occur without
an explicit user request. Unrelated changes, including staged changes, MUST remain untouched.

Rationale: repeatable evidence establishes readiness while preserving the user's authority over
repository history.

## Product and Technical Constraints

- The backend MUST remain authoritative for server-owned grading, scoring, conversation AI, lesson
  completion, entitlement, validation, and SRS scheduling. The client MUST NOT duplicate server
  thresholds or rules when the API can return a resolved semantic result.
- External systems MUST be isolated behind services/adapters and repositories. A real OpenAPI
  contract MUST precede generated client integration; presentation MUST receive mapped application
  or domain outcomes rather than parse transport exceptions.
- User-facing application chrome MUST use the canonical localization system rather than hardcoded
  strings.
- Credentials, authentication tokens, passwords, sensitive user content, and unnecessary personal
  data MUST NOT be logged or committed. Sensitive credentials MUST use platform-secure storage when
  such a requirement exists.
- Visual changes MUST update or reconcile the canonical design-system artifacts before code, unless
  the code change only corrects an existing deviation. Unresolved design decisions MUST use their
  documented defaults and MUST NOT be silently invented.
- Optional or deferred capabilities, infrastructure, and persistence MUST remain unbuilt until an
  approved requirement authorizes them.

## Development Workflow and Quality Gates

1. Before changing architecture, contributors MUST inspect the current implementation, relevant
   architecture documentation, and accepted ADRs. They MUST explain why the established approach is
   insufficient and record significant decisions in a new or amended ADR.
2. Before UI work, contributors MUST consult `design-system/IMPLEMENTATION_CONTRACT.md` and the
   applicable canonical token, component, template, interaction, accessibility, responsive, and
   decision documents. Conflicts MUST be reconciled in the design system rather than silently
   resolved in feature code.
3. Implementation MUST follow repository ownership and dependency directions. Generated API and
   token outputs MUST be produced by their generators, never manually edited.
4. Validation MUST run through FVM. The complete local gate is `sh tool/ci.sh`; targeted work MAY run
   narrower checks during development, but the final result MUST include formatting, analysis,
   architecture checks, token freshness verification, and all relevant tests.
5. Golden updates MUST be visually inspected and MUST NOT be accepted merely to silence unexplained
   failures. Native or integration validation MUST be reported accurately without claiming
   unexecuted platforms.
6. Review MUST reject unexplained arbitrary design values, feature-to-core/design-system dependency
   inversions, presentation access to generated APIs, duplicated backend rules, unjustified
   infrastructure, hardcoded user-facing chrome, leaked sensitive data, or unrelated file changes.

## Governance

This constitution consolidates the approved engineering rules in `AGENTS.md`, `docs/architecture/`,
accepted records in `docs/adr/`, and `design-system/IMPLEMENTATION_CONTRACT.md`. Those repository
sources remain authoritative for operational detail. If Spec Kit defaults conflict with approved
repository rules, the repository rules govern. If authoritative repository sources conflict with
one another, work MUST stop at the conflicting decision boundary until the source owners reconcile
the conflict; contributors MUST NOT choose silently.

Amendments require a documented rationale, review against the authoritative sources, explicit user
approval, an updated Sync Impact Report, and a semantic version change. Backward-incompatible
principle removals or redefinitions require a MAJOR increment; new principles or materially expanded
governance require MINOR; clarifications and non-semantic refinements require PATCH. The ratification
date remains the original adoption date, while the last-amended date changes for every approved
amendment.

Every specification, plan, task list, implementation, and review MUST demonstrate compliance with
this constitution. Exceptions MUST identify the violated rule, rationale, scope, owner approval,
and intended resolution; convenience alone is not sufficient. Compliance reviews MUST include the
quality gates in this document and the more detailed checks in the authoritative repository sources.

**Version**: 1.0.0 | **Ratified**: 2026-10-10 | **Last Amended**: 2026-10-10
