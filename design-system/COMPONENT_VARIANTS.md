# Component Variants

Canonical variant names. Use the `Component/Variant` form everywhere (code, prompts, docs). If a variant you need does not exist, add it here first (see [IMPLEMENTATION_CONTRACT.md](IMPLEMENTATION_CONTRACT.md)).

Each variant lists only what **differs** from the base component in [COMPONENTS.md](COMPONENTS.md).

---

## FeedbackSheet (one family, five verdict variants + loading)

Common frame (never varies): grabber, header row (verdict icon · coloured title · optional score · close), body, `FeedbackActionRow`. Width `layout.sheetWidth`, `radius.sheet`, `shadow.floating`, no scrim.

| Variant | Header | Body sections (in order) | Actions (`FeedbackActionRow`) | Extras | Evidence |
|---|---|---|---|---|---|
| `FeedbackSheet/WritingCorrect` | check icon, "excellent" title, `feedback.correct` (title text uses `accessible.successText`) | CorrectionDiff · explanation · Improvements bullets (purple) | `EditNext` | Rating thumbs | S056 |
| `FeedbackSheet/WritingIncorrect` | cross icon, "not correct" title, `feedback.incorrect` (title text uses `accessible.errorText`) | CorrectionDiff · explanation · Improvements bullets (purple) | `EditNext` | Rating thumbs; word lookup hint | S006 |
| `FeedbackSheet/GrammarCorrect` | check icon, "correct" title, `feedback.correct` (title text `accessible.successText`) | AnswerRecapBox only (compact) · link "view AI analysis" | `NextFull` | Compact height; no diff | S061 |
| `FeedbackSheet/GrammarIncorrect` | cross icon, "not correct" title, `feedback.incorrect` (title text `accessible.errorText`) | CorrectionDiff · explanation · Tips bullets (lime) | `FixNext` | | S060 |
| `FeedbackSheet/ConversationScoreFeedback` | thumbs icon, "close" (partial) title, `feedback.partial` (title text `accessible.partialText`), plus a score number ("fluency N") in `accessible.score{Low,Mid,High}Text` by band | CorrectionDiff · feedback paragraph · Mistakes bullets (orange) · AreasToImprove bullets (purple) | `CloseOnly` | Close × only; opened from `ScoreChip` | S028 |
| `FeedbackSheet/*` + `state=loading` | spinner, "Grading…" title (greyed) | Skeleton bars per section (`surfaceMuted`) | secondary "Cancel" | Applies to every verdict variant; correct grammar answers showed no loading frame (checked locally; INFERRED) | S055 |

Rules
- Section **labels are microLabels**, per variant copy. Copy is product content, not a token.
- The verdict set (`correct`, `incorrect`, `partial`) is open; if grammar or writing needs `partial` it reuses the conversation treatment.
- Unobserved variant combinations (Writing partial, Conversation correct/high-score) = use closest variant, record in DESIGN_DECISIONS.

### FeedbackActionRow variants
| Variant | Layout | Buttons |
|---|---|---|
| `EditNext` | two equal buttons | secondary "Edit" (returns to editor with text kept) · primary "Next" |
| `FixNext` | two equal buttons | secondary "Fix" (re-answer, text kept) · primary "Next" |
| `NextFull` | one full-width | primary "Next →" |
| `CloseOnly` | none (header close) | none |

All buttons are `Button/Primary` and `Button/Secondary` at size `Md`. Labels are product copy.

---

## ConversationShell

| Variant | Header centre | Bubbles | Composer | Extra regions | Evidence |
|---|---|---|---|---|---|
| `ConversationShell/Free` (`AppHeader/Modal`) | topic title | `ChatBubble/Ai` (white + hairline, EN + italic translation), `ChatBubble/User`, `ChatBubble/Typing` | `ChatComposer/Free` | `ScoreChip` under each learner bubble | S022–S028 |
| `ConversationShell/Scenario` (`AppHeader/Progress`) | `ProgressStepper/Scenario` (segments are data) | `ChatBubble/AiScripted` (grey; target-language line + italic gloss), `RoleLabel`, `ChatBubble/Task` | `ChatComposer/Scenario` | `HintChipBar`, scenario eyebrow (topic) | S064 |

