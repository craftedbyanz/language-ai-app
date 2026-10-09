# GramaGo Design System (observed)

Reconciled 2026-10-09 from 53 evidenced states. Supersedes `specs/design-tokens.md` (kept for history).
Second session added **pixel-sampled hex colours** and **fitted corner radii** (1x screenshots, no external tools; see the Method note). Font sizes and shadows are still ESTIMATED; font family is unknown.
Machine-readable subset: [design-tokens.json](design-tokens.json). Tags: OBSERVED / MEASURED / ESTIMATED / INFERRED.

## Evidence rules (added 2026-10-09)

1. **Inactive-window captures (32 of 63) support structure/layout only.** They must not define canonical fills, enabled/disabled states or opacity. Proven wrong this way: Home ModeCard (grey vs blue), Menu backdrop, grey submit/Next, deck header.
2. **Canonical viewport = 788×1083.** 554×772 (S047–S050, one Home capture) is ≈ 0.704× content scale; its numbers are not tokens. 908×1083 (S051) is a canvas, window geometry = 788.
3. **Colour encoding.** PNGs are of three kinds: untagged sRGB (S001–S018 originals), embedded "Display" profile (S019–S046), embedded Display P3 (13:36+ re-captures; S007/S051 untagged but P3-valued, INFERRED). Raw hex from a P3/Display file is **not** sRGB; the same UI colour reads `#3B82F6` (untagged), `#4E80EE` (P3). Where the table below differs between rows, check the encoding column in design-tokens.json.

## Spacing scale (MEASURED; frequency in parentheses)

| Token | pt | Where seen |
|---|---|---|
| space.2 | 3–4 | section title→subtitle (S001 ×2) |
| space.3 | 6–8 | hero label→title 6; chip gaps 8 (S001 ×8, S002 ×8); chip row gap 8; greeting lines 3; editor prompt gap 8 |
| space.4 | 9–13 | grid gaps 9 (S002/S008 cols+rows); SRS interval gap ≈16*; rail item gap 12–13 (S001/S003); page margins 12 (Home) |
| space.5 | 16–19 (DROPPED as a token: 12.5 range was fabricated) | subtitle→content 13–19; lesson rail margins 18/19 (S002/S003) |
| space.6 | 24–34 (no single value; DROPPED as a token) | section gaps 19–39 (no single value); prompt→banner 34 |
| space.row | 54 | menu rows (S011); 61–63 settings rows (S016); 87 word rows (S013) — three row rhythms by context |

*The interval buttons sit at 1634/1699/1763/1828 → gaps 16, 13-14, 16-14: ≈14–16. MEASURED (rough).
Conclusion: the scale is consistent with a 4-pt base grid (4/8/12/16/…) plus context-specific row rhythms. INFERRED.

## Typography (frame heights MEASURED; sizes ESTIMATED at ~1.2 line height)

| Level | Frame h | Est. size | Evidence | Style |
|---|---|---|---|---|
| display-xl | 39 | ≈32 | S002/S008 hero (4 lines) | Extra-bold, tight leading, two-tone colours |
| display | 26–29 | ≈22 | Home greeting (26), topic/lesson titles (29), streak count (70 = multi-line) | Bold |
| title | 17–19 | ≈15 | nav headings (17), section titles (19), feedback verdict (20) | Semibold/bold |
| body | 13 | ≈11 | subtitles, descriptions (30+ instances) | Regular, grey |
| body-strong | 16 | ≈13 | links/CTA text, menu labels (18) | Medium/bold |
| caption | 9–11 | ≈8 | micro-labels, stat captions, day numbers (9–11) | Regular, grey |
| micro | 7–9 | ≈6–7 | ALL-CAPS eyebrows ("CHẾ ĐỘ TẠO", "SỬA LỖI", "MỚI", "ON FIRE", IPA 7) | Caps + wide tracking |

- Typeface: rounded geometric sans (INFERRED, low confidence); not identified.
- Case system: Vietnamese sentence case for content; ALL CAPS for eyebrows/badges/English lesson titles ("EXPLORING THE DOOR TO HELL"). OBSERVED.
- IPA transcription rendered in caption size (7 pt frames). OBSERVED.

## Colour (MEASURED hex, second session)

