# Implementation Plan: Grammar Vertical Slice

**Branch**: `001-grammar-vertical-slice` | **Date**: 2026-10-10 | **Spec**:
[spec.md](spec.md)

**Input**: Feature specification from `specs/001-grammar-vertical-slice/spec.md`

## Summary

Add an independent Grammar vertical slice from Home through topic selection, lesson selection,
sentence correction, deterministic local feedback, and progression. The slice follows the existing
feature-first MVVM/UDF shape: pure Grammar domain entities and repository contract, an in-memory
development repository, a Riverpod `Notifier` with a sealed workflow state, Grammar presentation,
and app-owned typed routes. It reuses the canonical design-system components and extends only
missing reusable states in a backward-compatible way. No Grammar code imports Writing, no generic
Exercise domain layer is introduced, and production grading remains backend-owned.

## Technical Context

**Language/Version**: Dart 3.13.3 and Flutter stable 3.47.3, pinned by `.fvmrc`

**Primary Dependencies**: Flutter SDK, `flutter_riverpod` 3.4.3, `go_router` 18.0.2,
`flutter_localizations`, and `intl`; existing build tooling only

**Storage**: Immutable in-memory Grammar catalog and session-only exercise state; no database,
filesystem persistence, or secure storage

**Testing**: `flutter_test`, Riverpod `ProviderContainer` overrides, widget tests, focused golden
tests for reusable design-system changes, the architecture checker, and the existing integration
smoke test

**Target Platform**: Android, iPhone, iPad, and native macOS

**Project Type**: Adaptive Flutter mobile/desktop client

**Performance Goals**: Deterministic grading over the small local catalog; one result per submission;
Loading remains visible for the specified minimum 300 ms without blocking input recovery after
Cancel; interactions remain responsive at canonical compact, regular, and wide widths

**Constraints**: No network or AI grading, no new packages, no persistence, no completion UI,
English lesson content with EN/VI product chrome, no arbitrary visual values, no Writing source
changes, and all Flutter/Dart commands through FVM

**Scale/Scope**: One Home entry, one Grammar picker, one Grammar lesson list, one exercise workflow,
and a curated catalog with enough non-final and final sentences to validate progression

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### Pre-design gate

| Gate | Result | Evidence |
|---|---|---|
| Flutter client scope and pinned toolchain | PASS | Client-only change; commands use `.fvmrc` through FVM. |
| Feature-first MVVM/UDF | PASS | New code is owned by `features/grammar`; View dispatches intent to a `Notifier`. |
| Pure domain and dependency direction | PASS | Grammar domain is pure Dart; presentation depends inward; no generated API imports. |
| Riverpod and typed routing | PASS | Existing Riverpod and typed `go_router` conventions are extended without alternatives. |
| Canonical design system and adaptive UI | PASS | Existing components/tokens/templates remain authoritative; no device branching. |
| Deliberate simplicity | PASS | No use-case layer, generic `Base*`, shared Exercise domain, database, or new dependency. |
| Verifiable quality and user-controlled Git | PASS | Layered tests and full CI are planned; no commit or history operation is included. |
| Backend authority | PASS | In-memory grading is explicitly a deterministic development adapter only. |

Research may proceed. No gate requires an exception or ADR.

### Post-design gate

| Gate | Result | Design confirmation |
|---|---|---|
| Feature isolation | PASS | Grammar has its own entities, repository, state, copy, screens, and intentional public barrel. |
| No cross-feature internals | PASS | App composition imports only Grammar's barrel; Grammar imports no Writing path. `GrammarCopy` is exported intentionally because app-owned localization composition must supply localized screen input without the feature importing generated localization. |
| Repository boundary | PASS | Browse data and grading are accessed through `GrammarRepository` providers. |
| State correctness | PASS | Sealed states cover answering, submitting, visible feedback, minimized feedback, and finish. |
| Design-system source of truth | PASS | Required component gaps are reconciled in canonical docs/tokens before reusable code changes. |
| No arbitrary values | PASS | Layout uses existing tokens; the approved 300 ms dwell becomes a canonical generated token. |
| Writing preservation | PASS | Shared APIs are additive/default-preserving; Writing sources remain untouched and tested. |
| Production boundary | PASS | Contract documents state that a future production adapter consumes backend verdicts. |

Phase 1 design passes all constitution gates. Complexity tracking is not required.

