---

description: "Dependency-ordered implementation tasks for the Grammar Vertical Slice"
---

# Tasks: Grammar Vertical Slice

**Input**: Design documents from `/specs/001-grammar-vertical-slice/`

**Prerequisites**: `plan.md`, `spec.md`, `research.md`, `data-model.md`, `contracts/grammar-feature-contract.md`, `quickstart.md`

**Tests**: Required by the feature plan and repository Definition of Done. Add focused tests before the implementation they exercise, then run the complete FVM-based validation gate.

**Organization**: Tasks are grouped by user story so each priority increment has a distinct goal and independent test criteria. Shared design-system and domain prerequisites are isolated in the first two phases.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel because it targets different files and does not depend on an incomplete task.
- **[Story]**: Maps a task to a user story from `spec.md`.
- Every task names the exact file or files it changes or validates.

## Phase 1: Setup (Canonical Contract Reconciliation)

**Purpose**: Reconcile the authoritative design-system contract before changing shared Flutter UI.

- [ ] T001 Reconcile only the accepted Grammar instruction slot, disabled AI-analysis state and localized reason, feedback minimize/reopen behavior, Loading Cancel behavior, and scoped final return-to-list exception in `design-system/COMPONENTS.md`, `design-system/COMPONENT_VARIANTS.md`, and `design-system/DESIGN_DECISIONS.md`; retain the already-canonical required `PagerDots/Lesson` contract unchanged
- [ ] T002 Add the approved 300 ms minimum feedback-loading duration as `motion.feedbackMinimumDwell` in `design-system/TOKENS.json`, regenerate `lib/design_system/tokens/generated/design_tokens.dart` with `fvm dart run tool/generate_design_tokens.dart`, and leave no feature-local timing literal

**Checkpoint**: Canonical contracts and tokens authorize every planned reusable UI change.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Establish reusable component capabilities, localization inputs, pure Grammar types, and the complete workflow vocabulary required by every story.

**⚠️ CRITICAL**: No user story implementation begins until this phase is complete.

### Tests for Shared Foundations

- [ ] T003 Add failing reusable-component tests for the Grammar `SectionHeader` accent with unchanged Writing defaults, sentence instruction text, externally supplied answer focus, last-feedback affordance, disabled analysis reason and semantic reading-order behavior, minimize callback, empty/error states, lesson pager, constrained feedback content, canonical target size, and visible focus in `test/design_system/reusable_exercise_components_test.dart`

### Shared Design-System Implementation

- [ ] T004 Extend `SectionHeader` with a token-safe mode variant and add the canonical reusable `EmptyState` and `PagerDots/Lesson` surfaces without feature imports or changed Writing defaults in `lib/design_system/components/browse_components.dart`
- [ ] T005 Add an optional localized instruction slot to `SourceTextCard/Sentence`, an optional focus handle to `AnswerInput`, and an optional show-last-feedback action to `HintChipBar` while preserving existing constructors by default in `lib/design_system/components/exercise_components.dart`
- [ ] T006 Extend `FeedbackSheet/GrammarCorrect` with a disabled analysis control and localized unavailable reason, add optional minimize callbacks to the feedback family, and preserve current Writing behavior in `lib/design_system/components/feedback_sheet.dart`
- [ ] T007 Apply canonical feedback width, maximum-height, scroll, and reachable-action constraints for short windows without introducing raw layout values in `lib/design_system/patterns/exercise_template.dart`

### Localization and Grammar Contracts

