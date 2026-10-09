# Home Screen

> **Reconciled 2026-10-09:** canonical Home is [S001 active](../screenshots/S001-home-active-verification.png). Mode-card fill `#D4D4D5` in the inactive captures is an artefact (active = blue, radius ≈ 28). Navigation destinations listed as INFERRED below have since been OBSERVED (Insight, Flow Letter, flashcards, streak, history, profile, paywall, language, AI composer, Gramify 101). AX: [home--default](../accessibility/home--default.json).

Source: read-only Peekaboo inspection of the running GramaGo app, 2026-10-08.
Snapshots: `ps1_295a5e0ba7a4e59c362f61b245392574` (inspect_ui), `ps1_354b88c10790f7f1884f4e0532767283` (see + OCR), `ps1_c4573f9be507ff2d63515c2e5750f1ee` (repository screenshot capture).
Screenshot: [S001-home-inactive-original.png](../screenshots/S001-home-inactive-original.png).
Nothing was clicked, typed or scrolled during documentation. **Every navigation destination below is INFERRED, except Home → Writing Topic Picker, which was later observed** (see [flows/home-to-writing.md](../flows/home-to-writing.md)).

## Provenance legend

| Tag | Meaning |
|---|---|
| OBSERVED | Read directly from the accessibility (AX) tree text or seen plainly in the screenshot. No estimation. |
| MEASURED | A number reported by the tool (AX bounds, window list), or simple arithmetic on those numbers. AX values are integers and may be off by ±1 from rounding. |
| ESTIMATED | Read by eye from the screenshot. Approximate, not tool-reported. |
| INFERRED | Reasoned from evidence, not seen or measured. May be wrong. |

Coordinates: **global** = screen points as reported by Peekaboo. **local** = global minus window origin (1362, −1174), so (0,0) is the window's top-left corner. Local values are MEASURED (arithmetic on AX bounds).

## Screen metadata

| Field | Value | Tag |
|---|---|---|
| App name | GramaGo (bundle `com.tranhuy.projectx`, PID 98192) | OBSERVED |
| Window title / AX identifier | "Gramify" / `SceneWindow` | OBSERVED |
| Window ID | 3957 | OBSERVED |
| Window bounds (global) | x=1362, y=−1174, 788 × 1083 | MEASURED |
| Why y is negative | The window sits on a display arranged above the primary one | INFERRED |
| Title bar | local y 0–32 (viewport starts at global y −1142) | MEASURED |
| Viewport bounds (global) | x=1362, y=−1142, 788 × 1051 (local 0,32 → 788,1083) | MEASURED |
| Scrollable content height | 1464 (group at global y −1126, local y 48) → about 380–430 pt lies below the fold | MEASURED |
| Scroll position | At top (greeting sits 22 pt under the viewport top) | INFERRED |
| Screen name | "Home" or dashboard. The app does not name it. | INFERRED |
| Language of UI copy | Vietnamese, with English study content (Resilient, Acquire) | OBSERVED |
| Other windows owned by process | 9 untitled windows (4 at 1800×39, 4 at 2560×30, 1 at 500×500). Not inspected. | OBSERVED |
| Greeting is time-based ("Chúc ngủ ngon" = good night) | | INFERRED |

## Layout hierarchy

Top to bottom. Local coordinates are given in brackets as (x, y, w×h).

