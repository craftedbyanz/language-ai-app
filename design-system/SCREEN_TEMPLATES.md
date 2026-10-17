# Screen Templates

Page archetypes. Compose screens **only** from [COMPONENTS.md](COMPONENTS.md) / [COMPONENT_VARIANTS.md](COMPONENT_VARIANTS.md). Content (lesson text, copy, topic names) is a slot, never baked into the template.

Common rules for all templates
- **Page canvas**: `color.background` for browse screens (Home, pickers, lesson list, exercise, settings); `color.backgroundPlain` for data/list/chat screens (flashcards, insight, history, streak, conversation). Cards are `surface`.
- **Scroll**: the page body scrolls; `AppHeader`, `ChatComposer`, `SubmitButton` row and `FloatingBottomBar` stay fixed. Reserve bottom padding for any fixed bar.
- **Loading** (every template): keep the page header and controls visible while data arrives. Use `Skeleton` blocks in the shape of list and carousel content; the TopicPicker uses a small spinner in its grid region, as observed in the live app. Never replace the whole page with a blocking spinner.
- **Error** (every template): `InlineError` / `EmptyState/Error` in the failed region, with Retry (DD-04).
- **Empty** (every list region): `EmptyState` with a one-line explanation and, where an action exists, one `Button/Link`.
- Margins: `layout.marginDashboard` on the dashboard; `layout.marginScreen` elsewhere.
- Vertical rhythm from the `space.*` scale; sections separated by `space.xl`+.
- Empty / loading / error: use the template-wide defaults below (DD-04); a template may add more specific states.
- Each template lists its **state transitions** in shorthand; full flows are in [INTERACTION_PATTERNS.md](INTERACTION_PATTERNS.md).

---

## 1. HomeDashboardTemplate
**Regions (top → bottom)**: `GreetingBlock` · `PromptEntry` · `Banner/Promo` (non-purchasing Home preview, DD-31) · "learning modes" `SectionHeader/Section` + mode carousel (`ModeCard/Writing|Grammar|Conversation` + `PagerDots/Dashboard`) · "Gramify recommends" heading/caption + quick-topic chips (first highlighted; two groups of five wrapping on narrow windows) · `Banner/Feature` (flashcards) · `FlowLetterTile` (full-width word-game preview) · "Gramify 101" heading/caption + seven illustrated `HomeGuideTile`s · `FloatingBottomBar` (overlay, bottom). DD-31 enables the explainer rail following the explicit Home parity request.
**Hierarchy**: greeting (title) → modes (largest cards) → quick topics → feature banners.
**Slots**: user name, streak count, locale flag button, per-mode copy, banner content.
**Navigation**: mode card → TopicPickerTemplate; `PromptEntry` → `Sheet/Composer`; chip → quick-start sheet → available writing practice (DD-31; generation remains pending); guide tile → localized explainer sheet with an optional existing-feature shortcut; `Banner/Promo` → read-only preview (purchase flow deferred); `Banner/Feature` → FlashcardDeckTemplate; bottom bar → history / streak / MenuOverlay / settings; learning-language flag → SettingsDetailTemplate/LearningLanguage (DD-26; separate from app locale).
**Transitions**: full-width bottom dock fixed to the window edge; MenuOverlay is an overlay state of this template.
**Responsive**: Home fills the window minus dashboard margins (DD-27); modes carousel width ratio-based with proportional height; chips wrap in two source-order groups, explainers use a horizontal rail, and the dock spans the available width. Only on this template is the dock shown.
**Spacing**: regions separated by `space.xl`; section header → content `space.lg`; scroll content gets bottom padding = bar height + `space.lg`.
**Variants**: first-visit hints (`CoachMark`). Loading: carousel `Skeleton` cards. Empty: not applicable (static content).
**Evidence**: S001, S011.

