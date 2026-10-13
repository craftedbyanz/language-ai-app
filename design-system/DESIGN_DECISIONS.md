# Design Decisions

Two parts:

- **A. VERIFIED DESIGN RULES**: decided by evidence. Implement as written.
- **B. DESIGN DECISIONS**: evidence is missing or contradictory. Each item is either **APPROVED_V1** (decided by the product owner; implement as written) or carries a **recommended default** and says whether product design may choose **freely**. See the classification table below.

A default is a placeholder that keeps the build moving. It is **never** evidence. When a default is used, the code must reference the DD id in a comment. An `APPROVED_V1` decision is not a default and needs no `DD-XX default` comment.

## Implementation reconciliation — 2026-10-12

The Flutter Home and lesson-list carousels now use the existing `PagerDots/Dashboard`
and `PagerDots/Lesson` treatments. The lesson variant applies to both Writing and
Grammar. `state.modeCardIndexOpacity` and `state.modeCardDividerOpacity` centralise
the decorative opacity values already described in `COMPONENTS.md`; they introduce
no new visual decision. Lesson cards use one whole-card action with a right-aligned
CTA, and topic counts use the specified `StatusBadge/Count` treatment. These changes
reconcile implementation with the existing component and template rules.

---

## Classification (final QA, 2026-10-09)

A DD is **blocking** only if a coding agent cannot build a reasonable UI without a human answer. Every DD below has a usable default, so nothing blocks the ten core screens.

| Class | Meaning | DDs |
|---|---|---|
| **APPROVED_V1** | decided by the product owner for v1; implement as written | **DD-22, DD-23, DD-24, DD-25, DD-26** |
| **A. SHIP_BLOCKING** | cannot ship a coherent product UI without a human decision | **none** |
| **B. FEATURE_BLOCKING** | the UI default exists, but the *feature* cannot be completed without product rules | **DD-16** (word-game rules, scoring, results: only the visual layer is specified) |
| **C. NON_BLOCKING_DEFAULT_AVAILABLE** | use the default, comment `// DD-XX default`, list in the PR | DD-01, 02, 03, 04, 05, 06, 07, 08, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 21 |
| **D. FUTURE_ENHANCEMENT** | not in the initial build | **DD-09** (dark mode); swipe grading (DD-25, progressive enhancement); paywall purchase flow (DD-24, policy-blocked) |

For `APPROVED_V1` items code carries no `// DD-XX default` comment (they are decisions, not defaults); reference the DD id only where behaviour could look surprising (e.g. `// DD-24: paywall off in v1`).

Notes on the focus areas: typography (DD-08) has a complete default scale and system font; contrast (DD-22, APPROVED_V1) is resolved by the `accessible.*` tokens and `meta.colorProfile`; lesson completion (DD-01) has `CompletionTemplate`; conversation completion (DD-02) defaults to no result screen; errors (DD-04) have `InlineError`/`EmptyState/Error`; dark mode (DD-09) is out of scope; motion (DD-10) has `motion.*` tokens; chat menu (DD-03) has items and a component; breakpoints (DD-12) are `layout.breakpoint*` tokens.

**Release hygiene (not blocking, recommended before a public release):** have a human review the copy and thresholds from DD-01, 04, 05, 11.

---

## A. Verified design rules

