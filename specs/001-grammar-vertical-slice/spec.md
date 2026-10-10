# Feature Specification: Grammar Vertical Slice

**Feature Branch**: Not created (branch hook not configured)

**Created**: 2026-10-10

**Status**: Draft

**Input**: User description: "Implement the Grammar Vertical Slice for Lingua, covering Home through
topic and lesson selection, sentence practice, deterministic local feedback, and progression to the
next sentence. Reuse the canonical Grammar design system, support English and Vietnamese product
chrome and compact, medium, and expanded layouts, leave Writing unchanged, and exclude backend,
AI grading, lesson completion, other learning modes, accounts, and commerce."

## Clarifications

### Session 2026-10-10

- Q: What should happen to the canonical Grammar Correct sheet's “view AI analysis” link when
  backend and AI grading are outside this feature? → A: Show the link disabled with a localized
  unavailable explanation.
- Q: How long should Loading remain visible when local grading finishes almost immediately? → A:
  Show Loading for at least 300 milliseconds and allow cancellation during that interval.
- Q: What task should the learner perform for each displayed Grammar sentence? → A: Rewrite the
  entire sentence so it is grammatically correct.
- Q: Which language should Grammar exercises and expected answers use when product chrome supports
  English and Vietnamese? → A: Exercises and answers remain in English for both product locales.
- Q: What should happen when the learner chooses Next after feedback on the final sentence while a
  lesson-completion screen is out of scope? → A: Return to the Grammar Lesson List without a
  completion screen, rewards, or completion persistence.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Complete a Grammar Practice Turn (Priority: P1)

As a learner, I can enter Grammar from Home, select a topic and lesson, answer a sentence-based
exercise, submit my answer, see whether it is correct, and continue to the next sentence.

**Why this priority**: This is the smallest end-to-end journey that delivers the core value of
guided Grammar practice.

**Independent Test**: Start on Home with a catalog containing at least one topic, one lesson, and two
sentences. Select Grammar, choose the topic and lesson, submit a known correct answer, view the
loading and correct-feedback states, and advance exactly one sentence.

**Acceptance Scenarios**:

1. **Given** the learner is on Home, **When** they activate Grammar, **Then** the Grammar Topic Picker
   opens without changing the Writing entry or behavior.
2. **Given** Grammar topics are available, **When** the learner selects a topic, **Then** they see the
   Grammar lessons belonging to that topic in the canonical horizontal lesson carousel with
   `PagerDots/Lesson` position feedback.
3. **Given** Grammar lessons are available, **When** the learner selects a lesson, **Then** the first
   sentence exercise opens with a grammatically incorrect source sentence, an instruction to rewrite
   the entire sentence correctly, an answer field, hints, submit action, and progress.
4. **Given** the learner entered a response that matches an accepted answer, **When** they submit it,
   **Then** loading feedback is shown for at least 300 milliseconds before deterministic correct
   feedback for that response.
5. **Given** loading feedback is open, **When** the learner chooses Cancel, **Then** loading closes,
   no verdict is shown, progress does not advance, and the entered response remains available.
6. **Given** correct feedback is open on a non-final sentence, **When** the learner chooses Next,
   **Then** the next sentence opens, progress advances by exactly one, and the answer field is empty.
7. **Given** correct feedback is open, **When** the learner encounters the AI-analysis link, **Then**
   it is visibly disabled and a localized explanation communicates that the capability is unavailable.
8. **Given** feedback is open for the final sentence, **When** the learner chooses Next, **Then** the
   Grammar Lesson List opens without a completion screen, rewards, or saved completion state.
9. **Given** a direct Grammar lesson route contains an unknown `topicId`, **When** the route resolves,
   **Then** the canonical localized unavailable state is shown with a safe Back action, no unrelated
   topic or lesson is substituted, and no progress is created.
10. **Given** a direct Grammar exercise route contains an unknown `lessonId` or a lesson that does not
    belong to its `topicId`, **When** the route resolves, **Then** the canonical localized unavailable
    state is shown with a safe Back action and no exercise workflow is initialized.
11. **Given** an unknown `exerciseId` is encountered while initializing or grading the selected
    lesson, **When** the workflow validates the exercise, **Then** it shows the canonical localized
    unavailable state with a safe Back action, performs no grading, and does not mutate progress.

---

### User Story 2 - Learn From an Incorrect Answer (Priority: P2)

As a learner, I receive specific, consistent feedback when my answer is incorrect so I can inspect
the expected correction, try again, or continue practicing.

**Why this priority**: Incorrect feedback turns grading into learning and supports recovery without
forcing the learner to abandon the lesson.