```
Window "Gramify" (0,0, 788×1083)
├─ Title bar (0,0, 788×32): traffic lights + centered title "Gramify"
└─ Scroll content (0,48, 788×1464)
   ├─ 1. Header
   │    ├─ "Chúc ngủ ngon," (12,54, 160×26)
   │    ├─ "An" (12,83, 28×26), accent colour
   │    └─ Language flag button "US" (736,54, 40×27), right-aligned
   ├─ 2. AI prompt
   │    ├─ "Bạn chưa biết học gì hôm nay?" (12,125, 154×13)
   │    └─ "Tạo bài học với AI" + orb icon (12,146, 102×16)
   ├─ 3. Plus promo banner (collection 0,196, 788×77; button 12,196, 763×77)
   │    └─ 2 page dots below it (ESTIMATED from screenshot, absent from AX)
   ├─ 4. Section "Chế độ học tập" (title 12,300; subtitle 12,323)
   │    ├─ Horizontal carousel (0,343, 2060×412) of 3 ModeCards
   │    │    ├─ 01 LUYỆN VIẾT / Đoạn văn  (12,355, 670×385)  [active, fully in view]
   │    │    ├─ 02 NGỮ PHÁP / Sửa câu     (694,371, 670×369) [peeks 94 pt]
   │    │    └─ 03 GIAO TIẾP / Hội thoại  (1377,371, 669×369) [off-screen right]
   │    └─ Page dots (3, first lit), ESTIMATED from screenshot
   ├─ 5. Section "Gramify đề xuất" (title 12,779; subtitle 12,801)
   │    └─ Chip group (0,827, 522×67): row 1 × 5 chips, row 2 × 5 chips
   ├─ 6. Vocabulary Flashcard banner (12,913, 763×160)
   │    └─ title, description, "Mở Flashcard" CTA, 2 sample flashcards
   ├─ 7. [below fold] Flow Letter game card: title, "Thử ngay", letter tiles H-E-L-L-O
   ├─ 8. [below fold] Section "Gramify 101" (title 12,1221; subtitle 12,1246)
   │    └─ Horizontal strip (0,1272, 960×146) of 7 tiles (123×146 each)
   └─ (about 94 pt of empty scroll padding below the tile strip)

Floating overlay (does not scroll, drawn over content):
   Bottom bar
   ├─ Left icon button (18,1041, 36×36)
   ├─ Streak pill "Chuỗi: 0 ngày" (327,1008, 133×24)
   ├─ Menu pill (≈348,1042, ≈93×34, ESTIMATED) with star icon + "Menu" text
   └─ Right icon button (733,1041, 36×36)
```

"Floating overlay" is INFERRED. It is observed that the bar overlaps the Flashcard banner, so it is not part of the flow. Whether it is pinned or scrolls with content was not tested.

## Visible UI elements

x/y are **global**. Local equivalents are in the hierarchy above and in the helper columns. Interactive = reported actionable in AX (MEASURED/OBSERVED).

### Chrome and header

| Label / text | Role (AX) | x | y | w | h | Interactive |
|---|---|---|---|---|---|---|
| close button | AXButton | 1370 | −1166 | 16 | 16 | Yes |
| minimize button | AXButton | 1393 | −1166 | 16 | 16 | Yes |
| full screen button | AXButton | 1416 | −1166 | 16 | 16 | Yes |
| "Gramify" (title) | AXStaticText | 1444 | −1167 | 56 | 17 | No |
| "Chúc ngủ ngon," | AXStaticText | 1374 | −1120 | 160 | 26 | No |
| "An" | AXStaticText | 1374 | −1091 | 28 | 26 | No |
| "US" (flag) | AXButton | 2098 | −1120 | 40 | 27 | Yes |
| "Bạn chưa biết học gì hôm nay?" | AXStaticText | 1374 | −1049 | 154 | 13 | No |
| "Tạo bài học với AI" | AXStaticText | 1374 | −1028 | 102 | 16 | No (in AX) |

### Promo and study modes

| Label / text | Role (AX) | x | y | w | h | Interactive |
|---|---|---|---|---|---|---|
| "Đăng ký Gramify Plus, Mở khóa mức sử dụng cao hơn và làm chủ kỹ năng ngôn ngữ của bạn." | AXButton | 1374 | −978 | 763 | 77 | Yes |
| Banner collection (container) | AXGroup "collection" | 1362 | −978 | 788 | 77 | No |
| "Chế độ học tập" | AXStaticText | 1374 | −874 | 113 | 19 | No |
| "Nâng cao kỹ năng viết, ngữ pháp và giao tiếp cùng AI." | AXStaticText | 1374 | −851 | 269 | 13 | No |
| Card 01 "LUYỆN VIẾT, Đoạn văn, Rèn luyện dịch và viết các đoạn văn., KHÁM PHÁ" | AXButton | 1374 | −819 | 670 | 385 | Yes |
| Card 02 "NGỮ PHÁP, Sửa câu, Sửa lỗi nhanh với các câu ngắn., KHÁM PHÁ" | AXButton | 2056 | −803 | 670 | 369 | Yes (partly off-screen) |
| Card 03 "GIAO TIẾP, Hội thoại, Mô phỏng đa dạng các tình huống., KHÁM PHÁ" | AXButton | 2739 | −803 | 669 | 369 | Yes (off-screen) |
| Carousel container | AXGroup | 1362 | −831 | 2060 | 412 | No |

### Suggested topics

