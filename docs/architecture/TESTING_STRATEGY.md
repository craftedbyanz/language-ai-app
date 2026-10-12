# Testing strategy

Install FVM and run `sh tool/ci.sh`. Locally the script requires `fvm flutter` and `fvm dart`; in GitHub Actions it accepts only the explicitly configured SDK after verifying its version against `.fvmrc`. It resolves the shared workspace lockfile, checks generated-token freshness, regenerates localization/routes, checks tracked generation drift, checks formatting, analyzes, checks architecture, runs root and package tests, and builds web release output.

Current tests cover sealed outcomes, injected environments/flags, typed routing and unknown routes, safe root error hooks, localization, large text, responsive constraints, canonical breakpoint edges, alias rejection, token determinism/freshness/profile pairing, architectural violations and reusable surface goldens across compact/regular/wide widths.

Goldens use Flutter's deterministic test font and fixed Android target-platform theme on the pinned SDK. Inspect changes visually before accepting `fvm flutter test --update-goldens packages/lingua_design_system/test/surface_golden_test.dart`; never update all baselines to silence unexplained failures.

The independent production bootstrap smoke is `fvm flutter test integration_test/bootstrap_test.dart -d macos`. It exercises native startup without backend/plugins. Use Android/iOS device IDs when their toolchains are available. App Store/Play Store signing is outside this task.

Future coverage follows actual complexity: pure domain unit tests; repository/service tests with fake adapters; Notifier/AsyncNotifier tests with ProviderContainer overrides; widget tests using canonical theme/localization; component goldens for relevant sizes; integration tests for critical user flows. Prefer fakes, never real network credentials. Do not manufacture product tests before product code exists.