## Project Structure

### Documentation (this feature)

```text
specs/001-grammar-vertical-slice/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── grammar-feature-contract.md
└── tasks.md                         # Created later by $speckit-tasks
```

### Source Code (repository root)

```text
lib/
├── app/router/
│   ├── app_routes.dart              # Compose copy and declare typed Grammar routes
│   └── app_routes.g.dart            # Regenerated; never hand-edited
├── design_system/
│   ├── components/
│   │   ├── browse_components.dart   # Mode-aware hero plus required canonical EmptyState/PagerDots
│   │   ├── exercise_components.dart # Optional instruction/focus/last-feedback affordances
│   │   └── feedback_sheet.dart      # Disabled analysis and minimize callbacks
│   ├── patterns/exercise_template.dart
│   └── tokens/generated/design_tokens.dart
├── features/
│   ├── home/presentation/home_dashboard_screen.dart
│   ├── grammar/
│   │   ├── grammar.dart              # Public screens plus intentional GrammarCopy input contract
│   │   ├── domain/
│   │   │   ├── entities/grammar_content.dart
│   │   │   └── repositories/grammar_repository.dart
│   │   ├── data/repositories/in_memory_grammar_repository.dart
│   │   └── presentation/
│   │       ├── grammar_copy.dart
│   │       ├── providers/grammar_providers.dart
│   │       ├── state/grammar_exercise_state.dart
│   │       ├── view_models/grammar_exercise_view_model.dart
│   │       └── screens/
│   │           ├── grammar_topic_picker_screen.dart
│   │           ├── grammar_lesson_list_screen.dart
│   │           └── grammar_exercise_screen.dart
│   └── writing/                      # No source changes
└── l10n/
    ├── app_en.arb
    └── app_vi.arb

design-system/
├── TOKENS.json                       # Canonical approved feedback dwell token
├── COMPONENTS.md                     # Reconcile reusable state/API behavior first
├── COMPONENT_VARIANTS.md
└── DESIGN_DECISIONS.md               # Record clarified loading/analysis behavior

test/
├── app/router/app_routes_test.dart
├── design_system/
│   ├── reusable_exercise_components_test.dart
│   └── vertical_slice_golden_test.dart
└── features/
    ├── grammar/
    │   ├── in_memory_grammar_repository_test.dart
    │   ├── grammar_exercise_view_model_test.dart
    │   ├── grammar_flow_test.dart
    │   └── grammar_adaptive_localization_test.dart
    └── writing/                       # Existing regression suite; no edits required
```

**Structure Decision**: Use one independent feature-first Grammar slice. Mirror useful ownership
patterns from Writing, but do not import or refactor Writing internals and do not create a shared
Exercise domain/application abstraction. The app owns route and localization composition;
`design_system` owns reusable visuals only. App code imports Grammar only through
`package:lingua/features/grammar/grammar.dart`. `GrammarCopy` is part of that intentional public
screen-input contract—not a generally reusable presentation type—because app composition owns
generated localization while Grammar must not import app-generated localization classes.

## Design Decisions

### Reusable design-system surface

Reuse `ModeCard`, `TopicCard`, `LessonCard/Grammar`, `ProgressStepper/Grammar`,
`SourceTextCard/Sentence`, `AnswerInput` with the canonical blue pair, `SubmitButton`, `HintChipBar`,
`ExerciseTemplate`, and the three Grammar feedback states. Make only these additive reusable changes:

1. Give `SectionHeader` a token-safe mode variant so Grammar uses the canonical Grammar accent while
   Writing's default rendering remains unchanged.
2. Add a localized instruction/supporting-text slot to `SourceTextCard/Sentence` rather than creating
   a Grammar-only prompt component.
3. Extend `HintChipBar` with an optional “show last feedback” affordance controlled by feature state.
4. Allow `FeedbackSheet/GrammarCorrect` to render its analysis link disabled with a localized
   unavailable explanation, and expose an optional minimize callback for the existing sheet family.
5. Allow `AnswerInput` to receive a focus handle so Fix restores focus without a feature-specific
   input component.
6. Implement the already-canonical reusable `EmptyState` and the required `PagerDots/Lesson` for the
   horizontal carousel mandated by canonical `LessonListTemplate`; neither may be copied into
   Grammar.
