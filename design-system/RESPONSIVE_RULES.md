# Responsive Rules

The research observed **one canonical viewport: 788×1083 ru** (a portrait, desktop-window-like frame). Everything below converts measurements into **rules**. Do not copy coordinates.

Evidence status
- Canonical 788×1083: rules marked VERIFIED/SUPPORTED.
- 554×772 captures (≈ 0.70× scale; Home, language/appearance/lesson-settings, explainer): **adaptive evidence only**. Used here solely to confirm that layouts reflow rather than scale. No raw value from them appears below.
- No phone, tablet, landscape or wide viewport was ever observed. All breakpoints are ESTIMATED defaults (DD-12).

---

## 1. Definitions

| Term | Rule |
|---|---|
| `viewport` | Width of the app window/screen in ru (CSS px / pt) |
| `contentWidth` | `viewport − 2 × margin`, then capped at `layout.contentMaxWidth` |
| `margin` | `layout.marginDashboard` (12) on the dashboard; `layout.marginScreen` (18) otherwise |
| Breakpoints (ESTIMATED) | **compact** < `layout.breakpointCompact` (560) · **regular** 560–`layout.breakpointWide` (1024) · **wide** > 1024 |
| `effective viewport` | `viewport` for full-screen apps; the container width when the app is embedded |
| Reference | 788 falls in *regular*. All reference numbers apply to regular. |

## 2. Horizontal margins
- Dashboard / carousel screens: 12. Pushed screens: 18. Never use both on one screen.
- Floating surfaces keep at least `margin` from every viewport edge.
- Lists and rows span the full `contentWidth`; do not add extra inner margins.

## 3. Content width
- **Home exception (DD-27)**: dashboard content spans `viewport − 2×layout.marginDashboard` at every window width. Other screens use `contentWidth = min(viewport − 2×margin, layout.contentMaxWidth)`; `contentMaxWidth` = 764 (reference content width; ESTIMATED as a cap).
- In *wide* viewports, centre reading/detail screens at `contentMaxWidth`. Home fills the window; its mode-card height follows `layout.homeModeCardAspectRatio` with a content minimum.
- Chat bubbles: `max-width = layout.chatBubbleMaxWidthRatio × contentWidth`.

## 4. Grid behaviour
| Context | compact | regular | wide |
|---|---|---|---|
| Topic grid | 1 column | **2 columns** (VERIFIED) | 2 columns, centred at `contentMaxWidth` |
| Card height | content-driven, min `layout.topicCardHeight` | `layout.topicCardHeight` (123) | same |
| Card width | `contentWidth` | `(contentWidth − gridGap) / 2` | same |
| Stat grid | 3 columns (shrink labels) | 3 columns | 3 columns |
| Calendar | 7 columns, always | 7 | 7 |
Column gap and row gap are equal (`layout.gridGap`).

## 5. Card width behaviour
- **Carousels** (mode cards, lesson cards): card width is a **ratio of viewport**, not a constant, so the next card always peeks: ModeCard `layout.modeCardWidthRatio` (≈ 0.85); LessonCard `layout.lessonCardWidthRatio` (0.83). On compact use `layout.modeCardWidthRatioCompact` (0.9) for both. Snap to start; gap `layout.carouselGap`.
- **Full-width banners/rows**: `contentWidth`.
- **Fixed-size controls** (dialog actions, grade buttons, icon buttons): keep their `control.*` size; they never stretch except full-width CTAs.
- **SRS card**: width `layout.srsCardWidthRatio` × viewport, capped at `contentMaxWidth`; on compact, `contentWidth`; height from `layout.srsCardAspect`.
- **Hero numerals and illustration** scale with the card; text does not.

## 6. Stack behaviour
- Vertical flow is the default. Horizontal groups (chips, banners, tiles) become rails (horizontal scroll), never wrap into new rows, except the **topic quick-chips**, which may wrap if the hosting platform has no horizontal scroll.
- Two-button action rows (`EditNext`, `FixNext`, `Dialog/Confirm`) stay side by side down to `layout.stackActionsBelow` (280 ru) of container width; below that, stack vertically with the primary on top.
- Bottom bars (composer, hint bar, submit) stay bottom-anchored in a vertical stack: stepper → source → answer → hints → bar.
- Answer card takes `flex: 1` between source and hint bar.

## 7. Sheet width
- `sheetWidth = min(layout.sheetWidth (446), viewport − 2×margin)`; horizontally centred.
- Reference ratio: 446 / 788 ≈ 0.57. In *wide*, stay 446 (do not scale).
- Height: content-driven, `max-height = layout.sheetMaxHeightRatio × viewportHeight` with internal scroll; anchored near the bottom with `margin` offset (floating, not docked).
- Compact: full `viewport − 2×margin`; max-height `layout.sheetMaxHeightRatioCompact` × viewportHeight.

