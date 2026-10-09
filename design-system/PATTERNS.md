# Patterns

Cross-cutting visual and structural patterns that are **not** components and **not** flows. These are the recurring compositions that keep the product consistent. Interaction sequences are in [INTERACTION_PATTERNS.md](INTERACTION_PATTERNS.md).

---

## P1. Whole-card button
A card with several text children is a single button. Its accessible name concatenates the visible text in reading order ("index, MODE, kind, description, action"). No nested interactive elements except an explicit CTA on `LessonCard`.
Used by: ModeCard, TopicCard, DeckCard, Banner, InsightCard/History, LessonCard (card tap = CTA). A card with one destination is entirely the tap target; if a card ever gains a second action, its interaction regions must be declared separately in COMPONENTS.md first (DD-23).

## P2. Hero header
Eyebrow (microLabel) + two-line display heading. Line 1 `textPrimary`, line 2 `accessible.heroSecondLine`; the final full stop uses the mode accent (`feature.<mode>.accent`). One hero per picker / lesson-list screen, directly below the header.

## P3. Index numeral
Large faded numerals ("01", "02") occupy a card's corner as a typographic ornament; colour `textFaint` on light cards, or the card's text colour at 24% opacity on saturated fills. They are decoration (`aria-hidden`) unless they identify order.

## P4. Eyebrow + title + description
Cards and sections stack `microLabel` eyebrow → title → description (`body`, `textSecondary`). Gaps `space.xs` / `space.sm`.

## P5. Pill family
Every pill shares `radius.full`: chips (30), streak (24), level badge (19), CTAs (30–42), composer. Pills never mix with `radius.control` squares in one row.

## P6. Floating surface
Sheets, dialogs, popovers and the bottom bar all: inset from edges, all corners rounded, width-capped, `shadow.floating` (or glass), and positioned by the rules in RESPONSIVE_RULES. See **Overlays** table in INTERACTION_PATTERNS §6.

## P7. Verdict header
`[icon] [coloured title] ........ [score?] [close]`. Icon + word + colour (never colour alone). Used by every `FeedbackSheet` variant.

## P8. Sectioned feedback body
`microLabel` section title → content block. Order: (diff) → explanation → bullets. Bullet dot colour encodes the *type* of point (improvement, tip, mistake), not severity.

## P9. Mode kit
Each mode contributes: hero full-stop colour · lesson CTA fill · answer-card colour · progress colour. Nothing else changes. See FOUNDATIONS §10.

## P10. Segmented progress
N equal segments, `space.xs` gap. Done = mode progress colour, current = tint, idle = `border`. Always paired with an accessible "step N of M".

## P11. Bilingual text pair
Target-language line (`body`, `textPrimary`) with a smaller italic translation beneath (`caption`, `textMuted`). Translations are globally toggleable; the pair collapses to one line when hidden.

## P12. Rail
Horizontal scroller of equal-height items (chips, cards, tiles): start inset `marginScreen`, gap `space.sm` (chips) or `space.md` (cards), no visible scrollbar, end padding equals the start inset. Cards use scroll-snap with a peek of the next item.

## P13. Two-column grid
`layout.gridColumns` = 2, gap `layout.gridGap`, card height `layout.topicCardHeight`. Collapses to one column on compact.

## P14. Counter trio / stat cell
Icon + number (`title`) + unit + caption. Used in deck header (3 counters), insight (3×2 grid), streak (current / longest). Numbers are right-sized, never smaller than `heading`.

## P15. Bottom-anchored action area
Primary actions live at the bottom of the screen or sheet: submit circle bottom-right, composer bottom, sheet action row bottom, full-width CTA bottom (settings detail). Keep out of the safe area and above the keyboard.

## P16. Destructive action styling
Destructive label in `error` text on `errorTint` pill; always on the right in a two-button row; never the default focus.

## P17. Selected state vocabulary
| Context | Selected look |
|---|---|
| Filter chip | 2 ru `accessible.warningText` outline |
| Quick chip | `primaryTint` fill |
| Radio row | `accessible.selectedIndicator` radio with check + (level rows) coloured left bar |
| Plan card | `primaryTint` fill + `primary` border |
| Style tile | dark outline |
| Segmented control | `surface` thumb on `surfaceMuted` track |
Never invent a new selected look; pick from this table.

## P18. User-configurable colour
Colours the user can change (the answer card) are chosen from `answerPalette`, where every entry is a background/foreground **pair** (DD-26). Store the entry key; read both tokens of that key; never pick or compute a foreground yourself and never render a hard-coded constant.

## P19. Content-driven dynamics
Topic order, lesson order, hint count, step count, bubbles — all data-driven. Components accept counts/lists as props; do not bake the counts observed in the research (10, 20, 8, 5 chips…).

## P20. Opaque fallback for glass
Where blur is unavailable or reduced-transparency is set: replace `glass.*` with `surface` at ≥ 92% opacity and a `border` hairline.

## P21. Insight zero state
Numbers default to 0, charts to empty cells (`border`), no extra illustration. Do not hide the screen when there is no data.

## P22. Scrim as per-surface property
Each overlay documents its own scrim (default / none). Do not centralise.
