# Writing Feedback Sheet (AI correction)

> **Corrected 2026-10-09:** (C07) the sheet is a floating card, all four corners rounded, **not** bottom-attached, and the page behind it is not dimmed. (C08) wrong words are **struck through** (red), reference words are pale-green chips — not underlined. S006 is an **inactive-window** capture: colours are CANDIDATE.

State ID: `S006 writing-feedback-sheet--incorrect`
Source: snapshot `ps1_8083d36b6dc12c589039274089fb8360`, 2026-10-08, first `see` attempt hit an incomplete AX read and was retried once (per Peekaboo's own guidance), second attempt succeeded.
Screenshot: [S006-writing-feedback-sheet-incorrect.png](../screenshots/S006-writing-feedback-sheet-incorrect.png).

Tags: OBSERVED / MEASURED / ESTIMATED / INFERRED. Local = global − (1362, −1174).

## Identity

| Field | Value | Tag |
|---|---|---|
| Reached from | S005, pressing "Chuyển Tiếp" (submit) | OBSERVED |
| Presentation | **Half-screen sheet** attached to the bottom of the window: a "Sheet Grabber" handle (value "Half screen", help "Double tap to dismiss sheet") and two `PopoverDismissRegion` groups behind it | OBSERVED |
| Verdict | "Chưa đúng" ("Not correct") — header verdict; other verdicts (correct/partial) exist but were not seen | OBSERVED one variant |
| Feedback engine | AI-generated: explanation text discusses meaning, spelling, and scoring of the specific submission | INFERRED from content |

## Hierarchy

```
Behind sheet: the editor (S005) with two PopoverDismissRegion groups covering the screen (tap-to-dismiss, per AX identifier)
Sheet (content group 170,431, 446×458)
├─ Grabber handle (355,428, 77×18)
├─ Header: "Đóng" xmark.circle.fill (191,452, 25×25) + verdict "Chưa đúng" (228,455, 86×20)
├─ "SỬA LỖI" (216,509, 35×8) + hint "Chạm từ để tra cứu" (518,509, 68×8)
├─ Corrected text, word-by-word spans (y 527–546+): user's words then reference words
├─ "GIẢI THÍCH" (189,597, 56×8)
├─ Explanation paragraph (189,610, 403×110)
├─ "KEY IMPROVEMENTS" (189,735, 100×8) + 4 bullets (y 751–827)
├─ "Edit" (189,765, 200×38) + "Next" (398,765, 200×38) buttons
└─ "Thích" / "Không Thích" thumbs (370/401, 854, 16×17)
```

## Elements

| Label | Role | Global x | y | w | h | Interactive |
|---|---|---|---|---|---|---|
| Sheet Grabber | AXButton | 1717 | −746 | 77 | 18 | Yes (dismiss) |
| "Đóng" (`xmark.circle.fill`) | AXButton | 1553 | −722 | 25 | 25 | Yes |
| "Chưa đúng" (verdict) | AXStaticText | 1590 | −719 | 86 | 20 | No |
| "SỬA LỖI" | AXStaticText | 1578 | −665 | 35 | 8 | No |
| "Chạm từ để tra cứu" | AXStaticText | 1880 | −665 | 68 | 8 | No |
| Word spans "I" "ưent" "to" "the" "gym" "yếtrday" "." | AXStaticText ×7 | 1563–1752 | −647 | 10–50 | 19 | No (tap-to-lookup INFERRED) |
| Reference words "Turkmenistan" "is" "a" "country" "with" "many" "interesting" "places" "." | AXStaticText ×9 | 1563–1826 | −624/-647 | 13–91 | 19 | No |
| "GIẢI THÍCH" | AXStaticText | 1551 | −577 | 56 | 8 | No |
| Explanation (full AI text) | AXStaticText | 1551 | −564 | 403 | 110 | No |
| "KEY IMPROVEMENTS" | AXStaticText | 1551 | −439 | 100 | 8 | No |
| 4 improvement bullets | AXStaticText ×4 | 1562 | −423/−402/−381/−360 | 170–266 | 13 | No |
| "Edit" | AXButton | 1551 | −409 | 200 | 38 | Yes |
| "Next" | AXButton | 1760 | −409 | 200 | 38 | Yes |
| "Thích" (`hand.thumbsup`) | AXButton | 1732 | −320 | 16 | 17 | Yes |
| "Không Thích" (`hand.thumbsdown`) | AXButton | 1763 | −320 | 16 | 17 | Yes |

Explanation text (OBSERVED, verbatim): "Câu dịch của bạn chưa đúng với yêu cầu vì nội dung bị lệch hoàn toàn so với câu cần dịch. Bạn viết về việc đi đến phòng gym hôm qua, trong khi câu cần diễn tả là về một quốc gia có nhiều địa điểm thú vị. Ngoài ra, trong câu của bạn còn có lỗi chính tả ở “ưent” và “yếtrday”, đúng phải là “went” và “yesterday”. Nếu chỉ xét ngữ pháp tiếng Anh thì câu gốc bạn viết khá gần đúng, nhưng do sai nghĩa nên điểm bị trừ nhiều. Bạn nên đọc kỹ câu nguồn trước khi dịch để tránh lạc đề."

Improvement bullets (OBSERVED): "Đọc kỹ câu nguồn trước khi dịch" · "Chú ý lỗi chính tả của động từ và trạng từ thời gian" · "Giữ đúng chủ đề, không tự đổi nội dung" · "Kiểm tra lại nghĩa tổng thể của câu sau khi viết".

## Visual Design

| Observation | Tag |
|---|---|
| Sheet occupies the lower ~half of the window, rounded top corners, grabber handle centered | OBSERVED |
| Verdict "Chưa đúng" in red | OBSERVED (screenshot) |
| User's wrong words underlined red ("ưent", "yếtrday"), reference translation words in green | OBSERVED (screenshot) |
| Text rendered as per-word spans — enables tap-to-lookup ("Chạm từ để tra cứu") | OBSERVED structure |
| Edit/Next: two equal side-by-side filled buttons 200×38 (≈ 12 pt gap, 19 pt side margins) | MEASURED |
| Thumbs rating icons small (16×17), grey, centred below buttons | OBSERVED / MEASURED |
| Section micro-labels same style as elsewhere: all caps, ~8–9 pt frames, grey | OBSERVED |

## States

| State | Status |
|---|---|
| Verdict "Chưa đúng" (incorrect) | Captured (S006) |
| Verdict correct/partial, score display | Not seen |
| Thumbs selected | Not seen |
| Word lookup popover | Not seen |
| Sheet expanded from half to full | Not seen |

## Actions

| Element | Action | Destination | Tag |
|---|---|---|---|
| "Edit" | Press | Back to editor with text retained | INFERRED, not exercised |
| "Next" | Press | Next lesson's editor or lesson-complete | INFERRED, not exercised |
| Grabber / dismiss region / "Đóng" | Press | Dismiss sheet, back to editor | INFERRED, not exercised |
| Thumbs | Press | Rate the feedback (toggle state) | INFERRED, not exercised |
| Word span | Press | Dictionary lookup popover | INFERRED, not exercised |

## Notes

- **Position inconsistency in the AX capture:** the "Edit"/"Next" bounds (y −409, spanning local 765–803) overlap the improvement-bullet frames (local 751–827) although the screenshot shows bullets above the buttons. One of the two is likely a stale frame captured mid-sheet-animation. Treat Edit/Next geometry as unverified; the screenshot is authoritative. OBSERVED discrepancy.
- The first post-submit `see` returned an incomplete AX read (transient sheet) and succeeded on the single permitted retry — consistent with the sheet still animating.
- No explicit loading state was captured between submit and feedback; grading appeared instant on this run. (OBSERVED absence.)
- No score/percentage element appeared for this incorrect verdict; whether scores appear for better answers is unknown. INFERRED possibility.