7. Apply canonical sheet width/height constraints without changing normal Writing rendering. Shared
   changes must keep current constructor defaults and existing Writing goldens stable.

These are mandatory shared capabilities, not optional feature conveniences. Their APIs remain
visual/interaction contracts driven by supplied data and callbacks; they must not accept Grammar
entities, repository types, grading rules, or other feature-owned semantics. Grammar must compose
them directly rather than introduce visual copies, behavior-reproducing wrappers, or forks.

Before visual/API changes, reconcile `COMPONENTS.md`, `COMPONENT_VARIANTS.md`, and the applicable
design-decision entries. Add the approved 300 ms minimum feedback-loading duration to `TOKENS.json`
as the named `motion.feedbackMinimumDwell` token and regenerate typed tokens rather than hard-coding
it in feature code. T001 reconciles every component/interaction contract gap listed above before the
dependent Flutter API changes; T002 establishes the token before any feature consumes it.

### Grammar-specific code

Grammar owns its catalog entities, English authored content, repository contract and in-memory
adapter, workflow states, providers, ViewModel, localized-copy data object, and three screens. Browse
screens obtain catalog data from `grammarRepositoryProvider`; they do not instantiate the concrete
repository. No application/use-case layer is warranted for this local orchestration.

Localization ownership is field-specific. Page/navigation/action labels, empty/error/unavailable
messages, feedback chrome, progress/semantic labels, and UI taxonomy/category labels are app chrome
supplied through `GrammarCopy`. Topic titles, lesson titles/descriptions, source sentences, accepted
answers, corrections, hints, explanations, and tips are deterministic English authored learning
content in the repository and are not duplicated into ARB files.

`InMemoryGrammarRepository` is a mock/development adapter. It normalizes only case and insignificant
whitespace, compares against authored accepted full-sentence corrections, and returns authored
correction/explanation/tips. Its documentation and contract must state that production grading is
replaced by a backend adapter and that the client must not promote these rules into server policy.
It performs no Unicode canonical-equivalence transform; canonically distinct code-point sequences
match only when the authored alternatives make them equivalent after the stated case/whitespace
rules.

The immutable in-memory adapter has no expected external failure source, but the repository boundary
must remain failure-testable through fakes. Unexpected catalog failures render canonical
`EmptyState/Error` in the failed browse region with explicit Retry and safe Back where applicable.
Unexpected grading failures transition from Loading to a canonical in-sheet `InlineError` with
explicit Retry and Cancel, retaining the exact response and current progress. There is no automatic
mutation retry, fabricated fallback content, verdict, or progression.

### State machine

```text
GrammarAnswering(answer, optional last verdict)
  ├─ answerChanged ────────────────────────────────> GrammarAnswering
  └─ submit(nonblank) ─────────────────────────────> GrammarSubmitting(request id)

GrammarSubmitting
  ├─ Cancel ───────────────────────────────────────> GrammarAnswering(same answer)
  ├─ valid correct result + minimum dwell ─────────> GrammarFeedbackCorrect
  ├─ valid incorrect result + minimum dwell ───────> GrammarFeedbackIncorrect
  └─ repository failure ───────────────────────────> GrammarFailure(same answer/progress)

GrammarFailure
  ├─ Retry(explicit) ───────────────────────────────> GrammarSubmitting(new request id)
  └─ Cancel ────────────────────────────────────────> GrammarAnswering(same answer)

GrammarFeedbackIncorrect
  ├─ Fix ──────────────────────────────────────────> GrammarAnswering(same answer)
  ├─ minimize/close ───────────────────────────────> GrammarFeedbackMinimized
  └─ Next(non-final) ──────────────────────────────> GrammarAnswering(next, empty)

GrammarFeedbackCorrect
  ├─ minimize/close ───────────────────────────────> GrammarFeedbackMinimized
  └─ Next(non-final) ──────────────────────────────> GrammarAnswering(next, empty)

GrammarFeedbackMinimized
  └─ show last feedback ───────────────────────────> prior correct/incorrect feedback

Either visible feedback
  └─ Next(final) ──────────────────────────────────> GrammarFinished

Invalid topic, lesson, or exercise identity
  └─ validation failure ───────────────────────────> GrammarUnavailable(no progress mutation)
```