**Independent Test**: Open any sentence exercise, submit a known incorrect answer, verify the loading
and incorrect-feedback states, choose Fix and confirm the original response is retained, then reopen
feedback and choose Next to advance one sentence.

**Acceptance Scenarios**:

1. **Given** the learner entered a response that does not match any accepted answer, **When** they
   submit it, **Then** loading feedback is shown before deterministic incorrect feedback containing
   the correction, explanation, and authored tips for that sentence.
2. **Given** incorrect feedback is open, **When** the learner chooses Fix, **Then** feedback closes,
   the response remains available for editing, and input focus returns to the answer field.
3. **Given** incorrect feedback is open on a non-final sentence, **When** the learner chooses Next,
   **Then** the next sentence opens and progress advances by exactly one regardless of the incorrect
   verdict.
4. **Given** feedback has been minimized or dismissed, **When** the learner activates the feedback
   affordance in the hint area, **Then** the most recent feedback reopens without regrading.

---

### User Story 3 - Practice Across Languages and Layouts (Priority: P3)

As an English- or Vietnamese-language learner using a supported screen or window size, I can follow
the same Grammar journey with understandable product chrome and unobstructed controls.

**Why this priority**: The core journey must remain usable for the supported locales and across
phones, tablets, and resizable desktop windows.

**Independent Test**: Repeat the browse, answer, feedback, and Next journey in English and
Vietnamese at representative canonical compact, regular, and wide widths, verifying that all
actions remain reachable and the meaning and progression remain equivalent. These canonical
classes correspond to the requested product terms compact, medium, and expanded respectively.

**Acceptance Scenarios**:

1. **Given** English is the active product language, **When** the learner completes the Grammar
   journey, **Then** all Grammar navigation, instructions, actions, states, and feedback chrome are
   presented in English.
2. **Given** Vietnamese is the active product language, **When** the learner completes the Grammar
   journey, **Then** all Grammar navigation, instructions, actions, states, and feedback chrome are
   presented in Vietnamese while English lesson content remains unchanged.
3. **Given** any canonical compact, regular, or wide supported viewport, **When** the learner uses each
   Grammar screen and feedback state, **Then** content reflows without clipped text, overlapping
   controls, hidden primary actions, or loss of reading and focus order.
4. **Given** the learner uses touch, pointer, or keyboard input, **When** they traverse and activate
   the Grammar journey, **Then** each interactive element has a clear name, visible state, and an
   equivalent non-gesture action.

### Edge Cases

- An empty or whitespace-only answer keeps Submit visible but disabled and produces no verdict.
- Additional submit attempts while grading is in progress do not produce duplicate verdicts or
  advance progress.
- Canceling during Loading returns to the current sentence with the exact response retained, no
  verdict recorded, and no progress change.
- Case differences and insignificant leading, trailing, or repeated whitespace do not turn an
  otherwise accepted answer into an incorrect result; punctuation and word order remain meaningful.
- Choosing Fix retains the learner's exact entered response, including an incorrect response.
- Choosing Next after either verdict advances one and only one sentence and clears the prior answer.
- Minimizing and reopening feedback preserves the latest verdict and does not grade again.
- The AI-analysis link in correct feedback remains disabled, cannot receive activation, and does not
  initiate network or AI activity.
- Topic and lesson collections with no available items show a clear empty state and do not expose an
  unusable selection action.
- Unknown topic, lesson, or exercise identities never crash, never substitute fabricated or unrelated
  learning content, and never initialize grading or mutate progress; they show the canonical localized
  unavailable state with a safe Back action.
- Long localized labels, large text, short windows, and on-screen keyboards do not hide the current
  prompt, answer field, feedback actions, or Next action.
- Choosing Next after feedback on the final sentence returns to the Grammar Lesson List without a
  completion screen, rewards, or saved completion state.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Home MUST make the existing canonical `ModeCard/Grammar` actionable so it opens the
  Grammar Topic Picker. The active card MUST use localized `grammar`, `grammarDescription`,
  `learningModes`, and `explore` copy; canonical Grammar index `02`, fill, foreground, and category
  semantics; and no invented icon because canonical `ModeCard` has no icon slot. Writing content,
  navigation, state, grading, card copy, and visual behavior MUST remain unchanged, and other
  out-of-scope modes MUST remain disabled with their existing localized unavailable copy.
- **FR-002**: The Grammar Topic Picker MUST present the available Grammar topics and allow the learner
  to select one topic.
