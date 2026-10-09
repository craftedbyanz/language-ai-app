# Writing Exercise Editor (translation)

> **Corrected 2026-10-09:** (C09) submit-enabled **is a dark filled circle** in an active window ([S005 active](../screenshots/S005-writing-exercise-editor-filled-submit-enabled-active.png)); the grey reading came from inactive captures. (C03) "Next" after an incorrect verdict **advances to step 2** (2nd progress segment + 2nd sentence highlighted), it does not retry the same exercise (see [step-2 capture](../screenshots/S004-writing-editor-step2-modal-dimmed-alert-absent.png)). (C10) the bottom-centre group is a row of 5 blurred hint chips; progress is the top 10-segment bar. The "Thêm" menu is rendered in S051; the exit alert in S007.

State IDs: `S004 writing-exercise-editor--empty` and `S005 writing-exercise-editor--filled`.
Source: snapshots `ps1_bc463f0326e7f3b9d551ab4752a78f79`, `ps1_6c599dd468fa9dec262daddc21b74283`, `ps1_7acd9a156eb5574c0d02fafc89afcf1c`, `ps1_4c2d0ae070a791dd8fe871dde2c01ddf`, `ps1_a8f66d6478cc0d3ea7d89ac65e6ffc35`, 2026-10-08.
Screenshots: [S004 (empty)](../screenshots/S004-writing-exercise-editor-empty-inactive-original.png), [S005 (filled)](../screenshots/S005-writing-exercise-editor-filled-inactive-original.png).

Tags: OBSERVED / MEASURED / ESTIMATED / INFERRED. Local = global − (1362, −1174).

## Identity

| Field | Value | Tag |
|---|---|---|
| Reached from | S003, "Bắt đầu" on lesson 01 "Khám phá Cổng địa ngục" | OBSERVED |
| Replaces nav bar | No Back button; a "Đóng" (close, `xmark`) button instead, and no SwiftUI "Nav bar" group. Whether this is a full-screen cover or a pushed view is not known | OBSERVED / INFERRED |
| Lesson title | "EXPLORING THE DOOR TO HELL" (English, all caps micro-label) | OBSERVED |
| Task | Translate the Vietnamese source paragraph into English; answer area placeholder "Nhập bản dịch của bạn..." | OBSERVED |
| Full source text | "Turkmenistan là một quốc gia có nhiều địa điểm thú vị. Một địa điểm nổi tiếng là hố khí gas Darvaza. Mọi người cũng gọi nơi này là Cổng Địa Ngục. Nó là một cái hố lớn có lửa bên trong. Ngọn lửa cháy mỗi ngày và mỗi đêm. Nó trông rất sáng giữa sa mạc tối tăm. Nhiều khách du lịch đến xem những ngọn lửa màu cam. Họ chụp những bức ảnh đẹp về chiếc hố nóng rực. Bạn có thể cắm trại gần ngọn lửa cùng bạn bè. Đây là một trải nghiệm du lịch rất đặc biệt." | OBSERVED (AX value) |

## Hierarchy

```
Top bar: "Đóng" xmark (19,58, 16×14) left · "Thêm" pop-up (745,49, 30×30) right
Micro-label "EXPLORING THE DOOR TO HELL" (330,86, 127×7, centered)
Source paragraph  AXTextArea read-only (27,119, 733×429)
Language swap icon `arrow.trianglehead.swap` (386,560, 14×14, centered)
Answer area  AXTextArea settable (12,570, 763×460)
   empty: placeholder "Nhập bản dịch của bạn..." (308,791, 170×18)
   filled: typed text + insertion caret
Bottom bar: "Hoàn Tác" undo (18,1047, 33×26) left · center group (61,1046, 374×28) · "Chuyển Tiếp" submit (743,1047, 26×26) right
```

## Elements

| Label | Role | Global x | y | w | h | Interactive | Notes |
|---|---|---|---|---|---|---|---|
| "Đóng" (`xmark`) | AXButton | 1381 | −1116 | 16 | 14 | Yes | Closes exercise |
| "Thêm" | AXPopUpButton | 2107 | −1125 | 30 | 30 | Yes | Pop-up menu, items unknown |
| "EXPLORING THE DOOR TO HELL" | AXStaticText | 1692 | −1088 | 127 | 7 | No | Frame only 7 pt tall |
| Source text | AXTextArea | 1389 | −1055 | 733 | 429 | Read-only | Full text in AX value |
| Swap icon | AXImage | 1748 | −614 | 14 | 14 | Actionable | VI↔EN hint (INFERRED) |
| Answer area | AXTextArea | 1374 | −604 | 763 | 460 | Settable | Empty (S004) / filled (S005) |
| "Nhập bản dịch của bạn..." | AXStaticText | 1670 | −383 | 170 | 18 | No | Placeholder, disappears when filled |
| "Hoàn Tác" (`arrow.uturn.backward`) | AXButton | 1380 | −127 | 33 | 26 | No while empty; No after typing | Undo, never became actionable |
| "Chuyển Tiếp" (`chevron.right`) | AXButton | 2105 | −127 | 26 | 26 | No while empty; Yes when filled | Submit/grade |
| Bottom-center group | AXGroup | 1423 | −128 | 374 | 28 | No | Contents not exposed; screenshot shows a segmented pill row (ESTIMATED: word counter/progress) |

