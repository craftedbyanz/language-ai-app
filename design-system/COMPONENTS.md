# Components

Reusable component **families**. Differences between uses are expressed as **variants** (named `Component/Variant`) defined in [COMPONENT_VARIANTS.md](COMPONENT_VARIANTS.md). Never create a screen-specific duplicate of a component.

All values reference [TOKENS.json](TOKENS.json) by path. Dimensions given as numbers are `ru` (reference units at the canonical 788×1083 viewport) and are tokens-in-waiting, not coordinates: resolve them through [RESPONSIVE_RULES.md](RESPONSIVE_RULES.md).

Conventions used in every entry:
- **States**: default, pressed, focused, disabled, selected, loading are assumed for any interactive component unless stated. Only states with evidence or required by accessibility are listed.
- **Evidence** lists state ids (see [UI_MAPPING.md](UI_MAPPING.md)).
- Confidence is inherited from the tokens used. Component-level confidence is given where the *structure* is less certain than the tokens.

Naming aliases (components that exist as variants, not as separate families): `ScenarioComposer` = `ChatComposer/Scenario`; `TranslationTaskBubble` = `ChatBubble/Task`; `RoleLabels` = `RoleLabel`; `ScenarioVariant` = `ConversationShell/Scenario`; `HintChipBar`, `ProgressStepper` and `ChatBubble` are shared with Free chat and the exercises.

Index

1. Navigation & chrome: AppHeader · BackButton · FloatingBottomBar · MenuOverlay · PopupMenu · Dialog · Sheet · FAB · SegmentedControl · PagerDots
2. Browse & content: SectionHeader · ModeCard · TopicCard · PlusTile · LessonCard · CategoryChip · Banner · FlowLetterTile · StatusBadge · SearchField · EmptyState · CoachMark
3. Exercise: ProgressStepper · HintChipBar · ExerciseEditor · SourceTextCard · AnswerInput · SubmitButton
4. Feedback: FeedbackSheet · CorrectionDiff · FeedbackBulletList · FeedbackActionRow · AnswerRecapBox
5. Conversation: ConversationShell · ChatBubble · RoleLabel · ChatComposer · ScoreChip
6. Flashcards & SRS: FlashcardDeckHeader · DeckCard · FlashcardRow · SRSCard · SRSGradeButton
7. Settings & selection: SettingsRow · SelectableRow · Toggle · PaywallCard · InsightCard
8. Game: GameHUD · LetterTile · GlassButton
9. Actions & home surfaces (added by QA): Button · Skeleton · InlineError · GreetingBlock · PromptEntry · StreakPill
10. Composition constraints (every family, one table)

Colour roles: a component entry that names a raw `color.*` fidelity token for TEXT, an outline or a state indicator is read through the **accessible-production** mapping in [ACCESSIBILITY.md](ACCESSIBILITY.md) §8A (`accessible.*` tokens). Fills, dots and decorative icons keep the raw token. Default profile = production.

---

## 1. Navigation & chrome

