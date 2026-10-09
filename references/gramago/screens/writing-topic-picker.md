# Writing Topic Picker ("Viết nên câu chuyện")

State ID: `S002 writing-topic-picker--default`
Source: Peekaboo `see` (fresh), snapshot `ps1_2910e7e52757acbb5596fc7bc052b705`, 2026-10-08. A repository screenshot is not saved yet (see Notes).

Provenance tags: OBSERVED (read from AX tree text or seen plainly in the screenshot), MEASURED (tool-reported bounds or arithmetic on them, ±1 for AX rounding), ESTIMATED (by eye from the screenshot), INFERRED (reasoning, may be wrong).
Coordinates: **global** = Peekaboo screen points. **local** = global minus window origin (1362, −1174). Local values are MEASURED (arithmetic on AX bounds).

## Identity

| Field | Value | Tag |
|---|---|---|
| Reached from | Home (`S001`), pressing the "01, LUYỆN VIẾT, Đoạn văn…" mode card (`elem_25`) | OBSERVED |
| Navigation context | Pushed onto a navigation stack. The AX group "Nav bar" has identifier `_TtGC7SwiftUI32NavigationStackHosting`, and the back button has identifier `BackButton`. | OBSERVED |
| Implies | The app is native SwiftUI with a `NavigationStack` | INFERRED |
| Mode this screen belongs to | "CHẾ ĐỘ TẠO" (creation mode), titled "Viết nên câu chuyện" ("Write the story") | OBSERVED |
| Copy mismatch | The Home card says "Đoạn văn" (paragraphs, "translate and write paragraphs"), but this screen is titled "Viết nên câu chuyện" (story). Reason unknown. | OBSERVED mismatch; cause unknown |

## Window

| Field | Value | Tag |
|---|---|---|
| App / window | GramaGo, "Gramify" (`SceneWindow`) | OBSERVED |
| Window bounds (global) | x=1362, y=−1174, 788 × 1083 | MEASURED |
| Viewport (global) | x=1362, y=−1142, 788 × 1051 (local 0,32 → 788,1083) | MEASURED |
| Scroll content | group at global y −1085, 788 × 1107 (local y 89 → 1196). About 113 pt below the fold. | MEASURED |
| Floating bottom bar from Home (streak, Menu, side icons) | Not present | OBSERVED |

## Hierarchy

Top to bottom (local coordinates, x, y, w×h).

```
Window "Gramify" (0,0, 788×1083)
├─ Title bar (0,0, 788×32): traffic lights + "Gramify"
├─ Nav bar (0,48, 788×41)              [fixed, SwiftUI NavigationStack]
│   ├─ Back button   (7,48, 33×33)       leading
│   └─ "AI" button   (749,51, 27×27)     trailing
└─ Scroll content (0,89, 788×1107)
   ├─ Hero
   │   ├─ micro-label "● CHẾ ĐỘ TẠO"     (30,102, 62×9)
   │   ├─ "Viết nên"                      (18,117, 110×39)
   │   └─ "câu chuyện"                    (18,150, 156×39)
   ├─ "DANH MỤC" label                   (18,208, 54×9)
   ├─ Category rail (0,230, 1970×36)      horizontal scroller, 19 chips
   ├─ Section row
   │   ├─ "CHỦ ĐỀ CỦA BẠN"               (18,294, 86×9)
   │   └─ "12 chủ đề" count badge         (729,294, 34×9)
   └─ Topic grid (18,319, 751×785), 2 columns × 6 rows = 12 cards
```

## Elements

x/y are **global**. Roles are as reported by AX.

### Chrome and navigation

| Label / text | Role | x | y | w | h | Interactive |
|---|---|---|---|---|---|---|
| close / minimize / full screen | AXButton | 1370 / 1393 / 1416 | −1166 | 16 | 16 | Yes |
| "Nav bar" | AXGroup | 1362 | −1126 | 788 | 41 | No |
| "Back" (id `BackButton`) | AXButton | 1369 | −1126 | 33 | 33 | Yes |
| "AI" | AXButton | 2111 | −1123 | 27 | 27 | Yes |

### Hero

| Label / text | Role | x | y | w | h | Interactive |
|---|---|---|---|---|---|---|
| "CHẾ ĐỘ TẠO" | AXStaticText | 1392 | −1072 | 62 | 9 | No |
| "Viết nên" | AXStaticText | 1380 | −1057 | 110 | 39 | No |
| "câu chuyện" | AXStaticText | 1380 | −1024 | 156 | 39 | No |
| "DANH MỤC" | AXStaticText | 1380 | −966 | 54 | 9 | No |

### Category rail (19 chips, all AXButton, all interactive)