Scenario-only components: `RoleLabel`, `ChatBubble/Task` (the *task*, not a sent message; carries a "translate this sentence" microLabel and a tail dot), `ChatComposer/Scenario`, scenario eyebrow. Everything else is shared with Free.

**Identity rule:** Scenario is `ConversationShell/Scenario`, never an independent screen family. It shares `AppHeader`, `ChatBubble`, `HintChipBar`, `ChatComposer`, `ProgressStepper`, `FeedbackSheet` and `Dialog/Confirm` with Free. It is selected by a **mode preference** selected on the conversation picker `FAB` (persisted), not a separate screen.

### ChatBubble variants
| Variant | Side | Fill | Text | Notes |
|---|---|---|---|---|
| `Ai` | left | `surface` + hairline | `textPrimary` + translation `textMuted` italic | translation hidden by menu toggle |
| `AiScripted` | left | `feature.scenario.aiBubble` | same | with `RoleLabel` |
| `User` | right | `feature.conversation.userBubble` | `accessible.onBrand` | single line becomes a pill |
| `Task` | right | `feature.scenario.taskBubble` | `accessible.onFeatureFill` | microLabel "translate this sentence" |
| `Typing` | left | `surfaceMuted` | three animated dots (motion untuned, DD-10) | |

### ChatComposer variants
| Variant | Placeholder | Send label | Notes |
|---|---|---|---|
| `Free` | "Type a message…" | arrow icon | |
| `Scenario` | "Translate to English…" | "Send"/"Go" text (label is product copy) | disabled when empty |

---

## AppHeader

| Variant | Leading | Centre | Trailing |
|---|---|---|---|
| `AppHeader/Pushed` | `BackButton` | title | optional text/icon action |
| `AppHeader/Modal` | close ("Close") | optional title | `More` menu button |
| `AppHeader/Progress` | close | `ProgressStepper` | `More` menu |
| `AppHeader/Search` | `BackButton` | `SearchField` | none |

## ProgressStepper
Segments are data; done/current/idle colours below; the current segment also has a 2 ru outline.
| Variant | Segments (data) | Done colour | Current | Evidence |
|---|---|---|---|---|
| `Writing` | 10 | `feature.writing.progress` | highlighted segment | S004–S007 |
| `Grammar` | 20 | `feature.grammar.progress` | highlighted | S058 |
| `Scenario` | 8 | `feature.scenario.progress` | `feature.scenario.progressCurrent` | S064 |

## ExerciseEditor
| Variant | SourceTextCard | AnswerInput | Extras |
|---|---|---|---|
| `Paragraph` | `SourceTextCard/Paragraph` with current-sentence highlight, direction swap icon | answer colour `answerPalette.defaults.writing` (purple) default | "More" menu (show all, background colour, hints, dictionary, like/dislike) |
| `Sentence` | `SourceTextCard/Sentence` | `answerPalette.defaults.grammar` (blue) default | "More" menu = same family; v1 default for the grammar subset: Background colour, Hints, Dictionary (omit Show all and the rating items) (DD-15) |

## AnswerInput / SourceTextCard
`AnswerInput` states: `empty`, `focused`, `filled`, `disabled`. `SourceTextCard/Paragraph | Sentence`.

## SubmitButton states
`disabled` (ring) · `enabled` (filled) · `loading` (enabled colour + spinner, non-interactive).

## ModeCard
| Variant | Fill | Notes |
|---|---|---|
| `ModeCard/Writing` | `feature.writing.homeCardFill` | index "01" |
| `ModeCard/Grammar` | `feature.grammar.homeCardFill` | index "02"; text colour must be re-checked once the fill is final (DD-13) |
| `ModeCard/Conversation` | `feature.conversation.homeCardFill` | index "03" |
State axis: `active` (full size) and `peek`.

## TopicCard
`TopicCard/Standard` · `TopicCard/Plus` (alias to `PlusTile`; rendered only when `paywallEnabled`, DD-24) · state `locked` (renders as `PlusTile`).

## LessonCard
| Variant | CTA fill | CTA label (content) |
|---|---|---|
| `LessonCard/Writing` | `feature.writing.cta` | Start |
| `LessonCard/Grammar` | `feature.grammar.cta` (dark label) | Quick fix |
| `LessonCard/Conversation` | `feature.conversation.cta` | Start chat |
Plus a `LessonCard/AiCreate` entry card at the end of the conversation list ("create a scenario").

