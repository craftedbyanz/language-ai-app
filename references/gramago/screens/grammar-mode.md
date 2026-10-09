# Grammar Mode (NGỮ PHÁP) — S008, S009, S010

Grammar branch of Home mode card 02. Screens mirror the writing branch's templates with mode-specific copy; deltas are documented here.
Tags: OBSERVED / MEASURED / ESTIMATED / INFERRED. Local = global − (1362, −1174).

## S008 `grammar-topic-picker--default` — "Hoàn thiện ngữ pháp"

Source: snapshot `ps1_78ef6a642f3d45b27de296b0c943b600`, screenshot [S008-grammar-topic-picker.png](../screenshots/S008-grammar-topic-picker.png). Reached from Home card 02 (OBSERVED).

| Field | Writing (S002) | Grammar (S008) |
|---|---|---|
| Hero | "Viết nên / câu chuyện" | "Hoàn thiện / ngữ pháp" (145×39 + 130×39) |
| Grid | 12 cards, "N Sets" | 13 cards, "N **Qs**" (5 Qs each) |
| First grid item | topic card | **PLUS upsell tile**: "PLUS, Chế độ Vô tận, Học tập không ngừng" (371×123, same tile geometry) |
| Chips, nav bar, "CHỦ ĐỀ CỦA BẠN / count" | same | same (13 chủ đề) |

- Everything else (nav bar Back+AI, 19-chip rail, margins 18/19, tile 371×123, gaps 9) is identical to S002. MEASURED.
- The grid **inserts a Plus upsell tile as the first item** — paywall-adjacent marketing inside the content grid. OBSERVED. Not clicked (paywall boundary).
- Screenshot shows a warm/orange accent theme for this mode. OBSERVED (visual).

## S009 `grammar-lesson-list--default` — "Bài học" (grammar variant)

Source: snapshot `ps1_a5691914e990a0a80df6ff2deef299e9`, screenshot [S009-grammar-lesson-list.png](../screenshots/S009-grammar-lesson-list.png). Reached from S008 topic card "Lên thực đơn cả tuần, 5 Qs" (OBSERVED).

Same template as S003 (nav "Bài học", centered hero "BỘ SƯU TẬP / Lên thực đơn cả tuần", "CẤP ĐỘ A1" pill, lesson rail). Deltas (OBSERVED / MEASURED):
- CTA copy: **"Sửa nhanh"** (quick fix) instead of "Bắt đầu". Buttons 103×35 / 95×32.
- Illustrations: SF Symbols `calendar.badge.plus` (136×124), `refrigerator.fill` (80×106), `cart.fill` (113×103).
- Rail 3605×369 → 5 lesson cards ("5 Qs" = 5 questions). MEASURED.

## S010 `grammar-exercise-editor--empty` — sentence exercise

Source: snapshot `ps1_011cbfcc6ee989edd80c2bcc494a5dd8`, screenshot [S010-grammar-editor-empty.png](../screenshots/S010-grammar-editor-empty.png). Reached from S009 "Sửa nhanh" (OBSERVED).

Same editor shell as S004 (Đóng + Thêm top bar, undo/submit bottom bar disabled, swap icon 14×14). Deltas (OBSERVED / MEASURED):
- Prompt is a **single sentence**, not a paragraph: "Tôi cần lên kế hoạch ăn uống cho tuần tới." at (216,303, 354×21) — compact text, no large source card.
- Placeholder: "Nhập câu trả lời..." (enter your answer) at (328,770, 130×20).
- Entry area 763×460 at (12,570). Bottom-center group 272×28 (smaller than writing's 374×28).
- No lesson micro-label visible in AX (the writing editor had "EXPLORING THE DOOR TO HELL").

## States, actions, findings

| Finding | Tag |
|---|---|
| Exit from either editor (writing or grammar) opens the same confirm dialog (S007) | OBSERVED |
| "Thoát" returns to the lesson list; backtracking S010→S009→S008→Home works via Back | OBSERVED |
| Grammar topics/lessons also reshuffle between visits (dynamic ordering, like writing) | OBSERVED |
| Submitting a grammar answer (feedback variant) | NOT REACHED (text input blocked; see writing-exercise-editor Notes) |
| PLUS tile, category chips, level pill on this branch | Not explored |

## Notes
- The three modes share one picker template, one lesson-list template and one editor shell; only copy, counts (Sets/Qs), CTA labels and artwork differ. This is the strongest template-reuse evidence in the app. OBSERVED pattern.
