# Flow Letter (mini-game) — S034–S042

> **Added 2026-10-09 (N2):** a deck-source round exists — [S054](../screenshots/S037-flowletter-deck-gameplay-active.png): deck "Nấu ăn & Ẩm thực", LEVEL 1, **1/10**, purple. The topic-source round (S037, Nature) is 1/30; round length depends on the source (UNKNOWN beyond that).

Captured 2026-10-08. Entered from Home → Menu → "Chơi FlowLetter" (S011). The Home below-fold "Flow Letter / Thử ngay" card and S013 "Flow Letter" tab were **not** used; they are INFERRED to reach the same screen.
Tags: OBSERVED / MEASURED / ESTIMATED / INFERRED. Colours are pixel samples at the stated corner or point (the backgrounds are gradients, so a sample is a point, not a token).

The whole game is a **separate visual world**: full-bleed blurred gradient backgrounds, translucent "glass" controls, white type, no nav bar, round translucent corner buttons. It shares nothing with the light, flat main app except the type family. OBSERVED.

## States

| ID | State | Background (TL / centre / BR sample) | Screenshot |
|---|---|---|---|
| S034 | Tutorial overlay over lobby | magenta-maroon #954F78 / #904970 / #3B393A | [S034](../screenshots/S034-flowletter-tutorial-overlay.png) |
| S035 | Lobby (first visit) | pink→maroon #BB438D / #68294D / #29111F | [S035](../screenshots/S035-flowletter-lobby.png) |
| S036 | Topic select "Chọn chủ đề" | pink #B84F8C / #953F71 / #010001 | [S036](../screenshots/S036-flowletter-topic-select.png) |
| S037 | Gameplay (topic Nature) | green #7EAB49 / #719B3E / #000100 | [S037](../screenshots/S037-flowletter-gameplay-nature.png) |
| S039 | Lobby with resume row | same as S035 | [S039](../screenshots/S039-flowletter-lobby-resume.png) |
| S040 | Difficulty "Độ khó" | purple #6326AE / #3C1082 / #000001 | [S040](../screenshots/S040-flowletter-difficulty-select-screen.png) |
| S041 | Game settings "Cài đặt" | blue #405DB6 / #213787 / #000102 | [S041](../screenshots/S041-flowletter-settings.png) |
| S042 | Help guide "Hướng dẫn" | purple #6326AE / #3E1189 / #000001 | [S042](../screenshots/S042-flowletter-help-guide.png) |

S038 is intentionally unused: a capture after tapping "Gợi ý" looked identical to S037 and was discarded. Background hue is **per screen**: pink = lobby/topics, green = a Nature round, purple = difficulty/help, blue = settings. A per-topic hue for other topics is INFERRED, not seen.

## Flow

```
Home → Menu → "Chơi FlowLetter" → S034 tutorial overlay --"Chạm để bắt đầu"--> S035 lobby
S035 --"Chơi"--> S036 topic select --topic card--> S037 gameplay --Quay Lại--> S036 --Quay Lại--> S039 lobby(+resume)
S035/S039 --"Độ khó"--> S040 --Quay Lại--> lobby        S035/S039 --"Cài đặt"--> S041 --Quay Lại--> lobby
S035/S039 --"?" (Dấu Chấm Hỏi)--> S042 --Quay Lại--> lobby
lobby --"Đóng" (✕)--> Home (no confirm dialog)
```
All edges OBSERVED. Leaving a started round (S037 → Back) returns to the **topic list**, and the lobby then shows **"Tiếp tục Nature · 1/30"** (S039). After "Back" from S036 the lobby showed **no** tutorial overlay. Whether the overlay returns when re-entering from Home was not tested, so "first-entry only" is INFERRED, not observed.

## S034 tutorial overlay

The overlay is a single full-window button ("Chạm để bắt đầu" at the bottom). Centre: title "Cách chơi Flow Letter", sub "Sử dụng các cử chỉ sau để chơi game", four rows (icon, bold title, grey caption): **Di chuyển chữ** (Kéo thả chữ cái để đổi vị trí) · **Xem gợi ý** (Nhấn giữ để xem nghĩa từ) · **Bỏ qua từ** (Vuốt lên để chuyển từ tiếp theo) · **Xoay màn hình** (Xoay ngang để dễ chơi hơn). The lobby elements stay in the AX tree beneath it. OBSERVED.

## S035/S039 lobby