| Label / text | Role (AX) | x | y | w | h | Interactive |
|---|---|---|---|---|---|---|
| "Gramify đề xuất" | AXStaticText | 1374 | −395 | 120 | 19 | No |
| "Các chủ đề được chọn lọc để giúp bạn học nhanh hơn." | AXStaticText | 1374 | −373 | 274 | 13 | No |
| Chip "Làm tôi bất ngờ" | AXButton | 1374 | −346 | 120 | 29 | Yes |
| Chip "Du lịch" | AXButton | 1502 | −346 | 76 | 29 | Yes |
| Chip "Kinh doanh" | AXButton | 1586 | −346 | 100 | 29 | Yes |
| Chip "Ẩm thực" | AXButton | 1694 | −347 | 81 | 29 | Yes |
| Chip "Mua sắm" | AXButton | 1783 | −346 | 88 | 29 | Yes |
| Chip "Sức khỏe" | AXButton | 1374 | −309 | 89 | 29 | Yes |
| Chip "Xã hội" | AXButton | 1471 | −310 | 77 | 30 | Yes |
| Chip "IELTS" | AXButton | 1556 | −310 | 71 | 30 | Yes |
| Chip "Đời sống" | AXButton | 1636 | −309 | 87 | 29 | Yes |
| Chip "Giải trí" | AXButton | 1730 | −309 | 76 | 29 | Yes |
| Chip group (container) | AXGroup | 1362 | −347 | 522 | 67 | No |

### Flashcard banner and bottom bar

| Label / text | Role (AX) | x | y | w | h | Interactive |
|---|---|---|---|---|---|---|
| "VOCABULARY FLASHCARD, Lưu từ mới, ôn tập theo SRS và theo dõi tiến bộ mỗi ngày., Mở Flashcard, Resilient, Kiên cường, Acquire, Tiếp thu" | AXButton | 1374 | −261 | 763 | 160 | Yes |
| "Chuỗi:, 0 ngày" | AXButton | 1689 | −166 | 133 | 24 | Yes |
| "Rotate-Left--Streamline-Flex" | AXButton | 1380 | −133 | 36 | 36 | Yes |
| Star icon "Star-Circle--Streamline-Flex" | AXImage | 1728 | −123 | 16 | 16 | Reported actionable, no parent button |
| "Menu" | AXStaticText | 1751 | −122 | 33 | 16 | No (in AX) |
| "Sun--Streamline-Flex" (screenshot shows a gear glyph) | AXButton | 2095 | −133 | 36 | 36 | Yes |

### Below the fold (AX only, never seen rendered)

| Label / text | Role (AX) | x | y | w | h | Interactive |
|---|---|---|---|---|---|---|
| "Flow Letter" | AXStaticText | 1386 | −54 | 68 | 16 | No |
| "Xếp chữ cái thành từ vựng" | AXStaticText | 1386 | −36 | 102 | 10 | No |
| "Thử ngay" | AXStaticText | 2085 | −45 | 33 | 9 | No |
| Letters "H" "E" "L" "L" "O" | AXStaticText | 1674 / 1708 / 1742 / 1776 / 1810 | −11 | 27 | 27 | No |
| "Gramify 101" | AXStaticText | 1374 | 47 | 87 | 19 | No |
| "Tất cả những gì bạn cần biết về Gramify và cách ứng dụng giúp bạn học tập hiệu quả." | AXStaticText | 1374 | 72 | 425 | 13 | No |
| Tile "3 Chế Độ Luyện Tập Chính" | AXButton | 1374 | 98 | 123 | 146 | Yes |
| Tile "Trợ Lý AI & Hệ Thống Phản Hồi" | AXButton | 1509 | 98 | 123 | 146 | Yes |
| Tile "AI Magic Generator" | AXButton | 1645 | 98 | 123 | 146 | Yes |
| Tile "Hệ thống Flashcard & SRS" | AXButton | 1780 | 98 | 123 | 146 | Yes |
| Tile "Hệ Thống Theo Dõi Tiến Độ" | AXButton | 1916 | 98 | 123 | 146 | Yes |
| Tile "Chức Năng Ôn Tập Thông Minh" | AXButton | 2051 | 98 | 123 | 146 | Yes |
| Tile "C, A, T, S, Mini Game: Flow Letter" | AXButton | 2187 | 98 | 123 | 146 | Yes |

## Sections

