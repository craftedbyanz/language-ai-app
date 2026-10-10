# Data Model: Grammar Vertical Slice

## Ownership and purity

All entities in this document belong to `features/grammar/domain` and are pure Dart. They have no
Flutter, Riverpod, JSON, generated API, storage, or platform dependencies. The in-memory repository
owns fixture construction; presentation owns only workflow state and localized product chrome.

Localization ownership is explicit: UI taxonomy/category labels are localized application chrome,
while topic titles, lesson titles/descriptions, source sentences, accepted answers, corrections,
hints, explanations, and tips are deterministic English authored learning content. Authored learning
content is not duplicated into ARB files.

## Domain entities

### GrammarTopic

Represents a selectable grouping in the Grammar Topic Picker.

| Field | Meaning | Validation |
|---|---|---|
| `id` | Stable topic identity used by typed navigation and lookup | Non-empty; unique in catalog |
| `categoryId` | Stable identity whose learner-facing UI taxonomy label comes from localized chrome | Non-empty; must exist in catalog categories |
| `title` | Deterministic English authored topic title; never sourced from ARB | Non-empty |
| `lessonCount` | Count shown on the topic card | Non-negative; equals related lessons count |

Relationship: one topic owns zero or more ordered `GrammarLesson` records through `topicId`.

### GrammarLesson

Represents a selectable Grammar lesson within exactly one topic.

| Field | Meaning | Validation |
|---|---|---|
| `id` | Stable lesson identity used by typed navigation and lookup | Non-empty; unique in catalog |
| `topicId` | Owning topic | Must reference an existing topic |
| `level` | English authored learner-facing proficiency label | Non-empty authored value |
| `title` | Deterministic English authored lesson title; never sourced from ARB | Non-empty |
| `description` | Deterministic English authored lesson summary; never sourced from ARB | Non-empty |
| `exercises` | Ordered sentence-correction steps | Non-empty for selectable lessons |

Relationship: one lesson owns an ordered list of `GrammarSentenceExercise` records.

### GrammarSentenceExercise

Represents one full-sentence correction task.

| Field | Meaning | Validation |
|---|---|---|
| `id` | Stable identity within the catalog | Non-empty; unique |
| `incorrectSentence` | English sentence the learner must rewrite | Non-empty and intentionally incorrect |
| `acceptedAnswers` | Authored correct full-sentence variants | Non-empty; no blank normalized values |
| `hints` | Ordered English authored hints | May be empty; no blank entries |
| `explanation` | English explanation shown for an incorrect response | Non-empty |
| `tips` | Ordered English authored improvement tips | May be empty; no blank entries |

The first accepted answer is the canonical correction displayed in incorrect feedback. Other
accepted answers are grading alternatives, not additional UI chrome.

### LearnerResponse

The exact string entered for the active exercise. It remains unchanged through Submit, Cancel, Fix,
and feedback minimization. It is cleared only after non-final Next or when the active lesson changes.

Validation: a whitespace-only response cannot be submitted. The original string is never replaced
by its normalized representation.

### GrammarVerdict

Immutable result returned by `GrammarRepository.grade`.

| Field | Meaning |
|---|---|
| `kind` | `correct` or `incorrect` |
| `originalResponse` | Exact submitted learner text |
| `correctedAnswer` | Canonical authored correction |
| `explanation` | Authored explanation for the exercise |
| `tips` | Authored tips for incorrect feedback |

The same exercise and response always produce the same verdict. The verdict has no score, threshold,
completion status, reward, AI payload, or persistence identifier.

## Grading normalization

Apply these operations, in order, to the response and each accepted answer:

1. Remove leading and trailing whitespace.
2. Convert letter case consistently.
3. Replace each run of internal whitespace with one space.

Do not remove or transform punctuation. Do not reorder words, correct spelling, infer meaning, or
apply locale-specific translation. Correctness is exact membership in the normalized accepted-answer
set.

## Repository relationships and lookup rules

- Categories and topics retain deterministic authored ordering.
- `lessonsForTopic(topicId)` returns only lessons whose `topicId` matches, preserving order.
- `lessonById(lessonId)` returns no lesson for an unknown identifier; it never silently substitutes
  the first lesson.
- `exerciseById(lessonId, exerciseId)` returns no exercise when either identity is unknown or the
  exercise does not belong to the lesson; it never substitutes another exercise.
- Empty topic and lesson collections are valid repository results and drive canonical empty states.
- `grade` has no network, storage, logging, mutation, random, clock, or locale dependency.

## Presentation state machine

All active exercise states carry the selected lesson and current exercise index. Derived values
expose the current exercise, one-based step, total count, and whether the current step is final.
`GrammarFinished` carries only terminal navigation identity, and `GrammarUnavailable` carries only
unavailable presentation/back-navigation information because no valid exercise workflow exists.

### GrammarAnswering

- Data: lesson, index, exact `answer`, optional last verdict.
- Submit is available only when `answer.trim()` is non-empty.
- A retained last verdict exists only after feedback was minimized.

### GrammarSubmitting

- Data: lesson, index, exact answer, request identity.
- Input and Submit are disabled; Loading and Cancel are visible.
- A second submit is ignored.
- Cancel invalidates the request identity and returns to `GrammarAnswering` with the exact answer.

### GrammarFeedbackCorrect

- Data: lesson, index, exact answer, correct verdict.
- Visible actions: disabled analysis link with localized reason, Next, close/minimize.
- No Fix action and no AI/network activity.

### GrammarFeedbackIncorrect

- Data: lesson, index, exact answer, incorrect verdict.
- Visible actions: Fix, Next, close/minimize.
- Fix returns to `GrammarAnswering` on the same exercise with the exact answer.

### GrammarFeedbackMinimized

- Data: lesson, index, exact answer, last verdict kind and content.
- The hint bar exposes Show Last Feedback.
- Reopen restores the corresponding visible feedback state without calling `grade`.

### GrammarFinished

- Data: topic and lesson identities needed for terminal navigation.
- Produced only once when Next is accepted from final visible feedback.
- Contains no completion statistics, reward, or persisted completion marker.

### GrammarUnavailable

- Data: localized presentation reason key and safe Back destination only; no fabricated content,
  verdict, grading request, or progress mutation.
- Produced when route/repository validation finds an unknown `topicId`, unknown or topic-mismatched
  `lessonId`, or unknown internal `exerciseId`.
- Presentation renders canonical unavailable/error content. It never initializes grading.

## State transition invariants

- Only `GrammarAnswering` with nonblank text may enter `GrammarSubmitting`.
- At most one submission request is current.
- A canceled or superseded request can never publish feedback.
- Correct/incorrect feedback is derived only from the repository verdict.
- Progress changes only through Next from visible feedback.
- Non-final Next increments the index exactly once and clears the answer.
- Final Next produces `GrammarFinished`; it never wraps to the first exercise.
- Minimize/reopen never changes index, response, verdict, or grading-call count.
- Invalid topic, lesson, or exercise identity never enters `GrammarSubmitting`, never calls `grade`,
  never fabricates fallback learning content, and never mutates progress.
