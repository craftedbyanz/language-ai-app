# Quickstart: Validate the Grammar Vertical Slice

## Prerequisites

- FVM is installed.
- The SDK pinned in `.fvmrc` is available through `fvm install`.
- No global Flutter or Dart binary is used for project commands.
- No backend, credential, simulator service, or network connection is required for grading.

## Generate derived sources

Run from the repository root after implementation changes:

```sh
fvm dart run tool/generate_design_tokens.dart
fvm flutter gen-l10n
fvm dart run build_runner build
```

Expected result: typed design tokens, localization output, and typed route helpers are regenerated
without manual edits or unexplained drift.

## Focused automated validation

```sh
fvm flutter test test/features/grammar
fvm flutter test test/app/router/app_routes_test.dart
fvm flutter test test/design_system/reusable_exercise_components_test.dart
```

Expected result:

- Repository normalization and deterministic verdict tests pass.
- One grading case produces the identical verdict across exactly 100 consecutive repository calls.
- Exactly 100 fresh-fixture ViewModel progression runs each advance once, clear the answer, and
  return to `GrammarAnswering` at the same next index.
- The sealed workflow covers Submit, Loading, Cancel, both verdicts, Fix, minimize/reopen, non-final
  Next, and final return.
- Typed Grammar locations and route transitions pass.
- Reusable component states remain canonical and accessible.

Run focused goldens only when shared visual output changed:

```sh
fvm flutter test test/design_system/vertical_slice_golden_test.dart
```

Inspect any intentional new or changed baseline visually before accepting it. Do not blanket-update
goldens to silence failures.

## Writing regression verification

```sh
git diff --exit-code -- lib/features/writing
fvm flutter test test/features/writing
fvm flutter test test/design_system/vertical_slice_golden_test.dart
```

Expected result: Writing source is untouched; its repository, ViewModel, Home-to-Writing flow,
feedback variants, and existing golden renderings remain unchanged.

## Manual acceptance journey

Run the app on an available target, for example macOS:

```sh
fvm flutter run -t lib/main_dev.dart -d macos
```

Validate in both English and Vietnamese product locales:

1. Confirm the Grammar card uses its localized active `Explore` action and opens Grammar from Home;
   confirm Writing still opens and behaves as before and out-of-scope modes remain disabled.
2. Choose a Grammar topic and a Grammar lesson; confirm the canonical lesson carousel exposes
   `PagerDots/Lesson` position feedback.
3. Confirm the English incorrect sentence and visible rewrite instruction appear.
4. Verify whitespace-only input cannot be submitted.
5. Submit an accepted correction; verify Loading remains for at least 300 ms, then correct feedback
   appears with a recap, disabled analysis link, localized unavailable explanation, and Next.
6. Submit an incorrect correction; verify authored correction, explanation, tips, Fix, and Next.
7. Choose Fix; verify the exact response remains and focus returns to the answer field.
8. Cancel during Loading; verify no late verdict appears and progress does not change.
9. Minimize feedback and reopen it from the hint area; verify no new grading occurs.
10. Choose Next after either verdict; verify exactly one-step progress and a cleared answer.
11. Choose Next on the final sentence; verify return to the Grammar Lesson List with no completion UI,
    reward, or persisted completion state.
12. Open routes or inject fixtures with unknown topic, lesson, and exercise identities; verify the
    canonical localized unavailable state and safe Back action, with no fallback content, grading, or
    progress mutation.

Repeat the journey at representative widths:

- Compact: approximately 390 logical pixels.
- Regular: approximately 788 logical pixels.
- Wide: approximately 1200 logical pixels or a resizable macOS window above the wide breakpoint.

Also check a short window and large text. Expect no overflow, clipped labels, hidden primary actions,
lost focus order, or dependence on color alone.

## Architecture and complete CI gate

```sh
fvm dart format --output=none --set-exit-if-changed lib test integration_test tool
fvm flutter analyze
fvm dart run tool/check_architecture.dart
fvm dart run tool/verify_design_tokens.dart
sh tool/ci.sh
```

Expected result: formatting, analysis, architecture boundaries, token freshness, generated-file
drift checks, all tests, and existing regression coverage pass with no new dependency.

## Platform validation matrix

Record build and runtime separately as `PASS`, `FAIL`, or `UNVERIFIED`. A missing local runtime is
`UNVERIFIED`, never `PASS`, and does not by itself block local implementation completion.

| Target | Required command/evidence when available |
|---|---|
| macOS build | `fvm flutter build macos --debug -t lib/main_dev.dart` |
| macOS runtime and Grammar flow | `fvm flutter test integration_test/bootstrap_test.dart -d macos --no-pub` plus the Grammar-flow smoke |
| Android build | `fvm flutter build apk --debug --no-pub -t lib/main_dev.dart` |
| Android runtime | Run bootstrap/Grammar smoke with an available emulator or device ID |
| iPhone/iOS and iPadOS build | `fvm flutter build ios --debug --no-codesign --no-pub -t lib/main_dev.dart` |
| iPhone runtime | Run bootstrap/Grammar smoke with an available iPhone simulator or device ID |
| iPadOS runtime | Run bootstrap/Grammar smoke with an available iPad simulator or device ID |

The unsigned universal iOS build is shared build evidence for iPhone/iOS and iPadOS; their runtime
statuses remain separate.