## 2. TopicPickerTemplate
**Regions**: `AppHeader/Pushed` (trailing optional "AI"/create action) · `SectionHeader/Hero` · `CategoryChip/Filter` rail (horizontal) · topic grid (`TopicCard/Standard`, `TopicCard/Plus`).
**Hierarchy**: hero → filters → grid.
**Slots**: mode (drives hero accent), category list, topic list (dynamic ordering).
**Margins**: `marginScreen`; grid 2 columns, gap `gridGap`.
**Navigation**: topic card → LessonListTemplate; chip filters in place; trailing action → create sheet/AI scenario.
**Transitions**: filter select → grid refresh (animation unspecified).
**Responsive**: 2 columns → 1 column below the compact breakpoint; chip rail scrolls.
**Mode variants**: `Writing`, `Grammar`, `Conversation` (conversation: few topics, extra "customise" `FAB`, one-time `CoachMark`).
**States**: loading = a grid-region spinner while the hero and filters remain visible; empty topics (filter yields none) = `EmptyState` with "Clear filter" link; `TopicCard/Plus` first only when `paywallEnabled`.
**Evidence**: S002, S008, S019, S020, S031.

## 3. LessonListTemplate
**Regions**: `AppHeader/Pushed` · `SectionHeader/Hero` ("lessons") · horizontal `LessonCard/*` carousel · `PagerDots/Lesson`.
**Slots**: lesson number, level, title, description, mode CTA, optional trailing `LessonCard/AiCreate` (conversation).
**Navigation**: CTA → ExerciseTemplate (writing, grammar) or ConversationTemplate (free) / ScenarioConversationTemplate (when persisted mode = Scenario).
**Transitions**: closing an exercise (after confirm) lands here.
**Responsive**: card width = `layout.lessonCardWidthRatio` × viewport (0.9 on compact), snap to start, `layout.carouselGap`; hero `SectionHeader/Hero` above, `PagerDots/Lesson` centred `space.lg` below the carousel.
**States**: loading = 1 skeleton card; empty = `EmptyState`.
**Evidence**: S003, S009, S021.

## 4. ExerciseTemplate (writing, grammar)
**Regions**: `AppHeader/Progress` (close · `ProgressStepper` · More) · `SourceTextCard` · `AnswerInput` card · `HintChipBar` · `SubmitButton` · `FeedbackSheet` (floating overlay).
**Hierarchy**: source → answer → submit; feedback appears over the work.
**Slots**: step index/count, source text, current-sentence range, answer palette key (user pref, `answerPalette`), hint list.
**Variants**: `ExerciseEditor/Paragraph` (writing), `ExerciseEditor/Sentence` (grammar).
**Navigation**: close → `Dialog/Confirm` (if input exists) → LessonList; menu items alter view (show all, background colour, hints, lookup, rate).
**Transitions**: empty → filled (submit enabled) → submitting → loading sheet → verdict sheet → Edit/Fix (back to filled, text kept) or Next (next step; fresh empty editor, stepper advances; sparkle chip present). Correct Writing adds compact recap → optional analysis loading → detailed feedback before Edit/Next; Next is also available from the recap.
**Completion** (after final step): `CompletionTemplate` (§14, DD-01 default).
**Layout order (top → bottom)**: header · source card (`SourceTextCard`) · answer card (flex 1) · hint bar · submit row; gaps `space.lg`; the feedback sheet floats above the hint bar/submit row, bottom offset `margin`.
**States**: loading/error on grading → `FeedbackSheet` loading / `InlineError` inside the sheet body, text kept (DD-04).
**Responsive**: answer card fills remaining height; below compact, SourceTextCard becomes collapsible (recommended default, ESTIMATED).
**Evidence**: S004–S007, S010, S051, S055–S061.

## 5. ConversationTemplate (free chat)
**Regions**: `ConversationShell/Free`: `AppHeader/Modal` (close · title · More) · scrolling bubbles · `ChatComposer/Free` · `ScoreChip` under learner bubbles · `FeedbackSheet/ConversationScoreFeedback` (floating).
**Slots**: topic title, AI opening message, translations (toggle).
**Navigation**: More → [toggle translation, (disabled item), end session]; end session / close → `Dialog/Confirm` → LessonList. No result screen in v1 (DD-02 default).
**Transitions**: AI opens → learner types → send → typing indicator → AI reply + ScoreChip → chip tap → sheet.
**States**: loading first turn = `ChatBubble/Typing`; reply failure = `InlineError` row in the log with Retry (message kept); empty log is impossible (AI speaks first).
**More menu items** (DD-03 default): "Hide/Show translation", "End session".
**Responsive**: bubble max width ratio; composer sticks to the bottom/keyboard.
**Evidence**: S022–S028, S062.

