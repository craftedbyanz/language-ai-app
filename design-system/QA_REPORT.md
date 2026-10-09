# Design System QA Report: Final Implementation Readiness

Date: 2026-10-09 (updated after the product owner approved the v1 decisions, see "Approved v1 decisions"). Method: read-only audit of `design-system/` by an agent with no prior knowledge of the source application; no research archive, screenshots or app were consulted. Fixes were limited to what is derivable from the existing canonical files (see "What this QA changed").

# Verdict

**READY_FOR_VIBE_CODING**

All ten simulated screens are IMPLEMENTABLE after normalization. No contradiction remains that would make two reasonable agents build materially different UI. Before normalization the verdict would have been **NOT_READY** (see "Blocking Gaps (found and fixed)"): three screens and several components referenced undefined pieces.

Caveats that do not block, but must be understood:
- Typography sizes, shadows, breakpoints, motion and many layout ratios are `ESTIMATED` defaults, not measurements. They are centralised in `TOKENS.json`.
- The QA-introduced decisions DD-22 to DD-26 have since been **APPROVED_V1** by the product owner (see below). Remaining unknowns are copy, thresholds and device tuning.

# Implementation Simulation

| # | Screen | Result | Notes |
|---|---|---|---|
| 1 | Home dashboard | **IMPLEMENTABLE** | Was blocked: `GreetingBlock`, `PromptEntry`, `StreakPill`, brand fills of Banner/Plus/ModeCard were unspecified. Now defined; explainer rail marked OPTIONAL/DEFERRED; Promo banner gated by `paywallEnabled` (DD-24). |
| 2 | Writing topic picker | **IMPLEMENTABLE** | Hero, chip rail, 2-col grid, breakpoints, loading/empty all specified. `TopicCard/Plus` conditional on `paywallEnabled`. |
| 3 | Writing exercise editor | **IMPLEMENTABLE** | Was ambiguous: no `Button` family, no layout order, More-menu semantics, current-segment cue. Now defined. |
| 4 | Writing correct FeedbackSheet | **IMPLEMENTABLE** | Header, sections, actions, rating row, loading, a11y-safe title colour. |
| 5 | Grammar incorrect FeedbackSheet | **IMPLEMENTABLE** | Same family, Tips bullets, `FixNext`. |
| 6 | Free Conversation | **IMPLEMENTABLE** | More-menu items (DD-03), failure row (`InlineError`), no result screen (DD-02). |
| 7 | Scenario Conversation | **IMPLEMENTABLE** | Was underspecified after the opening state. Now: send → `FeedbackSheet/Writing*` → append next pair → stepper advance → `CompletionTemplate` (DD-06). |
| 8 | Flashcard deck | **IMPLEMENTABLE** | Header, counters, segmented control, row list, empty/loading. |
| 9 | SRS review card | **IMPLEMENTABLE** | Front/back/grades, keyboard 1-4 + Space, queue-empty state (DD-07). Swipe/tutorial explicitly future (DD-25). |
| 10 | Settings list | **IMPLEMENTABLE** | Rows, account card read-only, toggles with accessible colours. |

# Blocking Gaps (found and fixed)

None remain. Gaps that *would* have blocked and what resolved them (all derived from existing rules):

| Gap | Fix |
|---|---|
| `FeedbackActionRow`, `Dialog`, `Sheet/Create`, settings CTA all used an undefined "primary/secondary/destructive button" | Added `Button` family (variants, sizes, states) built from existing `control.*`, `radius.full`, `control_state.*`; new tokens `control_state.actionFill/actionText/secondaryFill`. |
| Text-on-fill colours (answer cards, home cards, task bubble, grade glyphs) specified as `textOnPrimary` (white) failed 4.5:1 | `accessible.onFeatureFill` / `onBrand` / `onGradeFill`, and `answerPalette.*` pairs for answer cards (DD-26); table in ACCESSIBILITY §8A. |
| Dashboard components used by the template had no entry (GreetingBlock, PromptEntry, StreakPill) | Added to COMPONENTS §9. |
| `Skeleton`, loading/error visuals referenced but not defined | Added `Skeleton`, `InlineError`, `EmptyState/Error`; template-wide loading/error/empty rules. |
| Lesson completion hook ("DEFERRED") left ExerciseTemplate and Scenario with no end state | `CompletionTemplate` (SCREEN_TEMPLATES §14) from DD-01's own default; built from existing components. |
| `HistoryCard`/`BenefitRow`/`PlanCard` ambiguous pseudo-components | See next section. |
| Responsive formulas referenced numbers in prose, not tokens (breakpoints, ratios, heights) | 22 new `layout.*` tokens; template responsive matrix (RESPONSIVE_RULES §14). |
| Conflicting formula: LessonCard width "viewport − 2×marginScreen − peek" vs "0.83 × viewport" | Single token `layout.lessonCardWidthRatio`. |
| ConversationShell eyebrow shown for both variants vs scenario-only | Eyebrow is Scenario only; Free shows the topic as header title. |
| `feature.flowLetter.gradient.roundDeck = "purple"` (non-hex, unresolved) | Aliased to the purple `options` gradient; flagged CANDIDATE. |
| `feature.conversation.*` duplicated `color.primaryStrong` hex as a separate concept | Aliased to `color.primaryStrong`. |