## 8. Modal width
- `Dialog`: width `layout.dialogWidth` (260) centred; compact `min(260, viewport − 2×margin)`.
- Menu overlay: centred column, max width `layout.sheetWidth`.
- Full-window overlays (menu, tutorial, composer sheet) fill the viewport.

## 9. Floating controls
- `FloatingBottomBar`: horizontally centred, inset `margin` from sides and from the bottom safe area; max width `contentWidth`. Content scrolls under it; reserve bottom padding equal to its height + `space.lg`.
- `FAB`: bottom-trailing, inset `margin`; expanded pills stack upward.
- `SubmitButton` and `ChatComposer`: bottom-anchored above the safe area and the on-screen keyboard.

## 10. Safe-area behaviour
No safe-area evidence exists (desktop captures). Rules (ESTIMATED defaults):
- Respect top/bottom/leading/trailing safe areas; add them to `margin`.
- Headers sit below the top inset; bars sit above the bottom inset.
- Full-bleed backgrounds (game gradients, glass overlay) extend under insets; content does not.
- Keyboard: composer and answer input scroll into view; sheets move up with the keyboard.

## 11. Compact viewport behaviour (ESTIMATED; derived from the 0.70× reflow observation)
- Reflow, do not scale: margins and control sizes stay constant; the grid goes to one column, carousel cards use a larger ratio (≈ 0.9) and fonts remain ≥ the `typography.body` floor.
- Hero `display` steps down to `typography.displayCompact`; no other type scales.
- Header title truncates; stepper segments shrink (min `layout.stepperSegmentMinWidth`) before the segment count changes.
- Hint chips scroll; sheet actions stack when < 280 ru.
- Bottom bar drops its pill captions (icons only) when `contentWidth < layout.hideBarCaptionsBelow`.
- `SourceTextCard/Paragraph` collapses to 3 lines + "Show all" (COMPONENTS: SourceTextCard).

## 12. Orientation and height
- Portrait is the reference. Landscape/short-height behaviour: not observed. Default: keep portrait layout, allow vertical scroll, cap sheet height to `layout.sheetMaxHeightRatioShort` × viewportHeight (DD-12).
- Content must scroll; nothing is clipped at 1083 ru height or less.

## 13. Do-not-copy list (raw numbers that are NOT rules)
Window width 788/908, 554/772 alternate sizes, absolute coordinates of any element, individual widths like 613, 650, 670, 746, 751, 761, 763, 764, 725 — all are derived from `viewport`, `margin`, or ratios above. Heights tied to content (e.g. 289, 334, 385) are content-driven; only `topicCardHeight`, `navBarHeight`, row pitches and control sizes are tokens.

## 14. Template responsive matrix (summary)

| Template | compact (< 560) | regular (560–1024) | wide (> 1024) |
|---|---|---|---|
| Home | carousel 0.9; chips scroll; bar icons only < 360 | carousel 0.85; bar with captions | centred column `contentMaxWidth` |
| TopicPicker | 1 column | 2 columns | 2 columns centred |
| LessonList | card 0.9, snap | card 0.83, snap | centred, card width capped to `contentMaxWidth` × 0.83 |
| Exercise | source collapsible; sheet full-width | source expanded; sheet 446 | same as regular, column centred |
| Conversation / Scenario | bubbles 0.94 of content; composer above keyboard | same | column centred |
| FlashcardDeck / Insight / Settings | single column, rows full width | same | column centred |
| SRSReview | card = contentWidth | card 0.58 × viewport | card capped |
| Completion | card = viewport − 2×margin | `layout.sheetWidth` | `layout.sheetWidth` |
| FlowLetterGame | gradient full-bleed; tiles `layout.letterTileSize`; glass buttons full content width | same | content centred |

## 12. Home destination overview widths (DD-29)

Profile and Review, including their headers and scrolling content, fill the
available safe-area width with `layout.marginDashboard` gutters, like Home.
They do not use the `layout.contentMaxWidth` reading-column cap. This applies
at compact and wide sizes and on window resize. Reading/detail pages retain
the default capped `ContentConstraints` layout.

## 13. Home discovery (DD-31)

Recommendations retain two source-order groups of five. Each group wraps to
additional rows as needed; compact controls retain 44px hit targets. The
explainer rail uses `layout.homeGuideWidth` / `layout.homeGuideHeight` multiplied
by text scale, so labels remain readable without truncation. Flashcard and
Flow Letter banners fill content width and grow vertically. Decorative flashcard
preview type is fixed and excluded from semantics. The 101 rail is followed
only by reserved dock clearance; avoid adding a second large blank footer gap.

On narrow windows with enlarged text, hide the decorative trailing Flashcard
preview to reserve the full width for its title and CTA. Decorative HELLO
letters keep their artwork text size; real title/caption/status copy scales.