## 6. ScenarioConversationTemplate
**Regions**: `ConversationShell/Scenario`: `AppHeader/Progress` (close · `ProgressStepper/Scenario` · More) · scenario eyebrow · bubbles (`AiScripted`, `Task`, `RoleLabel`) · `HintChipBar` · `ChatComposer/Scenario`.
**Slots**: scenario topic, role names, scripted AI line (+ gloss), target-language task line, step count.
**Navigation**: close → `Dialog/Confirm` → LessonList.
**Transitions**: opening → learner types translation → send → `FeedbackSheet/WritingCorrect|Incorrect` → Next appends the next `AiScripted` + `Task` bubbles and advances the stepper (DD-06 default); after the last step → `CompletionTemplate`.
**More menu items**: same as Free.
**Evidence**: S063, S064.

## 7. FlashcardDeckTemplate
**Regions**: `AppHeader/Pushed` · `FlashcardDeckHeader` (counters, review CTA, `SegmentedControl`) · `FlashcardRow` list.
**Variants**: Deck list (`DeckCard` carousel/list) vs deck detail.
**Navigation**: deck → detail; "Review" → SRSReviewTemplate (tutorial first time); "game" tab → FlowLetterGameTemplate (deck source).
**Slots**: counters, words.
**States**: loading = `Skeleton` rows; empty deck = `EmptyState` (Review CTA disabled).
**Layout**: header (full-bleed `accessible.brandFill`, `radius.card` bottom corners) then `SegmentedControl` then list; row gap `space.sm`.
**Evidence**: S012, S013.

## 8. SRSReviewTemplate
**Regions**: `AppHeader/Modal` (close · More) · `SRSCard/Front|Back` stack · persistent `SRSGradeButton` row below both sides. Live GramaGo shows all four grade actions on the front and back.
**Transitions**: front → tap/Space flips → back + 4 grades → grade → next card Front → empty queue → `EmptyState` "Review complete" + "Back to deck" (DD-07 default). Close needs no confirmation. The first-run tutorial overlay is out of v1 (DD-25).
**Layout**: centred `SRSCard` (stack of 2 decorative cards behind, offset `space.sm`), `SRSGradeButton` row below the card with `space.lg` gaps, bottom-anchored.
**Slots**: word, POS, IPA, translation, gloss, example, intervals.
**Responsive**: card width capped; grade buttons stay in one row.
**Evidence**: S014, S015, S052, S053.

## 9. SettingsListTemplate
**Regions**: `AppHeader/Pushed` titled Profile · centred double-ring avatar/plan badge/name · Plus preview banner with a separate Upgrade pill · "Studying" language card with flag, two-line English label and A1 badge · "General settings" single grouped card with nine GramaGo rows followed by the client-only App language preference · "Other" grouped card with feedback/legal/sign-out rows · centred app version and product footer. Settings rows use circular icon backgrounds and light chevrons. The banner and Upgrade label are visual previews while the paywall route is deferred.
**States**: static; toggles apply immediately; loading none.
**Slots**: rows (navigate, toggle, info); some rows leave the app (external links).
**Navigation**: row → SettingsDetailTemplate.
**Responsive**: rows full width; single column.
**Evidence**: S016.

## 10. SettingsDetailTemplate
**Regions**: `AppHeader/Pushed` (back labelled by parent title) · optional intro · control group (`SelectableRow`, `Toggle`, swatch grid, style tiles, reorder rows) · optional primary CTA (full-width).
**Variants**: Language (`SelectableRow/Language` + "coming soon"), Level (`SelectableRow/Level` + CTA), Lesson settings (swatches, toggles), Appearance (style tiles, reorder), Voice (`EmptyState`).
**State**: changes apply on explicit CTA for language/level; immediate for toggles (observed pattern, language CTA never pressed, so persistence is INFERRED).
**Evidence**: S043, S044, S048–S050.