- [ ] T008 Add English and Vietnamese ARB keys only for Grammar application chrome—page/navigation/action labels, UI taxonomy/category labels, loading/feedback, disabled-analysis, empty/error/unavailable, Retry/Cancel recovery, progress, and accessibility semantics—to `lib/l10n/app_en.arb` and `lib/l10n/app_vi.arb`; do not add authored topic/lesson/exercise content, then regenerate `lib/app/localization/generated/app_localizations.dart`, `lib/app/localization/generated/app_localizations_en.dart`, and `lib/app/localization/generated/app_localizations_vi.dart` with `fvm flutter gen-l10n`
- [ ] T009 Define immutable `GrammarCopy` in `lib/features/grammar/presentation/grammar_copy.dart` as the intentional public screen-input contract for every localized Grammar chrome and semantic label, without importing generated localization classes or carrying authored learning content
- [ ] T010 Implement pure-Dart `GrammarTopic`, `GrammarLesson`, `GrammarSentenceExercise`, `LearnerResponse`, and `GrammarVerdict` in `lib/features/grammar/domain/entities/grammar_content.dart`; keep UI taxonomy/category identity separate from deterministic English authored topic/lesson/exercise content and preserve these field constraints verbatim: topic `id` “Non-empty; unique in catalog”, `categoryId` “Non-empty; must exist in catalog categories”, `title` “Non-empty”, `lessonCount` “Non-negative; equals related lessons count”; lesson `id` “Non-empty; unique in catalog”, `topicId` “Must reference an existing topic”, `level` “Non-empty authored value”, `title` “Non-empty”, `description` “Non-empty”, `exercises` “Non-empty for selectable lessons”; exercise `id` “Non-empty; unique”, `incorrectSentence` “Non-empty and intentionally incorrect”, `acceptedAnswers` “Non-empty; no blank normalized values”, `hints` “May be empty; no blank entries”, `explanation` “Non-empty”, and `tips` “May be empty; no blank entries”; also preserve the exact learner response instead of its normalized form
- [ ] T011 Define the pure-Dart `GrammarRepository` contract for ordered categories/topics, topic-filtered lessons, nullable lesson and exercise identity lookup, and asynchronous deterministic grading in `lib/features/grammar/domain/repositories/grammar_repository.dart`; unknown identities return no content and never substitute a fallback, and the contract documents the development-adapter and future backend-authority boundary
- [ ] T012 Define exhaustive immutable sealed states for answering, submitting with request identity, correct feedback, incorrect feedback, minimized feedback, recoverable `GrammarFailure` retaining exact response/progress, one-shot finished navigation, and `GrammarUnavailable` without grading/progress data for invalid topic/lesson/exercise identity in `lib/features/grammar/presentation/state/grammar_exercise_state.dart`

**Checkpoint**: Shared APIs are backward compatible, Grammar domain remains pure Dart, and all user stories can use the same explicit state vocabulary.

---

## Phase 3: User Story 1 — Complete a Grammar Practice Turn (Priority: P1) 🎯 MVP

**Goal**: A learner can enter Grammar from Home, choose a topic and lesson, submit a correct full-sentence answer, observe cancellable Loading for at least 300 ms, receive deterministic correct feedback, advance one sentence, and return to the lesson list after the final sentence.

**Independent Test**: With a catalog containing one topic, one lesson, and at least two sentences, complete Home → topic → lesson → exercise → correct submission → Loading → correct feedback → Next; assert exact one-step progression, retained response after Cancel, and typed return to the lesson list on final Next.

### Tests for User Story 1