- Top-left round **✕ Đóng**, top-right round **? Dấu Chấm Hỏi** (both translucent pink, ≈ 33–34 pt). OBSERVED.
- Logo: glass letter tiles spelling **FLOW** / **LETTER** (rounded squares ≈ 40×40, white bold letters, translucent fill). Tagline "Xếp chữ cái thành từ vựng"; hint line "↻ Trải nghiệm tốt hơn khi xoay điện thoại" (phone-oriented copy). OBSERVED.
- **Stats card** (glass): "Level 1" bold · "XP tổng: 0" · right: "Best 0" in gold, "Combo x0" · divider · "Lần chơi: 0" and "Bắt đầu session đầu tiên" (first-session prompt). OBSERVED.
- S039 inserts a glass row **"↻ Tiếp tục Nature … 1/30"** under the stats card; the logo block and the card shift ≈ 22 pt up/down to make room (logo tile row at y ≈ 318 vs ≈ 340). The stats card still says "Lần chơi: 0 / Bắt đầu session đầu tiên", i.e. an unfinished round is not counted. OBSERVED / INFERRED (not counted).
- Three full-width glass pill buttons (≈ 725×38, radius = pill): **▶ Chơi**, **◔ Độ khó**, **⚙ Cài đặt**; bottom-centre small pill **"⤢ Xoay"** (rotate/orientation). OBSERVED.

## S036 topic select

Back (round pink), title "Chọn chủ đề", sub "Độ khó: Vừa" (current difficulty echoed). 2-column glass-card grid (7 rows, cards ≈ 370×93, gap ≈ 14), icon top-left + label bottom-left: **Ngẫu nhiên** (dice; the only Vietnamese label), Education, Nature, Business, Fashion, Tech, Sport, Travel, Politics, Health, Food, Emotions, Animals, Art = **14 topics**. Card brightness follows a diagonal gradient (brightest top-left, near-black bottom-right), a property of the shared background, not of each card. The AX order of the cards differed between two reads; cause unknown. OBSERVED.

## S037 gameplay (Nature, Level 1)

- Top: round Back, centred "LEVEL 1" over "Nature", right pill **"1/30"** (word progress), a centred pill "★ 0" (score) under them. OBSERVED.
- Just under the header a letter-spaced ghost line **"WNSLLEO"** (the scramble in caps). Centre: a row of 7 glass letter tiles **W N S L L E O** (≈ 40×44, fill ≈ #88C14B at 15–25 % white, white bold letters) — the same scramble; the target word is inferred to be "swollen". OBSERVED / INFERRED (target word).
- Bottom: a progress ticker (12 tick marks, the 8th taller/white) above three glass pills **💡 Gợi ý · ⤢ Xoay · → Bỏ qua**, and the **Vietnamese definition** of the target word in bold white: "đã sưng (dạng quá khứ phân từ)" (the clue is a Vietnamese gloss, not an English definition). OBSERVED.
- Tapping "Gợi ý" produced no visible change in the capture; the gloss was already visible, so the hint is presumably the tap-and-hold word-meaning peek described in the tutorial (not tested). OBSERVED / INFERRED.
- **Not tested**: dragging tiles (cannot be driven by background accessibility clicks), solving a word, combo/XP counters, level-up, game over / session result, the "Xoay"/"Bỏ qua" outcomes.

## S040 difficulty, S041 settings, S042 help

- **S040**: round-rect Back (≈ 33×33, *rounded square*, unlike other round buttons), title "Độ khó", three glass radio rows **Dễ / Vừa / Khó**; "Vừa" selected (white filled check circle at the right, ≈ 16 pt). Rows sit vertically centred in the screen (y ≈ 530–670); the top half is empty gradient. Not changed. OBSERVED.
- **S041**: same chrome, title "Cài đặt", two glass toggle rows **🔊 Âm thanh** and **📱 Rung phản hồi**, both on; toggle "on" green = #2CB782 (same green as the CEFR confirm button, S044). Not changed. OBSERVED / MEASURED.
- **S042**: title "Hướng dẫn", FLOW tiles, "Cách chơi Flow Letter", numbered steps in glass panels: **1 Mục tiêu** ("Sắp xếp các chữ cái thành từ vựng đúng"; demo C A T → C A T with green-outlined result tiles) · **2 Cách di chuyển** ("Kéo thả chữ cái để đổi vị trí"; C A T tiles + a "Nhấn để xem" capsule) · **3 Hoàn thành** ("Đúng từ sẽ tự động chuyển sang từ tiếp theo"; D O G in white-outlined tiles); then **"Mẹo hay"** with three tips (rotate landscape; pick a suitable difficulty; read the hint to guess faster). The help copy says "Nhấn để xem" where the tutorial says "Nhấn giữ". OBSERVED.

## Side effects of the crawl

One round was started (Nature, 1/30) and left, so the lobby now offers "Tiếp tục Nature". Difficulty and settings were not changed.