## CategoryChip
`Filter` (selected: `warning` outline) · `Quick` (first highlighted: `primaryTint`).

## StatusBadge
`New` (`successTint` + `accessible.successText`) · `Count` ("N sets") · `PartOfSpeech` (`feature.srs.posBadgeBg` + `primary` text) · `Level` (translucent pill "LEVEL · A1") · `Plan` (e.g. "Free").

## Banner
`Banner/Promo` (only when `paywallEnabled`, DD-24) · `Banner/Feature`.

## Sheet
| Variant | Scrim | Content | Evidence |
|---|---|---|---|
| `Sheet/Feedback` | none | `FeedbackSheet` | S006 |
| `Sheet/Create` | none | multiline field · suggestion chips · CTA (disabled until text) | S030 |
| `Sheet/Info` | `overlayScrim.default` | icon rows with tinted rounded squares | S032 |
| `Sheet/Paywall` | none | `PaywallCard` | S045 |
| `Sheet/Composer` | none (full-window) | chips + gradient-bordered input + send | S046 |

## Dialog
`Dialog/Confirm`: title · body · neutral action (left, default focus) · destructive action (right). Copy: "Leave exercise?" family, used for exercises and conversations. Same component for every mode (S007, S062).

## FAB
`FAB/Collapsed` · `FAB/Expanded` (pills: `Mode` toggle (Free/Scenario), `Voice`, `Info`, `Close`).

## SettingsRow
`Navigate` · `Toggle` · `Info` · `Account`.

## SelectableRow
`Language` (flag + two lines + optional "coming soon" pill) · `Level` (CEFR left bar + description) · `Difficulty` (single line, radio).

## InsightCard
`Stat` · `StatGrid` · `Calendar/Month` · `Calendar/DotMatrix` · `WeekChart` · `History` (= `HistoryCard`, **required** by InsightTemplate History) (each has an `empty` state).

## SRSCard
`Front` · `Back`. State axis: `stack` (cards behind).

## SRSGradeButton
`Again` · `Hard` · `Good` · `Easy`.

## SegmentedControl
2-segment only observed; allow 2–3.

## PagerDots

`PagerDots/Lesson` is required below the horizontal Grammar lesson carousel. It exposes the current
one-based position and total count semantically and supports direct selection when a callback is
provided.

## Grammar vertical-slice additive states

- `SourceTextCard/Sentence`: optional localized instruction; absent by default.
- `AnswerInput`: optional external focus node; internal/default focus behavior remains unchanged.
- `HintChipBar`: optional show-last-feedback action; absent by default.
- `FeedbackSheet/GrammarCorrect`: analysis action may be disabled with a localized reason.
- `FeedbackSheet/*`: optional minimize callback; absent by default.
- `FeedbackSheet/Loading`: Cancel retains input and invalidates the active request.
`Dashboard` (lime active) · `Lesson` (dark pill active).

## PopupMenu
`Standard` · `WithSubmenu` (a chevron item opens a nested list) · item states `default | disabled`. Chat More menu = `Standard` with the DD-03 items.

## GlassButton
`Action` · `Radio`.

## Global state vocabulary (use these exact names)
`default · pressed · focused · selected · disabled · loading · empty · error` (`error` is rendered by `InlineError` / `EmptyState/Error`; DD-04 default).

## Button
`Primary` · `Secondary` · `Destructive` · `Accent` · `OnBrand` · `Link` · `Icon`; sizes `Sm | Md | Lg`; width `Hug | Full`.

## Skeleton / InlineError / EmptyState
`Skeleton` (no variants) · `InlineError` (no variants) · `EmptyState/Empty` · `EmptyState/Error`.

## GreetingBlock / PromptEntry / StreakPill
Single variant each.

## Cards that are one family
`ModeCard`, `TopicCard`, `LessonCard`, `DeckCard`, `InsightCard/History`, `Banner` share the **whole-card button** behaviour (PATTERNS P1) and differ only in anatomy, fill and size. Do not create a generic `Card` with free slots: build the named family.

## PaywallCard (OPTIONAL / DEFERRED)
`PaywallCard` contains `PlanCard` and `BenefitRow` parts. They are **parts, not families**; not built in the initial implementation (DD-24).