- [ ] T013 [P] [US1] Add repository tests for authored ordering, topic/lesson relationships, empty and unknown topic/lesson/exercise lookups without fallback content, accepted alternatives, case and whitespace normalization, preservation of punctuation and word order, explicit non-normalization of canonically distinct Unicode sequences unless authored as alternatives, exactly 100 consecutive executions of one grading case with an identical verdict, and absence of network/storage/logging effects in `test/features/grammar/in_memory_grammar_repository_test.dart`
- [ ] T014 [P] [US1] Add provider/ViewModel tests for blank-submit suppression, answering → submitting, the `motion.feedbackMinimumDwell` 300 ms dwell, duplicate-submit suppression, Cancel with exact response retention, stale-result invalidation, invalid exercise rejection without a grading call or progress mutation, a throwing-fake repository transition to recoverable `GrammarFailure`, explicit Retry with a new request identity, failure Cancel, no automatic retry/verdict/progression, correct feedback, one-shot final outcome, and exactly 100 fresh-fixture runs of the same sentence/response progression scenario that each increment once, clear the answer, and return to `GrammarAnswering` at the same next index in `test/features/grammar/grammar_exercise_view_model_test.dart`
- [ ] T015 [P] [US1] Add typed-route tests for `/grammar`, `/grammar/:topicId`, `/grammar/:topicId/:lessonId`, unknown topic IDs, unknown or topic-mismatched lesson IDs, safe typed Back destinations, final return to the typed lesson route, and unchanged Writing route locations in `test/app/router/app_routes_test.dart`
- [ ] T016 [P] [US1] Add a widget-flow test for the active canonical Home Grammar card copy/state, topic selection, required lesson pager, lesson selection, blue answer surface, disabled blank Submit, cancellable Loading, correct feedback with the disabled analysis reason in semantic reading order but outside action focus/activation order, non-final Next, final return, provider-overridden empty catalogs, recoverable catalog/grading errors, and unavailable states with safe Back for invalid topic/lesson/exercise identity in `test/features/grammar/grammar_flow_test.dart`

### Implementation for User Story 1

- [ ] T017 [US1] Implement the immutable English authored catalog and `InMemoryGrammarRepository` in `lib/features/grammar/data/repositories/in_memory_grammar_repository.dart`, with localized UI taxonomy supplied separately, at least one topic, one selectable lesson in that topic, and two exercises per demonstration lesson; nullable topic/lesson/exercise identity lookups that never fabricate fallback content; exact trim/case/collapsed-whitespace normalization without additional Unicode canonical-equivalence transforms; punctuation and word-order preservation; and no network, AI, storage, logging, locale, clock, or random dependency
- [ ] T018 [US1] Add overrideable `grammarRepositoryProvider`, token-backed/injectable minimum-dwell policy, route-scoped Grammar workflow provider families, and validated topic/lesson/exercise initialization that yields `GrammarUnavailable` before workflow creation for unknown identities in `lib/features/grammar/presentation/providers/grammar_providers.dart`
- [ ] T019 [US1] Implement answer changes, guarded Submit, concurrent grading/minimum dwell, request-identity cancellation, stale-result rejection, repository-verdict mapping, invalid exercise refusal with no grading/progress mutation, recoverable repository failure with exact response/progress retention and explicit Retry/Cancel only, correct feedback, exactly-once Next, and final `GrammarFinished` emission in `lib/features/grammar/presentation/view_models/grammar_exercise_view_model.dart`
- [ ] T020 [P] [US1] Build the repository-driven Grammar Topic Picker with canonical `SectionHeader`, category chips, `TopicCard`, empty/unavailable states, and regional `EmptyState/Error` with explicit Retry for unexpected catalog failure in `lib/features/grammar/presentation/screens/grammar_topic_picker_screen.dart`
- [ ] T021 [P] [US1] Build the selected-topic Grammar Lesson List with the required canonical horizontal `LessonCard/Grammar` carousel and `PagerDots/Lesson`, ordered lessons, localized empty state, regional `EmptyState/Error` with explicit Retry for unexpected catalog failure, and unknown-topic unavailable state with safe Back in `lib/features/grammar/presentation/screens/grammar_lesson_list_screen.dart`
- [ ] T022 [US1] Build the exercise UI for answering, Loading, Cancel, recoverable in-sheet `InlineError` with explicit Retry/Cancel and retained response/progress, correct feedback, disabled AI analysis, non-final Next, finished callback, and unknown/topic-mismatched lesson or invalid exercise unavailable state with safe Back using `ExerciseTemplate`, `ProgressStepper/Grammar`, `SourceTextCard/Sentence`, blue `AnswerInput`, `HintChipBar`, `SubmitButton`, canonical `EmptyState/Error`, and canonical `FeedbackSheet` states in `lib/features/grammar/presentation/screens/grammar_exercise_screen.dart`
- [ ] T023 [US1] Export the three Grammar screen contracts and intentional public `GrammarCopy` screen-input contract from `lib/features/grammar/grammar.dart`; keep providers, ViewModel, states, repository, data adapter, and all Writing internals private
- [ ] T024 [US1] Import Grammar only through `package:lingua/features/grammar/grammar.dart`; add `_grammarCopy`, typed `GrammarTopicRoute`, `GrammarLessonRoute`, and `GrammarExerciseRoute`; wire canonical unavailable states and safe typed Back destinations; activate Home's existing `ModeCard/Grammar` with localized `grammar`, `grammarDescription`, `learningModes`, and `explore`, canonical index `02` and Grammar fill/foreground without inventing an icon; leave Writing unchanged and other out-of-scope modes disabled; then regenerate `lib/app/router/app_routes.g.dart` with `fvm dart run build_runner build` after changes to `lib/app/router/app_routes.dart` and `lib/features/home/presentation/home_dashboard_screen.dart`
- [ ] T025 [US1] Run the P1 focused suite through FVM for `test/features/grammar/in_memory_grammar_repository_test.dart`, `test/features/grammar/grammar_exercise_view_model_test.dart`, `test/features/grammar/grammar_flow_test.dart`, and `test/app/router/app_routes_test.dart`