# HistoryCard / BenefitRow decision

| Name | Required by an initial-implementation template? | Resolution |
|---|---|---|
| `HistoryCard` | **Yes**: `InsightTemplate` History variant (reachable from the Home menu) | Promoted: `InsightCard/History` is a full spec (anatomy, size tokens, states, interaction, a11y) in COMPONENTS §7; `HistoryCard` is its documented alias. |
| `BenefitRow` | **No**: only inside `PaywallTemplate` (policy-blocked purchases) | **OPTIONAL / DEFERRED** with `PaywallTemplate`, `PlanCard`, `PlusTile`, `Banner/Promo`, gated by `paywallEnabled = false` (DD-24). Anatomy recorded inside `PaywallCard` for when it is built. |
| `PlanCard` | No (same) | OPTIONAL / DEFERRED as above. |

# Non-blocking Open Decisions

DD-01…DD-26 reviewed. Classification (also recorded at the top of DESIGN_DECISIONS.md):

| Class | DDs |
|---|---|
| **A. SHIP_BLOCKING** | **none** |
| **APPROVED_V1** | **DD-22, 23, 24, 25, 26** (see next section) |
| **B. FEATURE_BLOCKING** | **DD-16** (word-game rules/scoring/results: visual layer only) |
| **C. NON_BLOCKING_DEFAULT_AVAILABLE** | DD-01, 02, 03, 04, 05, 06, 07, 08, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 21 |
| **D. FUTURE_ENHANCEMENT** | **DD-09** dark mode; swipe grading (progressive enhancement, DD-25); paywall purchase flow (policy-blocked, DD-24) |

Focus areas: typography (DD-08) has a complete scale and system font. Contrast (DD-22, APPROVED_V1) is resolved by `accessible.*` + `meta.colorProfile`. Lesson completion (DD-01) has `CompletionTemplate`. Conversation completion (DD-02): no result screen. Errors (DD-04): `InlineError`. Dark mode: out of scope. Motion (DD-10): `motion.*`. Chat menu (DD-03): items + `PopupMenu/Standard`. Breakpoints (DD-12): `layout.breakpoint*`.

# Token Integrity

