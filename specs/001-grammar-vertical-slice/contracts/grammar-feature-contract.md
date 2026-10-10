# Grammar Feature Contracts

These are internal client contracts. The feature exposes no HTTP endpoint, OpenAPI schema, storage
format, or inter-process protocol.

## Repository contract

`GrammarRepository` is the source-of-truth boundary for the Grammar catalog and grading.

### Catalog operations

- Return an ordered category collection for topic filtering.
- Return the ordered Grammar topic collection.
- Return ordered lessons belonging to a supplied topic identity.
- Return a lesson for a supplied lesson identity, or no value when it does not exist.
- Return an exercise for supplied lesson and exercise identities, or no value when either identity is
  unknown or the exercise does not belong to the lesson.
- Never substitute unrelated content for an invalid identity.
- Permit empty topic and lesson results so presentation can render canonical empty states.

### Grade operation

Input:

- One `GrammarSentenceExercise` from the repository catalog.
- The exact nonblank learner response.

Output:

- A future deterministic `GrammarVerdict` with correct/incorrect kind, original response, canonical
  correction, authored explanation, and authored tips.

Guarantees:

- Same exercise and response always yield the same verdict.
- Matching uses only the normalization rules in `data-model.md`.
- The operation performs no network, AI, storage, analytics, logging, or random work.
- The in-memory adapter is for this development slice. A production adapter must consume the
  backend's resolved verdict and must not replicate backend-owned grading policy.

## Provider and ViewModel contract

- `grammarRepositoryProvider` exposes the abstract repository and is overrideable by tests.
- The Grammar workflow provider is scoped to the selected lesson and disposes with that route.
- The ViewModel is the only writer of `GrammarExerciseState`.
- Route/provider initialization validates topic, lesson, and exercise identities before creating an
  answering state. Invalid identity yields `GrammarUnavailable`, makes no grading call, and does not
  mutate progress.
- The minimum Loading duration is injected or token-backed so tests can control time without a new
  timing package.
- Cancel invalidates the active request; late results are ignored.
- `GrammarFinished` is emitted once and contains only navigation identity.
- Screens render state and dispatch intent; they do not grade, normalize, or load concrete fixtures.

## Typed navigation contract

| Route | Path shape | Entry | Exit |
|---|---|---|---|
| `GrammarTopicRoute` | `/grammar` | Home Grammar card | Back to Home |
| `GrammarLessonRoute` | `/grammar/:topicId` | Topic selection | Back to picker |
| `GrammarExerciseRoute` | `/grammar/:topicId/:lessonId` | Lesson selection | Close/final Next to lesson list |

Route rules:

- App composition constructs route objects; feature code never constructs route strings.
- Unknown topic or lesson identities produce localized unavailable/empty content, not fallback data.
- An unknown `topicId` is presented by the lesson-list route; an unknown or topic-mismatched
  `lessonId` is presented by the exercise route; an unknown internal `exerciseId` is rejected by the
  repository/ViewModel boundary. Every case offers a safe typed Back destination.
- Final Next uses the typed lesson destination and never opens a completion route.
- Grammar's public barrel exports only the three screen contracts and the intentional `GrammarCopy`
  localized screen-input contract; app code does not deep-import internals.

## UI composition contract

| Region | Canonical reusable surface | Grammar-owned input |
|---|---|---|
| Home entry | `ModeCard/Grammar` Active | Localized `grammar`, `grammarDescription`, `learningModes`, and `explore`; canonical index `02`, Grammar fill/foreground, and route callback; no invented icon |
| Topic picker | `TopicCard`, filter chips, canonical picker composition | Topics/categories from repository |
| Lesson list | `LessonCard/Grammar`, lesson pager | Lessons for selected topic |
| Exercise progress | `ProgressStepper/Grammar` | Current index and lesson count |
| Prompt | `SourceTextCard/Sentence` | Visible localized instruction + English source sentence |
| Answer | `AnswerInput` canonical blue pair | Exact learner response |
| Hints | `HintChipBar` | Authored hints and optional last-feedback action |
| Submission | `SubmitButton` | Enabled/loading state and submit intent |
| Loading | `FeedbackSheet` loading state | Localized grading/cancel labels |
| Correct | `FeedbackSheet/GrammarCorrect` | Recap, disabled analysis state/reason, Next |
| Incorrect | `FeedbackSheet/GrammarIncorrect` | Correction, explanation, tips, Fix, Next |

Grammar must not fork or wrap these components into duplicate visual families. Reusable extensions
remain feature-agnostic and default-preserving for Writing.

## Localization contract

- Every product-chrome string comes from EN/VI ARB sources through `GrammarCopy`.
- `GrammarCopy` is intentionally exported by `features/grammar/grammar.dart` as the public localized
  screen-input contract because app composition owns generated localization. The feature does not
  import app-generated localization classes, and app code does not deep-import `grammar_copy.dart`.
- Page/navigation/action labels, UI taxonomy/category labels, empty/error/unavailable messages,
  feedback chrome, progress, and semantics are localized application chrome.
- Topic titles, lesson titles/descriptions, source sentences, answers, corrections, hints,
  explanations, and tips are identical English authored content under both locales and are not ARB
  values.
- The disabled analysis control exposes its localized unavailable reason to assistive technology.
- Progress, source, answer, hint, submit, feedback, empty-state, close, and confirmation semantics are
  localized.

## Adaptive and accessibility contract

- Layout uses available width and canonical compact/regular/wide classes only. Product terms map as
  compact → compact, medium → regular, and expanded → wide.
- Topic grid is one column on compact and two centered columns on regular/wide.
- Lesson cards use canonical viewport ratios and remain horizontally navigable.
- Feedback remains within canonical viewport margins and maximum height; body content scrolls when
  necessary while actions remain reachable.
- Touch, pointer, hover, Tab traversal, Enter/Space activation, Escape dismissal, focus restoration,
  live-region loading/verdict announcements, and non-color verdict cues are preserved where
  applicable.