### AppHeader
- **Purpose**: top bar for every non-dashboard screen.
- **Anatomy**: leading slot (BackButton or close) · centre slot (title **or** ProgressStepper) · trailing slot (0–1 action).
- **Variants**: `Pushed`, `Modal`, `Progress`, `Search` (→ COMPONENT_VARIANTS).
- **States**: default; scrolled (keep static, DD-10).
- **Layout/dimensions**: header content `layout.navBarHeight` (41) with `space.lg` vertical allowance (57 total); leading/trailing hit areas `control.backButton` (33) visual, `control.minTouchTarget` hit.
- **Spacing**: horizontal inset `layout.marginScreen`; slot gap `space.sm`.
- **Typography**: centre title `typography.heading`, `textPrimary`, one line, ellipsis.
- **Colours**: transparent on `background`; trailing text actions `textPrimary`.
- **Interaction**: leading action pops/dismisses; trailing action opens a PopupMenu or a screen.
- **Accessibility**: the centre title is a heading; BackButton name = "Back" (or the parent's title); trailing menu button names its action ("More").
- **Responsive**: height and margins constant; title truncates before actions.
- **Evidence**: S002, S003, S008, S009, S012, S013, S016–S018, S022, S064.

### BackButton
- **Purpose**: pop one level.
- **Anatomy**: chevron-left icon, optional label.
- **States**: default, pressed, focused.
- **Dimensions**: visual `control.backButton` (33) circle/pill; hit ≥ 44.
- **Colours**: icon `textPrimary`; no fill (fill `surfaceMuted` on pressed).
- **Interaction**: back navigation; for exercises use `AppHeader/Modal` close instead.
- **Accessibility**: role button; label "Back" or parent title (settings pages).
- **Evidence**: S002, S003, S016, S043, S048–S050.

### FloatingBottomBar
- **Purpose**: shortcut hub on the dashboard only.
- **Anatomy**: full-width frosted dock at the bottom edge · history circle left · Menu pill centred · profile circle right · StreakPill floating above the centre.
- **States**: default; pressed per control.
- **Dimensions**: icon buttons `control.iconButton` (36); streak pill height `control.pillSmallHeight` (24).
- **Spacing**: dock flush to the window edges; controls inset by `space.lg`; streak overlaps the dock top.
- **Typography**: pill labels `caption`/`bodyStrong`; streak count in `warning`.
- **Colours**: `glass.bar`; icons `textPrimary`.
- **Interaction**: left → history, streak pill → streak, Menu → MenuOverlay, right → Profile.
- **Accessibility**: a toolbar; each control labelled ("History", "Streak: N days", "Menu", "Profile"). Streak name includes the value.
- **Responsive**: keeps all four controls; the dock adapts to window width.
- **Evidence**: S001, S011.

### MenuOverlay
- **Purpose**: full-window shortcut hub.
- **Anatomy**: full-window blurred backdrop over the dashboard with a blue wash near the bottom · centred stack of 5 rows (round coloured icon + label) · Menu pill at bottom to dismiss.
- **Variants**: single.
- **States**: closed, open.
- **Dimensions**: row pitch `layout.rowMenu` (54); icon tile `icon.tile` (30).
- **Colours**: `glass.bar` blur + `color.primaryTint` lower wash; row labels `textPrimary` on glass; each icon tile uses its semantic colour token with white glyph.
- **Rows (data-driven, default order)**: Insight · Upgrade Gramify Plus · Flashcards · My streak · FlowLetter. Upgrade and FlowLetter remain non-actionable until their routes are implemented.
- **Interaction**: available rows push the destination screen. Upgrade and FlowLetter are non-actionable previews until their routes exist. Dismiss by backdrop tap, Escape, or the bottom Menu pill.
- **Accessibility**: modal; focus trapped; Escape closes; available rows are buttons and unavailable rows expose disabled state. Keyboard focus starts on the first Tab press.
- **Responsive**: centred column, max width `layout.sheetWidth`.
- **Evidence**: S011 (active).

### PopupMenu
- **Purpose**: contextual menu from a trailing "More" action or a long press.
- **Anatomy**: list of items; separators; optional submenu chevron; optional disabled item.
- **States**: item default, focused, pressed, disabled.
- **Dimensions**: width `layout.popupMenuWidth` (144, grows to the longest label); item height `control.buttonSmHeight` (30) visual, 44 hit; offset from trigger `space.xs`.
- **Typography**: `body`.
- **Colours**: `surfaceElevated` + `shadow.floating`.
- **Interaction**: opens anchored to its trigger; dismisses on outside tap or selection; no scrim.
- **Accessibility**: role menu / menuitem; arrow-key navigation; submenu opens with Right arrow; disabled items remain focusable but unannounced as actionable.
- **Visual evidence is partial**: items are known; the conversation "more" popup was never rendered (DD-03).
- **Evidence**: S023 (AX), S051 (rendered), S053 (AX).

### Dialog
- **Purpose**: blocking confirmation.
- **Anatomy**: title · body · two actions side by side (neutral left, destructive right).
- **Variants**: `Confirm` (see variants).
- **States**: open; action pressed.
- **Dimensions**: width `layout.dialogWidth` (260); actions height `control.buttonSmHeight` (30), each half of the inner width; stack vertically (primary/neutral on top) below `layout.stackActionsBelow`.
- **Spacing**: padded `space.lg`; action gap `space.sm`.
- **Typography**: title `heading`; body `body` `textSecondary`.
- **Colours**: `surfaceElevated`, `radius.dialog`, scrim `overlayScrim.default`; destructive label `accessible.errorTextOnTint` on `errorTint`. Neutral action = `Button/Secondary`, destructive = `Button/Destructive`.
- **Interaction**: modal; backdrop tap does not confirm; default focus is the *stay* action.
- **Accessibility**: role alertdialog; title and body announced on open; focus trap; Escape = stay.
- **Responsive**: width fixed; on compact `min(260, viewport − 2×marginScreen)`.
- **Evidence**: S007, S062.

### Sheet
- **Purpose**: container for floating bottom content (feedback, create, info, paywall).
- **Anatomy**: grabber · header (title + close) · scrollable body · action row.
- **Variants**: concrete sheets are `FeedbackSheet`, `Sheet/Create`, `Sheet/Info`, `Sheet/Paywall`.
- **States**: entering, open, minimised (grabber), dismissed.
- **Dimensions**: width `layout.sheetWidth` (446 max); height ≤ `layout.sheetMaxHeightRatio` of viewport (ESTIMATED), content-driven.
- **Colours**: `surfaceElevated`; `radius.sheet`; `shadow.floating`; scrim per variant (feedback/create/paywall none, info yes).
- **Layout**: header and action row are pinned; only the body scrolls when the sheet reaches its max height.
- **Interaction**: grabber drag/tap minimises, close dismisses, outside tap dismisses non-blocking sheets.
- **Accessibility**: role dialog (non-modal for feedback, modal when scrimmed); label from title; returns focus to trigger.
- **Responsive**: centred; full width minus margins on compact.
- **Evidence**: S006, S028, S030, S032, S045.

### FAB
- **Purpose**: floating customisation entry on the conversation picker; expands to a fan menu.
- **Anatomy**: circular trigger (sliders icon) · expanded pills (current mode, voice, info, close).
- **States**: collapsed, expanded (scrim), pill selected.
- **Dimensions**: trigger about 38; pills about 192×34 (SUPPORTED).
- **Colours**: trigger `surface` + `shadow.raised`, glyph `textPrimary`; pills `surface` + `shadow.raised`; scrim `overlayScrim.default` when expanded.
- **Interaction**: mode pill toggles Free chat ↔ Scenario and persists across navigation; info pill opens `Sheet/Info`.
- **Accessibility**: trigger is a menu button (expanded state announced); pills are menuitemradio-like; focus moves into the fan.
- **Evidence**: S020, S031, S063.

### SegmentedControl
- **Purpose**: switch between 2–3 sibling views in place.
- **Anatomy**: equal-width segments, one selected.
- **States**: selected, unselected, pressed, disabled.
- **Dimensions**: height `control.chipHeight`+ (about 35 observed); full content width.
- **Typography**: `bodyStrong`.
- **Colours**: selected `surface` with `shadow.hairline` on a `surfaceMuted` track (structure CANDIDATE; observed as two tabs "Review (N)" / game).
- **Interaction**: switches content without navigation, except inside `FlashcardDeckTemplate` where the `Game` segment is a navigation shortcut to `FlowLetterGameTemplate` and the control returns to the first segment when the user comes back. Segment labels are product copy.
- **Accessibility**: role tablist/tab or radiogroup; selected state announced.
- **Evidence**: S013.

### PagerDots
- **Purpose**: position within a horizontal carousel.
- **States**: active, inactive.
- **Colours**: dashboard: active = `feature.grammar.accent` lime; lesson list: active = dark pill `textPrimary`; inactive = `border`. Dot 6, active dashboard dot 6, active lesson pill 16×6 (ESTIMATED, defaults).
- **Accessibility**: decorative if the carousel itself exposes "page N of M".
- **Evidence**: S001, S003.

---

## 2. Browse & content

### SectionHeader
- **Purpose**: titles a group of content; also the hero on picker and lesson screens.
- **Anatomy**: optional eyebrow (`microLabel`) · title · optional subtitle · optional trailing link.
- **Variants**: `Section` (heading + subtitle) and `Hero` (display, two-tone, coloured full stop).
- **Typography**: Section: `heading`/`body` `textSecondary`; Hero: `display` (`displayCompact` on compact), line 1 `textPrimary`, line 2 `accessible.heroSecondLine` (fidelity token `textFaint` fails contrast even at display size), final full stop in the mode accent (a fill-like glyph; `feature.grammar.accent` lime on a light page may not be the only cue, the sentence still ends with a visible stop).
- **Spacing**: title→subtitle `space.xs`; subtitle→content `space.lg`.
- **Accessibility**: title = heading (level by hierarchy), hero is level 1.
- **Evidence**: S001, S002, S008, S013.

### ModeCard
- **Purpose**: dashboard entry to a learning mode (Writing, Grammar, Conversation).
- **Anatomy**: category pill (eyebrow) · title · large faded index numeral · description · footer "explore" affordance.
- **Variants**: `Writing`, `Grammar`, `Conversation`; each `Active` or `Peek` state.
- **States**: active (centred, about 4% larger), peek (next/previous), pressed, focused.
- **Dimensions**: width = `layout.modeCardWidthRatio` × effective viewport (`modeCardWidthRatioCompact` on compact; next card peeks); min height `layout.modeCardMinHeight`, content-driven above; `radius.heroCard`.
- **Active scale**: `motion.carouselActiveScale`; none under reduced motion.
- **Spacing**: card gap `layout.carouselGap`; inner padding `space.lg`+.
- **Colours**: fill from `feature.<mode>.homeCardFill` (writing CANDIDATE; others ESTIMATED); text colour by fill: `ModeCard/Writing` (`primary`) and `ModeCard/Grammar` (lavender) use `accessible.onFeatureFill`; `ModeCard/Conversation` (`primaryStrong`) uses `accessible.onBrand`. Not a profile-switch surface: these home fills stay as tokened. Index numeral = same text colour at `state.modeCardIndexOpacity` (decorative); divider uses `state.modeCardDividerOpacity`.
- **Interaction**: tap opens the mode's TopicPicker; swipe pages the carousel with PagerDots.
- **Accessibility**: one button; name = "index, MODE, kind, description, explore" (concatenated).
- **Responsive**: ratio-based width; one full card plus a peek at any width ≥ compact.
- **Evidence**: S001 (active); card 2/3 fills unmeasured (DD-13).

### TopicCard
- **Purpose**: select a topic inside a mode.
- **Anatomy**: icon in circle · title · count badge ("N sets/questions").
- **Variants**: `Standard`, `Plus` (→ PlusTile).
- **States**: default, pressed, focused, disabled (locked content shows PlusTile instead).
- **Dimensions**: height `layout.topicCardHeight` (123); width = (content − `layout.gridGap`) / 2; `radius.largeCard`.
- **Colours**: `surface` on `background` + `shadow.hairline`; icon circle `surfaceMuted`; count badge `StatusBadge/Count`. Use `surface`.
- **Interaction**: tap pushes LessonList for the topic.
- **Accessibility**: one button; name = title + count.
- **Responsive**: 2 columns at ≥ regular; 1 column on compact.
- **Evidence**: S002, S008, S020.

### PlusTile
- **Purpose**: in-grid upsell tile ("unlimited mode"), shown inside the topic grid.
- **Anatomy**: same footprint as TopicCard; fill `accessible.brandFill`, glyph and label `accessible.onBrand`.
- **Availability**: rendered only when the paywall is enabled (DD-24); otherwise omitted and the grid starts with `TopicCard/Standard`.
- **States**: default, pressed, focused. Never disabled.
- **Accessibility**: button, name = label + "upgrade".
- **Dimensions**: identical to TopicCard; inserted first in the grid.
- **Interaction**: opens the Paywall sheet; must never block browsing.
- **Evidence**: S008. Marketing content is product-specific; layout only.

### LessonCard
- **Purpose**: a lesson in a horizontal carousel.
- **Anatomy**: index numeral · LevelBadge pill · title (uppercase in learning language allowed) · description · primary CTA · faint illustration.
- **Variants**: `Writing`, `Grammar`, `Conversation` (CTA fill differs).
- **States**: default, pressed, CTA pressed, current-page scale.
- **Dimensions**: width = `layout.lessonCardWidthRatio` × effective viewport (peek of the next card); min height `layout.lessonCardMinHeight`; `radius.largeCard`; CTA `control.buttonMdHeight`; inner padding `space.lg`.
- **Colours**: `surface` + `shadow.hairline`; CTA `feature.<mode>.cta`.
- **Interaction**: CTA starts the exercise; card tap is equivalent.
- **Accessibility**: card is a group; CTA is the button ("Start", "Quick fix", "Start chat").
- **Responsive**: ratio width as above (use `modeCardWidthRatioCompact`-style 0.9 on compact); CTA stays right-aligned. Text on the CTA: `feature.grammar.cta` (lime) → `textPrimary`; navy / `primaryStrong` CTAs → `textOnPrimary`.
- **Evidence**: S003, S009, S021.

### CategoryChip
- **Purpose**: filter a topic grid or send a quick prompt.
- **Variants**: `Filter` (selected outline), `Quick` (icon + label, first highlighted).
- **States**: default, selected, pressed, focused.
- **Dimensions**: height `control.chipHeight` (30); `radius.chip`; gap `space.sm`.
- **Colours**: default `surface`/`surfaceMuted`; selected Filter = 2 ru `accessible.warningText` outline (the fidelity `warning` orange is 2.8:1 on white), Quick = `primaryTint` fill with `accessible.textOnPrimaryTint` label.
- **Interaction**: single-select in a horizontally scrolling rail; selection scrolls grid to top.
- **Accessibility**: role radio in a radiogroup (Filter) or button (Quick); `aria-pressed/checked`.
- **Evidence**: S001, S002, S008.

### Banner
- **Purpose**: promo or feature entry.
- **Variants**: `Promo` (single line CTA, brand fill) and `Feature` (gradient + CTA pill + preview cards).
- **Anatomy**: Promo = icon · one-line message · CTA pill. Feature = title · caption · CTA pill · two decorative preview cards at the trailing edge (`aria-hidden`).
- **Dimensions**: Promo height `layout.bannerPromoHeight` (77), Feature `layout.bannerFeatureHeight` (160); `radius.card`; padding `space.lg`.
- **Colours**: fill `accessible.brandFill` (Feature may run a 135° gradient `accessible.brandFill` → `color.primaryTextOnTint`); text and CTA label `accessible.onBrand`; CTA pill `surface` fill with `accessible.link` label.
- **States**: default, pressed, focused.
- **Availability**: `Banner/Promo` only when the paywall is enabled (DD-24); `Banner/Feature` (flashcards entry) always.
- **Interaction**: whole banner is a button; the CTA pill is decorative (not a second target).
- **Accessibility**: one button, name = message + CTA label.
- **Evidence**: S001.

### FlowLetterTile
- **Purpose**: dashboard tile advertising the word game.
- **Anatomy**: row of LetterTile previews spelling a word · title · caption.
- **Dimensions**: width `layout.historyCardWidth`-class small tile (123×146, CANDIDATE) in a rail; `radius.card`; fill = `feature.flowLetter.gradient.lobby`; text `feature.flowLetter.glassText` (check worst-case backdrop).
- **States**: default, pressed, focused. **Accessibility**: one button, name = title + caption.
- **Interaction**: opens the game tutorial/lobby.
- **Evidence**: S001 (off-screen, AX only).

### StatusBadge
- **Purpose**: tiny tag: NEW, part of speech, plan, level.
- **Typography**: `microLabel`.
- **Variants**: `New`, `PartOfSpeech`, `Level`, `Plan`, `Count` (topic count "N sets"; `surfaceMuted` bg, `textSecondary` text).
- **Colours**: `primaryTint` bg + `accessible.textOnPrimaryTint` text (POS: `feature.srs.posBadgeBg`); `New` = `successTint` bg + `accessible.successText` text.
- **Dimensions**: height about 8–20 per context; `radius.chip`.
- **Evidence**: S013, S052.

### SearchField
- **Purpose**: header-embedded search.
- **Dimensions**: height `control.buttonSmHeight` (30), width fills the header centre slot (observed 184); `radius.chip`; fill `surfaceMuted`; icon `textMuted`.
- **States**: empty (placeholder), focused, filled (clear button), no-results → `EmptyState`.
- **Accessibility**: role searchbox with visible placeholder and a label.
- **Evidence**: S017.

### EmptyState
- **Purpose**: zero-data screens.
- **Anatomy**: icon · title · body · optional link.
- **Layout**: centred column, icon `icon.container`-size in `surfaceMuted` circle, title `heading`, body `body` `textSecondary`, optional `Button/Link`; vertical gaps `space.sm`; padding `space.xl`.
- **Variants**: `Empty` (default), `Error` (icon `error`, same layout, action "Retry"; DD-04).
- **Evidence**: S050 (no voice models), S033 (zero stats). Error variant: `EmptyState/Error` (DD-04 default).

### CoachMark
- **Purpose**: one-time hint toast with icon, title, body, close.
- **Layout**: floating card (`surfaceElevated`, `shadow.floating`, `radius.card`), icon · title (`bodyStrong`) · body (`body`) · Close; anchored above the element it explains; width ≤ `layout.dialogWidth`+.
- **Interaction**: dismissed once; never returns. Non-modal. Role status; Close is a labelled button.
- **Evidence**: S019.

---

## 3. Exercise

Grammar's balanced workspace gives the prompt and answer equal dominant vertical
weight at regular/tall sizes, centers sentence content, and collapses to one
scrollable reading order when height or text scale is constrained. The hint rail
and trailing submit action remain reachable after both surfaces.

### ProgressStepper
- **Purpose**: position within a finite set.
- **Anatomy**: N equal segments in a row.
- **Variants**: `Writing` (10), `Grammar` (20), `Scenario` (8). Segment count is data-driven; the variants fix the mode colour.
- **States per segment**: done, current, idle.
- **Dimensions**: spans the header centre; segment gap `space.xs`; height `layout.stepperHeight`; segments shrink to `layout.stepperSegmentMinWidth` before the count changes.
- **Colours**: done `feature.<mode>.progress`; current `feature.<mode>.progressCurrent` **plus** a 2 ru outline in the mode progress colour (tint alone is nearly `border`); idle `border`.
- **Accessibility**: role progressbar, `valuenow/valuemax`, label "Step N of M".
- **Evidence**: S004–S007, S058, S064.

### HintChipBar
- **Purpose**: optional helper row above the composer/submit.
- **Anatomy**: undo button · ordered hint chips (blurred until revealed) · verdict re-open sparkle chip (appears after a verdict).
- **Dimensions**: chip height `control.chipHeight`; `radius.chip`; gap `space.sm`; horizontal scroll, never wraps; blur `layout.hintChipBlur` on hidden chips (the accessible name never contains the hint).
- **Colours**: chip `surface` + `shadow.hairline`, label `textPrimary`; sparkle chip `primaryTint` with `accessible.textOnPrimaryTint` glyph; undo `textSecondary`.
- **States**: hints hidden (blurred), revealed, verdict-chip present. Undo re-hides the last revealed hint.
- **Interaction**: chip reveals a hint; sparkle reopens the last FeedbackSheet.
- **Accessibility**: hints are buttons with a hidden-state label ("Hint 1, hidden"); sparkle labelled "Show last feedback".
- **Evidence**: S004–S006, S057, S060, S064. Relation to the 20-step grammar stepper unknown but irrelevant: they are independent.

### ExerciseEditor
- **Purpose**: the learner's working area.
- **Anatomy**: AppHeader/Progress or title · SourceTextCard · AnswerInput card · HintChipBar · SubmitButton.
- **Variants**: `Paragraph` (writing) and `Sentence` (grammar).
- **States**: empty, filled, submitting (disabled + loading), feedback-open.
- **Layout**: vertical stack header → source → answer (flex 1, min `layout.answerCardMinHeight`) → hint bar → submit row; gaps `space.lg`; `SubmitButton` is bottom-trailing in the row.
- **More menu** (`PopupMenu/WithSubmenu`): "Show all" expands/collapses the source card; "Background colour" opens the answer-colour swatch submenu: one swatch per `answerPalette.order` entry, drawn with its `.background`, selected state = check icon in its `.foreground` (DD-26); "Hints" toggles hint chips; "Dictionary" toggles tap-a-word lookup; "Like"/"Dislike" rate the last verdict (DD-15).
- **Interaction**: close asks Dialog/Confirm if any input exists; submit is disabled until non-empty.
- **Evidence**: S004, S005, S057–S059.

### SourceTextCard
- **Purpose**: the prompt to translate or correct.
- **Variants**: `Paragraph` (long, read-only card, current sentence highlighted) and `Sentence` (short single prompt).
- **Layout**: padding `space.lg`, `radius.largeCard`. Below compact the Paragraph variant is collapsed to 3 lines with a trailing "Show all" `Button/Link`; the current sentence is always scrolled into the visible part.
- **Colours**: `surface` card, highlight `color.highlight` behind the current sentence, text `textPrimary` (highlight contrast 17:1).
- **Typography**: `body` (Paragraph), `heading` (Sentence).
- **Accessibility**: read-only region labelled "Source text".
- **Evidence**: S004, S010.

### AnswerInput
- **Purpose**: the learner's text entry.
- **Anatomy**: coloured card · multiline text field · placeholder · direction swap icon (writing).
- **States**: empty, focused, filled, disabled (while grading).
- **Dimensions**: card `radius.largeCard`; width = content; initial height about 224 (writing) to 460 (full editor).
- **Colours**: card fill = `answerPalette.<key>.background`, text/placeholder/caret/icons = `answerPalette.<key>.foreground` of the **same key** (DD-26). Key comes from the user preference, default `answerPalette.defaults.writing` (purple) / `.grammar` (blue). Never read a foreground from anywhere else, never compute one. Placeholder = foreground, no opacity reduction. `white` entry also carries `shadow.hairline`.
- **Interaction**: autofocus on open; value persists across "Edit/Fix".
- **Accessibility**: labelled text input ("Your answer"), placeholder is not the label; contrast is guaranteed by the palette pair.
- **Evidence**: S004, S005, S058, S059.

### SubmitButton
- **Purpose**: send the answer for grading.
- **Anatomy**: circular, chevron icon (`textOnPrimary` when enabled; `control_state.submitDisabled` ring + icon when disabled).
- **States**: disabled (ring `control_state.submitDisabled`), enabled (filled `control_state.submitEnabled`), loading.
- **Dimensions**: `control.submitButton` (26) visual, hit ≥ 44.
- **Accessibility**: label "Submit"; disabled state exposed.
- **Evidence**: S004, S005, S059.

---

## 4. Feedback

### FeedbackSheet
- **Purpose**: the single container for every AI verdict.
- **Anatomy**: grabber · header (verdict icon + coloured title + optional score + close on detailed variants) · body sections (AnswerRecapBox or CorrectionDiff, explanation, FeedbackBulletList…) · FeedbackActionRow · optional rating row.
- **Variants**: `WritingRecap`, `WritingCorrect`, `WritingIncorrect`, `GrammarCorrect`, `GrammarIncorrect`, `ConversationScoreFeedback`. State `loading` (skeleton) applies to all. `WritingRecap` is a compact correct verdict with answer recap, View AI analysis, and Next; analysis replaces it with loading and then detailed `WritingCorrect`.
- **States**: loading, ready, minimised, dismissed.
- **Dimensions**: inherits `Sheet`; compact content for `GrammarCorrect`.
- **Typography**: verdict `heading`; section labels `microLabel`; body `body`.
- **Colours**: header icon/accent from `feedback.correct | incorrect | partial`; verdict title text uses `accessible.successText` / `accessible.errorText` / `accessible.partialText`; the header icon keeps the raw `feedback.*` colour; sections per variant table.
- **Composition**: exactly one `FeedbackSheet` is mounted at a time; `loading` → verdict replaces content in place (no second sheet). Scenario uses the Writing variants (DD-06).
- **Motion**: the active sheet enters/exits using `motion.sheet`, `motion.easing`, and `motion.sheetEnterOffset`; the outgoing sheet is inert during replacement. Reduced motion uses a short fade only (DD-10 default).
- **Interaction**: grabber minimises to the HintChipBar sparkle chip; actions route per variant. Rating thumbs: `Writing*` only.
- **Accessibility**: role dialog (non-modal), label = verdict; announces loading and result (`aria-live=polite`); focus moves to the sheet on ready, returns to the editor on dismiss.

#### Grammar vertical-slice reconciliation

- `SourceTextCard/Sentence` accepts an optional localized instruction slot above the authored sentence.
- `AnswerInput` accepts an optional externally owned focus node; the default behavior and every existing call site remain unchanged.
- `HintChipBar` accepts an optional leading “show last feedback” action after a sheet is minimized.
- `FeedbackSheet/GrammarCorrect` keeps “view AI analysis” visible but may expose it disabled with a localized unavailable reason. The disabled action remains in semantics but cannot activate.
- Every feedback variant may expose an optional minimize callback. Loading Cancel returns to the same editor state with exact input retained and invalidates any late result.
- The Grammar vertical slice may return directly to its Lesson List after final Next because completion UI and persistence are explicitly out of scope for that slice.
- Feedback content is width-capped and height-capped by canonical layout tokens; the body scrolls while actions remain reachable.
- **Responsive**: as Sheet.
- **Evidence**: S006, S055, S056, S028, S060, S061.

### CorrectionDiff

Grammar incorrect feedback may render retained, removed, and inserted
word/punctuation segments. Removed content uses strike-through and inserted
content uses underline or emphasis; semantic labels express the same state
without relying on color.
- **Purpose**: show the corrected text with word-level change marks.
- **Anatomy**: wrapped inline spans: kept words, removed words (strike-through, `accessible.diffRemovedText`), added words (chip: `feedback.diff.addedBg` fill, `accessible.diffAddedText` text, `radius.xs`); a "tap a word to look up" hint.
- **States**: default; word pressed (lookup; behaviour not observed, DD-15).
- **Accessibility**: rendered as a paragraph with `<del>`/`<ins>` semantics; screen reader announces "removed: …, added: …".
- **Evidence**: S006, S056, S060, S028.

### FeedbackBulletList
- **Purpose**: titled list of explanation points.
- **Variants** (by section): `Improvements` (purple), `Tips` (lime), `Mistakes` (orange), `AreasToImprove` (purple).
- **Typography**: label `microLabel`, items `body`.
- **Colours**: bullet dot `feedback.bullet.*` (decorative; a dot is never the only cue, the section label names the type); text `textPrimary`; section label `textSecondary`.
- **Evidence**: S056, S060, S028.

### FeedbackActionRow
- **Purpose**: the sheet's actions.
- **Variants**: `EditNext` (secondary + primary, writing), `FixNext` (secondary + primary, grammar incorrect), `NextFull` (one full-width primary, grammar correct), `CloseOnly` (conversation).
- **Dimensions**: buttons `control.buttonMdHeight`, about 200 wide each or full width; `radius.full`.
- **Colours**: primary = `Button/Primary`; secondary = `Button/Secondary`. Composed of `Button`, never custom buttons.
- **Optional**: rating thumbs (like / dislike) in the header row (writing).
- **Accessibility**: primary action is default focus.
- **Evidence**: S056, S006, S060, S061.

### AnswerRecapBox
- **Purpose**: echo the learner's answer on a correct result.
- **Anatomy**: label (check icon + uppercase "your answer") · answer in `surfaceMuted` rounded box.
- **Evidence**: S061.

---

## 5. Conversation

### ConversationShell
- **Purpose**: chat-based practice screen. **One shell, two variants**: `Free` and `Scenario`.
- **Anatomy**: AppHeader (`Modal` in Free, `Progress` in Scenario) · eyebrow line (topic; **Scenario only**, Free shows the topic as header title) · scrolling bubble list · HintChipBar (Scenario) · ChatComposer.
- **Variants**: `Free`, `Scenario`.
- **States**: awaiting-AI (typing indicator), idle, composing, scored.
- **Interaction**: AI speaks first; close/"end session" → Dialog/Confirm → lesson list (no result screen seen); "More" menu toggles translations.
- **Accessibility**: message list is a log (`aria-live=polite`); each bubble is a labelled item (speaker, text).
- **Evidence**: S022–S028 (Free), S064 (Scenario).

### ChatBubble
- **Purpose**: a message.
- **Variants**: `Ai`, `AiScripted`, `User`, `Task`, `Typing`.
- **Dimensions**: max width `layout.chatBubbleMaxWidthRatio` × content; `radius.control` (14).
- **Typography**: `body`; translation/gloss `caption` italic `textMuted`.
- **Colours**: Ai = `surface` + `shadow.hairline`; AiScripted = `feature.scenario.aiBubble`; User = `feature.conversation.userBubble` + `textOnPrimary`; Task = `feature.scenario.taskBubble`.
- **States**: static (no pressed state); `Typing` animated. `User`: sending (reduced opacity) → sent.
- **Colours (text)**: `User` on `feature.conversation.userBubble`: `accessible.onBrand`. `Task` on `feature.scenario.taskBubble`: `accessible.onFeatureFill` (white on `primary` is 3.7:1).
- **Interaction**: translation line visibility is a global toggle in the "More" menu.
- **Evidence**: S022, S026, S027, S064.

### RoleLabel
- **Purpose**: names the speaker above a bubble in scripted conversation.
- **Typography**: `caption`, `textMuted`; left for AI, right for learner.
- **Evidence**: S064.

### ChatComposer
- **Purpose**: message entry.
- **Anatomy**: pill input · round send button.
- **Variants**: `Free` ("Type a message…") and `Scenario` (prompt-specific placeholder; send labelled for translation).
- **States**: empty (send disabled `control_state.sendDisabled`), filled (send `feature.conversation.accent`), sending, awaiting-AI (input disabled).
- **Dimensions**: height `control.composerHeight`, grows; send `control.sendButton`; `radius.full` (single line) → `radius.control` (multi-line).
- **Colours**: field `surface` + `shadow.hairline`, text `textPrimary`, placeholder `textMuted`; send glyph `accessible.onBrand`.
- **Accessibility**: labelled input; send button disabled state exposed; Enter sends, Shift+Enter newline.
- **Evidence**: S022, S025, S064.

### ScoreChip
- **Purpose**: inline per-message score affordance under the learner's bubble.
- **Anatomy**: score dot · bold number · one-line summary · chevron.
- **States**: default, pressed.
- **Colours**: `surfaceMuted`; dot from `score.*` (fill); score number text from `accessible.score{Low,Mid,High}Text`; summary `textSecondary`.
- **Interaction**: whole chip is a button that opens `FeedbackSheet/ConversationScoreFeedback`.
- **Accessibility**: label "Score N: summary. Open feedback".
- **Known issue**: chip number vs sheet fluency number unresolved (DD-05).
- **Evidence**: S027, S028.

---

## 6. Flashcards & SRS

### FlashcardDeckHeader
- **Purpose**: summarises a deck.
- **Anatomy**: brand bar · title · description · three counters (new, learning, due) with icons · primary "Review (N)" CTA · SegmentedControl.
- **Colours**: header fill `accessible.brandFill`; text and counters `accessible.onBrand`; CTA `Button/OnBrand` (`surface` fill, `accessible.link` label).
- **Composition**: three counters in a row (P14); the CTA shows `Review (N)` and is disabled with N = 0.
- **Evidence**: S013.

### DeckCard
- **Purpose**: deck summary in a list/carousel.
- **Anatomy**: title · counters (new / learning / due) · chevron. Whole-card button.
- **Dimensions**: height `layout.deckCardHeight`, width `contentWidth`; `radius.card`; fill `surface` + `shadow.hairline`.
- **States**: default, pressed, focused. **Accessibility**: name = title + counters.
- **Evidence**: S012.

### FlashcardRow
- **Purpose**: a word in a deck.
- **Anatomy**: word · definition · IPA · StatusBadge · speak button · delete.
- **Dimensions**: pitch `layout.rowWord` (87); `radius.xs`; fill `surface` + `shadow.hairline`.
- **States**: default, pressed (row opens nothing in v1), speaking.
- **Interaction**: speak plays audio; delete is destructive and must use Dialog/Confirm (product decision; not exercised).
- **Evidence**: S013.

### SRSCard
- **Purpose**: the flip card.
- **Variants**: `Front`, `Back`.
- **Anatomy**: Front: word, POS badge, IPA, "tap to flip" hint, stacked cards behind. Back: translation, English gloss, POS badge, speaker, example sentence, SRSGradeButton ×4.
- **Dimensions**: width `layout.srsCardWidthRatio`, aspect `layout.srsCardAspect` (content may grow it); `radius.largeCard` (24 tolerance +/-2); `shadow.raised`.
- **Interaction**: tap flips; swipe grading and the tutorial overlay are **not part of v1** (DD-25, APPROVED_V1; swipe may later be a progressive enhancement); the grade buttons are the canonical interaction; close without confirmation.
- **Accessibility**: card is a button "Flip card"; back content announced on flip; swipe gestures **must** have button equivalents (the four grades).
- **Evidence**: S014, S015, S052.

### SRSGradeButton
- **Purpose**: self-rated recall.
- **Anatomy**: interval caption above · round icon button · label below.
- **Variants**: `Again` (1m), `Hard` (6m), `Good` (1d), `Easy` (4d).
- **Dimensions**: `control.gradeButton` (49); gap `space.lg`.
- **Colours**: circle fill `grade.again/hard/good/easy`; glyph `accessible.onGradeFill`; interval caption `textSecondary`, label `textPrimary`.
- **States**: default, pressed, focused, disabled (before flip). Keyboard shortcuts 1–4.
- **Accessibility**: name = "label, interval" (e.g. "Good, 1 day").
- **Evidence**: S052. Interval values are product data, not design tokens.

---

## 7. Settings & selection

### SettingsRow
- **Purpose**: row in a settings list.
- **Variants**: `Navigate` (chevron), `Toggle`, `Info`, `Account`.
- **Dimensions**: height `layout.rowSettings` (62); full content width; `radius.card` on grouped cards; padding `space.lg`.
- **States**: default, pressed, focused, disabled. `Toggle` variant embeds `Toggle`; `Account` shows avatar · name · plan `StatusBadge/Plan` and is **read-only** in v1 (profile editing is policy-blocked).
- **Typography**: label `bodyStrong`; value `body` `textSecondary`.
- **Accessibility**: row is one control; toggles expose checked state.
- **Evidence**: S016, S041, S048.

### SelectableRow
- **Purpose**: single-choice rows (language, level, difficulty).
- **Anatomy**: leading flag/bar · two lines · trailing radio/check · optional "coming soon" pill.
- **States**: selected (`accessible.selectedIndicator` radio with a check glyph), unselected, disabled (dimmed text, "coming soon").
- **Dimensions**: about 750×62; `radius.card`; level rows add a 3-wide left bar coloured by `cefr.*`.
- **Accessibility**: radiogroup; disabled rows explain why.
- **Evidence**: S040, S043, S044.

### Toggle
- **States**: on (`accessible.toggleOn`), off (`accessible.toggleOff`), disabled (`state.disabledOpacity`). Thumb `surface`. Size 44×26.
- **Accessibility**: role switch with label.
- **Evidence**: S041, S048.

### PaywallCard
- **Purpose**: subscription plan and benefits (layout only; flows are policy-blocked and out of scope here).
- **Anatomy**: `Sheet/Paywall` containing PlanCard ×2 (selected = `primaryTint` fill + `primary` border; discount badge) · BenefitRow ×N (icon, title, body) · full-width CTA · restore/terms links.
- **PlanCard**: radio · plan name · price line (product data) · optional discount `StatusBadge`; selected = `primaryTint` fill + 2 ru `primary` border + filled radio; `radius.card`; one plan always selected; name = "plan, price, selected".
- **BenefitRow**: `icon.tile` tinted icon · title (`bodyStrong`) · body (`body` `textSecondary`); not interactive; data-driven count.
- **Status**: **OPTIONAL / DEFERRED for v1** (DD-24: `paywallEnabled = false`, not in default navigation). `PaywallTemplate`, `PlusTile`, Home `Banner/Promo` and quota-exhaustion paywall remain gated. The Profile Plus banner and Menu Upgrade row are visual previews without a purchase action.
- **Evidence**: S045 (view-only).

### InsightCard
- **Purpose**: progress analytics.
- **Variants**: `Stat` (icon + number + unit + caption), `StatGrid` (3 columns), `Calendar` (month dot-matrix / month view), `WeekChart`.
- **Typography**: numbers `title`; captions `caption`.
- **Colours**: `surface`/`surfaceMuted`, empty cells `border`.
- **Empty**: zero-data state observed (all zero, empty chart).
- **Evidence**: S018, S033.

### InsightCard/History (HistoryCard)
- **Purpose**: an entry in the History list (a past lesson or session). **Required** by `InsightTemplate` History variant; `HistoryCard` is an alias of this variant.
- **Anatomy**: thumbnail (mode-tinted `surfaceMuted` block with the mode icon) · type label (`microLabel`) · topic (`bodyStrong`, 2 lines max). Group header = type label with a trailing "See more" `Button/Link`.
- **Dimensions**: `layout.historyCardWidth` × `layout.historyCardHeight`; `radius.card`; fill `surface` + `shadow.hairline`; cards in a horizontal rail per type group (P12).
- **States**: default, pressed, focused. Empty history → `EmptyState`; no search results → `EmptyState` with the query.
- **Interaction**: the **entire card is the single tap target** (one destination: that item's lesson list; DD-23, APPROVED_V1). "See more" is outside the card in the group header. If nested actions are ever added, declare the separate interaction regions here first.
- **Accessibility**: P1 name = type + topic.
- **Evidence**: S017.

---

## 8. Game

### GameHUD
- **Purpose**: status for the word game.
- **Anatomy**: level + topic · counter (n/total) · star count · tick progress · glass pill actions.
- **Colours**: `glass.button`, `glassText`.
- **Evidence**: S037, S054.

### LetterTile
- **Purpose**: draggable letter piece.
- **Dimensions**: about 40–44 square (SUPPORTED); inline preview 27.
- **Typography**: bold letter; `glassText`.
- **States**: idle, selected, placed, wrong (`error` outline), solved (`success` flash); wrong/solved treatments are the DD-16 defaults (Class B for the game feature).
- **Accessibility**: provide a non-drag alternative (tap-to-select, tap-to-place).
- **Evidence**: S035, S037, S042.

### GlassButton
- **Purpose**: game menu actions.
- **Dimensions**: pill about 725×38 at reference; radius full.
- **Variants**: `Action`, `Radio` (check circle at right).
- **Colours**: `glass.button`.
- **Evidence**: S035, S040–S042.

---

## 9. Actions & home surfaces (added by the final QA)

These were used by earlier entries (`FeedbackActionRow`, `Dialog`, `Sheet/Create`, settings CTA, loading, errors, dashboard) without a definition. All values are derivable from existing tokens.

### Button
- **Purpose**: every labelled action that is not a card, chip or icon button.
- **Variants**: `Primary` (fill `control_state.actionFill`, label `control_state.actionText`) · `Secondary` (fill `control_state.secondaryFill`, label `textPrimary`) · `Destructive` (fill `errorTint`, label `accessible.errorTextOnTint`) · `Accent` (fill = the mode CTA token e.g. `feature.grammar.cta`, label per LessonCard rule) · `OnBrand` (fill `surface`, label `accessible.link`; used on brand-filled surfaces) · `Link` (no fill, label `accessible.link`, `bodyStrong`) · `Icon` (icon-only: `control.iconButton` 36 visual, `icon.control` glyph, no fill, `surfaceMuted` when pressed; hit ≥ 44; accessible name is mandatory, ACCESSIBILITY §2). `IconButton` and `LocaleButton` mean `Button/Icon`.
- **Sizes**: `Sm` `control.buttonSmHeight` (30, dialogs) · `Md` `control.buttonMdHeight` (38, sheets, lesson CTA) · `Lg` `control.buttonLgHeight` (42, full-width settings CTA). All `radius.full`, label `bodyStrong`, horizontal padding `space.lg`. Hit area ≥ `control.minTouchTarget` (extend invisibly).
- **Width**: hug content, `Full` fills the container. Paired buttons share equal width.
- **States**: default · pressed (`state.pressedOverlay`) · focused (`focus.*` ring in `accessible.focusRing`) · disabled (`state.disabledOpacity`, stays in the tree) · loading (label replaced by a spinner, width kept, non-interactive, name unchanged + busy).
- **Composition**: at most one `Primary`/`Accent` per surface (FOUNDATIONS §2). `Destructive` is never default-focused (P16).
- **Accessibility**: role button; the name is the visible label.

### Skeleton
- **Purpose**: honest loading placeholder shaped like the final content (grading sheet, page loading per DD-04).
- **Anatomy**: rounded bars `surfaceMuted`, `radius.xs`, heights from the type scale of what they replace.
- **Motion**: optional shimmer `motion.sheet`-length loop; static under reduced motion.
- **Accessibility**: container `aria-busy`, hidden children; announce via the owning component's live region.

### InlineError
- **Purpose**: error inside the surface that failed (DD-04 default).
- **Anatomy**: `surfaceMuted` row, `radius.control` · error icon (`color.error`) · message (`body`, `accessible.errorText`) · `Button/Link` "Retry".
- **Placement**: replaces the content of the failed region (grading sheet body, chat reply slot as a `ChatBubble`-width row, list area as `EmptyState/Error`). Never full-screen. The user's input is never discarded.
- **Accessibility**: role alert (`assertive` is allowed here; DD-04 blocking errors only), Retry is the default focus target.
- **Status**: structure fixed here; copy and retry policy are DD-04.

### GreetingBlock
- **Purpose**: dashboard header region.
- **Anatomy**: greeting line (`title`, name inline) · optional caption (`body` `textSecondary`) · trailing `Button/Icon` (flag glyph, name "Language").
- **Layout**: top of `HomeDashboardTemplate`, margin `layout.marginDashboard`, below the top safe area; `space.lg` to the next region.
- **Accessibility**: greeting is the page's level-1 heading.

### PromptEntry
- **Purpose**: dashboard "ask the AI for a lesson" entry.
- **Anatomy**: pill (`feature.home.promptEntryFill`, `shadow.hairline`, `radius.full`, height `control.buttonLgHeight`+) · sparkle icon · placeholder text (`textMuted`) · send glyph.
- **Behaviour**: read-only trigger. Tap opens `Sheet/Composer` (full-window; `CategoryChip/Quick` suggestions + multiline input + send). Send uses the same generation flow as a quick-topic chip (DD-17).
- **States**: default, pressed, focused. **Accessibility**: button "Ask AI to create a lesson".

### StreakPill
- **Purpose**: streak shortcut in `FloatingBottomBar`.
- **Anatomy**: small progress motif · localized streak count · flame icon (`color.warning`) inside a white pill floating over the dock.
- **Dimensions**: height `control.pillSmallHeight`; `radius.full`; white surface and a subtle raised shadow.
- **Accessibility**: button, name "Streak: N days".

### Composition constraints (all families)

| Family | Must be composed of | Must not |
|---|---|---|
| `FeedbackSheet` | `Sheet` frame + `CorrectionDiff`/`AnswerRecapBox`/`FeedbackBulletList` + `FeedbackActionRow` (made of `Button`) | contain a second sheet, a scrim, or per-mode structure |
| `ConversationShell/*` | `AppHeader`, `ChatBubble/*`, `ChatComposer/*`, optional `HintChipBar` | fork bubbles or composer per variant |
| `ExerciseEditor/*` | `AppHeader/Progress`, `SourceTextCard`, `AnswerInput`, `HintChipBar`, `SubmitButton` | show more than one primary action |
| `Dialog/Confirm` | title, body, 2 `Button/Sm` | have a close ×, or backdrop-confirm |
| `Sheet/*` | grabber? · header · body · action row | dock to an edge |
| `SettingsRow/*` | label, optional value/control | nest a second interactive control (except `Toggle`) |
| `Card` families (Mode, Topic, Lesson, Deck, Banner, History) | whole-card button (P1) | contain two competing CTAs (`LessonCard` CTA + card tap are one action) |
| `FloatingBottomBar` | 2 `Button/Icon`, `StreakPill`, Menu pill | appear off the dashboard |
| FlowLetter (`GameHUD`, `LetterTile`, `GlassButton`) | `glass.*` + `feature.flowLetter.*` | use light-theme surfaces |
