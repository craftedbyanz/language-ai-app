# Architecture v1 implementation report

Validation date: 2026-10-10.

## Toolchain and identity

- Flutter 3.47.3 stable, Dart 3.13.3; the `.fvmrc`-pinned FVM SDK was used without upgrade/channel change.
- Dart package: `lingua`; organization and production app ID: `com.anznguyen` / `com.anznguyen.lingua`.
- Android, iOS/iPadOS, macOS and web hosts generated; no Windows/Linux hosts.
- Android SDK 36.0.0 and licenses available; Xcode 27.0 and CocoaPods 1.17.0 available.
- `fvm flutter doctor -v` reported missing iOS 27 simulator runtime and a GitHub network-check timeout. Commands used the project-pinned SDK through FVM; no global Flutter PATH was required.

## Delivered foundation

The [folder tree](FOLDER_STRUCTURE.md) documents all requested boundaries. Shared deterministic bootstrap supplies immutable AppConfig/FeatureFlags and Riverpod ProviderScope. No plugins need initialization. Safe root handlers accept only reviewed logger events. Runtime telemetry adapters are no-op.

Typed go_router defines only FoundationRoute and a localized unknown-route fallback. AdaptiveLayout uses available width and canonical compact/regular/wide boundaries; ContentConstraints caps the content column; AdaptiveNavigation accepts app-owned chrome without route coupling. No real navigation destinations exist.

The token generator resolves canonical aliases at build time, emits typed groups with provenance, defaults to production colors, supports explicit fidelity overrides and keeps answer color pairs together. Server-owned score thresholds are not exported. AppTheme, DesignTokensTheme, AppScaffold, AppSurface and a Widget Previewer fixture prove the pipeline. Localization uses gen_l10n with English/Vietnamese ARBs. Result/AppFailure are pure Dart sealed types. API/network/storage/platform boundaries remain documented placeholders.

Architecture checks cover dependency directions, pure domain imports, presentation/API isolation, public feature barrels, generated-token provenance and forbidden generic bases/folders. The scanner's limits and code-review responsibilities are explicit in [DEPENDENCY_RULES.md](DEPENDENCY_RULES.md).

Nine architecture guides and six accepted ADRs document implemented decisions. GitHub Actions runs `tool/ci.sh` on the pinned Flutter version. README now describes the Flutter client.

## Packages

| Package | Resolved version | Current requirement |
|---|---|---|
| flutter_riverpod | 3.4.3 | Root DI and lifecycle-aware state foundation |
| go_router | 18.0.2 | Typed-route runtime |
| flutter_localizations | SDK | Built-in localization delegates |
| intl | 0.20.3 | gen_l10n-generated imports |
| go_router_builder | 4.5.0 | Typed route helper generation |
| build_runner | 2.16.2 | Run the routing builder |
| flutter_lints | 6.0.0 | Maintainable analysis baseline |
| flutter_test / integration_test | SDK | Unit, provider, widget, golden and native smoke validation |

## Commands and results

Commands were run through the project FVM pin:

```sh
fvm flutter --version
fvm dart --version
fvm flutter doctor -v
fvm flutter create --project-name lingua --org com.anznguyen --platforms android,ios,macos --no-pub .
fvm flutter pub add flutter_riverpod go_router
fvm flutter pub add --dev go_router_builder build_runner
fvm dart run tool/generate_design_tokens.dart
fvm flutter gen-l10n
fvm dart run build_runner build
fvm dart format lib tool test integration_test
fvm flutter analyze
fvm dart run tool/check_architecture.dart
fvm dart run tool/verify_design_tokens.dart
fvm flutter test --update-goldens test/design_system/surface_golden_test.dart
sh tool/ci.sh
fvm flutter build macos --debug -t lib/main_prod.dart
fvm flutter test integration_test/bootstrap_test.dart -d macos --no-pub
fvm flutter build ios --debug --no-codesign --no-pub -t lib/main_prod.dart
fvm flutter build apk --debug --no-pub --target-platform android-arm64 -t lib/main_prod.dart
git diff --check
```

- Complete local CI script: **passed**. Format unchanged, analyzer zero issues, architecture checks passed, token verification passed and **17 tests passed**.
- Generator determinism and alias-cycle/missing-alias rejection: passed. Actual regeneration preserved the token file SHA-256. Route generation reported unchanged output; localization was regenerated.
- Three reusable surface golden baselines (compact, regular, wide): generated, visually inspected and passed normal comparison. No product UI golden was added.
- macOS debug build: passed; native bootstrap integration: **1 test passed**. The runner could not foreground the window (`open returned 1`), but connected and verified rendered localized content. Xcode also emitted the standard Flutter Assemble run-script output warning.
- iOS device debug build without signing: passed (`build/ios/iphoneos/Runner.app`). iPhone/iPad runtime interaction remains untested because no simulator runtime/device was used.
- Android APK smoke: did not complete within the 240-second budget while Gradle was running `assembleDebug`; this build invocation was stopped. No compiler error was reported before the timeout. Android SDK/Java/license checks passed, but APK and Android device validation remain outstanding.
- Hosted GitHub Actions was configured but not remotely executed; no commit or push was made.

## Review and remaining scope

No Home, Writing, auth, SRS, API integration or backend was added. Offline persistence, purchases, production telemetry/crash SDKs, HTTP stack, OpenAPI generation, product components/screens and dark mode remain deferred. Native environment flavors/side-by-side installation and release signing are deferred; the three entrypoints currently share the production app ID. Default Flutter host icons remain scaffold assets.

Canonical design-system files were not modified. The forensic archive was neither read nor modified. The pre-existing AGENTS.md edit was preserved; staging remained empty. No reset, commit, push or history modification occurred. Generated Dart was produced by its generator, never manually edited.

Final status: **READY_TO_FREEZE** for Architecture v1. Required static, generation, architecture and baseline tests pass, with macOS/iOS builds and native macOS boot verified. Android APK verification remains the toolchain limitation above; this report does not claim Android runtime or store-release validation.
