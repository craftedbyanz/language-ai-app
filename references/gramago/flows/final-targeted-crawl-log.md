# Final targeted crawl — log (2026-10-09)

Tags: OBSERVED / MEASURED / ESTIMATED / INFERRED. Window 788×1083, active unless stated. Tooling: Peekaboo CLI (MCP down).
Input method that works: `peekaboo paste "<text>" --app GramaGo --foreground` after a click into the field. `set-value` writes the AX value but the app does not register it (placeholder stays, submit stays disabled).

## Target A — Writing correct feedback (AI_CALLS_USED = 1)
Path: Home → Luyện viết card 01 → topic "Nghệ thuật và thủ công" → set 01 "Rừng sồi bần ở Alentejo" "Bắt đầu" → editor step 1/10.
| Step | State | Evidence |
|---|---|---|
| 1 | Filled editor, submit enabled (dark circle) | S005-active exists; not re-shot |
| 2 | Submit pressed → "Đang chấm điểm..." loading sheet (skeleton: SỬA LỖI box, GIẢI THÍCH, KEY IMPROVEMENTS, "Huỷ" button) | S055 |
| 3 | Correct verdict sheet "Xuất sắc" (green check, SỬA LỖI corrected sentence, GIẢI THÍCH, KEY IMPROVEMENTS ×3, Edit + Next, thumbs) | S056 + AX `writing-feedback-sheet--correct` |
| 4 | Next pressed once → editor step 2: 2nd sentence highlighted, progress segment 1 stays green, field empty, submit disabled, new sparkle (Tia Lửa) chip in the bottom bar | S057 |

OBSERVED rendering quirk: after the verdict arrived (AX tree already showed "Xuất sắc"/Next) the pixels stayed on the loading skeleton for >30 s through four capture methods (`see`, `screencapture -l`, full-display `screencapture`, refocus). Tapping the sheet grabber dismissed the sheet; a new sparkle chip appeared in the bottom bar and re-opens the verdict sheet (rendered correctly). This is a capture/render lag, not necessarily app behaviour (INFERRED).

## Session halt (2026-10-09 ~08:58) — OBSERVED
After leaving the writing set via "Thoát", the GramaGo process (pid 98192) sat at 85–92 % CPU with the main thread in a SwiftUI `NSTimer.TimerPublisher` → `ActionDispatcherSubscriber` loop. Pixels (window capture) froze on the writing step-2 editor while the AX tree reported the lesson list ("Bài học", "Nghệ thuật và thủ công"). Back/coordinate clicks produced no visual change; Google Chrome became the frontmost app. Crawl paused to avoid sending clicks to an unverified screen.
State at halt: AI_CALLS_USED = 1. Done: Target A (S055–S057). Not started: B, C, D, E, F.