The ViewModel runs repository grading and the canonical 300 ms minimum dwell concurrently. A request
identity invalidates late completion after Cancel and prevents duplicate submit/Next transitions.
`GrammarFinished` is a one-shot presentation outcome; the screen/app callback performs typed
navigation and renders no completion UI.

`GrammarUnavailable` is a non-grading terminal presentation state for invalid route/catalog
identity. Repository lookups never substitute fallback content; route screens own the canonical
localized unavailable UI and safe Back action, while the ViewModel refuses to initialize or grade an
unknown exercise and leaves progress untouched.

Focus follows the canonical accessibility contract. Opening Loading or verdict feedback moves focus
into the sheet and announces its title/state; replacing Loading with a verdict announces the result.
Cancel and ordinary feedback dismissal return focus to the action that opened the sheet, Fix returns
focus to `AnswerInput`, reopening feedback returns focus into that sheet and subsequent dismissal to
the `HintChipBar` trigger, non-final Next focuses the cleared next `AnswerInput`, and final Next moves
focus to the Grammar Lesson List heading. A disabled AI-analysis action remains in semantic reading
order with its localized reason but is omitted from action focus/activation order.

### Routing

Add app-owned typed routes at `/grammar`, `/grammar/:topicId`, and
`/grammar/:topicId/:lessonId`. Home receives a new `onGrammarPressed` callback for the existing
Grammar `ModeCard`; the Writing callback and route remain unchanged. Topic and lesson selection use
typed pushes. Final Next uses the typed Grammar lesson route, so direct-linked exercises also return
to the correct lesson list without string construction.

The Home Grammar card changes from unavailable to canonical `ModeCard/Grammar` Active behavior. It
uses the existing localized `grammar`, `grammarDescription`, `learningModes`, and `explore` values,
canonical index `02`, and canonical Grammar fill/foreground. `ModeCard` has no icon slot, so no icon
is invented. Writing remains byte-for-byte behaviorally unchanged, while Conversation and every
other out-of-scope mode retain their disabled localized “coming soon” state.

An unknown `topicId` is owned by `GrammarLessonListScreen`; an unknown or topic-mismatched `lessonId`
is owned by `GrammarExerciseScreen` route initialization; and an unknown internal `exerciseId` is
rejected by the repository/ViewModel boundary. Each case renders canonical unavailable/error content
with a safe typed Back action, never fabricates content, never starts grading, and never changes
progress.

### Localization and adaptive behavior

Add Grammar-specific EN/VI ARB keys and map them to the public screen-input contract `GrammarCopy`
inside app route composition, importing that contract only through Grammar's public barrel. Reuse
truly generic existing keys only when their meaning is identical. Localize page/navigation/action
labels, empty/error/unavailable messages, feedback chrome, progress/semantic labels, and UI
taxonomy/category labels. Topic titles, lesson titles/descriptions, source sentences, answers,
corrections, explanations, hints, and tips remain deterministic English repository content in both
locales and never move into ARB files.

Map product terminology explicitly as compact → canonical compact, medium → canonical regular, and
expanded → canonical wide. Behavioral acceptance and implementation use compact/regular/wide only.
Use `AdaptiveLayout`, `ContentConstraints`, and canonical tokens: one topic column on compact, two
centered columns otherwise; canonical lesson-card ratios; centered capped content and sheets;
scrollable short-height content; no platform/device-type layout checks.

Surface responsibilities are explicit: the topic picker owns column reflow and scrollable category
and card content; the lesson list owns the horizontal card viewport, pager position, and
keyboard/pointer navigation; the exercise owns capped readable content, on-screen-keyboard and
short-height scrolling, stable primary-action reachability, and logical reading order; feedback owns
canonical capped width/height, internal scrolling, and reachable actions. Long EN/VI chrome and large
text must not change semantic order or obscure actions. All applicable controls expose canonical
touch targets, pointer/trackpad activation, hover/focus states, Enter/Space activation, Escape
dismissal, and non-gesture alternatives; no information or action may be available only on hover.

Accessibility validation uses the objective canonical contract: named roles and labels, polite
announcements for grading, verdict, and progress, disabled-state descriptions, visible token-backed
focus, minimum `control.minTouchTarget`, canonical target separation, production-profile contrast,
and icon/text/shape cues for verdicts and progress at compact, regular, and wide sizes.

### Test strategy and Writing regression

