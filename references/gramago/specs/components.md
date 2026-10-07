# GramaGo Reusable Components (Home screen evidence)

Derived from [../screens/home.md](../screens/home.md), 2026-10-08. Read-only inspection, so **behaviour and destinations are INFERRED** and no state transitions were observed.

Provenance tags: OBSERVED (seen or in AX text), MEASURED (tool-reported bounds or arithmetic on them, ±1 for AX rounding), ESTIMATED (by eye from screenshot), INFERRED (reasoning). Sizes are in points. Component names are mine, not from the app's source, and are INFERRED labels.

## Summary

| Component | Instances on Home | Interactive | Evidence strength |
|---|---|---|---|
| TitleBar / WindowControls | 1 | Yes | Strong |
| ScreenHeader | 1 | No | Medium |
| FlagButton | 1 | Yes | Weak (1 instance) |
| AIPromptLink | 1 | Unclear | Weak |
| PromoBanner | 1 | Yes | Weak (1 instance) |
| PageIndicator | 2 (ESTIMATED) | Probably no | Weak |
| SectionHeader | 3 | No | Strong |
| ModeCard | 3 | Yes | Strong |
| TopicChip | 10 | Yes | Strong |
| FeatureBanner | 1 confirmed, 1 partial | Yes | Medium |
| MiniFlashcard | 2 | No | Weak |
| FloatingBottomBar | 1 | Yes | Medium |
| IconButton (circular) | 2 | Yes | Strong |
| Pill (streak / menu / CTA) | 3 | Yes | Medium |
| FeatureTile | 7 | Yes | Strong (AX only, off-screen) |
| LetterTile | 5 | No | Weak (AX only, off-screen) |

---

## TitleBar / WindowControls
- **Purpose:** standard macOS window chrome with a centred title. (INFERRED)
- **Structure (OBSERVED):** three 16×16 traffic-light buttons (close, minimize, full screen) and the title text "Gramify".
- **Bounds (MEASURED):** buttons at global (1370, −1166), (1393, −1166), (1416, −1166), each 16×16. Title text 56×17 at (1444, −1167). The title bar is about 32 pt tall.
- **States:** only the default state was seen.

## ScreenHeader
- **Purpose:** personalised greeting. (INFERRED)
- **Structure (OBSERVED):** two stacked text lines: "Chúc ngủ ngon," then the user name "An" in an accent colour (blue). The flag button is right-aligned in the same band.
- **Bounds (MEASURED):** line 1 160×26, line 2 28×26. Both start at local x 12, with a 3 pt gap between lines.
- **Variation:** the greeting changes by time of day, and the name by user. (INFERRED)

## FlagButton
- **Purpose:** probably a language or locale switch. (INFERRED)
- **Structure (OBSERVED):** a light rounded-rectangle button containing a US flag image. The AX label is "US".
- **Bounds (MEASURED):** 40×27 at local (736, 54), 12 pt from the right edge.
- **Interactive:** yes (AXButton). Destination unknown.

## AIPromptLink
- **Purpose:** entry point for AI lesson creation. (INFERRED)
- **Structure (OBSERVED):** the grey line "Bạn chưa biết học gì hôm nay?" above a bold line "Tạo bài học với AI", followed by a small gradient orb icon.
- **Bounds (MEASURED):** line 1 154×13 at local (12, 125). Line 2 102×16 at local (12, 146).
- **Interactive:** not actionable in AX (OBSERVED). It looks like a CTA, so a parent may be tappable. (INFERRED)

## PromoBanner
- **Purpose:** upsell to the Plus subscription. (INFERRED)
- **Structure (OBSERVED):** full-width blue rounded button with a leading sparkle icon, a bold title "Đăng ký Gramify Plus", a one-line description and decorative sparkle dots. It sits inside an AX "collection" with two small dots beneath (ESTIMATED), which suggests a pager of banners (INFERRED).
- **Bounds (MEASURED):** button 763×77 at local (12, 196). Collection 788×77 at local (0, 196).
- **Radius:** ≈ 20–24 (ESTIMATED).
- **Related:** shares the full-width, 763 pt, rounded-banner form with FeatureBanner.

