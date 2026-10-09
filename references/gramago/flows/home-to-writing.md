# Flow: Home → Writing (LUYỆN VIẾT) → Feedback

Status: **partial**. Explored down to the first AI feedback sheet. Everything after the feedback sheet is unexplored.
Captured 2026-10-08. Tags: OBSERVED (AX tree or screenshot), INFERRED (reasoning).

## Path

```
S001 Home
  → press "01, LUYỆN VIẾT, Đoạn văn…" card
S002 Writing Topic Picker "Viết nên câu chuyện"
  → press topic card "Kỳ quan thiên nhiên, 14 Sets"
S003 Writing Lesson List "Bài học"
  → press "Bắt đầu" on lesson 01 "Khám phá Cổng địa ngục"
S004 Writing Exercise Editor (empty)
  → type answer
S005 Writing Exercise Editor (filled)
  → press "Chuyển Tiếp" (submit)
S006 Writing Feedback Sheet ("Chưa đúng")
  → [not explored] Edit / Next / dismiss / thumbs / word lookup
```

## Transitions

| # | FROM | ACTION | TARGET | TO | OBSERVED RESULT |
|---|---|---|---|---|---|
| 1 | S001 (`ps1_a2a7de19…`, state verified by `inspect_ui` first) | Click, AX `elem_26` | Card "01, LUYỆN VIẾT, Đoạn văn, Rèn luyện dịch và viết các đoạn văn., KHÁM PHÁ", 670×385 | S002 | Tool reported unconfirmed. Inspect then showed Back, AI, hero "Viết nên câu chuyện", 19 chips, 12 cards. S002 screenshot saved after verification. Not retried. |
| 2 | S002 (`ps1_50ec60bf…`) | Click, AX `elem_37` | Topic card "Kỳ quan thiên nhiên, 14 Sets", 371×123 | S003 | Unconfirmed. Inspect showed nav title "Bài học", hero "BỘ SƯU TẬP / Kỳ quan thiên nhiên", level pill "CẤP ĐỘ A1", lesson rail, "Bắt đầu" buttons. Not retried. |
| 3 | S003 (`ps1_9e01dd47…`) | Click, AX `elem_25` | "Bắt đầu" on lesson 01, 89×35 | S004 | Unconfirmed. Inspect showed a Vietnamese source paragraph, a settable "text entry area", undo/submit disabled, "Đóng" close and a "Thêm" menu. No Back button. |
| 4 | S004 | Type "I went to the gym yesterday." | Answer area (settable AXTextArea) | S005 | Background `type` on the element failed (no writable AXFocused). A fresh-snapshot focus-point attempt was refused ("background pixel focus unavailable"). A foreground-app attempt failed to find the window. A foreground `type` with `window_id=3957` reported failure, but the text did land. The answer area held "I ưent to the gym yếtrday." (Vietnamese input-source substitution: `w`→`ư`, `s`→`ế`). Submit "Chuyển Tiếp" became actionable. |
| 5 | S005 (`ps1_a8f66d64…`) | Click, AX `elem_14` | "Chuyển Tiếp" submit, 26×26 | S006 | Unconfirmed. First `see` returned "AX tree incomplete" (sheet animating). The single retry showed a half-screen sheet: "Chưa đúng", corrected-text spans, explanation, key improvements, Edit/Next, thumbs. |

## Observations

| Observation | Tag |
|---|---|
| Every click returned "unconfirmed" yet landed (5 of 5 so far) | OBSERVED |
| The "Dành cho bạn" grid differs between visits to S002 (first visit had "Quy tắc ứng xử", second had "Kỳ quan thiên nhiên"), so its contents are randomized or rotating | OBSERVED |
| The Home card is labelled "Đoạn văn" (paragraphs) but the destination is "Viết nên câu chuyện" (story), and the exercise is a paragraph translation | OBSERVED |
| The floating bottom bar from Home appears on none of S002–S006 | OBSERVED |
| Navigation chrome changes along the path: S002 SwiftUI nav bar with Back + "AI"; S003 nav bar with Back + centered "Bài học"; S004 no nav bar, "Đóng" + "Thêm"; S006 bottom sheet | OBSERVED |
| No paywall, purchase prompt or login appeared | OBSERVED |
| Animation, duration and timing of every transition were not captured | not observed |

## Not explored

- S006 → "Edit", sheet dismissal, thumbs rating, word-lookup popover.
- S004 "Thêm" menu and the VI↔EN swap icon.
- S003 level pill "CẤP ĐỘ A1" and horizontal scrolling of the lesson rail.
- A correct answer (verdict, score, celebration) and exercise completion — **unreachable by automation**: background/foreground paste into the editor is refused, and typed English is corrupted by the active Vietnamese input source. See editor Notes.
- S002 category filters, AI button.

## Post-script: "Next" on the feedback sheet (2026-10-08)

FROM S006, ACTION click "Next" (200×38), TO the same editor as S004 with the answer cleared: placeholder visible, submit disabled again, but "Hoàn Tác" (undo) now actionable and the bottom-center group 304×28 instead of 374×28. So "Next" after an incorrect verdict reopens the same exercise rather than advancing to lesson 02. OBSERVED. (Whether "Next" advances on a correct verdict is unknown.)