Chips sit at y −941 (−942 for the first), height 30, except the first (31).

| # | Label | x | w |
|---|---|---|---|
| 1 | "Dành cho bạn" | 1379 | 117 |
| 2 | "Giao tiếp" | 1504 | 93 |
| 3 | "Hằng ngày" | 1607 | 100 |
| 4 | "Công việc" | 1717 | 98 |
| 5 | "Du lịch" | 1825 | 81 |
| 6 | "Mua sắm" | 1916 | 92 |
| 7 | "Ẩm thực" | 2017 | 90 |
| 8 | "Sức khỏe" | 2116 | 94 |
| 9 | "Phim ảnh" | 2220 | 93 |
| 10 | "Âm nhạc" | 2323 | 91 |
| 11 | "Trò chơi" | 2423 | 87 |
| 12 | "Thể thao" | 2520 | 91 |
| 13 | "Văn hóa" | 2620 | 87 |
| 14 | "Truyện ngắn" | 2717 | 107 |
| 15 | "Tiểu luận" | 2835 | 91 |
| 16 | "Email" | 2935 | 75 |
| 17 | "Học thuật" | 3020 | 97 |
| 18 | "IELTS" | 3126 | 75 |
| 19 | "Công nghệ" | 3211 | 102 |

Container: AXGroup at (1362, −944), 1970 × 36 (MEASURED). Only the first seven chips fit in the viewport (OBSERVED in screenshot, the eighth is clipped at the right edge).

### Topic grid (12 cards, AXButton, interactive)

Every card is 371 × 123. Column x: 1380 and 1760. Row y: −855, −723, −590, −458, −325, −193.

| Label (as in AX) | Position | Set count |
|---|---|---|
| "Quy tắc ứng xử" | row 1, col 1 | 12 |
| "Chiến lược khách hàng" | row 1, col 2 | 14 |
| "Phát triển sự nghiệp" | row 2, col 1 | 13 |
| "Di chuyển và giao thông" | row 2, col 2 | 14 |
| "Công nghệ và thiết bị" | row 3, col 1 | 14 |
| "Nghệ thuật và thủ công" | row 3, col 2 | 14 |
| "Trải nghiệm du lịch đa dạng" | row 4, col 1 | 14 |
| "Đàm phán kinh doanh" | row 4, col 2 | 14 |
| "Kỹ năng xã hội tại nơi công cộng" | row 5, col 1 | 14 |
| "Kỹ năng xã hội tại nơi làm việc" | row 5, col 2 | 15 |
| "Thị trấn và làng cổ" | row 6, col 1 | 14 |
| "Chia sẻ và mượn đồ" | row 6, col 2 | 13 |

Each AX label is "title, N Sets" (OBSERVED). Grid container: AXGroup at (1380, −855), 751 × 785. Row 6 is clipped at the viewport bottom (local y 981–1104 against a 1083 fold) and shows only partly in the screenshot.

### Section row

| Label / text | Role | x | y | w | h | Interactive |
|---|---|---|---|---|---|---|
| "CHỦ ĐỀ CỦA BẠN" | AXStaticText | 1380 | −880 | 86 | 9 | No |
| "12 chủ đề" | AXStaticText | 2091 | −880 | 34 | 9 | No |

## Visual Design

No pixel colours were sampled, so there are no hex values.

### Margins and spacing

| Value | Tag |
|---|---|
| Left content margin 18 pt (hero, labels, chip rail start at 17, grid) | MEASURED |
| Right content margin 19 pt (grid right edge local 769 against width 788) | MEASURED |
| Grid column gap 9 pt (1760 − 1751) | MEASURED |
| Grid row gap 9–10 pt (row pitch 132, 133, 132, 133, 132 against height 123) | MEASURED |
| Chip gap on the rail: 8 (first pair), then 9–11. The 17 later gaps are 9 (6×), 10 (10×), 11 (1×). | MEASURED |
| Nav bar height 41 pt, back button 33×33, AI button 27×27 | MEASURED |
| Hero line frames 39 pt tall, 33 pt pitch ("Viết nên" at local y 117, "câu chuyện" at 150), so the two lines overlap their frames by 6 pt | MEASURED |
| Hero label → title gap ≈ 6 pt; title → "DANH MỤC" gap ≈ 19 pt (from "câu chuyện" bottom 189 to 208) | MEASURED |
| "DANH MỤC" bottom → rail top ≈ 13 pt; rail bottom → "CHỦ ĐỀ CỦA BẠN" ≈ 28 pt; section row → grid ≈ 16 pt | MEASURED |

### Typography

Frame heights are MEASURED. Font sizes are not read from the app.