### Greeting / header
- Content (OBSERVED): "Chúc ngủ ngon," on line 1, the user's name "An" on line 2 in an accent colour (blue), a flag button at the top-right, then the prompt "Bạn chưa biết học gì hôm nay?" and the link-like "Tạo bài học với AI" with a small gradient orb.
- The flag is a light rounded-square button showing a US flag (OBSERVED). It is probably a language or locale switcher (INFERRED).
- "Tạo bài học với AI" is not actionable in AX (OBSERVED), but it looks like a CTA. Its tappable area may be an unexposed parent (INFERRED).
- Directly below the header is the Plus promo banner. It is a full-width blue button (OBSERVED), sitting in a collection with two small dots beneath it (ESTIMATED). It is probably a banner pager (INFERRED).

### Study-mode carousel ("Chế độ học tập")
- 3 cards, numbered 01, 02, 03 (OBSERVED). Each has a category pill, a large title, a faded index numeral, a description and a "KHÁM PHÁ ↗" footer (OBSERVED for card 01; 02 and 03 partly from AX text).
- Card 01 is 670×385. Cards 02 and 03 are 670/669×369 (MEASURED). They are 16 pt shorter and bottom-aligned with card 01 (both end at global y −434, MEASURED). The active card is probably scaled up (INFERRED).
- Gaps between cards are 12 and 13 (MEASURED). Card 02 peeks 94 pt in from the right edge (MEASURED).
- Card 01 renders with a washed-out grey fill and low-contrast text (OBSERVED). Likely a transition or inactive state, or a gradient not yet applied (INFERRED, cause unknown).
- Three page dots sit below the cards with the first one lit in lime green (ESTIMATED from screenshot).

### Suggested topics ("Gramify đề xuất")
- Ten chips in two wrapped rows of five (OBSERVED). Order: Làm tôi bất ngờ, Du lịch, Kinh doanh, Ẩm thực, Mua sắm / Sức khỏe, Xã hội, IELTS, Đời sống, Giải trí.
- Each chip has a leading icon and a text label (OBSERVED).
- The first chip ("Làm tôi bất ngờ") has a light-blue tint with blue text and a sparkle icon. The other nine are white with dark text (OBSERVED visually). The first chip is probably the selected or default state (INFERRED).
- Chips are tightly packed and left-aligned. Row 1 ends at global x 1871, so about 266 pt of the row is empty before the right margin (MEASURED).

### Flashcard banner
- Dark navy-to-blue gradient banner, 763×160 (OBSERVED / MEASURED).
- Content (OBSERVED): "VOCABULARY FLASHCARD" in bold caps, "Lưu từ mới, ôn tập theo SRS và theo dõi tiến bộ mỗi ngày.", a translucent "Mở Flashcard →" pill, and two stacked white sample cards at the right ("Resilient / Kiên cường", "Acquire / Tiếp thu").
- The bottom of the banner is covered by the floating bottom bar and its blur (OBSERVED).
- The two sample cards are probably decorative previews (INFERRED).

### Bottom navigation
- Floating overlay with four items (OBSERVED): a left circular icon button, a centred streak pill "Chuỗi: 0 ngày" (with a flame icon in the screenshot), a centred "Menu" pill with a star icon, and a right circular icon button.
- A blue-white gradient blur covers the bottom edge of the window behind the bar (OBSERVED visually).
- The streak pill is horizontally centred: its centre is local x 393.5 against the window centre of 394 (MEASURED).
- "Menu" has no AX button of its own, only an image and text (OBSERVED), so its pill bounds are ESTIMATED from the screenshot: x≈348–441, y≈1042–1076 local.
- This is not a tab bar. It has no per-destination tabs (INFERRED). "Menu" probably opens navigation (INFERRED).
- The right button's AX label is "Sun--Streamline-Flex" but the screenshot shows a gear icon (OBSERVED mismatch). Its function is unknown.

## UX actions

Action = AXPress is available (OBSERVED where AX says actionable). No destination was exercised, so every destination is **INFERRED** from label text and common patterns.

