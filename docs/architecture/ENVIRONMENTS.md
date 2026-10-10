# Environments and toolchain

Baseline: Flutter stable 3.47.3 / Dart 3.13.3 is pinned by `.fvmrc`;
`pubspec.lock` pins resolved packages. Install FVM and run `fvm install` once to
create `.fvm/flutter_sdk`. Do not depend on a global Flutter/Dart installation.

```sh
fvm flutter run -t lib/main_dev.dart -d macos
fvm flutter run -t lib/main_staging.dart -d macos
fvm flutter run -t lib/main_prod.dart -d macos
```

Each entrypoint selects AppEnvironment and shares bootstrap. `main.dart` defaults to production. AppConfig is immutable and injected. FeatureFlags exposes only paywallEnabled=false and srsSwipeEnabled=false; no environment bypasses those approved v1 decisions. There are no secrets, invented API URLs or environment business checks.

These are Dart environments, not native installable flavors. They currently share `com.anznguyen.lingua` on all platforms and cannot be installed side by side. Native suffixes/signing variants need a later requirement. Flutter's auto-selected local iOS signing team was removed from the new scaffold; developers supply signing locally when needed.

Runtime dependencies: flutter_riverpod (required DI/state lifecycle), go_router (required typed routing runtime), Flutter localization SDK and intl (gen_l10n output imports it). Dev dependencies: go_router_builder/build_runner for typed route generation, flutter_lints, SDK flutter_test and integration_test. Flutter primitives cannot replace the mandated Riverpod/router; built-in ARB tools avoid another localization framework. No vendor/native-service package is introduced.
