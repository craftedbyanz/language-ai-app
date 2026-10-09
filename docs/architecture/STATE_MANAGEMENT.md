# State and dependency injection

Riverpod is the root DI/state mechanism. `createAppRoot` accepts AppConfig, AppLogger and Analytics and creates ProviderScope overrides. Tests exercise the same root as production. No global mutable provider container is retained.

`appConfigProvider` must be overridden by bootstrap. Logging and analytics default to no-op implementations. `appRouterProvider` constructs and disposes GoRouter with provider lifecycle. No feature state or fake ViewModel is needed for the static boot page.

For future features, synchronous shared state uses Notifier; async lifecycle-aware state uses AsyncNotifier. Views dispatch intent and render immutable state. Ephemeral widget state stays local. Finite workflows use sealed states and exhaustive switches. StateNotifier is not the default.

Riverpod 3 automatic retry is disabled at the root. An idempotent read may opt into a bounded policy at its provider; a mutation must require explicit user retry. Do not place non-idempotent side effects in automatically repeated provider builds.

Root error handlers emit closed event names only, never raw errors, stack payloads or user content. The installer returns a restoration callback for tests/embedded hosts. The no-op logger intentionally provides no crash reporting; replace it with an audited adapter only when needed.