| # | Rule | Basis |
|---|---|---|
| V1 | Canonical layout is designed against a 788×1083 reference; other sizes reflow, they do not scale | Evidence rule; 554×772 reflowed content at ~0.70× |
| V2 | One feedback container (`FeedbackSheet`) for every AI verdict; variants differ in verdict, sections and actions | S006, S028, S056, S060, S061 |
| V3 | Scenario is a variant of `ConversationShell`, selected by a persistent mode preference | S063, S064 |
| V4 | Floating surfaces (sheets, dialogs) are inset with all corners rounded, not docked | S006, S028, S030, S032, S045 |
| V5 | Scrim is per surface: dialog and FAB menu/info sheet dim, feedback/create/paywall/popover do not | measured S007, S031, S032, S028, S030, S045 |
| V6 | Page background `#F9FAFB`, surfaces `#FFFFFF`, inset panels `#F3F4F6` | S001–S004, S006 |
| V7 | Error/incorrect red = `#EF4444`; submit disabled ring `#898990`, enabled `#000318` | S004, S005, S006 |
| V8 | SRS grade colours (again/hard/good/easy) as in `grade.*` | S052 (active) |
| V9 | Radii cluster: card 18, largeCard 24, heroCard 28, sheet ≈ 20, dialog 24, control (bubble) 14, pills full | circle fits on active captures |
| V10 | Exercise Next advances exactly one step after correct or incorrect verdicts | S055–S057, S006 |
| V11 | Exit confirmation uses one dialog for writing, grammar, conversation, scenario; none for SRS or the game | S007, S062, S015, S039 |
| V12 | Submit and send controls are disabled when empty and enabled by content | S004, S005, S022, S025 |
| V13 | Topic grid is two columns of equal-height cards at the reference width | S002, S008 |
| V14 | Navigation: dashboard → picker → list → exercise for every mode | State graph |
| V15 | Writing progress stepper = segmented bar; first segment completes after step 1 | S057 |
| V16 | Answer-card colour is a user preference, with defaults (writing purple `#A855F7`, grammar blue) | S004, S058, Lesson-settings screen |
| V17 | Grammar-correct sheet is compact (recap + link + single Next) | S061 |
| V18 | Hint bar keeps a sparkle chip after a verdict to reopen the last sheet | S057, S060 |
| V19 | Home bottom bar exists on the dashboard only | S001 vs all pushed screens |
| V20 | Colours are normalised to sRGB; non-sRGB raw hex never ships | encoding audit |

---

## B. DESIGN_DECISION_REQUIRED

### DD-01 Lesson-completion screen
- **Evidence**: none. Writing needs 10 gradings, grammar 20; budget ran out. No shortcut exists.
- **Unknown**: whether a result screen, a sheet, a summary or just a return to the lesson list follows the last step; what it shows (score, accuracy, streak, XP, next lesson).
- **Recommended default**: a `Sheet/Info`-style floating card with a heading, a 2–3 `Stat` row (steps completed, corrections, streak) and two actions (primary "Next lesson", secondary "Done" → LessonList). Built only from existing components.
- **Free to choose?** Yes, freely. It is the single largest design gap and must be added to SCREEN_TEMPLATES as `CompletionTemplate` when designed.
- **Status**: DEFAULT AVAILABLE. Specified as `CompletionTemplate` (SCREEN_TEMPLATES §14); remains a product decision for copy and stats.

### DD-02 Conversation result after a fully completed session
- **Evidence**: 0 and 1 scored turns → "end session" shows the exit dialog and lands on the lesson list; no result. The dialog says progress "will not be saved" when unfinished.
- **Unknown**: whether a longer session crosses a threshold that produces a result; what "finished" means; whether progress is saved.
- **Default**: no result screen for chats; per-message ScoreChips are the only feedback. "End session" and Close always show the same `Dialog/Confirm` (V11), then return to LessonList. If a session summary is wanted later, reuse `CompletionTemplate`.
- **Free to choose?** Yes, but keep one confirmation dialog and its copy for abandoning.

### DD-03 Chat "More" menu visual treatment
- **Evidence**: items known from accessibility only: translation toggle, one disabled item (label unknown), end session. The popup never rendered in any capture. The editor's More menu *was* rendered (S051) and is the closest analogue.
- **Unknown**: exact appearance, position, disabled-item label.
- **Default**: use `PopupMenu/Standard` anchored below the More button; items: "Hide/Show translation", "End session"; omit the third item.
- **Free to choose?** Yes, within `PopupMenu`.

### DD-04 Generic error, loading and empty states
- **Evidence**: loading exists for grading (skeleton + Cancel) and chat (typing dots). No error was ever triggered (AI quota, network failure, invalid input, empty lists).
- **Unknown**: error copy, colour, placement, retry model; page loading; empty topic/lesson/history/deck lists; outcome of "Cancel" while grading; free-tier quota block ("limit") presentation.
- **Default**: errors appear **inline in the affected surface** via `InlineError` (a `surfaceMuted` row with `error` icon + text + "Retry"; `EmptyState/Error` for list regions); blocking cases use `Dialog/Confirm` with a single action; empty lists use `EmptyState`; page loading uses skeletons (`surfaceMuted` bars). Cancel returns to the editor with text kept. Quota exhaustion opens `Sheet/Paywall`.
- **Free to choose?** Yes. Record the chosen design here before implementing.

