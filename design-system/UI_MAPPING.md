# UI Mapping (traceability only)

> **Not required to implement any screen.** Do not read this file for normal work. Nothing here overrides a rule elsewhere in `design-system/`.

Maps every evidenced research state to the canonical design-system component or template. **Future coding agents normally do not need this file or `references/gramago/`.** Use it only when an explicitly documented design decision asks you to check evidence.

State ids are those of the archived research (`references/gramago/SCREEN_INDEX.md`). 63 ids, S038 unused, 62 distinct states (S058 = active alias of S010). Quality: **A** = active window + canonical viewport (colours usable), **I** = inactive window (structure only), **X** = alternate viewport or canvas (structure only), **AX** = accessibility tree only.

## Feedback family

| State | Maps to | Quality |
|---|---|---|
| S055 | `FeedbackSheet/*` `state=loading` (writing) | A |
| S056 | `FeedbackSheet/WritingCorrect` | A |
| S006 | `FeedbackSheet/WritingIncorrect` | I (colours from S056/S060) |
| S060 | `FeedbackSheet/GrammarIncorrect` | A |
| S061 | `FeedbackSheet/GrammarCorrect` | A |
| S028 | `FeedbackSheet/ConversationScoreFeedback` | A (rendered) |
| S027 | `ScoreChip` in `ConversationShell/Free` | A (86 instance), I (58 instance) |

## Exercise

| State | Maps to |
|---|---|
| S004 | `ExerciseTemplate` / `ExerciseEditor/Paragraph` (empty) |
| S005 | `ExerciseEditor/Paragraph` (filled, `SubmitButton` enabled) |
| S057 | `ExerciseEditor/Paragraph` step 2 + `HintChipBar` verdict chip |
| S010 / S058 | `ExerciseEditor/Sentence` (empty) |
| S059 | `ExerciseEditor/Sentence` (filled) |
| S051 | `PopupMenu/WithSubmenu` (editor More), X (908 canvas) |
| S007 | `Dialog/Confirm` |
| S062 | `Dialog/Confirm` (conversation / scenario copy) |

## Browse

| State | Maps to |
|---|---|
| S001 | `HomeDashboardTemplate` (`ModeCard`, `Banner`, `CategoryChip/Quick`, `FloatingBottomBar`) |
| S011 | `MenuOverlay` |
| S002 | `TopicPickerTemplate` (writing) |
| S008 | `TopicPickerTemplate` (grammar), `TopicCard/Plus` |
| S019, S020 | `TopicPickerTemplate` (conversation), `CoachMark` |
| S003 | `LessonListTemplate` / `LessonCard/Writing` |
| S009 | `LessonListTemplate` / `LessonCard/Grammar` |
| S021 | `LessonListTemplate` / `LessonCard/Conversation` + `LessonCard/AiCreate` |

## Conversation

| State | Maps to |
|---|---|
| S022 | `ConversationShell/Free` (AI opening) |
| S023 | `PopupMenu/Standard` (chat More), AX only |
| S024 | `ChatBubble/Ai` (translation hidden) |
| S025 | `ChatComposer/Free` (filled) |
| S026 | `ChatBubble/User` + `ChatBubble/Typing` |
| S063 | `FAB/Expanded` (mode = Scenario) |
| S064 | `ConversationShell/Scenario` (a.k.a. ScenarioVariant) |
| S029 | `Sheet/Create` family: scenario generator list (full-window picker) |
| S030 | `Sheet/Create` |
| S031 | `FAB/Expanded` |
| S032 | `Sheet/Info` |

## Flashcards / SRS

| State | Maps to |
|---|---|
| S012 | `FlashcardDeckTemplate` (list), `DeckCard` |
| S013 | `FlashcardDeckTemplate` (detail), `FlashcardDeckHeader`, `FlashcardRow`, `SegmentedControl` |
| S014 | `SRSReviewTemplate` tutorial overlay |
| S015 | `SRSCard/Front` |
| S052 | `SRSCard/Back`, `SRSGradeButton` ×4 |
| S053 | `PopupMenu/Standard` (SRS More), AX only |
| S054 | `FlowLetterGameTemplate` (deck source) |

## Utility and insight

| State | Maps to |
|---|---|
| S016 | `SettingsListTemplate` |
| S017 | `InsightTemplate` (History), `InsightCard/History` (= HistoryCard), `SearchField` |
| S018 | `InsightTemplate` (Streak), `InsightCard/Stat`, `Calendar/Month` |
| S033 | `InsightTemplate` (Insight), `StatGrid`, `Calendar/DotMatrix`, `WeekChart` |
| S043 | `SettingsDetailTemplate` (Language), `SelectableRow/Language` |
| S044 | `SettingsDetailTemplate` (Level), `SelectableRow/Level` |
| S045 | `PaywallTemplate` / `Sheet/Paywall` (view only; OPTIONAL / DEFERRED, DD-24) |
| S046 | `Sheet/Composer` |
| S047 | explainer article (uses `SectionHeader/Hero` + illustration card; X) |
| S048 | `SettingsDetailTemplate` (Lesson settings), `Toggle`, swatch grid; X |
| S049 | `SettingsDetailTemplate` (Appearance), style tiles, reorder rows; X |
| S050 | `SettingsDetailTemplate` (Voice), `EmptyState`; X |

## Flow Letter (game world)

| State | Maps to |
|---|---|
| S034 | tutorial overlay |
| S035, S039 | `FlowLetterGameTemplate` lobby (`GlassButton/Action`) |
| S036 | topic select list |
| S037 | round (`GameHUD`, `LetterTile`) |
| S040 | `GlassButton/Radio` (difficulty) |
| S041 | `Toggle` on glass |
| S042 | help |

## Evidence quality caveats by group

- Quality **I** (inactive window): S006, S008, S010, S012, S014, S016–S024, S045–S050 and others. Their structure maps, but all colours come from active siblings or are CANDIDATE.
- Quality **X**: S047–S050 (554×772), S051 (908 canvas).
- Quality **AX**: S023 (menu), S053 (menu), S028 (no AX elements; rendered visually).

## Deferred / unmapped

| Item | Why |
|---|---|
| Lesson completion | never observed; default `CompletionTemplate` (DD-01) |
| Conversation result after completed session | not observed (DD-02) |
| Scenario grading / next / completion | not observed (DD-06) |
| SRS graded → next, queue empty | not observed (DD-07) |
| Game solve / game-over | not observed (DD-16) |
| Error states | not observed (DD-04) |
