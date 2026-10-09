# Foundations

The visual language of our product. These are rules for **our** app, derived from frozen research. Tokens referenced here live in [TOKENS.json](TOKENS.json).

Confidence tags: VERIFIED / SUPPORTED / CANDIDATE / ESTIMATED (defined in TOKENS.json `meta`).

---

## 1. Personality

A calm, light, friendly study tool that feels like a polished consumer app, not a classroom portal.

- **Light and airy**: near-white pages, white cards, almost no ornament. The learner's content is the hero.
- **Confident colour, used sparingly**: one saturated colour per context (blue banner, purple answer card, lime accent, indigo chat), set against neutral surfaces.
- **Rounded everywhere**: large radii on cards, full pills on controls. Nothing sharp.
- **Encouraging, not punishing**: feedback names what was good before what to fix (verdict title, then explanation, then improvements). Incorrect is red but never alarming; no screen-filling error treatments.
- **Editorial headlines**: large, heavy, tightly leaded hero lines with a coloured full stop; micro uppercase labels as eyebrows.

## 2. Information density

**Low-to-medium.** One primary task per screen. Lists are generous (rows 54–87 ru tall), cards are big (topic cards ~123 ru, lesson cards ~290 ru). Secondary information is caption-size grey text, never hidden behind icons only.

Rules:
- A screen has at most one primary call to action.
- Exercise screens show only: the source, the answer field, hints, submit.
- Dense data (calendars, stat grids) is allowed only in dedicated insight/history screens, kept to a 3-column / 7-column rhythm.

## 3. Whitespace philosophy

Whitespace separates *groups*, not items.

- Margins: `layout.marginDashboard` (12) on dashboards and carousels that bleed to the card edge; `layout.marginScreen` (18) on pushed/detail screens.
- Inside a group use `space.sm` (8); between related groups `space.lg` (16); between sections `space.xl`–`space.xxl` (24–32). Section gaps were irregular in the research (19–39); snap them to the scale, do not copy.
- Cards are padded generously; never put text within `space.md` of a card edge.
- Floating surfaces (bottom bar, sheets, dialogs) stand off from every edge instead of docking.

## 4. Hierarchy

Five levels, always in this order of weight:

1. `typography.display` – hero line (one per picker/lesson screen, max).
2. `typography.title` – screen/card titles, greetings, big numbers.
3. `typography.heading` – nav titles, section titles, verdict titles.
4. `typography.body` / `bodyStrong` – content, buttons.
5. `typography.caption` / `microLabel` – supporting labels, eyebrows, badges.

Colour carries hierarchy too: `textPrimary` → `textSecondary` → `textMuted` → `textFaint` (decoration only). Two-tone hero lines use `textPrimary` + `accessible.heroSecondLine` (second line softer).

Case system (VERIFIED as observed pattern): sentence case for content; **UPPERCASE microLabel** for eyebrows, badges and section labels; uppercase allowed for lesson titles in the learning language.

## 5. Surface hierarchy

| Level | Token | Used for |
|---|---|---|
| 0 Page | `color.background` (or `backgroundPlain` for data/list screens) | Screen canvas |
| 1 Card | `color.surface` + `shadow.none` or `shadow.hairline` | Cards, rows, bubbles |
| 1m Muted | `color.surfaceMuted` | Inset panels, chips, recap boxes, score chip, scripted AI bubble |
| 2 Raised | `color.surface` + `shadow.raised` | Stacked/flip cards (SRS) |
| 3 Floating | `color.surfaceElevated` + `shadow.floating` | Sheets, popovers, dialogs, menus |
| 4 Scrim | `color.overlayScrim.*` | Behind modal dialogs, FAB menu, info sheet |
| G Glass | `glass.bar` | Floating bottom bar, full-window menu overlay |

Elevation is expressed by **shadow and scrim**, never by a different white. Surface fill differences are only to *inset* (muted).

Scrim is **per surface**, not global (VERIFIED by measurement): modal dialogs and the FAB menu / info sheet dim the page; feedback sheets, score popovers, create sheets and the paywall do **not**. See [PATTERNS.md](PATTERNS.md) §Overlays for the table.

## 6. Card philosophy

- **Whole-card targets.** A card is one button; its accessible name concatenates its text.
- **Flat by default.** Cards separate from the page by fill contrast (white on near-white) and, where needed, a hairline border. Shadows are reserved for things that move or float.
- **One card = one decision.** Mode card → a mode. Topic card → a topic. Lesson card → a lesson. Never put two competing CTAs on one card.
- **Large cards use `radius.largeCard` (24); banners/list cards `radius.card` (18); hero dashboard cards `radius.heroCard` (28).** Radius stays proportional to card size.
- **Numbers as design.** Large faded index numerals ("01", "02") on mode and lesson cards give rhythm and a sense of sequence.
- **Mode colour appears as accent, not as wallpaper.** Lesson cards are white; the mode shows up in the CTA fill, hero full stop, and progress.

## 7. Navigation philosophy

- **Hub and spoke.** Dashboard → mode → topic picker → lesson list → exercise. Every mode uses the *same* picker → list → exercise chain (see SCREEN_TEMPLATES), so learners transfer what they know.
- **Back is leading, always.** Pushed screens: a leading back button, centred title, optional trailing action. Back label may be the parent's title on settings pages.
- **Exercises are modal.** They have a close affordance, not a back button, and ask for confirmation when work would be lost. Review sessions (flashcards) and games close without confirmation.
- **Floating bottom bar on the dashboard only.** Shortcuts live here (history, streak, menu, settings). Deeper screens do not carry a tab bar.
- **A full-window frosted menu** is the shortcut hub for secondary destinations; it is an overlay, not a bottom sheet.
- Content is dynamic; never rely on fixed ordering of topics or lessons.

