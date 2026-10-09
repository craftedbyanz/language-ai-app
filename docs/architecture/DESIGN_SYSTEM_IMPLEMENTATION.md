# Design-system implementation

Pipeline: `design-system/TOKENS.json` → `tool/generate_design_tokens.dart` → typed Dart → theme/primitives → future components/patterns → features. JSON is never loaded by the running app.

Run `dart run tool/generate_design_tokens.dart`; verify with `dart run tool/verify_design_tokens.dart`. Output is committed. Generation sorts groups/keys, resolves aliases (including embedded shadow aliases), rejects missing/cyclic aliases and unknown value representations, and formats with the installed Dart SDK. CI pins the SDK for stable formatting.

The generator emits color, feature identity, feedback, grade/CEFR colors, control state, space, radius, typography, shadow, glass, icon, control, layout, accessibility, focus, motion, state and answer-palette groups. Feature-named color tokens are design metadata, not implemented product features. `score.thresholds` is resolved/validated but deliberately not exported: AGENTS.md gives scoring rules to the backend. Score colors remain available.

Numeric lengths/ratios are doubles; motion durations are Duration; ease-out is Curve; colors are Color; typography is TextStyle with px line height converted to Flutter's ratio and em letter spacing converted to logical pixels. Font weight is validated. Shadow geometry becomes BoxShadow. Typography `ref`, confidence/evidence/notes remain source metadata. The CSS system-font stack is preserved as metadata, never passed as a Flutter font name; the theme uses Flutter's platform system font (DD-08 default). Micro-label transform is emitted separately; a future primitive must preserve the original semantic label when uppercasing visually.

Production is the default AccessibleTokens profile. Fidelity is explicit through ColorProfile and requires the owner decision described by DD-22; no entrypoint enables it. Only the canonical fidelityOverrides change. AnswerPaletteTokens exposes immutable background/foreground pairs; both profiles share them. White answer surfaces will require canonical hairline shadow when implemented.

AppTheme supplies canonical color roles and typography plus DesignTokensTheme extension access. Material is infrastructure only. New controls must supply canonical styling rather than inherit unreviewed Material defaults. AppSurface uses surface/card/hairline/spacing tokens. No full component library, dark mode or product screen exists.

Widget Previewer is supported by Flutter 3.47.3. Run `flutter widget-preview start`; `foundationPreview` demonstrates the canonical theme and surface, without dart:io, plugins or feature state. Fixture strings belong only in previews/tests. See the [official preview conventions](https://docs.flutter.dev/tools/widget-previewer).

Defaults used: DD-08 typography and DD-12 responsive/safe-area behavior, commented at use. DD-10 motion values are generated but no custom animation is introduced. No arbitrary visual exceptions or canonical spec changes were needed.