- **FR-003**: Topic selection MUST open a Grammar Lesson List containing only lessons associated with
  the selected topic, composed as the canonical horizontal `LessonCard/Grammar` carousel with
  `PagerDots/Lesson`.
- **FR-004**: The learner MUST be able to select a Grammar lesson and open its first available
  sentence exercise.
- **FR-005**: Each exercise MUST present one grammatically incorrect source sentence, an instruction
  to rewrite the entire sentence correctly, current progress, an answer field, authored hints, and a
  submit action as one focused task.
- **FR-006**: The Grammar journey MUST reuse the canonical `TopicCard`, `LessonCard/Grammar`,
  `PagerDots/Lesson`, `ProgressStepper/Grammar`, `SourceTextCard/Sentence`, `AnswerInput`,
  `SubmitButton`, `HintChipBar`, `ExerciseTemplate`, `FeedbackSheet/Loading`,
  `FeedbackSheet/GrammarCorrect`, and `FeedbackSheet/GrammarIncorrect` definitions without creating
  Grammar-specific duplicates.
- **FR-007**: The Grammar answer surface MUST use the canonical Grammar blue answer-palette
  background and its paired foreground treatment.
- **FR-008**: Submit MUST remain visible and disabled until the response contains a non-whitespace
  character, and MUST become unavailable for additional submission while grading is in progress.
- **FR-009**: Submitting an answer MUST enter the canonical loading-feedback state for at least 300
  milliseconds before showing a verdict, while preserving the sentence and learner response behind
  the feedback. Cancel MUST remain available during that interval and MUST return to the same
  sentence with the response retained, no verdict recorded, and no progress change.
- **FR-010**: Grading MUST occur locally and deterministically without a backend, network request, or
  AI service.
- **FR-011**: A response MUST be correct when its normalized value exactly matches any authored
  accepted answer for the current sentence. Normalization MUST ignore letter case and insignificant
  leading, trailing, and repeated whitespace, and MUST preserve punctuation and word order.
- **FR-012**: The same exercise and response MUST always produce the same verdict, independent of the
  active product language, supported platform, and viewport size.
- **FR-013**: Correct grading MUST show the canonical compact Grammar Correct feedback with an answer
  recap and a single Next action. Its AI-analysis link MUST remain visible but disabled, MUST have a
  localized unavailable explanation, and MUST NOT initiate network or AI activity.
- **FR-014**: Incorrect grading MUST show the canonical Grammar Incorrect feedback with the learner's
  response, expected correction, authored explanation, authored tips, Fix, and Next actions.
- **FR-015**: Fix MUST close incorrect feedback, retain the learner's exact response, and return the
  learner to editing the same sentence.
- **FR-016**: Next from either correct or incorrect feedback on a non-final sentence MUST advance
  exactly one sentence, advance progress exactly once, clear the answer field, and make the next
  prompt ready for input.
- **FR-017**: After a verdict, the learner MUST be able to reopen the most recent feedback from the
  canonical feedback affordance without submitting or grading again.
- **FR-018**: All Grammar application chrome MUST be available in English and Vietnamese, including
  page titles, navigation labels, action labels, empty/error/unavailable messages, feedback chrome,
  progress/semantic labels, and UI taxonomy/category labels. Authored learning content—topic title,
  lesson title, lesson description, source sentence, accepted answers, correction, hints,
  explanation, and tips—MUST remain deterministic local English content in both product locales,
  MUST NOT be duplicated into ARB files, and MUST NOT be translated or otherwise mutated when the
  chrome language changes.
- **FR-019**: The Grammar flow MUST provide equivalent content and actions across canonical compact,
  regular, and wide layouts, with reflow based on available space rather than device category. These
  classes map the requested product terms as compact → compact, medium → regular, and expanded →
  wide.
- **FR-020**: Grammar screens and feedback MUST expose meaningful labels, progress, verdicts, focus
  order, keyboard activation, and non-color indicators so the journey is operable without relying on
  a single input method or color alone.
- **FR-021**: Topic and lesson browsing MUST provide understandable empty states when their respective
  collections contain no selectable content. Unknown `topicId`, `lessonId`, or internal `exerciseId`
  values MUST produce a canonical localized unavailable/error state with a safe Back action, MUST NOT
  fabricate fallback learning content, MUST NOT initialize grading for invalid exercise state, and
  MUST NOT mutate progress.
- **FR-022**: The feature MUST NOT add backend integration, AI grading, a lesson-completion screen,
  completion rewards, completed-lesson persistence, Conversation, Scenario, Flashcards/SRS,
  authentication, paywall, purchase behavior, or changes to Writing.
