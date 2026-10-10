# Research: Grammar Vertical Slice

## Decision 1: Independent Grammar vertical slice

**Decision**: Create `lib/features/grammar/` with its own pure-Dart domain entities, repository
contract, in-memory adapter, Riverpod state/ViewModel, copy object, and screens.

App composition imports only `features/grammar/grammar.dart`. `GrammarCopy` is intentionally part of
that public barrel because app-owned generated localization must supply localized screen input while
the feature remains independent of generated localization classes. Providers, state, ViewModel,
repository, and adapter remain private.

**Rationale**: This follows frozen feature-first ownership and prevents Grammar from importing
Writing internals. The feature has enough grading and workflow behavior to justify a small domain
and repository boundary, but not an application/use-case layer.

**Alternatives considered**:

- Reuse Writing entities, repository, ViewModel, or screens: rejected as a cross-feature internal
  dependency and because the task semantics and feedback differ.
- Create generic Exercise domain/repository/ViewModel bases: rejected as premature abstraction with
  only two concrete modes and different lifecycle requirements.
- Put all behavior in widgets: rejected because deterministic grading and state transitions require
  independently testable boundaries.

## Decision 2: Grammar-specific repository boundary with an in-memory adapter

**Decision**: Define a pure-Dart `GrammarRepository` for catalog reads, lesson lookup, and grading.
Provide `InMemoryGrammarRepository` as the deterministic development adapter and inject it through a
Grammar-owned Riverpod provider.

**Rationale**: Repository ownership makes browse and grading behavior replaceable and testable. It
also keeps the local vertical slice explicit: future production grading replaces this adapter with a
backend-backed implementation and consumes backend verdicts.

**Alternatives considered**:

- Read static data directly from screens: rejected because it bypasses the source-of-truth boundary
  and prevents empty/fake catalog testing.
- Put normalization in the ViewModel: rejected because grading belongs to the repository contract.
- Treat local grading as production policy: rejected because production grading is backend-owned.

## Decision 3: Exact deterministic normalization

**Decision**: Normalize a response and every accepted answer by trimming outer whitespace,
lowercasing, and collapsing repeated internal whitespace. Preserve punctuation and word order. A
match against any authored full-sentence correction is correct.

**Rationale**: This implements the clarified specification exactly, remains deterministic across
platforms/locales, and avoids inventing linguistic equivalence rules.

**Alternatives considered**:

- Ignore punctuation, spelling, or word order: rejected because the specification makes them
  meaningful.
- Fuzzy or semantic matching: rejected as AI-like behavior outside scope.
- One accepted answer only: rejected because the data model explicitly supports authored variants.

## Decision 4: Riverpod Notifier and sealed workflow states

**Decision**: Use a Grammar-owned `Notifier` and sealed immutable states for answering, submitting,
correct feedback, incorrect feedback, minimized feedback, and the final terminal outcome. Scope the
provider to the selected lesson and inject repository and minimum-dwell policy for tests.

**Rationale**: The provider initializes synchronously; only submit is asynchronous, so
`AsyncNotifier` would obscure a finite workflow. A request identity prevents a canceled grade from
publishing a late verdict and prevents duplicate side effects.

**Alternatives considered**:

- Several booleans (`loading`, `correct`, `sheetOpen`): rejected as mutually inconsistent states.
- `StateNotifier`: rejected because it is not the project default for new code.
- Put navigation in the ViewModel: rejected because typed navigation belongs to app/presentation
  composition.

## Decision 5: Minimum Loading dwell is presentation policy

**Decision**: Run the grading future and a canonical 300 ms minimum dwell concurrently in the
ViewModel. Cancel invalidates the request and restores the exact answer immediately. Add the approved
duration to canonical tokens and generate the Dart constant.

**Rationale**: The user explicitly requires a perceivable Loading state and cancel affordance, while
the repository should remain concerned only with grading. A generated token avoids a raw timing
literal outside the canonical design source.

**Alternatives considered**:

