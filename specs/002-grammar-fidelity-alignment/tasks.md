# Tasks: Grammar Fidelity Alignment

**Input**: Design documents from `/specs/002-grammar-fidelity-alignment/`

**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/

**Tests**: Required because the specification defines behavioral, accessibility, adaptive, and visual success criteria.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Capture the approved visual contract and establish a safe baseline.

- [X] T001 Reconcile the approved component anatomy and landmark measurements into `design-system/components/` and `design-system/TOKENS.json`
- [X] T002 Record the pre-change focused test baseline for Grammar, Writing, and reusable exercise components in `specs/002-grammar-fidelity-alignment/quickstart.md`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Add shared data and design-system capabilities used by the user stories.

- [X] T003 Extend `GrammarTopic` with required `description` and `level`, and `GrammarLesson` with optional `illustrationKey`, in `lib/features/grammar/domain/entities/grammar_content.dart`
- [X] T004 Update repository catalog data and constructor fixtures for the new immutable entity fields in `lib/features/grammar/data/repositories/in_memory_grammar_repository.dart` and `test/features/grammar/`
- [X] T005 Add or generate canonical typed tokens for balanced exercise surfaces and feedback anchors in `design-system/TOKENS.json` and `lib/design_system/tokens/generated/design_tokens.dart`
- [X] T006 [P] Add localized topic context, collection context, correction-state, and carousel semantic copy in `lib/l10n/app_en.arb`, `lib/l10n/app_vi.arb`, and `lib/features/grammar/presentation/grammar_copy.dart`
- [X] T007 [P] Add failing shared-component contract tests for the new opt-in APIs while preserving Writing defaults in `test/design_system/reusable_exercise_components_test.dart`

**Checkpoint**: Shared contracts and data shape are ready; feature stories can be implemented.

---

## Phase 3: User Story 1 - Faithful Exercise Workspace (Priority: P1) 🎯 MVP

**Goal**: Deliver a truthful dense-progress Grammar exercise with dominant centered prompt/answer surfaces and reachable controls.

**Independent Test**: Open the primary lesson at 788×1083, verify 20 real steps and the empty/filled workspace, then submit without clipping at regular and short-height 200% text layouts.

### Tests for User Story 1

- [X] T008 [P] [US1] Add repository assertions for exactly 20 non-empty authored exercises in the primary lesson in `test/features/grammar/in_memory_grammar_repository_test.dart`
- [X] T009 [P] [US1] Add regular, short-height, and large-text exercise workspace coverage in `test/features/grammar/grammar_adaptive_localization_test.dart`

### Implementation for User Story 1

- [X] T010 [US1] Author exactly 20 deterministic sentence-correction exercises for the primary lesson in `lib/features/grammar/data/repositories/in_memory_grammar_repository.dart`
- [X] T011 [US1] Add centered/fill-height opt-in behavior to prompt and answer surfaces in `lib/design_system/components/exercise_components.dart`
- [X] T012 [US1] Add a height-aware balanced workspace variant with scroll fallback in `lib/design_system/patterns/exercise_template.dart`
- [X] T013 [US1] Compose the balanced workspace and truthful progress in `lib/features/grammar/presentation/screens/grammar_exercise_screen.dart`

**Checkpoint**: User Story 1 works independently without changing Writing defaults.

---

## Phase 4: User Story 2 - Faithful Contextual Browse Screens (Priority: P2)

**Goal**: Align Home, Topic Picker, and Lesson List hierarchy while keeping navigation and catalog behavior intact.

**Independent Test**: Navigate Home → Grammar Topic Picker → Lesson List and verify mode-card anatomy, topic context/count, centered collection header, lesson illustration slot, carousel reveal, and position semantics.

### Tests for User Story 2

- [X] T014 [P] [US2] Add Home mode-card and browse component anatomy/semantics coverage in `test/design_system/vertical_slice_golden_test.dart` and `test/design_system/reusable_exercise_components_test.dart`
- [X] T015 [P] [US2] Add topic context, lesson hero, carousel position, and keyboard navigation coverage in `test/features/grammar/grammar_flow_test.dart`

### Implementation for User Story 2

- [X] T016 [US2] Reorder shared `ModeCard` category/title/index/description/action anatomy in `lib/design_system/components/home_components.dart`
- [X] T017 [US2] Add a centered collection header and illustration-capable lesson-card anatomy in `lib/design_system/components/browse_components.dart`
- [X] T018 [US2] Add localized topic-section context and varied meaningful icons in `lib/features/grammar/presentation/screens/grammar_topic_picker_screen.dart`
- [X] T019 [US2] Compose topic description/level, centered collection hero, illustration slot, and accurate carousel semantics in `lib/features/grammar/presentation/screens/grammar_lesson_list_screen.dart`