Exact pixel values from flat fills in the 1x screenshots. **RAW values in the encoding of the source file** (see Evidence rule 3). Text colours are the **darkest glyph pixel**, so thin type reads lighter than its token. Many values equal Tailwind v3 palette entries (#F9FAFB gray-50, #F3F4F6 gray-100, #E5E7EB gray-200, #3B82F6 blue-500, #DBEAFE blue-100, #EF4444 red-500, #A855F7 purple-500, #FEF9C3 yellow-100); INFERRED, not proven. Machine-readable in [design-tokens.json](design-tokens.json).

| Role | Hex | Where |
|---|---|---|
| surface/page | **#F9FAFB** | most screens; **#FFFFFF** on S013, S016, S018, S029, S030, S033, S044; #F8F9FA on S015/S052 (C13 corrected) |
| surface/card | #FFFFFF | cards, bubbles, sheets |
| surface/muted | #F3F4F6 | feedback correction panel, score chip, preview panel |
| surface/topic-card | #EDEEEF | S002/S008/S020 grid cards |
| divider / inactive | #E5E7EB | idle progress segments, dot-matrix |
| text/primary | #0B0F21 (chat) / #000 (Home title) | |
| text/secondary · tertiary · caption · eyebrow | #505A6C · #676D7A · #737985 · #9AA0AB | |
| brand/home-blue | #3B82F6 sRGB (banner/deck bar/input default; read as #4E80EE in P3 files — one colour), #DBEAFE (selected chip) | S001, S013 |
| brand/paywall-blue | #4383FC | S045 |
| brand/hero-blue | #567DF3 | "giao tiếp" hero word, stat icons |
| brand/indigo | **#475DE8** | chat user bubble, send, lesson CTA, active pager dot |
| brand/navy | #131827 | paywall CTA (banner left edge #0E1635) |
| brand/cyan | #4CD0EC | language-select CTA |
| accent/orange | #F37A29 (outline), #F27A2C (flame), #F09343 (soft) | selected chip, streak, cloud |
| accent/lime | #CDFD1A | active Home carousel dot |
| accent/gold · pink | #E3B217 · #E7519A | trophy; heart |
| semantic/success | **#2CB782** | CEFR confirm, toggles, selected radio, check, stat icon; tint #DCEEEA |
| semantic/error | #EF4444 (verdict); chat score dot raw #E8504B = sRGB #EF4444 (same) | |
| SRS grades (S052 active, sRGB) | ↩ #EE3437 · 6m #F59800 · 1d #307CF5 · 4d #7BC800 | |
| submit | disabled ring #898990 (active) · enabled #000318 dark filled | inactive windows show #D3D3D4 for both |
| home mode card 01 (active) | raw #3A81F5 (P3) = sRGB #0883FD; ~~#D4D4D5~~ = inactive artefact | |
| highlight | #FEF9C3 | source-sentence highlight in writing editor |
| editor card (writing / grammar) | #A855F7 (sRGB; read #9D59EF in P3 captures — **same colour**, N1 resolved) / #007AFF (inactive S010 only: CANDIDATE) | user-configurable |
| CEFR scale | A1 #2BC25C · A2 #7FCA25 · B1 #E3B425 · B2 #F27626 · C1 #E74B46 · C2 #D4322A | S044 left bars |
| answer-box choices (S048) | default #4E80EE, orange #F09343, yellow #F7CE46, green #65C466, blue #3B86F7, pink #EB445A, purple #BB3ED9, indigo #6466E9 | user-selectable |

- **Blues collapse after encoding normalisation**: #3B82F6 = #4E80EE(P3) = #567DF3(Display) → one brand blue; #475DE8(Display) = #2563EB; #4383FC(Display) = #0088FF. Two to three blues, not five (INFERRED from ICC conversion). A clone should pick one and map the rest. MEASURED / INFERRED.
- **Per-screen accent**: language select = cyan, level select/toggles = green, chat = indigo, paywall = blue + navy, Flow Letter = its own gradient world. OBSERVED.
- The writing/grammar editor card colours are **user-configurable** (Settings → Lesson Settings → "Màu ô nhập"), so #A855F7 and #007AFF are probably mode defaults, not fixed tokens. INFERRED.
- Flow Letter uses full-bleed gradients (pink lobby, green Nature round, purple difficulty/help, blue settings); only 5 point samples per screen exist, see tokens. MEASURED points.
- Dark mode is still **not observed**; the "Giao diện" row is a *card-style picker* (Regular / Mono / Minimal / Glass) plus Home card reordering, not a theme switch. OBSERVED.

## Colour roles (earlier qualitative table, kept)

| Role | Observed on |
|---|---|
| surface/page | near-white grey |
| surface/card | white or light grey; light borders |
| text/primary | near-black |
| text/secondary | mid-grey |
| text/muted | light grey (faded index numerals, two-tone hero second line) |
| accent/blue | name highlight, selected chip tint, Plus banner, flashcard banner gradient |
| accent/orange | selected-category outline, streak value (NOT the grammar theme — grammar accent is **lime**, C02) |
| accent/lime | active carousel dot |
| semantic/red | wrong words in feedback, "Chưa đúng" verdict |
| semantic/green | reference translation words, active page dot (alt) |
| dark navy | writing lesson CTA (#131A29), paywall CTA, flashcard banner (NOT lesson cards, NOT the menu) |
| Lesson cards | flat white (C01); per-mode CTA: navy (writing) / lime (grammar) / indigo (conversation) |
| Dark mode | Not observed; "Giao diện" settings row suggests a theme option. INFERRED |

## Shape (corner radii: circle fit to corner pixels of flat fills, rms 0.4–1.6 px, ±1.5 pt)

| Token | Value | Evidence | Tag |
|---|---|---|---|
| radius.card-lg | **≈ 23–24** | lesson card 613×314 (23.0/23.5), writing answer card (24), topic card 371×122 (24/22) | MEASURED-FIT |
| radius.banner / list-card | **≈ 17** | Plus banner 759×74 (17/17), language card 62 tall (17) | MEASURED-FIT |
| radius.preview-card | **not tokenised** | S048 value 18.5 is from a 554×772 capture (~0.70×); normalised ≈ 26 ESTIMATED | alt viewport |
| radius.bubble | ≈ 14 | user chat bubble 122×30 | MEASURED-FIT |
| radius.pill | = height/2 | confirm buttons (22.5 vs 21), paywall CTA (19 vs 20), composer 16 | MEASURED-FIT |
| radius.circle | size/2 | icon buttons, send button | OBSERVED shape |
| radius.home-mode-card | **≈ 28** | S001 active 669×334, TL 28.4 / TR 28.5 / BL 28.1 / BR 28.1 (rms 0.34–0.40) | MEASURED-FIT |
| radius.alert | **≈ 24** | S007 rendered, TL 24.1 / TR 23.8 (rms 0.31) | MEASURED-FIT |
| radius.sheet | **≈ 19.5** | S032 TL 18.7 / TR 19.8; S030 TR 20.7; all four corners rounded | MEASURED-FIT (bottom corners unmeasured) |
| radius.srs-card | ≈ 25.5 | S052 BL 26.1 / BR 25.1 (rms 1.3) | MEASURED-FIT |
| radius.lesson/answer card | ≈ 24 | S003 active BL 24.1 / BR 25.0; S004/S005 BL 23.3 / BR 23.9 | MEASURED-FIT |

The earlier "card-lg 28–36, card-md 20–24, card-sm 12–16" estimates were **too high for the large cards** (real ≈ 23–24) and are superseded. Home mode-card radius is now measured from the active capture (≈ 28). Radii cluster: ≈ 17–18 (banner/list), ≈ 19–20 (sheets), ≈ 24 (cards/alert), ≈ 28 (Home mode card). Fit precision remains ±1.5 pt at 1x (an independent refit of S002 differed by ≈ 2.5 pt, C16); a `--retina` pass would tighten it.

## Elevation & borders

- **Cards: mostly flat** — topic cards, lesson card (hairline border); the SRS card and stacked cards show a soft shadow (candidate). They rely on fill contrast (#FFFFFF on #F9FAFB, #EDEEEF on #F9FAFB) and sometimes a hairline border.
- **Sheets/popovers do cast a shadow**: soft and large, downward-biased. From the S028 popover edge: bottom edge darkest ≈ #BBBCBD on #F9FAFB (≈ 25 % black) fading to the page colour over ≈ 48 pt; right edge #D7D8D8 → #F9FAFB over ≈ 38 pt. ESTIMATED (single sheet, 1x).
- Glass effects: Home floating bottom bar blur; feedback CTA translucent pill; dark sheet backdrops (PopoverDismissRegion). OBSERVED.
- **Scrim is per-surface (C06)**: alert dims the whole window ≈ 60% grey (page #F9FAFB → #CACACA); FAB menu / info sheet ≈ 21% black (→ #C4C5C6); SRS tutorial → #959595; **no dim** behind the S006 feedback card, S028 popover, S030 create sheet or S045 paywall. OBSERVED / MEASURED.

## Iconography

| Set | Usage | Sizes |
|---|---|---|
| Streamline Flex | decorative/chrome icons, named `*-–Streamline-Flex` | 14–16 (inline), 36 (buttons), 254 (hero graphic) |
| SF Symbols | functional glyphs (`flame.fill`, `xmark`, `chevron.right`, `trash.fill`, `speaker.wave.2.fill`, `magnifyingglass`, `calendar.badge.plus`, `book.fill`, `clock.arrow.circlepath`, `sparkles`, `bolt.fill`, `mountain.2.fill`, `leaf.fill`, `cart.fill`, `refrigerator.fill`, `fork.knife`) | 7–136 |

For the clone: pick one set (recommend SF Symbols on iOS / lucide-react-native elsewhere) and map consistently. INFERRED recommendation.

## Layout constants

| Constant | Value | Tag |
|---|---|---|
| Home margins | 12 / 12–13 | MEASURED |
| Pushed-screen margins | 18 / 19 | MEASURED |
| Content width | 763–764 (788 window) | MEASURED |
| Nav bar height | 41; title bar 32 | MEASURED |
| Modal editor entry field | 763×460 | MEASURED |
| Feedback sheet height | ≈ half window (content 458) | MEASURED |
| Dialog | 260×161, actions 112×30 | MEASURED |
| Two-column grid | 371×123 cards, 9 gaps | MEASURED |
| List rows | settings 61, menu 54, words 87 | MEASURED |

## Motion

- Sheet presentation animations exist (incomplete AX reads during S006 and S018 transitions). OBSERVED effect, timing not measured.
- Carousel active-card scale difference (385 vs 369 heights) implies an animated scale transition. INFERRED.
- No other motion captured (still captures only).

## Gaps

Font family/sizes/weights, border widths, dark-mode values, motion durations, Home mode cards 02/03, sheet bottom-corner radii and the Flow Letter gradient stops are not measured. Colours from the 21 inactive-only states remain CANDIDATE until recaptured active. A 2x capture (Peekaboo `--retina`) would make radii and hairlines exact. Hex values come from 1x captures only.

## Method note (second session)

No imaging library was available, so a small standard-library PNG decoder was written outside the repo (in `/tmp`) to read pixels; radii were fitted by comparing the per-row inset of a card's corner against a circle model. These scripts are not part of the repo, so the numbers can only be re-derived from the screenshots in `screenshots/`.

## Reconciliation log (2026-10-09, documentation only)

Evidence used: existing PNGs only (corner-pixel circle fits; flat-fill samples; ICC-profile conversion). No new captures. Changes: radii for Home mode card / alert / sheet / SRS card added; scrim per-surface; `modeCardObserved` quarantined; encoding rule added; `previewCard` un-tokenised; typography and shadow stay ESTIMATED/CANDIDATE. See [design-tokens.json](design-tokens.json) `_reconciliation`.

## Final-crawl additions (2026-10-09, qualitative only — no new pixel measurements)

Evidence: S055–S064 (all active-window captures). Colours below are **OBSERVED names, not hex**; no token values were added or changed.
- **Verdict colour roles** (FeedbackSheet header): success = green ✓ ("Xuất sắc", "Chính xác"); error = red ✕ ("Chưa đúng"); partial = blue 👍 ("Gần đúng"); conversation score = orange number ("Trôi chảy 88", chip dot orange for 84/86). Diff chips: added = green text on pale-green chip, removed = red strike-through (consistent with S006).
- **Bullet colours by section**: KEY IMPROVEMENTS = purple (writing), MẸO = lime (grammar), LỖI SAI = orange, NHỮNG ĐIỂM CẦN CẢI THIỆN = purple (chat).
- **Grammar editor card is blue** in the active capture S058 (resolves the S010 "#007AFF inactive only: CANDIDATE" as at least *blue*; exact hex not re-measured). Writing editor card stays purple.
- **Primary CTA in sheets** = full-width navy pill ("Câu tiếp theo →", "Next"); secondary = white/grey pill ("Edit", "Sửa", "Huỷ").
- **Scenario chat**: AI bubble is **grey-filled** (Free chat: white + hairline); learner task bubble = brand indigo/blue; role labels = grey caption; progress segments done = solid blue, current = light blue (writing uses green, grammar green — mode-tinted ProgressStepper, INFERRED from three captures).
- **Loading**: skeleton bars light grey on the white sheet; title greyed with spinner (S055).
- **Exit alert** S062 shares the S007 shape and scrim; destructive action "Thoát" = red text on pale-red pill.