## States

| State | Evidence |
|---|---|
| **S004 empty** — placeholder shown, undo and submit non-actionable (disabled) | OBSERVED |
| **S005 filled** — answer contains text, caret at end, submit becomes actionable (enabled, filled dark in screenshot), placeholder gone | OBSERVED |
| Focused vs unfocused, keyboard-visible | Not separately captured (macOS window; no on-screen keyboard) |
| Loading during grading | Not separately captured (grading was instant or the loading frame was missed) |

## Actions

| Element | Action | Destination | Tag |
|---|---|---|---|
| "Chuyển Tiếp" (when filled) | Press | AI feedback sheet (S006) | OBSERVED |
| "Đóng" | Press | Expected: close exercise, back to S003 | INFERRED, not exercised |
| "Thêm" pop-up | Open | Unknown menu | INFERRED, not exercised |
| Swap icon | Press | Swap translation direction? | INFERRED, not exercised |

## Visual Design

| Observation | Tag |
|---|---|
| Source paragraph inside a very light grey rounded card (≈ 20 pt radius), regular dark text, ~15 pt inner padding | OBSERVED / ESTIMATED |
| Answer area inside a white card with subtle border; placeholder grey centered | OBSERVED |
| Submit is a circular button; grey/disabled when empty, dark filled when enabled | OBSERVED |
| Undo is a plain icon button that stayed non-actionable even with text present | OBSERVED (odd; possibly disabled until edits exist) |
| Bottom bar floats over the answer card with blur | OBSERVED |
| 12 pt horizontal margins for answer card; source card inset 27/28 pt | MEASURED |

## States (additional, observed after feedback)

| State | Evidence |
|---|---|
| **Post-feedback retry** — after pressing "Next" on the feedback sheet (S006), the same editor reappears with the answer cleared (placeholder back, submit disabled), but "Hoàn Tác" (undo) becomes actionable and the bottom-center group is 304×28 instead of 374×28. Same screen as S004; recorded as a variant, not a new state ID. "Next" therefore does **not** advance to lesson 02 on an incorrect verdict (or it retries the same exercise) | OBSERVED |
| Correct-answer feedback variant | NOT REACHED. Blocked by input automation (see Notes) |

## Notes — automation findings

- **Every Peekaboo click so far returned "unconfirmed" (5 of 5 across both sessions), yet each one landed**; verify by capture, never retry blindly. OBSERVED pattern.
- **Background typing into the SwiftUI TextEditor failed** (no writable AXFocused attribute; background pixel focus refused). It required **foreground typing targeted at window_id 3957**; that returned "failed after focus" but the text did land. OBSERVED.
- The typed test sentence "I went to the gym yesterday." arrived as **"I ưent to the gym yếtrday."** — the active Vietnamese input source maps `w`→`ư` and `s`→`ế`. Automation artifact, not app behaviour. OBSERVED.
- **Input automation on the retry attempt (2026-10-08):** background text paste into the editor did not land (unconfirmed → observed empty). Foreground paste was refused ("Paste hotkey did not return a confirmed outcome"); the answer area stayed empty (verified by AX value). Because the Vietnamese input source also corrupts typed English, a correct answer could not be delivered, so the "correct" verdict variant of the feedback sheet is UNREACHED. OBSERVED.
- **Foreground focus attempts open a system search UI.** After the foreground typing/pasting attempts, AX captures list the macOS menu bar plus two elements with identifiers `_SC_SEARCH_FIELD` (search text field) and `_SC_RESULTS_TABLE` (search result) at the bottom-left of the display, at negative x / y≈1144 (a second display below the main one). They appeared in 3 consecutive captures while the app tree was otherwise normal, and disappear in clean captures (e.g. S005, S006). They were never interacted with. What they are and whether my focus attempts opened them is unknown. OBSERVED sighting / INFERRED link to foreground input.
- **Snapshot invalidation:** a failed `type` marks the active snapshot stale; a fresh `see`/`inspect_ui` is required before the next mutation attempt. OBSERVED (Peekaboo behaviour).
- The answer area is a single settable AXTextArea labelled "text entry area" (SwiftUI TextEditor).