- Valid JSON: yes. 204 leaf entries (VERIFIED 30, SUPPORTED 65, CANDIDATE 33, ESTIMATED 76). **0 unresolved `{alias}` references** (checked mechanically). Every token path cited in the markdown resolves (two citations, `layout.breakpoint*` and `accessible.score{Low,Mid,High}Text`, are glob/brace shorthand).
- Observed values: **none modified.** Additions are new tokens or aliases. Only three re-pointings, all same-hex: `feature.conversation.accent/cta/userBubble/homeCardFill` now alias `color.primaryStrong` (#2563EB, identical), and `roundDeck` ("purple" → alias).
- Semantic naming rule added to `meta.rules`: `…Text` on neutral, `…TextOnTint` on tint, `…Strong` for filled controls with white body text.
- **Fidelity vs production** (`accessible` group + `meta.colorProfile` + ACCESSIBILITY §8A): decision table by *role*; default profile `production`; `fidelity` is explicit opt-in only and is defined mechanically by `meta.colorProfile.fidelityOverrides`. Measured contrast (WCAG):

| Pair | Fidelity | Production |
|---|---|---|
| white on `primary` | 3.7 | white on `primaryStrong` 5.2 |
| primary text on white / on `primaryTint` | 3.7 / 3.0 | `primaryStrong` 5.2 / `primaryTextOnTint` 5.5 |
| `success` text on white | 2.5 | `successText` 5.5 |
| `error` text on white / on `errorTint` | 3.8 / 3.3 | `errorText` 4.8 / `errorTextOnTint` 5.9 |
| `warning` text/outline on white | 2.8 | `warningText` 5.2 |
| diff added text on tint | 2.1 | 4.6 |
| `textFaint` hero line | 2.6 | `heroSecondLine` 5.2 |
| toggle off | 2.0 | 3.3 |
| writing answer card / grammar answer card | white 4.0 / 4.0 | `answerPalette` pair foreground `textPrimary` 4.8 / 4.7 |
| grammar home card / task bubble | white 2.0 / 3.7 | `accessible.onFeatureFill` 9.5 / 5.2 |
| grade glyphs | white 2.1-4.1 | `textPrimary` 4.7-9.2 |

- Findings fixed: `errorText` on `errorTint` was only 4.1-4.2 (sub-AA) → `errorTextOnTint`; `successText` on `successTint` is 4.56 (pass); the lone-colour current segment in `ProgressStepper` was ~`border` → requires an outline.
- Unused groups: only `feature.scenario.accent`, `feature.srs.accent/cardFill`, `feature.flowLetter.glassFill` (referenced by alias only) remain unreferenced in prose: harmless aliases, retained for mode-kit completeness.
- Canonical vs estimated is distinguishable at every leaf (`confidence`). `typography.*.ref` is informational only (noted in the token file); `layout.contentWidthDashboard` marked "do not use in code".
- ESTIMATED-heavy areas that rely on defaults: typography, shadows (`floating`, `hairline`), `space.xl/xxl`, `layout.sheetMaxHeightRatio*`, all `motion.*`, all new breakpoints/ratios.

# Component Integrity

All requested families verified against purpose / anatomy / variants / states / tokens / dimensions / interaction / a11y / composition:

| Family | Status |
|---|---|
| ModeCard, TopicCard, LessonCard | Complete. Fixed: width tokens, text-colour rule, `Plus` availability. |
| ExerciseEditor, AnswerInput, SubmitButton | Complete. Fixed: layout order, More-menu semantics, paired answer-card foreground (`answerPalette`). |
| FeedbackSheet | **One reusable family** (frame + 5 variants + `loading`), buttons via `Button`, composition constraint table. |
| ConversationShell / ChatBubble / ChatComposer | **Scenario is `ConversationShell/Scenario`**: identity rule added to COMPONENT_VARIANTS; shares header, bubbles, composer, stepper, FeedbackSheet, Dialog. Eyebrow contradiction fixed. |
| ScoreChip, ProgressStepper, HintChipBar | Complete. Stepper current-segment cue and height token added. |
| SRSCard / SRSGradeButton | Complete. No swipe grading or tutorial in v1; grade buttons canonical (DD-25, APPROVED_V1). |
| PopupMenu, Dialog, Sheet | Complete. Dimensions tokenised; destructive label colour fixed. |
| SettingsRow | Complete. Account row read-only. |
| FlowLetter components | Visual layer complete; interaction rules are DD-16 (Class B, feature scope). |

Remaining thin spots (acceptable, product copy or data): `DeckCard` internals, `FlowLetterTile` preview, `GameHUD` internals are structurally specified but with CANDIDATE dimensions.

# Template Integrity

- 14 templates (added `CompletionTemplate`). Each has regions, hierarchy, slots, navigation, and template-wide loading/error/empty rules.
- **Prose dependency scan:** no instance of "same as original", "similar to the screenshot", "roughly like", or "refer to research" remains. Remaining "Evidence: S0xx" lines are traceability only, not instructions. "Desktop/reference app" mentions are in README/CONTRACT policy text.
- Gaps left that are *content*, not design: copy for every string; quick-topic list; topic taxonomies.

# Accessibility Readiness

Ready. Roles, names, focus order, announcements, target sizes, gesture alternatives, reduced motion and language attributes are specified; contrast now has an explicit role→token decision table (§8A) and an unlisted-pair rule. Known limits: game accessibility is only derived from §10 (DD-16); score popover and menu visuals are defaults.

# Responsive Readiness

Ready for compact / regular / wide with a template matrix (§14) and tokenised thresholds. Everything outside the 788 portrait reference is ESTIMATED (DD-12, DD-21); no phone/landscape evidence exists, so a first device pass may tune ratios, but the structure (reflow, not scale; 1-col grid; stacked actions < 280) is unambiguous.

# Recommended Coding-Agent Reading Order

1. ALWAYS: README → TOKENS.json → IMPLEMENTATION_CONTRACT.
2. TASK: the one SCREEN_TEMPLATE → the listed COMPONENTS / COMPONENT_VARIANTS → INTERACTION_PATTERNS section.
3. WHEN NEEDED: DESIGN_DECISIONS (classification table first), ACCESSIBILITY (§8A for colour), RESPONSIVE_RULES, FOUNDATIONS/PATTERNS.
4. NEVER REQUIRED: UI_MAPPING (traceability only), `references/gramago/`.

(Implemented in VIBE_CODE_GUIDE.md §1 with a task→files table.)

# What this QA changed

- `TOKENS.json` 1.0.0 → 1.2.0 (1.2.0 adds `answerPalette`, `meta.colorProfile`): +`accessible`, `state`, `focus`, `motion`, `feature.home`; +22 `layout.*`, 3 `color.*Text*`, 3 `control_state.*`, `typography.displayCompact`, `progressCurrent` ×2; documented composite/typography exception; 4 same-hex aliases.
- `COMPONENTS.md`: contrast-role mapping, Button/Skeleton/InlineError/GreetingBlock/PromptEntry/StreakPill, composition constraints table, HistoryCard promotion, PlanCard/BenefitRow deferral, contradictions fixed.
- `COMPONENT_VARIANTS.md`, `SCREEN_TEMPLATES.md` (+Completion), `INTERACTION_PATTERNS.md`, `PATTERNS.md`, `FOUNDATIONS.md`, `RESPONSIVE_RULES.md`, `ACCESSIBILITY.md` (§8A), `DESIGN_DECISIONS.md` (classification, DD-23…26), `IMPLEMENTATION_CONTRACT.md` (precedence, style-exception, optional features), `VIBE_CODE_GUIDE.md` (rewritten), `UI_MAPPING.md` (banner), `README.md`.
- Not touched: `references/`, application code. Nothing committed.

# Approved v1 decisions

| DD | Decision | Status |
|---|---|---|
| DD-22 | `production` colour profile is DEFAULT; `fidelity` explicit opt-in only. `accessible.*` for text/icon/outline/state surfaces where contrast requires; fidelity colours stay for decorative fills, dots, previews and explicit fidelity-mode. Mechanism: `TOKENS.json` `meta.colorProfile` (`fidelityOverrides`, `alwaysFidelity`, `invariant`). | **APPROVED_V1** |
| DD-23 | Entire `InsightCard/History` card is the tap target while it has one destination; nested actions would require explicitly separate interaction regions (declared in COMPONENTS first). | **APPROVED_V1** |
| DD-24 | `paywallEnabled = false`; paywall absent from default v1 navigation; `PaywallCard`, `PlanCard`, `BenefitRow` OPTIONAL / DEFERRED. | **APPROVED_V1** |
| DD-25 | No swipe grading in v1; grade buttons canonical; swipe later only as progressive enhancement; no tutorial overlay in v1. | **APPROVED_V1** |
| DD-26 | Every answer palette entry is a safe pair `answerPalette.<key>.background` + `.foreground` (keys: purple, blue, indigo, green, lime, ink, white). Agents never guess a foreground. Preference stores the key. | **APPROVED_V1** |

Contrast of every `answerPalette` pair (computed): purple 4.81, blue 4.73, indigo 5.17, green 5.48, lime 15.99, ink 19.0, white 19.0 (all ≥ 4.5:1). The `white` entry must carry `shadow.hairline` (card vs page is 1.05:1). Because these decisions are approved, code does not carry `// DD-XX default` comments for them (IMPLEMENTATION_CONTRACT 18, 19b).

# Remaining Human Decisions

Not blocking; each has a default:

1. ~~Colour profile, DD-23/24/25/26~~: **resolved, APPROVED_V1.**
2. **Copy and thresholds** (DD-01, 04, 05, 11): completion text/stats, error wording, score bands (low < 60, mid 60-89, high ≥ 90).
3. **Font family** (DD-08) before brand polish.
4. **Word-game rules and scoring** (DD-16) before building that feature; **purchase flow and pricing** only if `paywallEnabled` is ever turned on.
5. **Dark mode** (DD-09): deferred.
6. A real device pass to tune `ESTIMATED` ratios/heights (DD-12, DD-21).