- Delay inside the repository: rejected because it couples a visual policy to data behavior.
- Skip Loading for immediate results: rejected by the clarified flow.
- Add a timer/cancellation package: rejected because SDK futures and a request identity suffice.

## Decision 6: Typed app-owned Grammar routes

**Decision**: Add typed routes for topic picker, lesson list, and exercise under `/grammar`. Compose
Grammar copy and screen callbacks in `app_routes.dart`; regenerate `app_routes.g.dart`. Final Next
navigates with the typed lesson route and no completion route.

**Rationale**: Semantic routes remain stable while screens stay independent of route strings.
Returning with a typed route also handles direct links safely.

**Alternatives considered**:

- Construct route strings in feature screens: rejected by frozen routing rules.
- Make Grammar own a second router: rejected as unnecessary architecture.
- Add a completion route: rejected because completion UI and persistence are out of scope.

## Decision 7: Reuse and narrowly extend the canonical design system

**Decision**: Compose Grammar screens from existing canonical component families. Add only
backward-compatible reusable capabilities that the accepted flow requires: Grammar hero accent,
sentence instruction, disabled analysis state with reason, feedback minimize/reopen affordance,
answer focus restoration, canonical empty state, lesson pager if required by the template, and
adaptive sheet constraints.

**Rationale**: Most required variants already exist. Narrow extensions preserve one canonical
family and avoid feature-local visual duplicates. Existing Writing call sites retain their defaults
and rendering.

**Alternatives considered**:

- Copy components into Grammar: rejected by the implementation contract.
- Refactor Writing and Grammar into shared feature widgets: rejected because Writing must remain
  unchanged and a second feature does not justify generic feature-domain infrastructure.
- Complete every deferred design-system component: rejected as unrelated scope.

## Decision 8: Canonical-source reconciliation before reusable UI changes

**Decision**: Update the applicable canonical design-system contract documents and token source
before changing shared UI code. Record the clarified disabled analysis state and loading/cancel
behavior; retain DD-01 globally but document the scoped final-return choice for Grammar.

**Rationale**: The current correct-feedback default makes analysis actionable, while the accepted
spec requires it visible but disabled. The design system is authoritative, so implementation cannot
silently diverge.

**Alternatives considered**:

- Implement the spec only in feature code: rejected because it would conflict with the canonical
  component contract.
- Remove the analysis link: rejected because clarification selected a visible disabled link.
- Build `CompletionTemplate`: rejected by the scoped decision and feature exclusions.

## Decision 9: Localization boundary

**Decision**: Add Grammar application chrome to English and Vietnamese ARB sources, generate
localization output, and map values into the public screen-input contract `GrammarCopy` from app
composition through Grammar's barrel. Chrome includes page/navigation/action labels, UI
taxonomy/category labels, empty/error/unavailable messages, feedback chrome, progress, and semantic
labels. Keep authored topic titles, lesson titles/descriptions, source sentences, answers,
corrections, hints, explanations, and tips in deterministic English inside the repository.

**Rationale**: Features do not depend on app-generated localization, UI strings are not hardcoded,
and locale changes cannot alter grading inputs.

**Alternatives considered**:

- Reuse `WritingCopy`: rejected as cross-feature coupling and incorrect wording.
- Put topic, lesson, or exercise content in ARB: rejected because it is authored learning content,
  not product chrome.
- Add a localization dependency: rejected because the SDK pipeline already covers the requirement.

## Decision 10: Focused tests plus explicit Writing regression

**Decision**: Add repository, state/ViewModel, widget-flow, adaptive/localization, routing, semantics,
and narrowly scoped design-system tests. Run the untouched Writing suite and existing goldens before
the full CI script.

**Rationale**: This validates the new slice at every owned boundary and catches regressions caused by
Home or shared design-system changes without modifying Writing to accommodate Grammar.

**Alternatives considered**:

- Only an end-to-end widget test: rejected because cancellation races and normalization need focused
  deterministic tests.
- Blanket golden updates: rejected because they can hide unrelated visual regressions.
- Add mocking or fake-time packages: rejected because handwritten fakes, completers, provider
  overrides, and WidgetTester virtual time are sufficient.
