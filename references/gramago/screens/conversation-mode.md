# Conversation Mode (GIAO TIẾP) — S019–S032

> **Corrected 2026-10-09 (C01):** the statement that writing/grammar lesson cards use per-lesson gradients is wrong; all lesson cards are flat white with a mode-specific CTA (navy / lime / indigo). Conversation S019–S024 are inactive captures (structure only); S025–S032 are active.

Captured 2026-10-08 via the Peekaboo CLI (MCP server was down; see [../README.md](../README.md) Method). Window 788×1083 pt, screenshots are 1x so pixel = point.
Tags: OBSERVED (AX tree or screenshot) / MEASURED (pixel-sampled or pixel-walked from a 1x screenshot, ±1–2) / ESTIMATED (by eye) / INFERRED.

Same template chain as writing/grammar: Home card 03 → topic picker → lesson list → modal exercise. OBSERVED.

## States

| ID | State | Doc section | Screenshot |
|---|---|---|---|
| S019 | Topic picker + "Tùy chỉnh Bài học" coachmark | Picker | [S019](../screenshots/S019-conversation-topic-picker-customize-coachmark.png) |
| S020 | Topic picker (clean) | Picker | [S020](../screenshots/S020-conversation-topic-picker.png) |
| S021 | Lesson list "Bài học" | Lesson list | [S021](../screenshots/S021-conversation-lesson-list.png) |
| S022 | Chat, AI opening message | Chat | [S022](../screenshots/S022-conversation-chat-free-ai-opening.png) |
| S023 | Chat "Thêm" menu open | Chat | [S023](../screenshots/S023-conversation-chat-more-menu-open-popup-not-in-capture.png) (menu **not visible** in capture; AX only) |
| S024 | Chat, translation hidden | Chat | [S024](../screenshots/S024-conversation-chat-translation-hidden.png) |
| S025 | Composer filled, send enabled | Chat | [S025](../screenshots/S025-conversation-chat-composer-filled.png) |
| S026 | User bubble sent, AI typing | Chat | [S026](../screenshots/S026-conversation-chat-reply-loading.png) |
| S027 | AI reply + per-message score chip | Chat | [S027](../screenshots/S027-conversation-chat-reply-received.png) |
| S028 | Score chip popover — **blank render, unresolved** | Chat | [S028](../screenshots/S028-conversation-score-popover-blank-render.png) |
| S029 | AI scenario generator "CHỌN CHỦ ĐỀ" | AI generator | [S029](../screenshots/S029-conversation-ai-scenario-generator.png) |
| S030 | "Tạo Hội Thoại" create sheet (empty) | AI generator | [S030](../screenshots/S030-conversation-ai-create-dialog-empty.png) |
| S031 | Picker with customize FAB expanded | Customize | [S031](../screenshots/S031-conversation-picker-customize-fab-expanded.png) |
| S032 | "Hướng dẫn Cài đặt" info sheet | Customize | [S032](../screenshots/S032-conversation-customize-info-sheet.png) |

## Picker (S019/S020)