### DD-05 Score chip "86" vs feedback "Trôi chảy 88"
- **Evidence**: a chip showed 86; its opened sheet displayed a fluency number 88 and a "close" verdict. Another message scored 58. Dot colours: 58 red; 84/86 orange.
- **Unknown**: whether chip = overall and sheet = a fluency sub-score, a re-score, or a rounding difference; the sheet may expose several sub-scores.
- **Default**: treat the chip as the **overall score** and the sheet number as a **named sub-score** ("Fluency"). Show both only if the backend returns both; never show two numbers labelled the same. Chip dot colour derives from the overall score.
- **Free to choose?** Yes, but the chip and the sheet must never contradict each other for the same label.

### DD-06 Scenario grading, next task, completion
- **Evidence**: only the opening state (S064).
- **Unknown**: verdict presentation, whether the next task appends to the chat, how the stepper advances, end state.
- **Default**: after send, show `FeedbackSheet/WritingIncorrect|Correct` (translation task is writing-like; same family), then append the next scripted AI + Task bubbles and advance the stepper. Completion → DD-01.
- **Free to choose?** Yes, but reuse FeedbackSheet.

### DD-07 SRS grade → next card, queue-empty summary
- **Evidence**: card front/back, grade buttons (none pressed).
- **Unknown**: transition animation, whether the next card's back reveals immediately, summary screen.
- **Default**: grade → next card Front (no animation required); empty queue → `EmptyState` "Review complete" with counts and a "Back to deck" action.
- **Free to choose?** Yes.

### DD-08 Typeface family, absolute sizes, weights
- **Evidence**: hierarchy ratios from frame heights (display 39, title 26, heading 19/17, body 13, caption 9–11, micro 7–9). Live inspection of the running GramaGo app bundle identified Plus Jakarta Sans font files. Sizes in `TOKENS.json` remain ESTIMATED.
- **Default**: bundle the OFL release of Plus Jakarta Sans for English and Vietnamese at the sizes in `typography.*` (body floor 14). `typography.*.ref` is informational only, never used in code.
- **Free to choose?** Family is fixed; size estimates may be refined by visual comparison while keeping the hierarchy and body floor.

### DD-09 Dark mode
- **Evidence**: none; the "appearance" setting is a card-style picker, not a theme.
- **Default**: light only at launch. If dark is added, derive from semantic tokens, not per-component overrides.
- **Free to choose?** Yes.

### DD-10 Motion
- **Evidence**: presentation animations exist (sheets, dialog, carousel scale ~4%, typing dots); timings not measurable from stills.
- **Default**: 200–250 ms ease-out for sheets and dialogs, 150 ms for state changes, honour reduced motion. Carousel active card scale 1.04 is CANDIDATE.
- **Implementation note**: feedback sheets use the tokened `motion.sheetEnterOffset` for a short vertical entrance/exit, with a fade-only transition under reduced motion. This distance is a design default, not a measured GramaGo value.
- **Free to choose?** Yes.

### DD-11 Score bands and thresholds
- **Evidence**: 58 → red, 84/86/88 → orange. No green seen.
- **Default**: `score.thresholds` (low < 60, mid 60–89, high ≥ 90) with `error/warning/success`. The thresholds are product rules, not UI measurements.
- **Free to choose?** Yes, but red must stay "needs work", and band colours must come from tokens.

### DD-12 Breakpoints, wide viewports, orientation, safe areas
- **Evidence**: one canonical viewport; a 0.70× window reflowed content (cause of the resize unknown).
- **Default**: breakpoints in RESPONSIVE_RULES (560 / 1024), `contentMaxWidth` 764, portrait-first, safe-area insets added to margins.
- **Free to choose?** Yes; update RESPONSIVE_RULES first.

