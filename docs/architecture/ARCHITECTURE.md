# Architecture v1

The repository is the `lingua` Flutter client for Android, iOS/iPadOS, web and native macOS. The application identifier is `com.anznguyen.lingua`. AGENTS.md remains the engineering authority; `design-system/` owns UI values and behavior.

There was no existing Flutter implementation to preserve: the platform/source directories were empty. This foundation introduces one localized boot placeholder, not a product feature. It establishes feature-first ownership, MVVM/UDF, pragmatic external adapters and selective domain modeling. See ADRs 0001–0006.

`main_dev`, `main_staging` and `main_prod` select immutable configuration and invoke the same bootstrap. `main.dart` delegates to production. Bootstrap installs safe error hooks and a ProviderScope. The app owns localization, the router and composition. Product features are added as vertical slices. The Pub Workspace contains `lingua_design_system` for reusable Flutter visuals, `lingua_auth` for framework-independent sessions and `lingua_networking` for Dio infrastructure. The app remains the composition root.

Do not create empty domain/application/data layers for each feature. A ViewModel calls a repository directly unless meaningful orchestration warrants a use case. Backend-owned scoring, entitlement and scheduling stay on the backend.

Start with [FOLDER_STRUCTURE.md](FOLDER_STRUCTURE.md), [DEPENDENCY_RULES.md](DEPENDENCY_RULES.md) and [TESTING_STRATEGY.md](TESTING_STRATEGY.md). See ADR-0007 for package, web and platform boundaries. The old `docs/implementation-plan.md` is explicitly superseded and is not implementation guidance.