## 8. Feedback philosophy

- **One family.** Every AI verdict, in every mode, uses `FeedbackSheet` (variants differ in verdict, sections and actions, not in structure).
- **Verdict first, then why.** Header (icon + title + optional score) → corrected text → explanation → bullets → actions.
- **Never colour alone.** Verdicts pair colour with an icon and a word; diffs pair colour with strike-through or a chip.
- **Non-blocking.** Feedback sheets float over the exercise, are not scrimmed, and can be minimised (grabber) and reopened (a sparkle chip in the hint bar). The learner can still see their work.
- **Loading is honest.** A skeleton of the final sheet plus a "grading" title, with a cancel action.
- **Errors**: `InlineError` in the failed region with Retry; never full-screen (DD-04).

## 9. Use of accent colours

- **Neutral first**: `background`, `surface`, `textPrimary` carry ~90% of any screen.
- **`primary`** (blue) = brand/interactive/selected fills and dots. Blue **text and brand surfaces carrying text** go through `accessible.*` (ACCESSIBILITY §8A).
- **Feature accents** (see §10) identify a mode on its picker hero, lesson CTA, progress.
- **`success`** (green) = correct, on, selected radio, completed step. **`error`** (red) = incorrect, destructive. **`warning`** (orange) = selected filter, streak, mid score, 'mistakes'. These raw hues are for fills, dots and icons; their text and outline use the `accessible.*` alias.
- **Lime is an accent, never a text colour** on light surfaces. Use it for fills, dots and bullets; pair with dark text when it holds a label.
- User-configurable: the exercise answer-card colour is a **user preference** chosen from `answerPalette` (default writing `purple`, grammar `blue`); each entry is a background/foreground pair. Do not hard-code it or pick a foreground yourself.
- Max three accent hues visible on a screen outside the hero.

## 10. Feature-mode differentiation

Differentiate modes with **a small, consistent kit**: a hero full-stop colour, the lesson CTA fill, the answer-card colour and the progress colour.

| Mode | Accent | Lesson CTA | Answer card | Progress |
|---|---|---|---|---|
| Writing | blue | dark navy | purple | green |
| Grammar | lime | lime (dark label) | blue | green |
| Conversation | indigo | indigo | n/a (chat) | n/a |
| Scenario | blue | n/a | n/a (chat) | blue (current = tint) |
| SRS / Flashcards | blue | n/a | white card | n/a |
| Flow Letter | own gradient world | n/a | n/a | n/a |

Everything else (layout, type, radius, spacing) is shared. Mode identity must never change component *structure*.

## 11. Glass / frosted surfaces

Used in exactly three places:
1. The floating bottom bar on the dashboard.
2. The full-window menu overlay (blur plus dim).
3. The game (Flow Letter) controls, which are translucent white on saturated gradients.

Rules: glass always sits over *content or gradient* (never a flat page), uses `glass.*` tokens, and its text/icon contrast is checked against the worst-case backdrop. Fall back to an opaque `surface` where blur is unsupported or `prefers-reduced-transparency` is set.

## 12. Floating feedback surfaces

Sheets, popovers and dialogs **float**: all four corners rounded, inset from the screen edges, width capped (≈57% of the reference viewport, see RESPONSIVE_RULES), anchored low on the screen for sheets and centred for dialogs. They are not docked to the bottom edge.

- Sheets have a grabber (drag to minimise) and a close action.
- Sheets use `radius.sheet` (20) and `shadow.floating`; dialogs `radius.dialog` (24).
- Whether the page dims is per surface (see §5).

## 13. Educational progression patterns

- **Segmented progress.** A `ProgressStepper` of N equal segments shows position in a set (writing 10, grammar 20, scenario 8 observed). Done = solid mode colour; current = tint or highlight; idle = `border`.
- **Source highlight.** In multi-sentence exercises the current sentence is highlighted with `color.highlight`.
- **Short loop:** Attempt → verdict → fix or continue. "Fix" keeps the learner's text; "Next" advances one step and resets the field.
- **Hints are optional and subdued** (blurred chips + a reopen-last-verdict chip).
- **Scaffolded input difficulty by mode:** paragraph translation (writing) → single sentence correction (grammar) → open conversation (conversation) → scripted translation tasks (scenario).
- **Spaced repetition:** card front → flip → 4-level self-grade (Again / Hard / Good / Easy) with interval previews.
- **Streak and insight** reward consistency (flame, calendar, stat tiles); numbers use `title`-size type.
- **Completion**: `CompletionTemplate` (DD-01 default). Do not invent another.

## 14. Do / Don't summary

| Do | Don't |
|---|---|
| Use `surface` + hairline for cards | Add shadows to flat cards |
| Pair verdict colour with icon + word | Use colour alone |
| Keep one accent family per mode | Tint the whole screen with the mode colour |
| Snap spacing to the 4-pt scale | Copy irregular measured gaps |
| Float sheets and dialogs inset from edges | Dock sheets to the bottom edge |
| Use lime for fills/dots | Use lime as body text |
| Offer an opaque fallback for glass | Put glass on a flat white page |