## PageIndicator
- **Purpose:** show the position in a carousel. (INFERRED)
- **Structure (ESTIMATED from screenshot, not in AX):** a row of small dots. Under the carousel there are 3 dots, the first lit in lime green. Under the Plus banner there are 2 small dots.
- **Bounds:** not measured. The carousel dots sit at roughly local y 757 and x 370–420, and the banner dots at about local y 279. (ESTIMATED)
- **Interactive:** not exposed. Probably not tappable. (INFERRED)

## SectionHeader
- **Purpose:** title and subtitle above a content group. (OBSERVED)
- **Structure (OBSERVED):** a bold title line over a one-line grey subtitle.
- **Bounds (MEASURED):** title frame height 19, subtitle frame height 13, in all 3 instances. Title-to-subtitle gap 4, 3 and 6 pt (the 6 is "Gramify 101"). Left aligned at local x 12.
- **Instances:** "Chế độ học tập", "Gramify đề xuất", "Gramify 101" (the last below the fold).
- **Vertical spacing to content:** 19 pt before the carousel, 14 pt before the chips, 13 pt before the tiles. The spacing is not uniform. (MEASURED)

## ModeCard
- **Purpose:** entry to a study mode (writing, grammar, conversation). (INFERRED)
- **Structure (OBSERVED, from card 01 and AX text):**
  1. category pill, caps: "LUYỆN VIẾT" / "NGỮ PHÁP" / "GIAO TIẾP"
  2. large title: "Đoạn văn" / "Sửa câu" / "Hội thoại"
  3. large faded index numeral: 01 / 02 / 03
  4. short description
  5. footer "KHÁM PHÁ" with an arrow (↗ in screenshot)
  6. a small circular icon at the top-right corner of card 01 and a large decorative ring arc
- **Bounds (MEASURED):** card 01 670×385. Card 02 670×369. Card 03 669×369. Gaps 12–13. Cards 02 and 03 are bottom-aligned with card 01.
- **States:** the active (first) card is larger than the other two. The card dimensions strongly suggest a scale or selected state (INFERRED). Card 01 rendered grey with low contrast. Whether that is a state or a transient rendering is unknown.
- **Radius:** ≈ 28–36 (ESTIMATED).
- **Interactive:** yes (AXButton, label is the concatenation of all of its text).

## TopicChip
- **Purpose:** a topic filter or topic shortcut. (INFERRED)
- **Structure (OBSERVED):** a pill with a leading icon and a text label.
- **Bounds (MEASURED):** height 29 (30 for two of them, an AX rounding artefact). Width follows the content: 71 ("IELTS") to 120 ("Làm tôi bất ngờ"). Gap 8 pt horizontally and 8 pt between rows.
- **States (OBSERVED):** two visual states. *Selected or highlighted* is a light-blue tint with blue text and a sparkle icon (first chip only). *Default* is white with dark text and a grey or dark icon (the other nine). Which state is actually "selected" is INFERRED.
- **Layout:** left-aligned, wrapping rows. 5 chips per row at this window width (OBSERVED).
- **Interactive:** yes (AXButton). Whether tapping toggles the selection or starts a lesson is unknown.

## FeatureBanner
- **Purpose:** promote a feature area with a CTA and a preview. (INFERRED)
- **Instance 1: Vocabulary Flashcard (OBSERVED):**
  - gradient navy-to-blue background
  - bold caps title "VOCABULARY FLASHCARD"
  - description "Lưu từ mới, ôn tập theo SRS và theo dõi tiến bộ mỗi ngày."
  - translucent CTA pill "Mở Flashcard →"
  - two stacked MiniFlashcards at the right, rotated or offset slightly
- **Bounds (MEASURED):** 763×160 at local (12, 913). Same width as PromoBanner.
- **Instance 2: Flow Letter (partial, AX only):** title "Flow Letter", description "Xếp chữ cái thành từ vựng", a "Thử ngay" CTA, and five LetterTiles. Its container bounds were not reported, so its size and look are unknown.
- **Interactive:** yes for Instance 1 (AXButton wrapping the whole banner). The Flow Letter container was not reported as a button.

