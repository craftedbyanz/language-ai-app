# Quickstart: Grammar Fidelity Alignment

## Automated validation

```sh
fvm dart format --output=none --set-exit-if-changed lib test
fvm flutter analyze
fvm flutter test test/design_system/reusable_exercise_components_test.dart
fvm flutter test test/features/grammar
fvm flutter test test/features/writing
fvm flutter test
```

Run golden tests intentionally after reviewing the shared Home mode-card change. Do not blindly rebaseline unrelated images.

## Manual journey

1. Verify the Home Grammar mode card anatomy and one-target semantics.
2. Open Grammar, change filters, and verify topic context/count plus adaptive grid.
3. Select a topic and navigate the lesson carousel with pointer and keyboard.
4. Open the primary lesson and verify 20 truthful progress steps.
5. Check empty, focused, and filled answer states at 788×1083 logical pixels.
6. Submit an incorrect response; inspect word-level correction, Fix, Next, minimize, and reopen.
7. Submit an accepted response; inspect compact correct feedback and Next.
8. Repeat critical actions in Vietnamese chrome and with keyboard-only navigation.

## Adaptive matrix

- compact phone width;
- regular 788×1083 reference viewport;
- wide desktop/tablet width;
- short height with keyboard inset;
- 200% text scale.

For each, record clipping, overflow, unreachable actions, focus order, and semantic naming. Document all intentional content and branding divergences.

## Validation record — 2026-10-12

Automated baseline before implementation was green for the focused reusable
exercise test. After implementation:

- formatter: PASS (85 files checked, no changes required);
- generated design tokens: PASS/current;
- architecture boundary check: PASS;
- Flutter analyzer: PASS, zero issues;
- full Flutter test suite: PASS, 91 tests;
- `git diff --check`: PASS;
- `tool/ci.sh`: generated localization/build steps completed, then its
  clean-tree drift guard correctly stopped on this feature's intentional,
  uncommitted generated localization changes. The equivalent generation,
  format, analysis, architecture, and full-test checks were run separately.

The three Grammar golden baselines changed intentionally:
`grammar_components_regular.png`, `grammar_feedback_regular.png`, and
`grammar_exercise_compact.png`. Writing and generic surface goldens were not
rebaselined.

## Authorized reference review

| State | Result | Notes |
|---|---|---|
| S001 Home | PASS with intentional divergence | Category/title/index/description/action hierarchy aligned. Product branding, copy, and limited mode scope retained. |
| S008 Topic Picker | PASS | Two-tone hero, filters, section/count context, adaptive grid, and varied icons verified. Paywall/AI creation intentionally omitted. |
| S009 Lesson List | PASS | Centered collection context, level, lesson anatomy, owned decorative illustration, CTA, and pager semantics verified. |
| S058 Empty editor | PASS with intentional divergence | Truthful 20-step progress and dominant prompt/answer workspace verified. Product keeps English sentence correction instead of translation. |
| S059 Filled editor | PASS | Centered response, blue canonical answer pair, hints, and trailing submit remain visible/reachable. |
| S060 Incorrect feedback | PASS | Context remains visible; retained/removed/inserted words and punctuation use color, strike/underline, and localized semantics. |
| S061 Correct feedback | PASS | Compact anchored verdict, answer recap, unavailable-analysis reason, minimize/close, and Next verified. |

Live macOS review covered Home → Topic Picker → Lesson List → empty exercise →
filled incorrect feedback at a short desktop window. Widget/golden coverage adds
compact 390×844, regular 788-wide, wide 1200-wide, keyboard/pointer, bilingual,
short-height keyboard-inset, and 200% text cases. No clipping or unreachable
primary action was observed.
