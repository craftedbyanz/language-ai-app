# Flashcards & SRS — S012, S013, S014, S015

> **Corrected 2026-10-09:** (C18) the deck-detail top-right "Thêm" is a ⋯ **menu** button, not "Add card" (add = the list FAB). SRS card back is captured ([S052](../screenshots/S052-srs-card-back-active.png)); SRS "Thêm" menu = S053 (AX only). Deck-detail active capture: [S013](../screenshots/S013-flashcard-deck-detail-active-verification.png).

Reached from Home Menu → "Học flashcard" (OBSERVED). The Home Flashcard banner ("Mở Flashcard") presumably leads to the same list. INFERRED.
Tags: OBSERVED / MEASURED / ESTIMATED / INFERRED. Local = global − (1362, −1174).

## S012 `flashcard-deck-list--default` — "Học flashcard"

Snapshot `ps1_1ca41953012150570cf77e96ee155286`, screenshot [S012-flashcard-deck-list.png](../screenshots/S012-flashcard-deck-list.png).

| Element | Role | Global x | y | w | h | Interactive |
|---|---|---|---|---|---|---|
| Back | AXButton (`BackButton`) | 1369 | −1126 | 33 | 33 | Yes |
| "Học flashcard" | AXHeading + nav identifier | 1711 | −1118 | 88 | 17 | No |
| "Thêm" (plus) | AXButton | 2085 | −161 | 46 | 46 | Yes |
| Deck "10, Nấu ăn & Ẩm thực, Từ vựng về nấu ăn, ẩm thực" | AXButton | 1380 | −1066 | 369 | 98 | Yes |

- AX is sparse here (18 elements); the screenshot shows a deck carousel wider than the AX tree exposes. OBSERVED.
- Scroll group 788×209. MEASURED.

## S013 `flashcard-deck-detail--default` — deck "Nấu ăn & Ẩm thực"

Snapshot `ps1_cb7697da15e4dd466b8da01effa819f9`, screenshot [S013-flashcard-deck-detail-inactive.png](../screenshots/S013-flashcard-deck-detail-inactive.png). Reached by pressing the deck card (OBSERVED).

| Element | Role | Global x | y | w | h | Interactive | Notes |
|---|---|---|---|---|---|---|---|
| Back (label "Học flashcard") | AXButton | 1369 | −1126 | 33 | 33 | Yes | Back label = previous screen title |
| "Nấu ăn & Ẩm thực" | AXStaticText | 1703 | −1117 | 105 | 16 | No | Nav title (centered) |
| "Thêm" | AXButton | 2111 | −1123 | 27 | 27 | Yes | Add card |
| Deck header | texts | 1663/1688, −1004/−971 | 185/135 | 26/13 | No | Title + description |
| Stats "10 / 0 / 0" | AXStaticText + icons | 1686–1827, −933 | 13–20 | 23 | No | sparkles=new, book=learning, clock=review |
| "Mới / Đang học / Ôn tập" | AXStaticText | 1680–1811, −904 | 16–42 | 11 | No | Stat captions |
| "Ôn tập (10)" tab | AXButton | 1380 | −867 | 369 | 35 | Yes | Starts review session (OBSERVED) |
| "Flow Letter" tab | AXButton | 1762 | −867 | 369 | 35 | Yes | Deck mini-game (not explored) |
| "Deck Progress" + "10 cards" | AXStaticText | 1380 / 2088, −807 | 75 / 43 | 13 | No | Section header |
| "Newest" | AXPopUpButton | 1380 | −746 | 66 | 23 | Yes | Sort |
| "Filters" | AXPopUpButton | 2075 | −746 | 56 | 23 | Yes | Filter |
| Word rows ×8 (Guava, Blitz, Melon, Flabby, Watermelons, Bakes, Waffles, Caramelized) | text rows | 1392, −697…−110 | — | — | No | word 16pt frame, definition 13pt, IPA 7pt |
| "MỚI" status badge | AXStaticText | 2098, per row | 15 | 8 | No | Per-row NEW badge |
| Speaker (`speaker.wave.2.fill`) | AXButton | 2058, per row | 27 | 23 | Yes | Audio |
| Trash (`trash.fill`) | AXImage | 2147, per row | 13 | 14 | Yes | Delete card (destructive — not exercised) |
| "Tìm Kiếm" (`magnifyingglass`) | AXButton | 2104 | −128 | 27 | 27 | Yes | Search |