### DD-13 Mode-card fills for grammar and conversation; Home card text colours
- **Evidence**: writing card active blue (measured in the archive). In live GramaGo on 2026-10-12, the active Grammar card was purple and the adjacent Conversation peek was cyan. Flat screenshot samples were approximately `#8A5BF7` and `#7FD7E7` respectively; JPEG capture may vary slightly from the source assets.
- **Default**: use `feature.*.homeCardFill` for the three distinct mode cards. The production Grammar fill is shifted a few RGB levels brighter than the screenshot sample so `accessible.onFeatureFill` passes 4.5:1. Production text uses `accessible.onFeatureFill` on all three; the live app's white lettering on purple is recorded as visual evidence, but production accessibility remains governed by DD-22.
- **Free to choose?** Keep the sampled fills unless later evidence refines them.

### DD-27 Grammar vertical-slice feedback reconciliation — **APPROVED_V1**

- **Decision**: Grammar sentence exercises show the canonical Loading feedback for at least
  `motion.feedbackMinimumDwell` (300 ms), with Cancel retaining exact input and invalidating late
  results. `GrammarCorrect` keeps the analysis action visible but disabled with a localized reason.
  Feedback may minimize and reopen through `HintChipBar`. Final Next returns to Grammar Lesson List
  without completion UI because completion and persistence are outside this scoped slice.
- **Ownership**: these are additive states of the existing canonical components. Defaults remain
  backward compatible for Writing; no feature-local visual copies are permitted.
- **Accessibility**: the disabled analysis action remains discoverable in semantic reading order but
  is excluded from action activation order; feedback focus and announcements follow ACCESSIBILITY.

### DD-14 Menu overlay dismissal
- **Evidence**: open state only.
- **Default**: tap the backdrop or press Escape or an explicit close control.
- **Free to choose?** Yes.

### DD-15 Rating, word lookup, "view AI analysis", editor menu effects
- **Evidence**: controls exist (thumbs, "tap a word to look up", analysis link, menu items "show all", "background colour", "hints", "dictionary", "like", "dislike"); none was activated.
- **Default**: v1 grammar More menu omits "Show all" and the like/dislike items; writing keeps all. Thumbs toggle a pressed state and send a signal; lookup opens a small `PopupMenu`-style popover with definition and speak; "view analysis" expands the sheet to the full writing-style body; menu items perform their labels.
- **Free to choose?** Yes.

### DD-16 Word game interaction states
- **Evidence**: lobby, topic list, round start, settings, help.
- **Unknown**: drag affordances, solved/wrong/hint, combo, level-up, game over.
- **Default**: tap-select / tap-place as primary interaction, `success` flash on solved, `error` shake (reduced-motion: outline) on wrong; results shown with `Sheet/Info` pattern.
- **Free to choose?** Yes, inside the glass visual language.

### DD-17 Quick-topic chip effect
- **Evidence**: 10 chips exist ("surprise me", travel, etc.); effect not observed.
- **Default**: tap generates a lesson for that topic, using the same generation flow as the AI entry.
- **Free to choose?** Yes.

### DD-18 Icon family
- **Evidence**: two families mixed in the reference (decorative set + platform symbols).
- **Default**: one outline family, 1.5–2 stroke, sizes `icon.*`.
- **Free to choose?** Yes (but one family only).

### DD-19 Inactive-only states' final colours
- **Evidence**: ~18 states were captured only in inactive windows (e.g. flashcard deck list, profile, history, streak, conversation steps, paywall, game screens, AI composer). Structure is valid; fills, enabled/disabled colours and opacity are not. Known artefacts: Home card read grey instead of blue; topic-card fill read `#EDEEEF` instead of near-white.
- **Default**: use the semantic tokens (`surface`, `surfaceMuted`, `primary`) for these screens; mark anything specific `CANDIDATE`.
- **Free to choose?** Yes, within the token vocabulary.

### DD-20 Radii not fully measured
- **Evidence**: top corners of sheets and dialog measured; bottom corners not. Fit precision ±1.5. Word-row card radius (8) low confidence. Alternate-viewport radii not tokenised.
- **Default**: keep `radius.sheet` 20 and `radius.dialog` 24 on all four corners; `radius.xs` 8.
- **Free to choose?** Yes, ±2.

### DD-21 Compact viewport values
- **Evidence**: only the reflow at ~0.70× scale; no actual phone viewport.
- **Default**: RESPONSIVE_RULES §11.
- **Free to choose?** Yes.