- **FR-023**: Next from feedback on the final sentence MUST return the learner to the Grammar Lesson
  List without showing a completion screen, awarding a reward, or recording lesson completion.

### Key Entities *(include if feature involves data)*

- **Grammar Topic**: A learner-facing grouping of related Grammar lessons; its taxonomy/category label
  is localized application chrome, while its authored title is deterministic English learning
  content. It has an ordered collection of lessons.
- **Grammar Lesson**: A selectable unit within one topic; its title and description are deterministic
  English authored learning content, and it has an ordered collection of sentence exercises.
- **Grammar Sentence Exercise**: One practice step containing a grammatically incorrect source
  sentence, one or more authored full-sentence corrections accepted as answers, hints, an
  explanation, and optional tips.
- **Learner Response**: The exact text entered for the current sentence, retained when the learner
  chooses Fix and cleared when the learner advances.
- **Grammar Verdict**: A deterministic correct or incorrect result for one exercise and response,
  together with the authored feedback needed by the applicable canonical feedback state.
- **Practice Progress**: The current sentence position and total sentence count for the active
  lesson; advances only through Next after a verdict.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: In moderated acceptance testing, at least 90% of learners can navigate from Home to a
  first Grammar verdict and then to the next sentence without assistance within two minutes.
- **SC-002**: The implementation remains portable across Android, iPhone/iOS, iPadOS, and macOS. The
  deterministic grading test set covering accepted answers, case variations, whitespace variations,
  and known incorrect answers MUST receive the expected verdict in 100% of shared automated cases.
  Every build or runtime target available in the validation environment MUST also be validated by the
  platform matrix. An unavailable build or runtime target MUST be recorded as `UNVERIFIED`, MUST NOT
  be reported as `PASS`, and MUST NOT by itself make local implementation completion impossible.
- **SC-003**: Repeating the same sentence and response 100 times produces one identical verdict and
  identical progression behavior every time, with no external connectivity.
- **SC-004**: Every Grammar product-chrome string and state in the defined journey has a non-empty
  English and Vietnamese localization value, with zero missing keys, fallback-key output, or
  mixed-locale labels in automated UI checks. Linguistic-quality approval is a separate human review
  outside the automated implementation gate.
- **SC-005**: All defined screens and states pass visual and interaction review at representative
  canonical compact, regular, and wide widths with zero clipped text, overlap, unreachable primary
  action, or reading-order defect.
- **SC-006**: All primary Grammar actions can be reached and activated by touch, pointer, and keyboard,
  and all progress and verdict information is understandable without color alone.
- **SC-007**: Regression review finds zero observable changes to the existing Writing experience,
  including its Home entry, navigation, content, controls, state, grading, and feedback.
- **SC-008**: From either a correct or incorrect verdict on a non-final sentence, Next advances exactly
  one sentence in 100% of progression tests and never carries the prior answer into the next input.
- **SC-009**: From either verdict on the final sentence, Next returns to the Grammar Lesson List in
  100% of terminal-flow tests without showing completion UI, awarding rewards, or recording
  completion.

## Assumptions

- The Grammar catalog is curated product content available to the client and contains at least two
  sentence exercises for the end-to-end progression demonstration.
- Accepted answers, corrections, explanations, hints, and tips are authored with each exercise; this
  feature does not generate feedback.
- Grading normalization ignores case and insignificant whitespace only. Broader linguistic
  equivalence, alternate punctuation, spelling tolerance, and semantic interpretation are excluded
  unless represented explicitly as accepted answers.
- Product chrome follows the learner's existing application locale; selecting or persisting a locale
  is not part of this feature.
- Authored topic titles, lesson titles/descriptions, exercise content, feedback explanations/tips,
  and learner answers use English regardless of the active product locale. UI taxonomy/category
  labels are localized application chrome.
- Practice progress lasts for the active lesson session. Resume, cross-device synchronization,
  completion UI, completion rewards, and completed-lesson persistence are outside this slice; the
  final Next action only returns to the Grammar Lesson List.
- Product layout terms map to the canonical implementation vocabulary as compact → compact, medium →
  regular, and expanded → wide; the specification introduces no new layout thresholds.
- Human linguistic-quality review may be performed by product/content owners, but it is not an
  automated implementation gate for this slice.
- The loading state communicates grading progress even though grading is local; it does not imply a
  remote call or AI processing.

### Dependencies

- The approved Home experience and its canonical Grammar entry point are available for extension.
- The canonical component variants, screen templates, localization conventions, accessibility
  expectations, and responsive behavior in `design-system/` remain authoritative.
- The existing Writing experience is the non-regression baseline and is not a dependency to modify.