| Element | Action | Expected destination / state | Destination tag |
|---|---|---|---|
| Window close / minimize / full screen | Press | Standard macOS window behaviour | INFERRED |
| Flag "US" | Press | Language or locale picker | INFERRED |
| "Tạo bài học với AI" (not actionable in AX) | Press (if parent is tappable) | AI lesson generator, maybe the "AI Magic Generator" feature | INFERRED |
| Plus banner "Đăng ký Gramify Plus" | Press | Subscription / paywall screen | INFERRED |
| Card 01 "Đoạn văn" | Press | Paragraph writing practice (translate and write paragraphs) | INFERRED |
| Card 02 "Sửa câu" | Press | Sentence-correction practice | INFERRED |
| Card 03 "Hội thoại" | Press | Conversation / role-play practice | INFERRED |
| Carousel (swipe/scroll) | Horizontal scroll | Reveals cards 02, 03 and updates the page dots | INFERRED |
| Chip "Làm tôi bất ngờ" | Press | Random ("surprise me") topic, or select topic filter | INFERRED |
| Chips Du lịch, Kinh doanh, Ẩm thực, Mua sắm, Sức khỏe, Xã hội, IELTS, Đời sống, Giải trí | Press | Pick topic: starts a lesson or sets a filter. Which one is unknown. | INFERRED |
| Flashcard banner / "Mở Flashcard" | Press | Flashcard / SRS review screen | INFERRED |
| Streak pill "Chuỗi: 0 ngày" | Press | Streak / progress detail | INFERRED |
| Left icon button (Rotate-Left) | Press | History or reset | INFERRED |
| Menu pill | Press | App navigation menu | INFERRED |
| Right icon button (Sun label, gear glyph) | Press | Settings (from glyph) or theme toggle (from AX label) | INFERRED |
| Tiles in Gramify 101 (7) | Press | Feature explanations or tutorial | INFERRED |
| Flow Letter "Thử ngay" | Press | Flow Letter mini-game | INFERRED |

## Visual design

All values below are from the screenshot (rendered at 788×1083, assumed 1 image pixel = 1 point) and AX bounds. No pixel colours were sampled, so **no hex values exist**.

### Horizontal margins

| Value | Tag |
|---|---|
| Left content margin = 12 pt (every section starts at local x 12: 10+ elements) | MEASURED |
| Right content margin = 12–13 pt (banners end at local x 775; flag ends at 776; window width 788) | MEASURED |
| Content width = 763–764 pt (banner button width) | MEASURED |
| Inner padding inside banners ≈ 12–16 pt (Flow Letter title at +12 from its card edge, flashcard text ≈ +15) | ESTIMATED |
| Bottom-bar button margins: left 18 pt, right 19 pt (to the 36×36 buttons) | MEASURED |
| The 12 pt margin repeats across header, banners, section titles, carousel, chips and tiles | OBSERVED |

### Vertical rhythm (gaps between consecutive elements)

| Gap | Value (pt) | Tag |
|---|---|---|
| Viewport top → greeting top | 22 | MEASURED |
| "Chúc ngủ ngon," bottom → "An" top | 3 | MEASURED |
| "An" bottom → prompt text top | 16 | MEASURED |
| Prompt text bottom → "Tạo bài học với AI" top | 8 | MEASURED |
| "Tạo bài học với AI" bottom → Plus banner top | 34 | MEASURED |
| Plus banner bottom → section title top | 27 | MEASURED |
| Section title bottom → subtitle top | 4 ("Chế độ học tập"), 3 ("Gramify đề xuất"), 6 ("Gramify 101") | MEASURED |
| Subtitle bottom → content top (carousel) | 19 | MEASURED |
| Subtitle bottom → content top (chips) | 14 | MEASURED |
| Carousel bottom → next section title top | 39 (includes page dots) | MEASURED |
| Chip row 1 → chip row 2 | 8 | MEASURED |
| Chip row 2 bottom → flashcard banner top | 19 | MEASURED |
| Gramify 101 subtitle bottom → tile top | 13 | MEASURED |
| Sections are separated by roughly 27–39 pt; no divider lines are visible | | OBSERVED / MEASURED |

### Spacing between sibling items

| Value | Tag |
|---|---|
| Chip gap = 8 pt (8 horizontal gaps, 4 per row: all 7–9, six of them exactly 8) | MEASURED |
| Carousel card gap = 12–13 pt | MEASURED |
| Tile gap = 12–13 pt (alternating 12, 13 across 6 pairs, so the true value is probably fractional) | MEASURED / INFERRED |

### Typography hierarchy

Text-frame heights are MEASURED from AX. They are frame heights, not font sizes. Font sizes in the last column are ESTIMATED by assuming a line height of about 1.2× the font size.