### DD-22 Colour profile and contrast of observed accent fills — **APPROVED_V1**
- **Evidence**: measured accent fills with white text: primary blue 3.7:1, default writing answer card 4.0:1; red text on white 3.8:1; green on white 2.5:1.
- **Decision (approved)**: **`production` is the DEFAULT colour profile; `fidelity` is an explicit opt-in only.**
  - *Production*: wherever a colour carries text, an icon, an outline or a state indicator and contrast requires it, use the `accessible.*` tokens (role table: ACCESSIBILITY §8A). Brand-blue surfaces use `accessible.brandFill` + `accessible.onBrand`.
  - *Fidelity colours stay available* for decorative fills, dots, bars, previews and swatch thumbnails (raw `color.*`, `feedback.*`, `score.*`, `grade.*`), and for explicit fidelity-mode use.
  - *Fidelity mode* is enabled only by the product owner, by applying `TOKENS.json` `meta.colorProfile.fidelityOverrides`. A coding agent never switches profile itself. No observed token value is ever overwritten.
  - *Answer cards* are outside the profile switch: they use `answerPalette.*` pairs (DD-26) in both profiles.
- **Constraint**: in production every text/background pair is ≥ 4.5:1 (≥ 3:1 for large text, UI components and state indicators).
- **Status**: APPROVED_V1.

### DD-23 Home and History small behaviours — **APPROVED_V1**
- **Evidence**: PromptEntry opens a full-window composer sheet (S046); History cards' tap target not exercised; live Menu interaction on 2026-10-12 confirms five coloured round icons.
- **Decision (approved)**: the **entire `InsightCard/History` card is the tap target** while it has a single destination (opens that item's LessonList). The group-header "See more" link lives outside the card and is a separate target. If nested actions are ever added inside a card, the interaction regions must be declared explicitly separate in COMPONENTS.md first (no implicit nested buttons; PATTERNS P1 exception list must name them).
- **Also (defaults, same decision)**: `PromptEntry` opens `Sheet/Composer`; menu row icon tiles use semantic coloured fills with white glyphs; `feature.home.promptEntryFill` = `surface`.
- **Status**: APPROVED_V1.

### DD-24 Paywall gating — **APPROVED_V1**
- **Decision (revised after live-app comparison, 2026-10-12)**: `paywallEnabled = false` for v1. The paywall route, purchase flow, `TopicCard/Plus`, Home `Banner/Promo` and quota-exhaustion upsell remain deferred. To preserve the observed Profile and Menu layouts, the settings Plus banner and Menu Upgrade row render as non-actionable previews. `PaywallCard`, `PlanCard` and `BenefitRow` remain optional/deferred. Quota exhaustion shows `InlineError` with a plain message. Brand-blue surfaces use `accessible.brandFill`.
- **Still open for a future release**: purchase flow, pricing and copy (policy-blocked, §C). Enabling the flag requires a new decision.
- **Status**: APPROVED_V1.

### DD-25 SRS gestures and tutorial — **APPROVED_V1**
- **Decision (approved)**: **no swipe grading in v1.** The four `SRSGradeButton`s are the canonical grading interaction (keys 1–4 grade, Space flips). No tutorial overlay in v1. Swipe may be added later as a **progressive enhancement** that mirrors the buttons and never replaces them.
- **Status**: APPROVED_V1.

### DD-26 Answer-card colour palette — **APPROVED_V1**
- **Decision (approved)**: every palette entry is a **safe pair** in `TOKENS.json` `answerPalette`: `answerPalette.<key>.background` and `answerPalette.<key>.foreground`. Keys (display order): `purple` (writing default), `blue` (grammar default), `indigo`, `green`, `lime`, `ink`, `white`. Foreground covers text, placeholder, caret and icons on the card.
- **Rules**: coding agents **never guess or compute a foreground**; they read the paired token. The user preference stores the entry key, not a hex. v1 offers no free-form colour picker; adding an entry means adding both tokens and checking ≥ 4.5:1 first. The `white` entry must carry `shadow.hairline`.
- **Status**: APPROVED_V1.

---

## C. Policy-blocked flows (not in the design system)

Purchases, trials, restore, account/profile edit, logout, language/level confirmation persistence, destructive deletes. The design system defines the *surfaces* (PaywallCard layout, SelectableRow, Dialog/Confirm) but no flow, copy or pricing. Add them through a product decision.
