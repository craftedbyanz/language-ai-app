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

These are Dart environments, not native installable flavors. They currently share `com.anznguyen.hifive` on all platforms and cannot be installed side by side. Native suffixes/signing variants need a later requirement. Flutter's auto-selected local iOS signing team was removed from the new scaffold; developers supply signing locally when needed.

Development initializes a named `hifive-development` Firebase app for
`hifive-dev-8189c` using FlutterFire-generated options. The composition root
injects that app; the Auth provider explicitly uses it. Staging/production remain
local previews, without a configured Firebase provider or dev fallback in Dart.
Native generated Firebase resources currently describe dev for all native build
configurations. This is not a production Firebase setup: separate resources and
environment projects before release. See [ADR-0009](../adr/0009-firebase-development-bootstrap.md)
and the [setup guide](../firebase-setup.vi.md).

Runtime dependencies include flutter_riverpod (DI/state lifecycle), go_router
(typed routing), Flutter localization SDK and intl, firebase_core (native Firebase
initialization), and firebase_auth (SDK-owned sessions). Firebase stays in app/core
infrastructure; domain and shared design-system packages remain independent of it.
Dev dependencies include go_router_builder/build_runner, flutter_lints,
flutter_test and integration_test. No alternative routing/DI system is introduced.