## 11. InsightTemplate
**Regions**: `AppHeader/Pushed` · `InsightCard/StatGrid` (3×2) · `InsightCard/Calendar` · `InsightCard/WeekChart`.
**Variants**: Insight overview; Streak (ON FIRE summary with large animated layered flame (DD-10a; static under reduced motion) · navigable month calendar · current/longest stat cards); History/Review (centred title · trailing search · grouped `HistoryCard` rails).
**Empty**: zero-data (all zeros, empty chart, P21); populated = same layout with data.
**History variant** (requires `InsightCard/History`): `AppHeader/Search` · per-type group (header + trailing "See more") · horizontal rail of `InsightCard/History`; no results → `EmptyState`.
**Evidence**: S017, S018, S033.

## 12. FlowLetterGameTemplate
**Visual world**: full-bleed gradient (`feature.flowLetter.gradient.*`) + glass.
**Regions**: lobby (`GlassButton/Action` list, resume entry) · topic select (list) · round (`GameHUD`, `LetterTile` field) · difficulty (`GlassButton/Radio`) · settings (toggles) · help.
**Navigation**: own back stack ("Back"/"Close"); close exits **without confirmation**, even mid-round.
**Unobserved**: solve, wrong word, level-up, game over (DD-16).
**Evidence**: S034–S037, S039–S042, S054.

## 13. PaywallTemplate
**Regions**: `Sheet/Paywall` over the dashboard: close · hero wordmark · PlanCard ×2 · `BenefitRow` ×6 · full-width CTA · restore/terms.
**Selection**: one plan pre-selected (the longer plan with the longer trial in the research).
**Constraint**: layout only. Purchasing logic is out of scope.
**Status**: **OPTIONAL / DEFERRED** (DD-24). Not required by any other template when `paywallEnabled` = false.
**Evidence**: S045 (view-only).

---

## 14. CompletionTemplate (DD-01 default, pending product approval)
**Regions**: `Sheet/Info`-style floating card (centred, `layout.dialogWidth`+ up to `layout.sheetWidth`, no scrim change) over the lesson list · heading ("Lesson complete" is product copy) · `InsightCard/Stat` ×2–3 (steps completed, corrections, streak; values from props) · `Button/Primary` "Next lesson" · `Button/Secondary` "Done".
**Navigation**: Done → LessonListTemplate; Next lesson → next lesson's exercise (disabled when none).
**Used by**: ExerciseTemplate and ScenarioConversationTemplate after the final step. Free conversation does not use it (DD-02).
**States**: static. Reduced motion: no confetti, no scale.
**Status**: DEFAULT, built only from existing components. Comment `// DD-01 default` at the call site.

---

### Template ⇒ component coverage check
Every component used above exists in COMPONENTS.md: AppHeader, BackButton, FloatingBottomBar, MenuOverlay, Dialog, Sheet, FAB, SegmentedControl, PagerDots, SectionHeader, GreetingBlock, PromptEntry, StreakPill, ModeCard, TopicCard, PlusTile, LessonCard, CategoryChip, Banner, FlowLetterTile, SearchField, EmptyState, InlineError, Skeleton, Button, CoachMark, ProgressStepper, HintChipBar, ExerciseEditor, SourceTextCard, AnswerInput, SubmitButton, FeedbackSheet (+ children), ConversationShell, ChatBubble, RoleLabel, ChatComposer, ScoreChip, FlashcardDeckHeader, DeckCard, FlashcardRow, SRSCard, SRSGradeButton, SettingsRow, SelectableRow, Toggle, InsightCard (incl. `InsightCard/History`), GameHUD, LetterTile, GlassButton. PaywallCard (with its parts `PlanCard`, `BenefitRow`) is **OPTIONAL / DEFERRED** with `PaywallTemplate` and `PlusTile`.

**Pseudo-component resolution**
- `HistoryCard` = `InsightCard/History`. **Required** by InsightTemplate (History variant); fully specified in COMPONENTS.md §7.
- `BenefitRow`, `PlanCard` = parts of `PaywallCard`; **OPTIONAL / DEFERRED** (DD-24). Not built in v1; specified inside the `PaywallCard` entry for when it is.


### Learning language and level (DD-26)
Home's trailing flag and Profile's learning-language card open the same learning-language screen. English is selected; Korean, Chinese and Japanese are disabled with Coming soon. The current-level row opens a CEFR A1–C2 list. Its confirmation updates the parent draft; parent confirmation persists the preference. Both screens use pushed headers, constrained scrolling content and a bottom CTA. App-language settings remain a separate route.