## Resume after GramaGo restart (new pid 580) — Target B
Verified before resuming: GramaGo frontmost after `activate`, window 788×1083 at (1012,63), CPU 25–35 % idle, S055–S057 not colliding with SCREEN_INDEX (last ID S054). The window repeatedly drops to inactive between calls (traffic lights grey); every persisted capture was re-taken after `osascript activate` and checked for coloured traffic lights.
Path: Home → NGỮ PHÁP card → picker (13 topics, "N Qs") → "Tình bạn lâu năm" (5 Qs) → lesson list (3 lessons, CTA "Sửa nhanh") → lesson 01 editor (**20 progress segments** — count corrected from an earlier "18" by a pixel-row count of S058, prompt in Vietnamese "Chúng tôi là bạn từ khi còn nhỏ.", blue answer card, placeholder "Nhập câu trả lời...").
| State | File |
|---|---|
| Grammar editor empty, active (S058) | screenshots/S058-grammar-editor-empty-active.png |
| Grammar editor filled with "We is friend since small." — submit dark (S059) | screenshots/S059-grammar-editor-filled-incorrect-answer-submit-enabled-active.png + AX grammar-editor--filled |
| Incorrect verdict sheet "Chưa đúng" (S060): SỬA LỖI diff chips (red strike-through removed, green added), GIẢI THÍCH, **MẸO** (lime bullets, replaces writing's KEY IMPROVEMENTS), buttons **Sửa** / **Tiếp theo** (writing: Edit / Next); sparkle chip appears in bottom bar | screenshots/S060-grammar-feedback-sheet-incorrect-active.png + AX grammar-feedback-sheet--incorrect |
AI_CALLS_USED = 2 (this verdict rendered normally; CPU spiked to ~99 % during grading then fell to ~32 %).
| Sửa pressed → editor re-opens same question (AX field keeps the wrong text; sparkle chip stays in the bottom bar) | no new file |
| Correct verdict sheet "Chính xác" (S061): compact sheet (≈446×246 at the bottom half over the blue card), green check + title, "CÂU TRẢ LỜI CỦA BẠN" box with the answer, caption "Xem phân tích chi tiết từ AI cho câu trả lời của bạn", purple link **Xem phân tích AI**, full-width navy CTA **Câu tiếp theo →**. Grabber value "Collapsed" | screenshots/S061-grammar-feedback-sheet-correct-active.png + AX grammar-feedback-sheet--correct |
AI_CALLS_USED = 3. Observation: the correct submission returned in ≈ 8 s with no CPU spike and no loading skeleton was seen (INFERRED: exact-match grading is local and the AI analysis is opt-in via "Xem phân tích AI").
Target B: DONE.

## Target C — shortcut inspection (grammar editor "Thêm" menu, AX only) — OBSERVED
Items: Màu nền · Hiển thị gợi ý · Từ điển bài · (2 disabled items, presumably Hiện tất cả + the VI/EN swap variant — INFERRED from the writing menu S051) · Thích · Không thích. None is a completion shortcut. Grammar lesson 01 has 20 progress segments (writing: 10), so completing either set costs ≥ 9 further AI gradings. Decision: run Targets D–F first, return to C only if ≥ 10 calls remain.
Evidence: accessibility/menu--grammar-editor-more-open.{json,txt}
Next: Câu tiếp theo advanced grammar to question 2 ("Chúng tôi thường chơi ở công viên sau giờ học.", progress segment 2 lit).

## Target E — S028 score popover RENDERED (2026-10-09 09:46) — P0-6 RESOLVED
Technique (OBSERVED): `screencapture -x -R 1012,63,908,1083` — a display-region capture (the S051 wide-canvas idea; ONE capture method used). The old window-scoped capture rendered the popover blank (old S028 PNG, retained as history).
Trigger: tap the score chip under the user message ("86 • Câu đúng, chỉ hơi tự nhiên hơn được. ›").
The popover exposes NO AX elements (tree shows only window chrome): accessibility/conversation--score-popover-AX-EMPTY.txt.
File: screenshots/S028-conversation-score-popover-rendered-active.png — 1576×2166 px = 788×1083 logical @2x (canonical geometry; the region ran past the display edge and was clamped). Active window (coloured traffic lights). A macOS notification banner overlaps the top-right of the capture (unrelated to the app).
Contents (VERIFIED by the user against the screenshot):
- Floating bottom feedback sheet — same family as the Writing/Grammar feedback sheets (grabber on top, rounded top corners, ≈ 445 pt wide, centred, running past the bottom of the capture).
- Header: blue thumbs-up icon + verdict title "Gần đúng"; right: small label "Trôi chảy" above an orange number "88"; round close (×) button.
- "SỬA LỖI" box: corrected-sentence diff (added tokens green: "today", ".", "a"; removed token red strike-through: "my"); hint "Chạm từ để tra cứu".
- "PHẢN HỒI": Vietnamese explanation paragraph.
- "LỖI SAI": 3 bullets (orange dots).
- "NHỮNG ĐIỂM CẦN CẢI THIỆN": 2 bullets (purple dots).
- The chat chip shows 86 while the sheet shows "Trôi chảy 88" (both OBSERVED; relationship UNKNOWN).
CORRECTION (2026-10-09): earlier drafts of this section described a green "Điểm của bạn" bar-chart panel. That description was FALSE and has been deleted; do not reuse it.
AI_CALLS_USED = 4 (one chat message produced the score chip).

## Target D — Conversation completion (2026-10-09)
Fresh disposable chat started manually. Verified before acting: chat with AI opening line only ("Hey, how's your day going so far?…"), composer EMPTY, send button disabled (same state as S022 — no duplicate captured).
1. "Thêm" opened (AX click, menu = Ẩn bản dịch / 1 disabled item / Kết thúc bài làm — same as S023 AX).
2. Composer STILL EMPTY after menu open (the earlier stray "c"/"C ti" did not recur).
3. "Kết thúc bài làm" selected (AX click elem_18) → **confirmation alert S062**: "Thoát bài tập?" + "Bạn chưa hoàn thành bài tập. Tiến độ sẽ không được lưu nếu bạn thoát bây giờ." + Ở lại / Thoát. Files: screenshots/S062-conversation-end-confirm-alert-no-message-active.png (display-region capture; the peekaboo window capture shows only the dimmed backdrop without the alert panel) + AX dialog--conversation-end-confirm.{json,txt}.
NOTE (OBSERVED): ending with ZERO user messages routes through the SAME "Thoát bài tập?" alert as the editors (title identical; body text differs from S007's writing variant: "Bạn chưa hoàn thành bài tập. Tiến độ sẽ không được lưu…").
NEXT: press "Thoát" → capture result screen.
AI_CALLS_USED = 4.

## Target D — scored path (2026-10-09 ~11:00) — RESOLVED: VERIFIED_NO_RESULT_FOR_ONE_TURN
Input source was switched to ABC by the user beforehand. Sequence (all AX-targeted, composer verified EMPTY before and after each step; no stray text):
1. Fresh chat; one harmless message sent (AI call #5). The sent bubble read "This week I studied English and I played football with my brother.này" (the trailing "này" was injected by Telex before the input switch — OBSERVED, not typed by the agent). One AI reply and a score chip **84 • "Thiếu dấu câu và cách chia động từ chưa thật tự nhiên"** appeared.
2. "Thêm" → "Kết thúc bài làm" → **confirmation alert** "Thoát bài tập?" / "Bạn chưa hoàn thành bài tập. Tiến độ sẽ không được lưu nếu bạn thoát bây giờ." / Ở lại · Thoát. Identical to the zero-message alert (S062). Extra evidence: screenshots/S062-conversation-end-confirm-alert-after-one-scored-turn-active.png (shows the scored chat dimmed behind the alert) + accessibility/dialog--conversation-end-confirm-after-scored-turn.txt. Not a new state ID (same template as S062; content-instance variant).
3. "Thoát" → straight back to the Conversation lesson list ("Bài học" · "Mở rộng vốn từ tự nhiên" · "Bắt đầu chat"). NO result / summary / score screen appeared (AX and pixel capture agree; CPU low).
Conclusion: the conversation has no end-of-session result screen, with 0 or 1 user turns. The alert wording "Bạn chưa hoàn thành bài tập. Tiến độ sẽ không được lưu" implies a completion threshold exists (INFERRED; a longer chat might reach it — NOT tested, P2).
Return destination: Conversation lesson list (S021-type).
AI_CALLS_USED = 5 (budget remaining 10).

## Target F — Scenario mode (2026-10-09) — PARTIAL
Precondition: the user opened the customize FAB manually (the FAB has no AX handle). An earlier inspection in this pass found the AI generator S029 open instead; nothing was clicked there.
1. FAB fan-out open (S031 state): AX pills "Trò chuyện Tự do" · "Giọng: Thoải mái" · "Thông Tin" · "Đóng".
2. AX click on "Trò chuyện Tự do" → the pill toggles in place to **"Chế độ Kịch bản"** (icon changes from two chat bubbles to a document/script glyph). No sheet, picker or confirmation appears. Evidence: **S063** screenshots/S063-conversation-picker-fab-scenario-mode-selected-active.png + AX picker--conversation-fab-scenario-mode.{json,txt}.
3. "Đóng" closed the fan-out; the picker looks unchanged.
4. Topic "Mở rộng vốn từ tự nhiên" opened in Scenario mode → lesson list is identical to Free-chat mode (same AX tree, same visual: "Bắt đầu chat", "Tạo tình huống?" card, CẤP ĐỘ A1). Not a new state.
5. Scenario conversation surface NOT captured: it requires pressing "Bắt đầu chat", which the permission classifier blocked earlier in this pass and which was therefore not retried by the agent.
Mode persistence and restore: PENDING — restoring "Trò chuyện Tự do" needs the FAB, which has no AX handle.
AI_CALLS_USED = 5.

## Target F — Scenario chat surface (2026-10-09) — S064 (user pressed "Bắt đầu chat"; agent sent NO message)
Distinct from Free chat (OBSERVED, structural):
- Top bar: × (Đóng) + **segmented progress bar (8 segments; seg 1 dark blue, seg 2 light blue = current)** + ⋯ (Thêm). Free chat has a centred title "Trò chuyện Tự do" instead.
- Eyebrow under the bar: "MỞ RỘNG VỐN TỪ TỰ NHIÊN: MUA TRÁI CÂY Ở CHỢ" (topic: scenario name).
- **Role labels** above bubbles: "Người bán hàng" (AI, left) and "Khách hàng" (learner, right).
- AI bubble is **grey-filled** (Free chat AI bubble: white with hairline), bold Vietnamese line + italic grey English gloss ("Chào bạn, bạn muốn mua gì?" / "Hello, what would you like to buy?"). Bubble has a small tail dot bottom-left.
- **Scripted learner line pre-filled as a blue bubble**: "Tôi muốn mua táo." with micro-label "DỊCH CÂU NÀY" (translate this sentence) and a tail dot bottom-right. It is the prompt, not a sent message.
- Composer placeholder **"Dịch sang tiếng Anh..."** (Free chat: "Nhập tin nhắn..."); send button AX "Lên" (Free: "Hình Tròn Chứa Mũi Tên Lên"), disabled while empty.
- **Hint-chip row** (3 blurred chips) above the composer — same HintChipBar as the writing/grammar editors.
INFERRED: Scenario mode = the editor translate-loop rendered as a chat: Vietnamese prompt → user translates → (AI grades) → next step; progress bar = steps of the script.
Files: screenshots/S064-conversation-scenario-chat-opening-active.png (active, 788×1083) + accessibility/conversation--scenario-chat-opening.{json,txt}.
AI_CALLS_USED: the opening was generated when the user pressed "Bắt đầu chat"; the agent counts it conservatively → **AI_CALLS_USED = 6**.

## Target F — restore (2026-10-09) — Target F VERIFIED
User opened the customize fan-out manually. AX pill read "Chế độ Kịch bản" (mode persisted across chat exit + navigation — OBSERVED). AX click → pill reads "Trò chuyện Tự do" (verified in AX). AX "Đóng" closed the fan-out; picker visually identical to S020. No new capture (default = S031/S020).
Target F: VERIFIED (S063 mode selected, S064 scenario chat opening, default restored).

## Target C — DEFERRED_BY_AI_BUDGET
Shortest set (writing, 10 steps; grammar, 20 steps) needs ≈ 9+ further gradings vs 9 remaining calls. Not attempted. Feedback/loading/progression families are verified (S055–S061); completion screen is a documented gap.

## End of app interaction. AI_CALLS_USED = 6 / 15.