**Checkpoint**: User Story 1 is a complete independently testable MVP with no backend, completion UI, persistence, or Writing source change.

---

## Phase 4: User Story 2 — Learn From an Incorrect Answer (Priority: P2)

**Goal**: An incorrect response produces deterministic authored correction feedback; Fix retains the exact response and restores editing focus, Next advances once, and minimized feedback reopens without regrading.

**Independent Test**: Submit a known incorrect answer, inspect correction/explanation/tips, choose Fix and observe exact response plus restored focus, submit again, minimize/reopen without another repository call, then choose Next and observe one-step progression.

### Tests for User Story 2

- [ ] T026 [P] [US2] Extend repository tests for incorrect verdict kind, exact original response, first accepted answer as canonical correction, authored explanation/tips, and deterministic repeatability in `test/features/grammar/in_memory_grammar_repository_test.dart`
- [ ] T027 [P] [US2] Extend ViewModel tests for incorrect feedback, Fix retention, minimize/reopen with unchanged verdict and grading-call count, duplicate Next suppression, and one-step progression from an incorrect verdict in `test/features/grammar/grammar_exercise_view_model_test.dart`
- [ ] T028 [P] [US2] Extend widget-flow tests for GrammarIncorrect content, Fix focus restoration, retained exact response, minimized feedback affordance, reopen without Loading, and Next from incorrect feedback in `test/features/grammar/grammar_flow_test.dart`

### Implementation for User Story 2

- [ ] T029 [US2] Add Fix, minimize, reopen-last-feedback, incorrect-feedback Next, and idempotent transition handling to `lib/features/grammar/presentation/view_models/grammar_exercise_view_model.dart`
- [ ] T030 [US2] Compose canonical `FeedbackSheet/GrammarIncorrect`, correction/explanation/tips, Fix focus restoration, minimize callbacks, and `HintChipBar` show-last-feedback behavior in `lib/features/grammar/presentation/screens/grammar_exercise_screen.dart`
- [ ] T031 [US2] Run the P2 repository, ViewModel, and widget-flow coverage through FVM in `test/features/grammar/in_memory_grammar_repository_test.dart`, `test/features/grammar/grammar_exercise_view_model_test.dart`, and `test/features/grammar/grammar_flow_test.dart`

**Checkpoint**: Correct and incorrect learning paths are independently covered, and recovery never triggers duplicate grading or progression.

---

## Phase 5: User Story 3 — Practice Across Languages and Layouts (Priority: P3)

**Goal**: The full Grammar journey has equivalent EN/VI product chrome and remains usable and understandable across canonical compact, regular, and wide layouts, short heights, large text, touch, pointer, and keyboard input.