- Hero: eyebrow "CHẾ ĐỘ TẠO" + two-line title "Thực hành" (near-black) / "giao tiếp" (blue, sampled ≈ #567DF3). OBSERVED / MEASURED.
- Category rail "DANH MỤC": 11 chips in AX (Dành cho bạn, Vui chơi & Giải trí, Giao tiếp, Sức khỏe, Công việc, Ẩm thực, Sân bay & Khách sạn, Học tập & Nghiên cứu, Văn hóa & Phim ảnh, Mua sắm, Công nghệ); writing/grammar rails had 19. Selected chip = white fill + orange outline (≈ #F37A29). OBSERVED / MEASURED.
- "CHỦ ĐỀ CỦA BẠN" + counter "1 chủ đề"; **one** topic card "Mở rộng vốn từ tự nhiên · 1 Sets", sparkle icon in a circle, fill #EDEEEF, ≈ 329–371×122. Writing/grammar grids had 12–13 cards, so conversation content is far thinner. OBSERVED.
- Nav: Back (left) and an **"AI"** button (right, round, Apple-Intelligence-style glyph) that opens the scenario generator (S029). OBSERVED.
- Bottom-right round white **FAB** (sliders icon, ≈ 38×38, no AX label). Opens S031. OBSERVED.
- S019 coachmark: toast-style card at bottom, title "Tùy chỉnh Bài học", body "Chuyển đổi giữa Trò chuyện Tự do và Kịch bản. Điều chỉnh độ khó, giọng và số câu hỏi.", sliders icon, small round "Đóng" ✕. It sits left of the FAB. After "Đóng" it did not appear on the three later visits to this picker, so it is INFERRED to be a one-time first-run hint. Dismissing it changed persistent UI state. OBSERVED / INFERRED.

## Lesson list (S021)

- Nav title "Bài học"; eyebrow "BỘ SƯU TẬP"; title "Mở rộng vốn từ tự nhiên" with a blue period; centred description; level pill "CẤP ĐỘ A1 ⓘ" (AX button "CẤP ĐỘ, A1"; not tapped). OBSERVED.
- Carousel (2 pages, pager dots: active pill ≈ #475DE8, inactive grey):
  1. **Lesson card 01**: white (≈ 613×314 at x 88–700, y 254–571), corner radius ≈ 22–24 (ESTIMATED from pixel profile), title, grey description, faint chat-bubbles illustration bottom-right, ghost numeral "01", CTA **"Bắt đầu chat"** (indigo pill #485EE8, ≈ 115×35). OBSERVED / MEASURED.
  2. **AI card** peeking at the right edge (pale blue #E5EEFD): AX button "Tạo tình huống? / Nhập vai mọi tình huống với AI / Tạo tùy chỉnh" → opens S029. OBSERVED.
- The writing/grammar lesson cards used per-lesson gradients; this one is plain white with an indigo CTA. OBSERVED.

## Chat (S022–S028)

Modal full-screen exercise (no Back; "Đóng" ✕ top-left; "Thêm" ⋯ top-right in a circle), centred title = mode name **"Trò chuyện Tự do"** (Free chat). OBSERVED.

| Element | Detail | Tag |
|---|---|---|
| Topic line | ALL-CAPS micro text under the nav, tracking wide, grey ≈ #9AA0AB, two lines; shows the lesson description | OBSERVED / MEASURED |
| AI bubble | white, hairline border, left-aligned, max width ≈ 706 pt; English line (≈ 16–17 pt, #0B0F21) + Vietnamese translation underneath in italic grey (#676D7A) | OBSERVED / MEASURED |
| AI speaks first | opening line is generated and conversational ("Hey, good to see you! … what have you been up to lately?"); content is dynamic | OBSERVED / INFERRED (dynamic) |
| Composer | pill field "Nhập tin nhắn…" (white, ≈ 709×31) auto-focused on entry + round send button (disabled #D2D5DB with up-arrow; enabled #475DE8) | OBSERVED / MEASURED |
| User bubble | right-aligned, indigo #475DE8, white text, radius ≈ 12–15 | OBSERVED / MEASURED |
| Typing indicator | small grey capsule at left with three dots (one raised) shown while waiting for the reply | OBSERVED |
| Score chip | under the *user's* bubble, right-aligned capsule (fill #F3F4F6): red dot (#E8504B) + bold red **"58"** (#E84B46) + grey caption "• Câu đúng ngữ pháp nhưng chưa tự nhiên trong hội thoại." + chevron; whole chip is one AXButton | OBSERVED / MEASURED |

- Latency: reply arrived within ≈ 6–8 s of sending (typing indicator seen at ≈ 1 s). ESTIMATED.
- **Score semantics**: for "Hello, I am OK, thank you." the app showed 58 with the verdict "grammatically correct but not natural". Scale (0–100?) and the colour bands are INFERRED; only a red dot was seen. The AI reply does not wait for the score; the chip appeared with the reply.
- **"Thêm" menu (S023)**: AX menu with three items: "Ẩn bản dịch" (toggles to "Hiện bản dịch" once hidden), one item exposed only as "menu item disabled", and "Kết thúc bài làm" (End session — not pressed). The menu popup did not render into any capture. OBSERVED (AX).
- **Translation toggle (S024)**: hiding removes every Vietnamese line, leaving English only; bubbles shrink. Restored to the default afterwards. OBSERVED.
- **S028 score popover**: tapping the chip opened a white rounded panel 446×≈508 at x 171–617, y 304–811 with a soft shadow, but the **content never rendered** (window capture, area capture and native `screencapture` all blank for ≥ 15 s; AX tree incomplete). Contents UNKNOWN. Panel width 446 equals the S006 feedback sheet, so a shared container is INFERRED. `Escape` did not close it; a foreground click outside the panel did. OBSERVED / INFERRED.
- **Exit**: "Đóng" → the same alert as S007 ("Thoát bài tập?" / "Bạn chưa hoàn thành bài tập. Tiến độ sẽ không được lưu nếu bạn thoát bây giờ.", "Ở lại"/"Thoát"). "Thoát" returned to the lesson list S021. OBSERVED.
- During this crawl one test message was sent and the throwaway chat was then discarded via "Thoát" (see REVERSE_ENGINEERING_REPORT.md, Safety log).

## AI generator (S029/S030)

- Entered from the lesson-list AI card or the picker's "AI" button. Both open the same layout (S029 was captured from the AI card; the "MÔ TẢ CHỦ ĐỀ" → S030 step was taken from the picker's "AI" entry). OBSERVED.
- **S029** full-screen modal: eyebrow "TẠO BẰNG AI" / "CHỌN CHỦ ĐỀ" (top-left), ✕ close (top-right, outlined circle), vertical scrollbar at the right edge. The body is a **tall list/wheel**: the centred selected row **"TÙY CHỈNH ⊕"** in huge bold black; other rows in large light-grey type. AX lists TÙY CHỈNH + 20 scenario rows (the same count in both entry points). The scenario set **differs between the two entry points** ("Gọi món ở nhà hàng, Khiếu nại của khách hàng, …" vs "Thảo luận về ước mơ, Đi khám bác sĩ, …"), so it is shuffled or per-entry. Bottom bar: eyebrow "MÔ TẢ CHỦ ĐỀ", the selected row's description ("Tạo tình huống độc đáo của riêng bạn."), and a round black → button. OBSERVED.
- Selecting a preset scenario was **not** tried (it likely starts a lesson/AI call; effect ambiguous → rule 14).
- **S030** half sheet over S029 (x 171–617, y 542–811): grabber, title **"Tạo Hội Thoại"**, ✕, multiline field with placeholder "VD: 'Phỏng vấn xin việc', 'Gọi món tại nhà hàng'…" (auto-focused), horizontally scrolling suggestion chips **in English** ("At a Job Interview", "Checking into a Hotel", "Complaining about food", "Asking for Directions", "Meeting a new neighbor"), full-width CTA **"Bắt Đầu Luyện Tập"** (disabled grey until text exists). Not submitted (would call the AI). OBSERVED.

## Customize FAB (S031/S032)

- **S031**: tapping the FAB dims the picker with a grey scrim and fans out four floating pills at bottom-right: **"Trò chuyện Tự do"** (chat icon, current mode), **"Giọng: Thoải mái"** (person icon, current voice), **ⓘ "Thông Tin"** and **✕ "Đóng"** side by side. The mode/voice pills were not tapped (they change a lesson preference). OBSERVED.
- **S032** info sheet **"Hướng dẫn Cài đặt"** (half sheet with "Sheet Grabber", value "Half screen"): intro "Hiểu rõ các cài đặt giúp bạn tối ưu hóa việc luyện tập hội thoại."; section "CHẾ ĐỘ HỌC" → *Trò chuyện Tự do* ("Hội thoại mở. AI thích ứng với câu trả lời của bạn. Phù hợp cho luyện tập nâng cao.") and *Chế độ Kịch bản* ("Tuân theo kịch bản cụ thể. Phù hợp cho người mới bắt đầu cần hướng dẫn rõ ràng."); section "GIỌNG & TÍNH CÁCH" → *Trang trọng*, *Thoải mái*, *Thân thiện* with one-line descriptions; each row has a tinted rounded-square icon (chat, script, briefcase, person, heart). OBSERVED.
- Difficulty and "số câu hỏi" are mentioned by the coachmark but were **not** found in the FAB menu; they probably belong to the Scenario mode. INFERRED.
- Scenario mode itself ("Kịch bản") was never entered → UI unknown.

## Not explored

Scenario mode, the voice toggle, "Kết thúc bài làm" result/summary screen, S028 contents, the score chip for a high-scoring message, multi-turn chat, level pill ⓘ, the disabled menu item's label, the "Tạo tùy chỉnh" typed flow end-to-end, preset-scenario start.
