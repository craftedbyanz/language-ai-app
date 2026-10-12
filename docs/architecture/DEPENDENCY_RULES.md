# Dependency rules

`app → features → lingua_design_system / core`. The app may compose `lingua_auth` and `lingua_networking`; networking never imports auth. Core never depends on app, features or the design system. Design system never depends on app, features, auth, networking or API output. Features never depend on app.

For a complex feature: presentation → optional application → domain ← data. Domain is pure Dart and owns repository contracts only when business complexity requires it. Result/AppFailure are pure core contracts. Presentation cannot import generated API clients. Another feature may import only `lib/features/<name>/<name>.dart`, an intentional public barrel; review that barrel's exports.

Run `fvm dart run tool/check_architecture.dart`. It checks import/export/part directives, relative and package paths, conditional branches, pure-domain dependencies, internal package boundaries, generated-token provenance and forbidden generic base classes/folders. It reads the root and workspace-package `lib/` trees. Domain imports use a small Dart SDK allowlist plus their own domain and pure core outcome types. Extend deliberately for a real pure dependency.

This lightweight scanner is not a full Dart parser. The analyzer catches syntax/type errors; code review still checks cycles, transitive API leaks through barrels, handwritten logic inside generated files, domain JSON usage and ownership. Generated headers alone do not establish provenance: deterministic regeneration in CI verifies the outputs we currently generate.

No service locator, event bus, alternate router/state framework, database or generic repository framework is present.