**Independent Test**: Repeat browse, answer, both feedback variants, and Next in English and Vietnamese at approximately 390, 788, and 1200 logical pixels plus a short-height/large-text case; authored English content remains identical and all actions, reading order, focus, semantics, and non-color verdict cues remain available.

### Tests for User Story 3

- [ ] T032 [US3] Add EN/VI localization-key completeness, non-empty string, no fallback-key, no mixed-locale, compact/regular/wide, short-height, large-text, English authored topic/lesson/exercise content invariance, canonical contrast and target-size checks, mouse/trackpad/pointer and applicable hover parity, keyboard traversal plus Enter/Space activation, Escape dismissal, exact transition focus placement/restoration, semantic roles, grading/verdict/progress live-region announcements, disabled-analysis discoverability without activation focus, and non-color verdict coverage in `test/features/grammar/grammar_adaptive_localization_test.dart`; do not treat automated presence checks as human linguistic-quality approval

### Implementation for User Story 3

- [ ] T033 [P] [US3] Complete width-driven one-column compact and centered two-column regular/wide topic layouts, scroll behavior, localized empty/error/unavailable semantics, long-label resilience, pointer/trackpad activation, canonical hover/focus states, and no hover-only action in `lib/features/grammar/presentation/screens/grammar_topic_picker_screen.dart`
- [ ] T034 [P] [US3] Complete canonical lesson-card viewport ratios, horizontal keyboard/mouse/trackpad navigation, applicable hover/focus states, pager semantics, and localized empty/error/unavailable behavior in `lib/features/grammar/presentation/screens/grammar_lesson_list_screen.dart`
- [ ] T035 [US3] Complete short-height and on-screen-keyboard scrolling, large-text action reachability, logical Tab order, mouse/trackpad plus applicable hover states, Enter/Space activation, Escape feedback dismissal, and the exact focus policy from `specs/001-grammar-vertical-slice/plan.md`: focus enters Loading/verdict feedback; Cancel or ordinary dismissal returns to its trigger; Fix focuses `AnswerInput`; reopened feedback returns dismissal focus to its `HintChipBar` trigger; non-final Next focuses the cleared next `AnswerInput`; final Next focuses the Lesson List heading; also add localized grading/progress/verdict/error announcements and non-color cues in `lib/features/grammar/presentation/screens/grammar_exercise_screen.dart`
- [ ] T036 [US3] Audit Grammar chrome wiring so page/navigation/action labels, UI taxonomy/category labels, empty/error/unavailable messages, feedback chrome, progress, and assistive labels come from EN/VI ARB values through the public `GrammarCopy` contract, while authored topic titles, lesson titles/descriptions, source sentences, answers, corrections, hints, explanations, and tips remain repository-owned English and absent from ARB files in `lib/app/router/app_routes.dart`, `lib/features/grammar/grammar.dart`, `lib/features/grammar/presentation/grammar_copy.dart`, `lib/l10n/app_en.arb`, and `lib/l10n/app_vi.arb`
- [ ] T037 [US3] Run `test/features/grammar/grammar_adaptive_localization_test.dart` through FVM at the defined size/locale cases and rerun `test/features/grammar/grammar_flow_test.dart` to ensure P1/P2 behavior remains unchanged

**Checkpoint**: The same semantic Grammar journey is available in both locales and every canonical size class without device-specific layout branching.

---

## Phase 6: Polish & Cross-Cutting Validation

**Purpose**: Add critical integration coverage, visually validate shared changes, prove Writing non-regression, and run every repository quality gate.

