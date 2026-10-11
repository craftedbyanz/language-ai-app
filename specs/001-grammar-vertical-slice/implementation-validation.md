# Grammar Vertical Slice — Implementation Validation

**Date**: 2026-10-11  
**Toolchain**: FVM-pinned Flutter 3.47.3

## Automated gates

| Gate | Status | Evidence |
|---|---|---|
| Format | PASS | `fvm dart format --output=none --set-exit-if-changed lib test integration_test tool` |
| Static analysis | PASS | `fvm flutter analyze` |
| Architecture | PASS | `fvm dart run tool/check_architecture.dart` and architecture tests |
| Design tokens | PASS | Generator and `tool/verify_design_tokens.dart` |
| Generated localization/routes | PASS | `gen-l10n` and `build_runner` produced no further changes after generation |
| Unit/widget/golden tests | PASS | Complete `fvm flutter test` via `tool/ci.sh` |
| Writing regression | PASS | No diff under `lib/features/writing/`; all Writing and existing Writing golden tests pass without rebaseline |
| Grammar integration smoke | PASS (macOS) | Home → Grammar → topic → lesson → correct feedback → Next |

`tool/ci.sh` was run with a temporary Git index containing the newly generated
localization and route files. This lets its generated-output cleanliness check
compare against the intended feature result without staging, committing, or
changing the user's real Git index.

## Platform matrix

| Target | Build | Runtime smoke | Notes |
|---|---|---|---|
| macOS | PASS | PASS | Debug build and integration smoke completed. The runner reported a non-fatal foreground warning; both tests passed. |
| Android | PASS | UNVERIFIED | Debug APK built. No Android emulator/device was connected. |
| iPhone | PASS | UNVERIFIED | Unsigned iOS device build completed. The connected wireless iPhone had Developer Mode disabled, so the smoke could not launch. |
| iPad | PASS (shared iOS artifact) | UNVERIFIED | Unsigned universal iOS build completed; no iPad simulator/device was available. |

## Acceptance coverage

- Automated EN/VI checks cover non-empty Grammar chrome and confirm authored
  English learning content remains locale-invariant.
- Automated compact, regular, wide, short-height, and large-text checks pass.
- Automated flows cover cancellable Loading, correct and incorrect verdicts,
  Fix, minimize/reopen, non-final Next, final return, and invalid-ID safe Back.
- Three Grammar-only golden baselines were generated and visually inspected.
- Human linguistic-quality approval for Vietnamese remains outside the
  automated implementation gate.
- Physical Android/iPhone/iPad runtime acceptance remains unverified until an
  eligible device or simulator is available.
