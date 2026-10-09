# Writing Lesson List ("Bài học")

> **Corrected 2026-10-09 (C01):** lines 73–74 (per-card gradients; card 02 purple/pink, 03 green) are wrong. The active capture [S003](../screenshots/S003-writing-lesson-list-active-verification.png) shows a flat **white** card (radius ≈ 24), navy CTA. The original capture was inactive-window.

State ID: `S003 writing-lesson-list--default`
Source: Peekaboo, snapshots `ps1_548aee20c8ab4c6877c2eaa524d3a31c` (inspect_ui) and `ps1_9e01dd4708092e3c8a315b9f9eba7421` (see), 2026-10-08.
Screenshot: [S003-writing-lesson-list-inactive-original.png](../screenshots/S003-writing-lesson-list-inactive-original.png).

Provenance tags: OBSERVED (AX text or screenshot), MEASURED (tool bounds or arithmetic, ±1), ESTIMATED (by eye), INFERRED (reasoning).
Coordinates: global points; local = global − (1362, −1174).

## Identity

| Field | Value | Tag |
|---|---|---|
| Reached from | S002, topic card "Kỳ quan thiên nhiên, 14 Sets" | OBSERVED |
| Nav title | "Bài học" — the nav-bar group's AX identifier is "Bài học" and an AXHeading carries the title, so this screen is presented as a titled navigation destination | OBSERVED |
| Topic title | "Kỳ quan thiên nhiên" — the same topic that was clicked, so this screen is the topic's lesson list | OBSERVED |
| "N Sets" meaning | The topic card said "14 Sets"; the lesson rail here holds 14 cards (content group ≈ 8,886 pt wide ÷ ≈ 662 pt per card). "Sets" = lessons | MEASURED / INFERRED |
| Topic shown differs from first S002 visit | The S002 "Dành cho bạn" grid is randomized per visit; "Quy tắc ứng xử" from the first visit was not present on the second visit, so the representative card "Kỳ quan thiên nhiên" was used instead | OBSERVED |

## Window

788 × 1083 at (1362, −1174); viewport 788 × 1051 (local 0,32 → 788,1083). MEASURED, unchanged from S001/S002.

## Hierarchy

```
Nav bar (0,48, 788×41): Back left, centered AXHeading "Bài học"
Scroll content
├─ Hero (centered)
│   ├─ micro-label "BỘ SƯU TẬP"        (363,102, 60×9)
│   ├─ "Kỳ quan thiên nhiên" + orange "."  (287,123, 202×29 + 490,123, 9×29)
│   ├─ subtitle "Chiêm ngưỡng vẻ đẹp…" (245,165, 297×13)
│   └─ level pill "CẤP ĐỘ · A1"        (354,191, 79×19)
└─ Lesson rail (0,210, 8886×369) — horizontal, 14 cards
    ├─ Card 01 "Khám phá Cổng địa ngục" (base local x 111)
    │   ├─ number "01" (661,258, 15×17)  top-right of card
    │   ├─ title (111,258, 242×26)
    │   ├─ subtitle "Tìm hiểu về miệng núi lửa…" (111,291, 259×13)
    │   ├─ "Bắt đầu" button (111,496, 89×35)
    │   └─ flame illustration (597,433, 98×113, SF Symbol `flame.fill`)
    ├─ Card 02 "Cuộc phiêu lưu trên sông ngầm" (base x 760, peeks in view)
    └─ Card 03 "Khu rừng đá kỳ lạ" (base x 1388, partially visible)
```

## Elements

| Label | Role | Global x | y | w | h | Interactive |
|---|---|---|---|---|---|---|
| Back (`BackButton`) | AXButton | 1369 | −1126 | 33 | 33 | Yes |
| "Bài học" | AXHeading | 1732 | −1118 | 46 | 17 | No |
| "BỘ SƯU TẬP" | AXStaticText | 1725 | −1072 | 60 | 9 | No |
| "Kỳ quan thiên nhiên" | AXStaticText | 1649 | −1051 | 202 | 29 | No |
| "." (accent) | AXStaticText | 1852 | −1051 | 9 | 29 | No |
| Subtitle | AXStaticText | 1607 | −1009 | 297 | 13 | No |
| "CẤP ĐỘ, A1" level pill | AXButton | 1716 | −983 | 79 | 19 | Yes |
| Lesson 01 title "Khám phá Cổng địa ngục" | AXStaticText | 1473 | −916 | 242 | 26 | No |
| "01" | AXStaticText | 2023 | −916 | 15 | 17 | No |
| Lesson 01 subtitle | AXStaticText | 1473 | −883 | 259 | 13 | No |
| "Bắt đầu" (lesson 01) | AXButton | 1473 | −678 | 89 | 35 | Yes |
| "Ngọn Lửa" illustration (`flame.fill`) | AXImage | 1959 | −741 | 98 | 113 | Actionable |
| Lesson 02 "Cuộc phiêu lưu trên sông ngầm" + "02" | AXStaticText | 2122 / 2627 | −906 | 278 / 16 | 24 / 16 | No |
| "Bắt đầu" (lesson 02) | AXButton | 2122 | −685 | 82 | 32 | Yes |
| Lesson 03 "Khu rừng đá kỳ lạ" + "03" | AXStaticText | 2750 / 3254 | −905 | 150 / 17 | 24 / 16 | No |
| "Bắt đầu" (lesson 03) | AXButton | 2750 | −686 | 82 | 32 | Yes |
| Lesson rail group | AXGroup | 1362 | −964 | 8886 | 369 | No |

## Visual Design

| Observation | Tag |
|---|---|
| Hero is centered, unlike S002's left-aligned hero | OBSERVED |
| Lesson card ≈ 650 × 289 (button-to-number span), ≈ 12 pt gap (card 2 starts where card 1 ends + gap) | MEASURED |
| Lesson 01: dark navy→blue gradient, white bold title, grey subtitle, faded large "01" numeral, white rounded "Bắt đầu" button bottom-left, large flame illustration bottom-right | OBSERVED |
| Card 02 gradient is purple/pink, card 03 dark green — each lesson card has its own palette | OBSERVED (partial view) |
| Illustrations are SF Symbols (`flame.fill`, `mountain.2.fill` identifiers) rendered large | OBSERVED |
| "Bắt đầu" first button 89×35, later buttons 82×32 (AX rounding or slight scale difference of the active card) | MEASURED |
| Level pill: small translucent capsule, divider between "CẤP ĐỘ" label and "A1" value | OBSERVED |
| No floating bottom bar on this screen | OBSERVED |

## States

| State | Status |
|---|---|
| Default, card 01 active | Captured (S003) |
| Rail scrolled to later lessons | Not captured |
| Level pill menu open | Not captured (pill is a button; menu unknown) |

## Actions

| Element | Action | Destination | Tag |
|---|---|---|---|
| "Bắt đầu" (any lesson) | Press | Exercise editor (S004) | OBSERVED for lesson 01; INFERRED identical for others |
| Back | Press | S002 | INFERRED (not exercised) |
| Rail | Horizontal scroll | Later lesson cards | INFERRED |
| "CẤP ĐỘ A1" pill | Press | Level picker? | INFERRED, unexplored |

## Notes

- The click on the topic card (S002 → S003) returned "unconfirmed" but had landed; verification by capture, no retry.
- Content width differs from S002: hero elements are centered, cards start at local x 111.
- Lesson numbering "01…" continues to 14 off-screen (INFERRED from group width; only 1–3 visible).