- [ ] T038 [P] Add a critical smoke journey from Home through a correct Grammar verdict and one Next transition without external connectivity in `integration_test/bootstrap_test.dart`
- [ ] T039 Prove Writing non-regression by requiring an empty diff under `lib/features/writing/`; running all Writing provider/ViewModel and widget tests under `test/features/writing/`; preserving Home card content/order/callback and typed route locations in `test/app/router/app_routes_test.dart`; verifying Writing localization, accessibility semantics, adaptive behavior, grading, feedback, and architecture boundaries; and requiring byte-stable Writing cases in `test/design_system/vertical_slice_golden_test.dart`; never accept or rebaseline a Writing golden diff for this slice
- [ ] T040 Add and visually inspect exactly three restrained baselines in `test/design_system/vertical_slice_golden_test.dart`: `test/design_system/goldens/grammar_components_regular.png` covering `LessonCard/Grammar`, blue `AnswerInput`, and `SourceTextCard/Sentence`; `test/design_system/goldens/grammar_feedback_regular.png` covering `FeedbackSheet/GrammarCorrect` and `FeedbackSheet/GrammarIncorrect`; and `test/design_system/goldens/grammar_exercise_compact.png` covering one representative compact exercise state; do not add content-permutation or wide baselines unless a material canonical layout difference first amends the plan, and stop for separate approval rather than updating any Writing baseline if a shared correction would change Writing
- [ ] T041 Regenerate and verify derived token, localization, and typed-route outputs using `tool/generate_design_tokens.dart`, `lib/l10n/app_en.arb`, `lib/l10n/app_vi.arb`, `lib/app/router/app_routes.g.dart`, and `tool/verify_design_tokens.dart`, without hand-editing generated files; audit the diff so permitted shared/generated changes remain limited to the plan's file-change policy and produce no observable Writing change
- [ ] T042 Run FVM formatting and static analysis over `lib/`, `test/`, `integration_test/`, and `tool/`, resolving all findings without adding dependencies or unrelated changes
- [ ] T043 Run `fvm dart run tool/check_architecture.dart`, `fvm dart run tool/verify_design_tokens.dart`, and the architecture suite in `test/architecture/architecture_test.dart`; ensure Grammar does not import Writing, app, generated API, Flutter/Riverpod from domain, or introduce generic Exercise/Base abstractions
- [ ] T044 Run all Flutter tests and the complete repository gate with `sh tool/ci.sh`, using `tool/ci.sh` as-is and recording any platform validation not executed
- [ ] T045 Execute and record the platform-validation matrix: macOS debug build plus native bootstrap and Grammar-flow smoke; Android debug APK build plus runtime smoke when an emulator/device is available; unsigned iOS/iPadOS debug build plus separate iPhone and iPad runtime smokes when simulators/devices are available; use FVM commands from `specs/001-grammar-vertical-slice/quickstart.md`, record build and runtime statuses separately as PASS/FAIL/UNVERIFIED, and never report an unavailable target as PASS
- [ ] T046 Perform and record the EN/VI manual acceptance journey at compact, regular, wide, short-height, and large-text conditions using `specs/001-grammar-vertical-slice/quickstart.md`, including active Grammar Home card copy/state, required lesson pager, invalid-ID unavailable states and safe Back, Loading cancellation, both verdicts, Fix, minimize/reopen, non-final Next, final return, and unchanged Writing behavior; record human linguistic-quality review as outside the automated implementation gate

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 — Setup**: Starts immediately; T002 follows T001 so the token reflects the reconciled canonical decision.
- **Phase 2 — Foundational**: Depends on Phase 1 and blocks every user story. T003 defines shared expectations before T004–T007; T009–T012 can proceed after their direct inputs exist.
- **Phase 3 — US1**: Depends on Phase 2. Tests T013–T016 precede implementation; T017–T019 establish data/state, T020–T022 compose screens, and T023–T024 expose the feature and routes.
- **Phase 4 — US2**: Depends on the US1 exercise and grading foundation. Tests T026–T028 precede T029–T030.
- **Phase 5 — US3**: Depends on the complete P1/P2 journey so locale, adaptive, and accessibility coverage exercises every state. T032 precedes T033–T036.
- **Phase 6 — Polish**: Depends on all selected user stories. T038 and T040 may be prepared independently, but final validation T039–T046 runs against the integrated result.

