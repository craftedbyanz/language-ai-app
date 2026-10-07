# GramaGo Design Tokens (derived from Home screen)

Derived from [../screens/home.md](../screens/home.md) and [components.md](components.md), 2026-10-08.
Source: one read-only Peekaboo capture of one screen. **Only values with repeated evidence are listed as tokens.** Anything with a single data point, or only an estimate, is in the "Not tokens" section.

Token names are mine (INFERRED labels), not from the app's source. Values are in points.

Provenance tags: MEASURED (tool-reported bounds or arithmetic on them; AX is integer-rounded, so ±1), OBSERVED (seen or in AX text), ESTIMATED (by eye from screenshot), INFERRED (reasoning).

## Supported tokens

### Spacing

| Token | Value | Evidence (count) | Tag |
|---|---|---|---|
| `space.page-margin-left` | 12 | Every section, banner, chip row and card starts at local x 12 (more than 10 elements) | MEASURED |
| `space.page-margin-right` | 12–13 | Banners end at local x 775 (13 from the edge). The flag ends at 776 (12). 3 elements. | MEASURED |
| `space.chip-gap` | 8 | 8 horizontal gaps measured (4 per row), 7–9 pt, 6 of them exactly 8. Plus the 8 pt row gap. | MEASURED |
| `space.chip-row-gap` | 8 | 1 row pair. Consistent with `chip-gap`, so treated as the same token. | MEASURED |
| `space.item-gap-scroller` | 12–13 | Carousel: 12, 13. Tile strip: 12, 13, 12, 13, 12, 13. Alternating values suggest a fractional gap (≈12.5). | MEASURED / INFERRED |
| `space.section-title-to-subtitle` | 3–4 | 2 of 3 sections ("Chế độ học tập" 4, "Gramify đề xuất" 3). The third, "Gramify 101", is 6 (title y 47 + height 19 = 66, subtitle y 72). | MEASURED |

Note: `space.section-gap` is not listed. The gaps between sections are 19, 27 and 39 and no single value is supported (see "Not tokens").

### Sizes

| Token | Value | Evidence (count) | Tag |
|---|---|---|---|
| `size.content-width` | 763–764 | Plus banner 763, Flashcard banner 763, Gramify Plus collection group ends at 788 minus margins | MEASURED |
| `size.icon-button` | 36 × 36 | 2 bottom-bar buttons | MEASURED |
| `size.window-control` | 16 × 16 | 3 traffic lights | MEASURED |
| `size.chip-height` | 29 (30 on two chips) | 10 chips. The 30s are likely AX rounding. | MEASURED |
| `size.mode-card-width` | 670 (one at 669) | 3 cards | MEASURED |
| `size.mode-card-height-active` | 385 | 1 card (card 01). Single instance, so only weakly supported. | MEASURED |
| `size.mode-card-height-inactive` | 369 | 2 cards (02, 03) | MEASURED |
| `size.feature-tile` | 123 × 146 | 7 tiles (off-screen, from AX) | MEASURED |
| `size.letter-tile` | 27 × 27 | 5 tiles (off-screen, from AX) | MEASURED |

### Typography (frame heights only)

| Token | Value | Evidence (count) | Tag |
|---|---|---|---|
| `type.section-title.frame-height` | 19 | 3 of 3 section titles | MEASURED |
| `type.section-subtitle.frame-height` | 13 | 3 of 3 section subtitles, plus the "Bạn chưa biết…" line, 4 of 4 | MEASURED |
| `type.display.frame-height` | 26 | 2 lines (greeting and name) | MEASURED |
| Weight: titles bold, subtitles regular | Seen on greeting, section titles, banner titles | OBSERVED |
| Case: category pills, card footers and banner titles are in caps | "LUYỆN VIẾT", "KHÁM PHÁ", "VOCABULARY FLASHCARD" | OBSERVED |

Font sizes are not tokens here. Frame heights are not font sizes, and no font size was read from the app. An estimate from frame heights (about 22 / 16 / 11 pt at a 1.2 line height) is recorded in home.md as ESTIMATED only.

### Shape (qualitative, from repeated visual evidence)

| Token | Value | Evidence | Tag |
|---|---|---|---|
| `shape.pill` | Fully rounded (radius = half height) | 10 chips, streak pill, menu pill, CTA pill all look fully rounded | OBSERVED shape |
| `shape.circle` | Radius = half size | 2 icon buttons | OBSERVED shape |

The shapes are observed. The numeric radius for pills and circles follows from the measured height, so 14.5 for chips and 18 for icon buttons (INFERRED).

### Colour roles (qualitative only, no hex)

| Token | Description | Evidence | Tag |
|---|---|---|---|
| `color.accent-blue` | Saturated blue | User name, selected chip tint and text, Plus banner fill (3 uses) | OBSERVED |
| `color.text-primary` | Near-black | Headings, chip labels | OBSERVED |
| `color.text-secondary` | Mid-grey | Subtitles, descriptions (4+ uses) | OBSERVED |
| `color.surface-page` | Near-white / very light grey | Window background | OBSERVED |
| `color.on-fill` | White | Text on the Plus banner, the Flashcard banner and mode cards | OBSERVED |

These are roles, not values. No pixel colour was sampled, so no hex is recorded.

## Not tokens (insufficient or no evidence)

| Item | Why it is excluded |
|---|---|
| Any hex or RGB colour | No pixel sampling was done |
| Card, banner and flag radii (≈ 28–36, 20–24, 8) | ESTIMATED by eye only, with no tool measurement |
| Border widths, shadow offsets and blur | Not measured. Shadows are largely absent or faint. |
| Font family, font sizes, line heights, letter spacing | Not read from the app |
| Banner inner padding (≈ 12–16) | ESTIMATED, and inconsistent between the two samples |
| `space.section-gap` | Values 19, 27, 34, 39 vary. No single value is supported. |
| Streak pill, Menu pill and CTA pill heights | Pill heights differ (24 measured, ≈34 estimated, one unmeasured), so no shared value |
| Banner heights (77, 160) | Two different values, one per banner |
| Icon glyph sizes inside buttons and chips (≈ 14–20) | ESTIMATED |
| Mode-card tint colours | Only card 01 was seen, and it was washed out |
| Dark-mode values | Not observed. A "Sun" label only hints at a theme toggle. |
| Motion, duration and easing | Not observable from a still capture |

## Confidence summary
- **Strong (3+ instances, MEASURED):** left margin 12, chip gap 8, icon-button 36, window control 16, feature tile 123×146, mode-card width 670, section title/subtitle frame heights.
- **Medium (2 instances):** content width 763, inactive mode-card height 369, display text frame 26.
- **Weak (1 instance or an estimate):** everything in "Not tokens", plus `size.mode-card-height-active`.
- **Next measurements needed to close gaps:** pixel colours (needs a capture I can sample), exact corner radii, and the below-fold components rendered on screen. Those would each need a new read-only capture.