**Checkpoint**: User Story 2 works independently through existing typed routes.

---

## Phase 5: User Story 3 - Faithful Correct and Incorrect Feedback (Priority: P3)

**Goal**: Make incorrect corrections understandable at word/punctuation level and place both feedback variants contextually.

**Independent Test**: Submit one incorrect and one accepted answer, validate correction semantics, Fix/Next, minimize/reopen, and variant placement without a second grade operation.

### Tests for User Story 3

- [X] T020 [P] [US3] Add deterministic repeated-word, punctuation, insertion, deletion, and replacement diff tests in `test/features/grammar/grammar_correction_diff_test.dart`
- [X] T021 [P] [US3] Add correction non-color cues, semantics, scrolling, and feedback-anchor component tests in `test/design_system/reusable_exercise_components_test.dart`
- [X] T022 [P] [US3] Extend correct/incorrect Fix, Next, minimize/reopen, and no-duplicate-grade flow tests in `test/features/grammar/grammar_flow_test.dart`

### Implementation for User Story 3

- [X] T023 [US3] Implement presentation-only word/punctuation LCS mapping in `lib/features/grammar/presentation/state/grammar_correction_diff.dart`
- [X] T024 [US3] Add neutral correction-segment rendering with text decoration and semantics in `lib/design_system/components/feedback_sheet.dart`
- [X] T025 [US3] Add canonical compact/detailed feedback anchoring in `lib/design_system/patterns/exercise_template.dart`
- [X] T026 [US3] Wire derived correction segments and feedback variants into `lib/features/grammar/presentation/screens/grammar_exercise_screen.dart`

**Checkpoint**: User Story 3 is independently understandable and preserves the existing feedback state machine.

---

## Phase 6: User Story 4 - Accessible and Adaptive Equivalence (Priority: P4)

**Goal**: Confirm every aligned state works with locale, keyboard, semantics, focus, input modalities, width/height constraints, and large text.

**Independent Test**: Complete all supported actions in English and Vietnamese with keyboard/semantic navigation across compact, regular, wide, and short-height 200% text cases.

### Tests and implementation for User Story 4

- [X] T027 [P] [US4] Extend bilingual semantic labels and large-text assertions in `test/features/grammar/grammar_adaptive_localization_test.dart`
- [X] T028 [P] [US4] Add focus restoration, Enter/Space, Escape, and carousel traversal assertions in `test/features/grammar/grammar_flow_test.dart`
- [X] T029 [US4] Resolve any adaptive, focus, localization, or semantics regressions in `lib/design_system/` and `lib/features/grammar/presentation/`

**Checkpoint**: All stories meet the accessibility and adaptive contract.

---

## Phase 7: Polish & Cross-Cutting Concerns

- [X] T030 Review and update only the intentional Home/Grammar golden baselines in `test/design_system/goldens/`
- [X] T031 Run formatter, analyzer, focused Grammar/Writing/component tests, and the full suite from `specs/002-grammar-fidelity-alignment/quickstart.md`
- [X] T032 Record PASS/intentional-divergence results for all seven authorized reference states in `specs/002-grammar-fidelity-alignment/quickstart.md`
- [X] T033 Verify `git diff --check`, architecture boundaries, generated-file policy, and absence of unrelated changes across the repository

---

## Dependencies & Execution Order

- Setup precedes foundational work; foundational work blocks every user story.
- US1 is the recommended MVP and provides the exercise surface later used by US3.
- US2 can proceed after foundations independently of US1.
- US3 depends on the shared exercise surface from US1 but not on US2.
- US4 validates the integrated US1–US3 result.
- Polish follows all selected stories.

## Parallel Opportunities

- T006 and T007 can proceed after the entity/token contract is known.
- Within each story, the marked test tasks touch independent files and can be authored in parallel.
- US2 browse implementation is independent of US1/US3 exercise implementation after Phase 2.

## Implementation Strategy

1. Complete setup and foundational contracts without adding dependencies.
2. Deliver and validate US1 as the exercise MVP.
3. Add US2 browse hierarchy, then US3 teaching feedback.
4. Run US4 accessibility/adaptive hardening.
5. Review intentional goldens and execute the complete validation matrix.

All 33 tasks follow the required checkbox, sequential ID, optional parallel marker, story label, and concrete file-path format.