- Repository tests cover catalog relations, invalid topic/lesson/exercise lookups, accepted
  alternatives, exact case/whitespace and Unicode non-normalization boundaries, exactly 100
  consecutive executions of the same grading case with an identical verdict, authored feedback, and
  absence of external activity.
- ViewModel/provider tests exhaust every state transition, 300 ms dwell, duplicate suppression,
  cancellation race invalidation, exact response retention, minimize/reopen without regrading,
  invalid exercise rejection without grading/progress mutation, throwing-fake repository recovery
  with explicit Retry/Cancel and no automatic retry, one-step progression, and the final terminal
  outcome. The same sentence/response progression scenario runs exactly 100 times from fresh fixtures
  and must end each run at the deterministic next index with an empty answer in `GrammarAnswering`
  after exactly one increment.
- Widget-flow tests cover Home through both verdicts, Fix, Cancel, disabled AI link/reason, feedback
  reopen, non-final Next, final return, provider-overridden empty catalogs, and canonical unavailable
  states with safe Back for invalid topic/lesson/exercise identities.
- Localization/adaptive tests cover EN and VI chrome with identical English content at compact,
  regular, and wide widths, plus short-height/large-text, mouse/trackpad/hover parity, keyboard/focus
  semantics, exact transition focus policy, roles, state announcements, target sizes, production
  contrast, and non-color cues.
- Localization checks require non-empty EN/VI values, zero fallback keys, and zero mixed-locale
  labels. Human linguistic-quality approval is recorded as outside the automated implementation gate.
- Focused visually reviewed goldens are limited to three representative baselines:
  `grammar_components_regular.png` for `LessonCard/Grammar`, blue `AnswerInput`, and
  `SourceTextCard/Sentence`; `grammar_feedback_regular.png` for both Grammar feedback sheets; and
  `grammar_exercise_compact.png` for one representative compact exercise state. Regular/wide layout
  behavior remains covered by widget tests; no wide golden is added unless implementation reveals a
  material canonical visual difference and the plan is amended first.
- Writing verification requires no changes under `lib/features/writing/**`; runs all existing Writing
  provider/ViewModel and widget tests; preserves Home card content/order/callback, typed route
  locations, localization, accessibility semantics, adaptive behavior, grading, feedback, and
  architecture boundaries; and keeps every existing Writing golden byte-stable. Any Writing golden
  diff is a regression for this slice and must not be accepted or rebased. If a required canonical
  correction would intentionally change Writing, implementation stops and that change is handled as
  a separately approved design decision rather than folded into this feature.
- Permitted shared/generated edits are limited to the canonical documents and token named in T001–T002,
  additive default-preserving `lib/design_system/**` APIs, Grammar ARB keys and regenerated
  localization outputs, app-owned typed routes/generated route output, the Home Grammar callback/card
  activation, Grammar-owned files, and their tests. These file changes are permitted only when the
  Writing regression matrix remains unchanged; edits under `lib/features/writing/**`, changed Writing
  snapshots, or observable Writing copy/visual/state/navigation/accessibility/adaptive differences are
  prohibited and require explicit separate review.
- Final validation runs token verification, generated-file drift checks, formatting, analysis,
  architecture checks, all tests, and `sh tool/ci.sh` through the pinned toolchain.

### Platform validation matrix

| Target | Build evidence | Runtime/flow evidence | Unavailable target handling |
|---|---|---|---|
| macOS | Debug build | Native bootstrap plus Grammar-flow smoke | Record `UNVERIFIED` if no macOS runtime is available; never claim PASS |
| Android | Debug APK build | Bootstrap/Grammar smoke when an emulator or device is available | Record runtime `UNVERIFIED` when unavailable; build and runtime statuses remain separate |
| iPhone/iOS | Unsigned debug iOS build | Bootstrap/Grammar smoke when an iPhone simulator/device is available | Record runtime `UNVERIFIED` when unavailable; build and runtime statuses remain separate |
| iPadOS | Same unsigned universal iOS build evidence | Bootstrap/Grammar smoke at an iPad simulator/device size when available | Record runtime `UNVERIFIED` when unavailable; build and runtime statuses remain separate |

Every target available in the current environment is validated. An unavailable runtime is not a
local implementation failure, but `UNVERIFIED` is never converted to or reported as PASS.

## Complexity Tracking

No constitution violations or justified complexity exceptions are present.