### User Story Dependency Graph

```text
Setup → Foundational → US1 (P1 / MVP) → US2 (P2) → US3 (P3) → Polish
```

- **US1** provides the independently valuable correct-answer journey and shared exercise shell.
- **US2** extends US1's established grading workflow with the incorrect/recovery branch; it remains independently testable with its focused repository, ViewModel, and widget scenarios.
- **US3** evaluates the complete journey across locales, layouts, and input modes and therefore follows both verdict branches.

### Within Each User Story

- Add focused tests before the implementation they specify and observe the expected failure.
- Keep domain/repository work before ViewModel/provider work, and state work before screen composition.
- Generate route/localization/token outputs through their generators; never hand-edit generated Dart.
- Complete and run each story's independent test before moving to the next priority.

### Parallel Opportunities

- In Phase 2, T008–T012 target separate localization/domain/state files and can proceed alongside the shared-component sequence once T001–T002 are complete.
- In US1, T013–T016 can be authored in parallel; after T017–T019, the picker (T020) and lesson list (T021) can be implemented in parallel.
- In US2, T026–T028 can be authored in parallel before the shared ViewModel/screen implementation sequence.
- In US3, T033 and T034 can run in parallel after T032 because they target separate browse screens.
- In Polish, integration preparation (T038) can proceed independently of golden preparation (T040) before the serial final gates.

---

## Parallel Example: User Story 1

```text
Task T013: Repository contract and deterministic grading tests
Task T014: State-machine and cancellation-race tests
Task T015: Typed-route tests
Task T016: End-to-end widget-flow tests

After T017–T019:
Task T020: Grammar Topic Picker
Task T021: Grammar Lesson List
```

## Parallel Example: User Story 2

```text
Task T026: Incorrect repository verdict tests
Task T027: Fix/minimize/reopen/progression ViewModel tests
Task T028: Incorrect-feedback widget-flow tests
```

## Parallel Example: User Story 3

```text
After T032:
Task T033: Adaptive/localized topic picker
Task T034: Adaptive/localized lesson list
```

---

## Implementation Strategy

### MVP First — User Story 1

1. Complete Phase 1 canonical reconciliation.
2. Complete Phase 2 shared foundations.
3. Complete Phase 3 and run the P1 independent test suite.
4. Stop at the MVP checkpoint and review the correct-answer journey before adding recovery and cross-layout breadth.

### Incremental Delivery

1. **Foundation**: Canonical design-system changes, tokens, localization, pure domain, repository contract, and sealed state vocabulary.
2. **US1**: Home-to-correct-feedback journey, cancellation, one-step progression, and final return.
3. **US2**: Incorrect feedback, Fix, minimize/reopen, and incorrect-path progression.
4. **US3**: EN/VI, adaptive layouts, keyboard/focus, and accessibility equivalence.
5. **Polish**: Critical integration smoke, Writing regression, focused goldens, architecture/token/generated checks, full CI, explicit platform matrix, and manual acceptance.

## Notes

- Use only `fvm flutter ...` and `fvm dart ...`; do not rely on global Flutter or Dart binaries.
- Do not add dependencies, backend/AI integration, persistence, completion UI, rewards, or generic shared Exercise/Base abstractions.
- `design-system/` remains authoritative; `references/gramago/` is frozen forensic evidence and is not part of these tasks.
- Grammar must not import Writing internals, and no task authorizes changes under `lib/features/writing/`.
- App composition imports Grammar only through `package:lingua/features/grammar/grammar.dart`; `GrammarCopy` is public solely as the localized screen-input contract.
- Localize application chrome and UI taxonomy/category labels only; keep topic/lesson/exercise learning content deterministic English repository data.
- Use canonical compact/regular/wide names in implementation, mapped from product compact/medium/expanded terminology.
- Keep all new UI values on canonical tokens and retain canonical background/foreground palette pairs.
- Do not commit, push, rewrite history, or create tags; Git remains user-controlled.