- Row pitch ≈ 87 (y −701, −614, −528, −441, −355, −277, −191, −113). MEASURED.
- Word list group 768×631. Scroll content 788×1270. MEASURED.

## S014 `srs-review-session--tutorial` — review with gesture tutorial

Snapshot `ps1_af9281eb40e0c1d1415566edcd0e9396`, screenshot [S014-srs-gesture-tutorial-overlay.png](../screenshots/S014-srs-gesture-tutorial-overlay.png). Reached by pressing "Ôn tập (10)" (OBSERVED).

Full-screen session (Đóng xmark top-left, Thêm top-right; no nav bar):
- "Cơ chế học thông minh" (187×21) + "Vuốt thẻ bài để đánh giá mức độ ghi nhớ của bạn" — tutorial title/subtitle. OBSERVED.
- Four gesture explainer rows (icon 27×27 + bold label + caption 13pt):
  - left arrow circle → "Quên bài" / "Vuốt trái để Gramify sắp xếp học lại ngay"
  - down arrow circle → "Hơi khó nhớ" / "Vuốt xuống nếu bạn thấy từ này còn lạ lẫm"
  - up arrow circle → "Đã nhớ" / "Vuốt lên khi bạn trả lời đúng nghĩa và phát âm"
  - right arrow circle → "Quá dễ" / "Vuốt phải để ít gặp lại từ này hơn"
- Stacked flip cards behind (3 visible, "CHẠM ĐỂ LẬT" = tap to flip), words Molding / Sweetener / Caramelized, IPA, POS tags (VERB/NOUN).
- Interval buttons (49×77): "1m Học lại", "6m Khó", "1d Tốt", "4d Dễ" at x 1634/1699/1763/1828, y −204. MEASURED.
- CTA "Đã hiểu, bắt đầu học" 170×40 at (1671,−169). OBSERVED.

## S015 `srs-review-session--active`

Snapshot `ps1_5b2b774ec152f68bfd09a5ae1ea1baa9`, screenshot [S015-srs-card-front-inactive.png](../screenshots/S015-srs-card-front-inactive.png). After "Đã hiểu, bắt đầu học" (OBSERVED).

- Tutorial rows gone; card stack remains (3 cards: Molding behind, Sweetener, Caramelized front — front card shows word 25–29pt, POS tag, IPA, "CHẠM ĐỂ LẬT").
- Top-right mini list of remaining words (Molding/Sweetener/Caramelized, small).
- Interval buttons unchanged. MEASURED.

## Actions observed/inferred

| Action | Result | Tag |
|---|---|---|
| Menu → Học flashcard | S012 | OBSERVED |
| Deck card → S013 | OBSERVED |
| "Ôn tập (10)" → S014 | OBSERVED |
| "Đã hiểu, bắt đầu học" → S015 | OBSERVED |
| Card tap → flip (reveal answer) | INFERRED, not exercised |
| Swipe gestures / interval buttons → grade card, advance SRS schedule | INFERRED, not exercised (mutates study data) |
| Session "Đóng" → back to S013, **no confirmation dialog** | OBSERVED |
| S013 Back → S012; S012 Back → Home | OBSERVED |
| Trash per word row | DESTRUCTIVE, not exercised |
| "Thêm", "Filters", "Newest", search, "Flow Letter" tab | Not explored |

## Notes
- Exit asymmetry: writing editor warns on exit (S007 dialog), SRS session does not. OBSERVED.
- The SRS intervals (1m/6m/1d/4d) and gesture grading (forgot/hard/remembered/easy) define the review algorithm's user-facing surface. OBSERVED.
- Deck stats show 10 new / 0 learning / 0 review — matches the fresh test account. OBSERVED.