## MiniFlashcard
- **Purpose:** decorative preview of a vocabulary card. (INFERRED)
- **Structure (OBSERVED):** a white rounded card with an English word in bold ("Resilient", "Acquire") and a Vietnamese translation in blue-grey ("Kiên cường", "Tiếp thu"). Two instances are stacked and slightly offset.
- **Bounds:** not in AX. Roughly 100×50 each. (ESTIMATED)
- **Interactive:** not separately. They are part of the banner button.

## FloatingBottomBar
- **Purpose:** persistent quick actions over the scroll content. (INFERRED)
- **Structure (OBSERVED):** four items on one row. Left: IconButton. Centre: StreakPill, with the Menu pill below it, as a stack. Right: IconButton. A blue-white gradient blur sits behind the whole bar at the window's bottom edge.
- **Bounds (MEASURED):** left button local (18, 1041) 36×36. Right button local (733, 1041) 36×36. Streak pill local (327, 1008) 133×24, centred on the window.
- **Menu pill (ESTIMATED):** about 93×34 at local (348, 1042). The AX tree gives only the 16×16 star icon at local (366, 1051) and the 33×16 text at local (389, 1052).
- **Behaviour:** drawn over the Flashcard banner. Whether it stays fixed when scrolling was not tested. (INFERRED to be fixed)

## IconButton (circular)
- **Structure (OBSERVED):** circular translucent button holding a single glyph.
- **Bounds (MEASURED):** 36×36, 2 instances.
- **Instances:** left "Rotate-Left--Streamline-Flex" (the screenshot shows a circular-arrow glyph). Right "Sun--Streamline-Flex" (the screenshot shows a gear glyph, so the AX label and glyph disagree).
- **Glyph size:** ≈ 18–20. (ESTIMATED)

## Pill (streak / menu / CTA)
- **Shared form (OBSERVED):** fully rounded capsule, translucent white or light fill, with a short label and optional icon.
- **Instances:**
  - Streak: "Chuỗi:" in grey, "0 ngày" in orange, with a flame icon. 133×24 (MEASURED).
  - Menu: star icon and "Menu" text. Bounds ESTIMATED (above).
  - "Mở Flashcard →": translucent pill inside the FeatureBanner. Bounds not measured.
- **Whether these are one component or three** is INFERRED. They look alike but sizes differ (24, ≈34 and unmeasured heights).

## FeatureTile
- **Purpose:** short feature explainer in the "Gramify 101" strip. (INFERRED)
- **Structure:** only the AX label is known (for example "AI Magic Generator"). The last tile's label also exposes the letters "C, A, T, S", so it contains a small letter graphic. The visual design of the tiles is unknown (never seen rendered).
- **Bounds (MEASURED):** 123×146, 7 instances. Pitch 135–136 pt (gap 12–13). The group is 960 wide with 12 pt padding each side.
- **Instances:** "3 Chế Độ Luyện Tập Chính", "Trợ Lý AI & Hệ Thống Phản Hồi", "AI Magic Generator", "Hệ thống Flashcard & SRS", "Hệ Thống Theo Dõi Tiến Độ", "Chức Năng Ôn Tập Thông Minh", "Mini Game: Flow Letter".
- **Interactive:** yes (AXButton). Destination is unknown.

## LetterTile
- **Purpose:** letter graphic for the Flow Letter game. (INFERRED)
- **Structure:** square tiles "H", "E", "L", "L", "O". Appearance not seen (below the fold).
- **Bounds (MEASURED):** 27×27, pitch 34 (gap 7), 5 instances.
- **Interactive:** no (AXStaticText).

---

## Cross-component patterns

| Pattern | Evidence | Tag |
|---|---|---|
| All content shares a 12 pt left margin | ≥ 10 elements start at local x 12 | MEASURED |
| Full-width banners are 763 wide | 2 instances (Plus, Flashcard) | MEASURED |
| Pill shapes for chips, streak, menu, CTA | Visible in screenshot | OBSERVED |
| Carousel and strip share the 12–13 pt gap | Cards 12/13, tiles 12/13 | MEASURED |
| Whole-card buttons: one AXButton whose label concatenates all child text | Cards, banners, tiles | OBSERVED |

## Not documented (insufficient evidence)
- Pressed, disabled, focus and loading states: none seen.
- Animation and transition timing: not observable from a still capture.
- The Flow Letter container, tile internals and the carousel dot sizes: not measured.