| Level | Example | Frame height (MEASURED) | Weight (OBSERVED visually) | Font size (ESTIMATED) |
|---|---|---|---|---|
| Display | "Chúc ngủ ngon," / "An" | 26 | Bold, large | ≈ 22 |
| Section title | "Chế độ học tập", "Gramify đề xuất", "Gramify 101" | 19 (3 of 3) | Bold | ≈ 16 |
| Link / CTA text | "Tạo bài học với AI" | 16 | Bold-ish | ≈ 13 |
| Body / subtitle | "Bạn chưa biết học gì hôm nay?", section subtitles | 13 (4 of 4) | Regular, grey | ≈ 11 |
| Micro-label | "LUYỆN VIẾT", "KHÁM PHÁ", "VOCABULARY FLASHCARD" | not measured | Caps, letter-spaced (observed on cards) | not estimated |
| Card title | "Đoạn văn" | not measured | Bold, white, large | not estimated |

Typeface name: not determined. It looks like a rounded geometric sans (INFERRED, low confidence). Line-height and letter-spacing values are not measured.

### Colour usage

Qualitative only. There are no sampled values.

| Use | Description | Tag |
|---|---|---|
| Window background | Near-white / very light grey | OBSERVED |
| Primary text | Near-black | OBSERVED |
| Secondary text | Mid-grey | OBSERVED |
| Accent: user name "An", selected chip tint | Saturated blue | OBSERVED |
| Plus banner | Solid saturated blue with white text and small sparkle dots | OBSERVED |
| Flashcard banner | Dark navy to bright blue gradient, white text | OBSERVED |
| Mode card 01 | Light-grey fill, white text, low contrast | OBSERVED |
| Page dot active | Lime green (inactive dots grey) | ESTIMATED |
| Streak value "0 ngày" | Orange with a flame icon | OBSERVED |
| Chips (unselected) | White with dark text and dark-grey icons | OBSERVED |
| Mode card colour per category (tint varies by card) | | INFERRED (cards 02, 03 not seen fully) |
| Dark-mode support | A "Sun" label hints at a theme toggle | INFERRED |

### Card radius

| Element | Radius | Tag |
|---|---|---|
| Mode cards | ≈ 28–36 pt, large | ESTIMATED |
| Plus banner | ≈ 20–24 pt | ESTIMATED |
| Flashcard banner | ≈ 20–24 pt, similar to the Plus banner | ESTIMATED |
| Mini flashcards (inside banner) | ≈ 12–16 pt | ESTIMATED |
| Exact values | Not measurable from AX | n/a |

### Button radius

| Element | Radius | Tag |
|---|---|---|
| Chips | Fully rounded pill (≈ 14–15 pt, half of the 29 pt height) | OBSERVED shape / INFERRED value |
| Streak pill, Menu pill, "Mở Flashcard" pill | Fully rounded pill | OBSERVED shape |
| Bottom icon buttons (36×36) | Circle (radius 18) | OBSERVED shape / INFERRED value |
| Flag button (40×27) | Small rounded rectangle, ≈ 8 pt | ESTIMATED |

### Border / shadow treatment

| Observation | Tag |
|---|---|
| No strong drop shadows on the banners or mode card | OBSERVED (at screenshot resolution) |
| Chips and flag button have a faint light edge or very subtle shadow | ESTIMATED |
| Bottom bar: translucent pills over a blue-white gradient blur | OBSERVED |
| Card 01 has a soft pale edge with no visible stroke | ESTIMATED |
| Border widths and shadow parameters | Not measured |

### Icon sizing

| Element | Size | Tag |
|---|---|---|
| Star icon in Menu pill | 16×16 | MEASURED |
| Window controls | 16×16 (3 of 3) | MEASURED |
| Bottom icon buttons (hit area) | 36×36 (2 of 2) | MEASURED |
| Glyph inside the 36×36 buttons | ≈ 18–20 | ESTIMATED |
| Chip leading icons | ≈ 14–16 | ESTIMATED |
| Flag | 40×27 container, glyph ≈ 26×18 | MEASURED container / ESTIMATED glyph |
| Plus banner sparkle icon | ≈ 28–30 | ESTIMATED |
| Icon family | Streamline Flex (names end in `--Streamline-Flex`) | OBSERVED |

## Known gaps and discrepancies

- No hex colours, radii, font sizes or shadow values were measured. All are ESTIMATED or missing.
- The Flow Letter card and the Gramify 101 strip were never seen rendered (below fold). Only their AX text and bounds are known.
- The 3-dot carousel indicator, the 2-dot banner indicator and the Menu pill bounds are not in the AX tree and are ESTIMATED from the screenshot.
- "Sun--Streamline-Flex" (AX) vs gear glyph (screenshot) is an unresolved mismatch.
- Card 01's grey, washed-out look may be a transient rendering state, so its colours should not be treated as the card design.
- OCR output was garbled Vietnamese and was not used.