| Level | Example | Frame h | Look | Tag |
|---|---|---|---|---|
| Display (largest on any screen seen so far) | "Viết nên" / "câu chuyện" | 39 | Very bold, tight tracking | OBSERVED look, MEASURED frame |
| Micro-label | "CHẾ ĐỘ TẠO", "DANH MỤC", "CHỦ ĐỀ CỦA BẠN" | 9 | All caps, wide letter-spacing, small, grey | OBSERVED |
| Chip label | "Dành cho bạn" etc. | not reported | Medium weight, dark | OBSERVED |
| Card title | "Quy tắc ứng xử" | not reported | Bold, dark, bottom-left | OBSERVED |
| Card meta | "12 Sets" | not reported | Small, grey | OBSERVED |

Font sizes: not determined.

### Colour usage (qualitative)

| Observation | Tag |
|---|---|
| Page background: near-white, very light grey | OBSERVED |
| "Viết nên" near-black, "câu chuyện" light grey-lavender. A deliberate two-tone title, and possibly a gradient effect. | OBSERVED two-tone / INFERRED gradient |
| Selected chip ("Dành cho bạn"): white fill with an orange outline and orange star icon | OBSERVED |
| Other chips: white fill, no visible outline, with coloured icons (blue, teal, purple, pink, red) | OBSERVED |
| Topic cards: flat light-grey fill, thin lighter border, dark icon in a white circle | OBSERVED |
| Count badge "12 chủ đề": small grey rounded pill | OBSERVED |

The topic cards render flat grey, like Home's mode card 01. Whether that is the real design or a placeholder/loading state is unknown.

### Radius, borders, shadows (all ESTIMATED from the screenshot)

| Element | Value | Tag |
|---|---|---|
| Topic cards | ≈ 20–24 pt radius, thin light border, no visible shadow | ESTIMATED |
| Chips | fully rounded pill (≈ 15 pt, half of the 30 pt height) | OBSERVED shape / INFERRED value |
| Back and AI buttons | circles | OBSERVED shape |
| Count badge | small rounded pill | OBSERVED shape |
| Selected-chip outline | ≈ 1.5–2 pt, orange | ESTIMATED |

### Icons

| Element | Size | Tag |
|---|---|---|
| Back button container | 33 × 33 | MEASURED |
| AI button container | 27 × 27 (screenshot shows a larger ring, so the container may exceed the AX frame) | MEASURED / unverified |
| Chip leading icon | ≈ 14–16 | ESTIMATED |
| Chip trailing chevron ">" (present on every chip, new compared with Home chips) | ≈ 8–10 | ESTIMATED |
| Card icon in white circle (cup, briefcase, plane, chat bubble) | circle ≈ 30–32, glyph ≈ 16 | ESTIMATED |
| Icon family | Not stated on this screen | n/a |

## States

| State | Status |
|---|---|
| Default, "Dành cho bạn" selected, scrolled to top | **Captured (S002)** |
| Another category chip selected | Not captured |
| Category rail scrolled horizontally | Not captured |
| Grid scrolled to the bottom (row 6 fully visible) | Not captured |
| Loading / empty / error for the grid | Not seen |
| Cards in colour (non-grey) | Not seen |

## Actions

All destinations are INFERRED. None was exercised (the next click was denied, see Notes).

| Element | Action | Expected result | Tag |
|---|---|---|---|
| Back (`BackButton`) | Press | Return to Home (`S001`) | INFERRED |
| "AI" button | Press | AI lesson / topic generator | INFERRED |
| Category chip (19) | Press | Select a category and filter the grid, with the selected chip getting the orange outline | INFERRED |
| Category rail | Horizontal scroll | Reveals chips 8–19 | INFERRED |
| Topic card (12) | Press | Open the lesson sets for that topic ("N Sets") | INFERRED |
| Content | Vertical scroll | Reveals the rest of row 6 | INFERRED |

## Notes

- **Correction:** an earlier message of mine described the "Dành cho bạn" chip as the "dark" selected one. The screenshot shows a white chip with an **orange outline**, not a dark fill.
- **Unconfirmed click:** the click that produced this screen returned "no confirmed outcome", but the next capture showed the new screen, so it landed. It was not retried.
- **Crawl paused:** the next action (pressing "Quy tắc ứng xử", `elem_37`) was denied by the permission classifier, so deeper screens are not explored.
- **Screenshot not yet saved to the repo.** A direct capture was scheduled for the next visit to this screen: the app had returned to Home on its own, so capturing now would have shown the wrong screen. The S001 Home capture was taken instead (direct `path` output worked; file `screenshots/S001-home-inactive-original.png`).
- The back button is at the top-left and the AI button at the top-right, with no title text in the nav bar (the hero acts as the title).
