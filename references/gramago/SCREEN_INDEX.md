# GramaGo Screen Index

Reconciled 2026-10-09 (documentation pass; no app contact). **49 indexed states** (S001–S050, S038 unused) + **S051–S054 added** = 53, + **S055–S064 added by the final targeted crawl (2026-10-09)** = 63 IDs / **62 distinct evidenced states** (S058 is an ID alias: the active re-capture of S010's state). **77 PNGs and 43 AX files (21 snapshots)** are all registered below (final-crawl log: [flows/final-targeted-crawl-log.md](flows/final-targeted-crawl-log.md)). Window-state, viewport and colour-encoding of every capture are recorded in the *Capture register*; **inactive captures support structure only**. See [REVERSE_ENGINEERING_REPORT.md](REVERSE_ENGINEERING_REPORT.md) and [CURRENT_STATUS.md](CURRENT_STATUS.md).

State ID scheme: `S<number> <screen-slug>--<variant>`. One ID = one state; several files per ID are *re-captures* (listed in the register, one marked **Canonical**). The *Screenshot* column below links the canonical file where one exists, else the best inactive file (marked †). Dynamic content (greeting, streak number, randomized topic grids/lesson order) does not create a new state.

## Explored

| ID | Screen | Variant | Reached from | Doc | Screenshot |
|---|---|---|---|---|---|
| S001 | Home | default | launch | [home.md](screens/home.md) | [S001-home-inactive-original.png](screenshots/S001-home-active-verification.png) |
| S002 | Topic Picker (writing) | "Viết nên câu chuyện" | S001 card 01 | [writing-topic-picker.md](screens/writing-topic-picker.md) | [S002](screenshots/S002-writing-topic-picker-active-verification.png) |
| S003 | Lesson List (writing) | "Bài học" | S002 topic card | [writing-lesson-list.md](screens/writing-lesson-list.md) | [S003](screenshots/S003-writing-lesson-list-active-verification.png) |
| S004 | Exercise Editor | empty | S003 "Bắt đầu" | [writing-exercise-editor.md](screens/writing-exercise-editor.md) | [S004](screenshots/S004-writing-exercise-editor-empty-active-verification.png) |
| S005 | Exercise Editor | filled | typing | same | [S005](screenshots/S005-writing-exercise-editor-filled-submit-enabled-active.png) |
| S006 | Feedback Sheet | incorrect | S005 submit | [writing-feedback-sheet.md](screens/writing-feedback-sheet.md) | [S006](screenshots/S006-writing-feedback-sheet-incorrect.png) † |
| S007 | Exit-confirm Dialog (alert 260×161: "Thoát bài tập?" · "Ở lại"/"Thoát") | rendered | S004/S010/S022 "Đóng" | [writing-exercise-editor.md](screens/writing-exercise-editor.md) (States/Notes) | [S007](screenshots/S007-exit-confirm-alert-rendered.png) |
| S008 | Topic Picker (grammar) | "Hoàn thiện ngữ pháp" | S001 card 02 | [grammar-mode.md](screens/grammar-mode.md) | [S008](screenshots/S008-grammar-topic-picker.png) † |
| S009 | Lesson List (grammar) | "Sửa nhanh" CTAs | S008 topic card | [grammar-mode.md](screens/grammar-mode.md) | [S009](screenshots/S009-grammar-lesson-list-active-recapture.png) (active, final crawl) |
| S010 | Exercise Editor (grammar) | empty, sentence prompt | S009 "Sửa nhanh" | [grammar-mode.md](screens/grammar-mode.md) | [S010](screenshots/S010-grammar-editor-empty.png) † |
| S011 | Home + Menu **overlay** (frosted, full-window) | open | S001 Menu star icon | [home-menu.md](screens/home-menu.md) | [S011](screenshots/S011-home-menu-open-active-verification.png) |
| S012 | Flashcard Deck List | "Học flashcard" | S011 "Học flashcard" | [flashcards.md](screens/flashcards.md) | [S012](screenshots/S012-flashcard-deck-list.png) † |
| S013 | Flashcard Deck Detail | default | S012 deck card | [flashcards.md](screens/flashcards.md) | [S013](screenshots/S013-flashcard-deck-detail-active-verification.png) |
| S014 | SRS Review Session | tutorial overlay | S013 "Ôn tập (10)" | [flashcards.md](screens/flashcards.md) | [S014](screenshots/S014-srs-gesture-tutorial-overlay.png) † |
| S015 | SRS Review Session | card front, active | S014 "Đã hiểu…" | [flashcards.md](screens/flashcards.md) | [S015](screenshots/S015-srs-session-front-active-verification.png) |
| S016 | Profile / Settings | default | S001 bottom-right icon | [profile-history-streak.md](screens/profile-history-streak.md) | [S016](screenshots/S016-profile-settings.png) † |
| S017 | History "Ôn tập" | default | S001 bottom-left icon | [profile-history-streak.md](screens/profile-history-streak.md) | [S017](screenshots/S017-history.png) † |
| S018 | Streak "Chuỗi Streak" | default | S001 streak pill | [profile-history-streak.md](screens/profile-history-streak.md) | [S018](screenshots/S018-streak-progress.png) † |
| S019 | Topic Picker (conversation) | + "Tùy chỉnh Bài học" coachmark | S001 card 03 | [conversation-mode.md](screens/conversation-mode.md) | [S019](screenshots/S019-conversation-topic-picker-customize-coachmark.png) † |
| S020 | Topic Picker (conversation) | "Thực hành giao tiếp", 1 topic | S019 coachmark ✕ | same | [S020](screenshots/S020-conversation-topic-picker.png) † |
| S021 | Lesson List (conversation) | "Bài học", "Bắt đầu chat" + AI card | S020 topic card | same | [S021](screenshots/S021-conversation-lesson-list.png) † |
| S022 | Chat "Trò chuyện Tự do" | AI opening message | S021 "Bắt đầu chat" | same | [S022](screenshots/S022-conversation-chat-free-ai-opening.png) † |
| S023 | Chat + "Thêm" menu | open — items Ẩn bản dịch · (disabled) · Kết thúc bài làm; **popup never rendered in any capture (AX only)** | S022 "Thêm" | same | [S023](screenshots/S023-conversation-chat-more-menu-open-popup-not-in-capture.png) † |
| S024 | Chat | translation hidden | S023 "Ẩn bản dịch" | same | [S024](screenshots/S024-conversation-chat-translation-hidden.png) † |
| S025 | Chat | composer filled, send enabled | typing | same | [S025](screenshots/S025-conversation-chat-composer-filled.png) |
| S026 | Chat | user bubble + typing indicator | S025 send | same | [S026](screenshots/S026-conversation-chat-reply-loading.png) |
| S027 | Chat | AI reply + score chip ("58"; final-crawl instance "86") | ≈ 7 s after S026 | same | [S027](screenshots/S027-conversation-chat-reply-received.png) · [86-instance](screenshots/S027-conversation-chat-reply-received-active-recapture.png) |
| S028 | Score chip popover | **RENDERED (final crawl)**: bottom floating feedback sheet — thumbs-up + "Gần đúng", "Trôi chảy 88", ×, SỬA LỖI diff, PHẢN HỒI, LỖI SAI ×3, NHỮNG ĐIỂM CẦN CẢI THIỆN ×2; no AX elements | S027 chip | same | [S028](screenshots/S028-conversation-score-popover-rendered-active.png) · AX [empty](accessibility/conversation--score-popover-AX-EMPTY.txt) |
| S029 | AI scenario generator "CHỌN CHỦ ĐỀ" | wheel/list | S021 AI card / S020 "AI" | same | [S029](screenshots/S029-conversation-ai-scenario-generator.png) |
| S030 | "Tạo Hội Thoại" sheet | empty | S029 "MÔ TẢ CHỦ ĐỀ" | same | [S030](screenshots/S030-conversation-ai-create-dialog-empty.png) |
| S031 | Picker + customize FAB | expanded | S020 FAB | same | [S031](screenshots/S031-conversation-picker-customize-fab-expanded.png) |
| S032 | "Hướng dẫn Cài đặt" info sheet | half sheet | S031 ⓘ | same | [S032](screenshots/S032-conversation-customize-info-sheet.png) |
| S033 | Insight | default (all-zero data) | S011 "Insight" | [insight.md](screens/insight.md) | [S033](screenshots/S033-insight.png) |
| S034 | Flow Letter | tutorial overlay | S011 "Chơi FlowLetter" | [flow-letter.md](screens/flow-letter.md) | [S034](screenshots/S034-flowletter-tutorial-overlay.png) |
| S035 | Flow Letter lobby | first visit | S034 "Chạm để bắt đầu" | same | [S035](screenshots/S035-flowletter-lobby.png) |
| S036 | Flow Letter topic select | "Chọn chủ đề", 14 topics | S035 "Chơi" | same | [S036](screenshots/S036-flowletter-topic-select.png) |
| S037 | Flow Letter gameplay | **topic source** Nature, level 1, 1/30 | S036 topic | same | [S037](screenshots/S037-flowletter-gameplay-nature.png) |
| S039 | Flow Letter lobby | + "Tiếp tục Nature 1/30" | S037 Back ×2 | same | [S039](screenshots/S039-flowletter-lobby-resume.png) |
| S040 | Flow Letter difficulty | "Độ khó" (Vừa selected) | S039 "Độ khó" | same | [S040](screenshots/S040-flowletter-difficulty-select-screen.png) |
| S041 | Flow Letter settings | "Cài đặt" (2 toggles on) | S039 "Cài đặt" | same | [S041](screenshots/S041-flowletter-settings.png) |
| S042 | Flow Letter help | "Hướng dẫn" | S039 "?" | same | [S042](screenshots/S042-flowletter-help-guide.png) |
| S043 | Language select | "Ngôn ngữ học" | S001 flag "US" | [language-and-level.md](screens/language-and-level.md) | [S043](screenshots/S043-language-select-screen.png) |
| S044 | CEFR level select | "Chọn cấp độ" (A1 selected) | S043 level row | same | [S044](screenshots/S044-language-level-select-screen.png) |
| S045 | Paywall "Nâng cấp Gramify+" | **view-only** | S001 Plus banner | [paywall-plus.md](screens/paywall-plus.md) | [S045](screenshots/S045-paywall-plus.png) † |
| S046 | Home AI composer sheet | empty | S001 "Tạo bài học với AI" | [language-and-level.md](screens/language-and-level.md) | [S046](screenshots/S046-home-ai-composer-sheet-empty.png) † |
| S047 | Gramify 101 detail | "3 Chế Độ…" (window 554×772) | S001 tile | same | [S047](screenshots/S047-gramify101-detail-3-modes-554x772.png) † |
| S048 | Settings: Lesson Settings | default | S016 "Cài đặt bài học" | [settings-subpages.md](screens/settings-subpages.md) | [S048](screenshots/S048-settings-lesson-settings-554x772.png) † |
| S049 | Settings: Appearance | Glass selected | S016 "Giao diện" | same | [S049](screenshots/S049-settings-appearance-554x772.png) † |
| S050 | Settings: Voice | empty (no models) | S016 "Giọng đọc" | same | [S050](screenshots/S050-settings-voice-no-models-554x772.png) † |
| S051 | Writing editor "Thêm" popup | open, 6 items (Hiện tất cả · Màu nền › · Hiển thị gợi ý · Từ điển bài · Thích · Không thích) | S005 "Thêm" | [writing-exercise-editor.md](screens/writing-exercise-editor.md) | [S051](screenshots/S051-writing-editor-filled-more-menu-open-active-908x1083.png) · AX [menu--editor-more-open](accessibility/menu--editor-more-open.json) |
| S052 | SRS card back | translation, EN gloss, VERB badge, speaker, "Ví dụ", 4 grade buttons (none pressed) | S015 tap card | [flashcards.md](screens/flashcards.md) | [S052](screenshots/S052-srs-card-back-active.png) · AX [srs--card-back](accessibility/srs--card-back.json) |
| S053 | SRS "Thêm" popup | **AX only** — Tự động phát · Màu thẻ · Hướng dẫn (no PNG) | S015/S052 "Thêm" | [flashcards.md](screens/flashcards.md) | AX [menu--srs-more-open](accessibility/menu--srs-more-open.json) |
| S054 | Flow Letter gameplay | **deck source** "Nấu ăn & Ẩm thực", LEVEL 1, 1/10, purple | deck "Flow Letter" tab (IMPLIED, not logged) | [flow-letter.md](screens/flow-letter.md) | [S054](screenshots/S037-flowletter-deck-gameplay-active.png) · AX [flowletter--deck-gameplay](accessibility/flowletter--deck-gameplay.json) |

| S055 | Writing feedback sheet | **grading/loading** — "Đang chấm điểm..." spinner title, skeleton SỬA LỖI / GIẢI THÍCH / KEY IMPROVEMENTS, "Huỷ" | S005 submit | [writing-feedback-sheet.md](screens/writing-feedback-sheet.md) | [S055](screenshots/S055-writing-grading-loading-sheet-active.png) |
| S056 | Writing feedback sheet | **correct** — green ✓ "Xuất sắc", SỬA LỖI, GIẢI THÍCH, KEY IMPROVEMENTS ×3, Edit / Next, thumbs | S055 (grading done) | same | [S056](screenshots/S056-writing-feedback-sheet-correct-excellent-active.png) · AX [writing-feedback-sheet--correct](accessibility/writing-feedback-sheet--correct.json) |
| S057 | Writing editor | **step 2 after correct → Next** — sentence 2 highlighted, progress seg 2, empty field, submit disabled, sparkle chip (re-opens last verdict) in bottom bar | S056 "Next" | [writing-exercise-editor.md](screens/writing-exercise-editor.md) | [S057](screenshots/S057-writing-step2-editor-after-correct-next-active.png) |
| S058 | Grammar editor (**alias of S010** — same state, active capture) | empty, **active** — 20-segment progress, VI prompt card, blue answer card "Nhập câu trả lời..." | S009 "Sửa nhanh" | [grammar-mode.md](screens/grammar-mode.md) | [S058](screenshots/S058-grammar-editor-empty-active.png) |
| S059 | Grammar editor | filled (wrong answer), submit enabled | S058 typing | same | [S059](screenshots/S059-grammar-editor-filled-incorrect-answer-submit-enabled-active.png) · AX [grammar-editor--filled](accessibility/grammar-editor--filled.json) |
| S060 | Grammar feedback sheet | **incorrect** — red ✕ "Chưa đúng", diff chips, GIẢI THÍCH, **MẸO**, **Sửa / Tiếp theo** | S059 submit | same | [S060](screenshots/S060-grammar-feedback-sheet-incorrect-active.png) · AX [grammar-feedback-sheet--incorrect](accessibility/grammar-feedback-sheet--incorrect.json) |
| S061 | Grammar feedback sheet | **correct** — compact: green ✓ "Chính xác", CÂU TRẢ LỜI CỦA BẠN, "Xem phân tích AI" link, CTA **Câu tiếp theo →** | S060 "Sửa" → re-answer → submit | same | [S061](screenshots/S061-grammar-feedback-sheet-correct-active.png) · AX [grammar-feedback-sheet--correct](accessibility/grammar-feedback-sheet--correct.json) |
| S062 | Conversation end-confirm alert | "Thoát bài tập?" / "Bạn chưa hoàn thành bài tập. Tiến độ sẽ không được lưu nếu bạn thoát bây giờ." / Ở lại · Thoát (same with 0 or 1 user turns; Scenario "Đóng" too) | S023 "Kết thúc bài làm" | [conversation-mode.md](screens/conversation-mode.md) | [S062](screenshots/S062-conversation-end-confirm-alert-no-message-active.png) · [scored-turn](screenshots/S062-conversation-end-confirm-alert-after-one-scored-turn-active.png) · AX [dialog--conversation-end-confirm](accessibility/dialog--conversation-end-confirm.json) |
| S063 | Picker + customize FAB | **Scenario mode selected** — pill "Chế độ Kịch bản" (script icon) | S031 tap mode pill | same | [S063](screenshots/S063-conversation-picker-fab-scenario-mode-selected-active.png) · AX [picker--conversation-fab-scenario-mode](accessibility/picker--conversation-fab-scenario-mode.json) |
| S064 | Scenario chat | opening — 8-seg progress, scenario eyebrow, role labels, grey AI bubble (VI + italic EN), learner task bubble "DỊCH CÂU NÀY", composer "Dịch sang tiếng Anh...", hint chips | S021 "Bắt đầu chat" in Scenario mode | same | [S064](screenshots/S064-conversation-scenario-chat-opening-active.png) · AX [conversation--scenario-chat-opening](accessibility/conversation--scenario-chat-opening.json) |
S038 was not used (identical to S037 after a hint tap; discarded). † = inactive-window capture only: layout/structure valid, **colours, fills and enabled/disabled states are CANDIDATE**. S047–S050 are 554×772 (alternate viewport, window resized outside the crawl; **no geometry from them is canonical**); S051 is a 908×1083 canvas (geometry = 788); all others 788×1083. S054's file keeps its legacy `S037-` prefix (renaming would break link history; ID is S054).

## Known but not explored

| From | Control | Status |
|---|---|---|
| S022 | "Kết thúc bài làm" | **Pressed (final crawl)** → S062 → "Thoát" → lesson list; **no result screen with 0 or 1 user turns** (VERIFIED_NO_RESULT_FOR_ONE_TURN). Longer chats untested (P2). Disabled 3rd menu item label still unknown |
| S027/S028 | Higher score bands; multi-turn chat | Popover contents now captured (S028); others not tried (P2) |
| S021 | Scenario mode | **Entered (S063/S064)** and restored to Free chat; Scenario grading/next-step/result and the voice pill not explored (P2) |
| S029 | Preset scenario rows; S030 submit | Not started (would call the AI / change state) |
| S037 | Dragging letters, solving a word, combo/XP, level-up, game-over/result | Not reachable via accessibility clicks; not tried |
| S040/S041 | Changing difficulty or the sound/haptics toggles | Preference changes, not tried |
| S043/S044 | "Xác nhận" on either screen; picking another language/level | Account/profile boundary; not pressed |
| S045 | Plan switch, CTA, Restore, Terms, Privacy | Purchase boundary; never touched |
| S046 | Suggestion chips, typing + send | Would call the AI |
| S047 | Other six Gramify 101 tiles | Only the first opened; rest INFERRED to share the template |
| S048–S050 | Swatches, toggle, style tiles, Card Order drag, Reset, voice "?" guide | Preference changes, not tried |
| S016 | Notifications, Mời bạn bè, Đánh giá, Gửi phản hồi, Điều khoản, Chính sách, language row | Not opened (some leave the app); edit-profile / subscription / promo / logout blocked by safety rules |
| S001 | 10 topic chips; mode card carousel pages 2/3 (card 02 only peeks, lavender) | Not opened |
| S013 | "Flow Letter" tab → S054 | Reached (S054 captured) but the click is not logged: edge IMPLIED |
| S002/S008 | 18 other category chips, "AI" button, level pill | Not explored (the conversation "AI" button was explored → S029) |
| S006 | "Edit", thumbs rating, word-lookup popover, dismiss | Not explored |
| S004/S010 | "Thêm" menu **item effects** (menu itself = S051), VI↔EN swap icon, "Hoàn Tác"; grammar editor menu | Items not pressed |
| S012/S013 | "Thêm", search, "Filters", "Newest", trash rows | Not explored (trash = destructive) |
| S017 | History card details, search, floating "+" | Not explored |
| S018 | Month navigation | Not explored |
| — | **Lesson-complete result (writing/grammar) — DEFERRED_BY_AI_BUDGET**; SRS graded/summary, error states, onboarding/login, dark mode | Not seen (correct/incorrect feedback now captured: S056, S060, S061) |
| S061 | "Xem phân tích AI" (detailed AI analysis), grammar editor "Thêm" item effects (menu AX: [menu--grammar-editor-more-open](accessibility/menu--grammar-editor-more-open.json)) | Not pressed (AI call / P2) |

## Housekeeping

- Earlier research preserved in `specs/components.md` and `specs/design-tokens.md` (Home-only evidence); superseded by top-level COMPONENTS.md / DESIGN_SYSTEM.md, which merge it.
- Screenshots are captured directly into `screenshots/` (CLI: `peekaboo see --no-remote --capture-engine classic --path …`; the default engine failed because ScreenCaptureKit was held by another process).
- Filenames describe the **verified** state. Twelve files were renamed in session 2 after viewing the capture showed the first filename guess did not match the verified state (S019, S022, S023, S028, S034, S036, S040, S043, S044, S046, S047, S050).
- Every Peekaboo click on this app returns "unconfirmed" but lands (verified per action); the only hard failures were caused by the locked GUI session at the end.
- Peekaboo calls: 92 in the first session (MCP). This session used the CLI and the calls were **not counted**; every UI action was preceded and followed by a state read, so the true total is well above the number of actions. The 500-call budget in the original brief was therefore not tracked this session. States: 53 distinct of the 150 budget.

## Capture register (all 77 PNGs)

Window = traffic-light pixel (active = coloured). Encoding: sRGB-tagged = untagged/`srgb` PNG (S001–S018 originals); "Display" / Display P3 = embedded ICC profile (raw hex ≠ sRGB, see [design-tokens.json](design-tokens.json) `meta.rules`). Counts: **57 canonical 788×1083** (29 active / 28 inactive) · **5 × 554×772** (4 inactive S047–S050 + 1 active S001) · **1 × 908×1083** (active S051) — plus **14 final-crawl captures**, all active and 788×1083 logical (11 at 1x via `peekaboo see`; 3 at **2x, 1576×2166 px** via `screencapture -R`: S028-rendered, both S062). Active total 45, inactive 32.

| State | File | Window | Viewport | Encoding | Role |
|---|---|---|---|---|---|
| S001 | [S001-home-active-verification-554x772.png](screenshots/S001-home-active-verification-554x772.png) | active | **554×772** (alt) | Display P3 | Alternate viewport (0.704× content). Layout only; never a geometry source. |
| S001 | [S001-home-active-verification.png](screenshots/S001-home-active-verification.png) | active | 788×1083 | Display P3 | **Canonical** Home (13:46). |
| S001 | [S001-home-inactive-original.png](screenshots/S001-home-inactive-original.png) | inactive | 788×1083 | sRGB-tagged | Original; structure only. Mode-card fill `#D4D4D5` is an inactive-window artefact. |
| S001 | [S001-home-inactive-verification.png](screenshots/S001-home-inactive-verification.png) | inactive | 788×1083 | Display P3 | Deliberate inactive control (13:36). Proves the grey card is window-state, not style. |
| S002 | [S002-writing-topic-picker-active-verification.png](screenshots/S002-writing-topic-picker-active-verification.png) | active | 788×1083 | Display P3 | **Canonical.** |
| S002 | [S002-writing-topic-picker-inactive-original.png](screenshots/S002-writing-topic-picker-inactive-original.png) | inactive | 788×1083 | sRGB-tagged | Inactive; structure/layout only — colours CANDIDATE. |
| S003 | [S003-writing-lesson-list-active-verification.png](screenshots/S003-writing-lesson-list-active-verification.png) | active | 788×1083 | Display P3 | **Canonical.** Flat white lesson card, navy CTA. |
| S003 | [S003-writing-lesson-list-inactive-original.png](screenshots/S003-writing-lesson-list-inactive-original.png) | inactive | 788×1083 | sRGB-tagged | Inactive; structure/layout only — colours CANDIDATE. |
| S004 | [S004-writing-exercise-editor-empty-active-verification.png](screenshots/S004-writing-exercise-editor-empty-active-verification.png) | active | 788×1083 | Display P3 | **Canonical.** Submit disabled = grey ring `#898990`. |
| S004 | [S004-writing-exercise-editor-empty-inactive-original.png](screenshots/S004-writing-exercise-editor-empty-inactive-original.png) | inactive | 788×1083 | sRGB-tagged | Inactive; structure/layout only — colours CANDIDATE. |
| S005 | [S005-writing-exercise-editor-filled-inactive-original.png](screenshots/S005-writing-exercise-editor-filled-inactive-original.png) | inactive | 788×1083 | sRGB-tagged | Inactive; structure/layout only — colours CANDIDATE. |
| S005 | [S005-writing-exercise-editor-filled-submit-enabled-active.png](screenshots/S005-writing-exercise-editor-filled-submit-enabled-active.png) | active | 788×1083 | Display P3 | **Canonical.** Submit enabled = dark filled circle. |
| S006 | [S006-writing-feedback-sheet-incorrect.png](screenshots/S006-writing-feedback-sheet-incorrect.png) | inactive | 788×1083 | sRGB-tagged | Inactive; structure/layout only — colours CANDIDATE. |
| S007 | [S004-writing-editor-step2-modal-dimmed-alert-absent.png](screenshots/S004-writing-editor-step2-modal-dimmed-alert-absent.png) | inactive | 788×1083 | sRGB-tagged | **Invalid for S007** (no alert drawn). Kept as evidence of editor step 2 (2nd progress segment, 2nd sentence highlighted) behind a modal dim. Filename prefix `S004` is historical. |
| S007 | [S007-exit-confirm-alert-rendered.png](screenshots/S007-exit-confirm-alert-rendered.png) | inactive | 788×1083 | untagged (P3-valued, INFERRED) | **Canonical S007.** Window dimmed by the alert (reads as inactive by design). |
| S008 | [S008-grammar-topic-picker.png](screenshots/S008-grammar-topic-picker.png) | inactive | 788×1083 | sRGB-tagged | Inactive; structure/layout only — colours CANDIDATE. |
| S009 | [S009-grammar-lesson-list.png](screenshots/S009-grammar-lesson-list.png) | inactive | 788×1083 | sRGB-tagged | Inactive. Filename was `grammar-question` historically; content is the lesson list. |
| S010 | [S010-grammar-editor-empty.png](screenshots/S010-grammar-editor-empty.png) | inactive | 788×1083 | sRGB-tagged | Inactive; structure/layout only — colours CANDIDATE. |
| S011 | [S011-home-menu-open-active-verification.png](screenshots/S011-home-menu-open-active-verification.png) | active | 788×1083 | Display P3 | **Canonical.** Frosted full-window overlay, 5 centred rows. |
| S011 | [S011-home-menu-open-inactive-original.png](screenshots/S011-home-menu-open-inactive-original.png) | inactive | 788×1083 | sRGB-tagged | Inactive; structure/layout only — colours CANDIDATE. |
| S012 | [S012-flashcard-deck-list.png](screenshots/S012-flashcard-deck-list.png) | inactive | 788×1083 | sRGB-tagged | Inactive. Content is the deck list. |
| S013 | [S013-flashcard-deck-detail-active-verification.png](screenshots/S013-flashcard-deck-detail-active-verification.png) | active | 788×1083 | Display P3 | **Canonical.** |
| S013 | [S013-flashcard-deck-detail-inactive.png](screenshots/S013-flashcard-deck-detail-inactive.png) | inactive | 788×1083 | sRGB-tagged | Inactive; structure/layout only — colours CANDIDATE. |
| S014 | [S014-srs-gesture-tutorial-overlay.png](screenshots/S014-srs-gesture-tutorial-overlay.png) | inactive | 788×1083 | sRGB-tagged | Inactive; structure/layout only — colours CANDIDATE. |
| S015 | [S015-srs-card-front-inactive.png](screenshots/S015-srs-card-front-inactive.png) | inactive | 788×1083 | sRGB-tagged | Inactive; structure only. (Filename "inactive" = window state.) |
| S015 | [S015-srs-session-front-active-verification.png](screenshots/S015-srs-session-front-active-verification.png) | active | 788×1083 | Display P3 | **Canonical.** |
| S016 | [S016-profile-settings.png](screenshots/S016-profile-settings.png) | inactive | 788×1083 | sRGB-tagged | Inactive; structure/layout only — colours CANDIDATE. |
| S017 | [S017-history.png](screenshots/S017-history.png) | inactive | 788×1083 | sRGB-tagged | Inactive; structure/layout only — colours CANDIDATE. |
| S018 | [S018-streak-progress.png](screenshots/S018-streak-progress.png) | inactive | 788×1083 | sRGB-tagged | Inactive; structure/layout only — colours CANDIDATE. |
| S019 | [S019-conversation-topic-picker-customize-coachmark.png](screenshots/S019-conversation-topic-picker-customize-coachmark.png) | inactive | 788×1083 | "Display" profile | Inactive; structure/layout only — colours CANDIDATE. |
| S020 | [S020-conversation-topic-picker.png](screenshots/S020-conversation-topic-picker.png) | inactive | 788×1083 | "Display" profile | Inactive; structure/layout only — colours CANDIDATE. |
| S021 | [S021-conversation-lesson-list.png](screenshots/S021-conversation-lesson-list.png) | inactive | 788×1083 | "Display" profile | Inactive; structure/layout only — colours CANDIDATE. |
| S022 | [S022-conversation-chat-free-ai-opening.png](screenshots/S022-conversation-chat-free-ai-opening.png) | inactive | 788×1083 | "Display" profile | Inactive; structure/layout only — colours CANDIDATE. |
| S023 | [S023-conversation-chat-more-menu-open-popup-not-in-capture.png](screenshots/S023-conversation-chat-more-menu-open-popup-not-in-capture.png) | inactive | 788×1083 | "Display" profile | Popup absent (AX only). |
| S024 | [S024-conversation-chat-translation-hidden.png](screenshots/S024-conversation-chat-translation-hidden.png) | inactive | 788×1083 | "Display" profile | Inactive; structure/layout only — colours CANDIDATE. |
| S025 | [S025-conversation-chat-composer-filled.png](screenshots/S025-conversation-chat-composer-filled.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S026 | [S026-conversation-chat-reply-loading.png](screenshots/S026-conversation-chat-reply-loading.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S027 | [S027-conversation-chat-reply-received.png](screenshots/S027-conversation-chat-reply-received.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S028 | [S028-conversation-score-popover-blank-render.png](screenshots/S028-conversation-score-popover-blank-render.png) | active | 788×1083 | "Display" profile | Active but popover renders blank. |
| S029 | [S029-conversation-ai-scenario-generator.png](screenshots/S029-conversation-ai-scenario-generator.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S030 | [S030-conversation-ai-create-dialog-empty.png](screenshots/S030-conversation-ai-create-dialog-empty.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S031 | [S031-conversation-picker-customize-fab-expanded.png](screenshots/S031-conversation-picker-customize-fab-expanded.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S032 | [S032-conversation-customize-info-sheet.png](screenshots/S032-conversation-customize-info-sheet.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S033 | [S033-insight.png](screenshots/S033-insight.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S034 | [S034-flowletter-tutorial-overlay.png](screenshots/S034-flowletter-tutorial-overlay.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S035 | [S035-flowletter-lobby.png](screenshots/S035-flowletter-lobby.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S036 | [S036-flowletter-topic-select.png](screenshots/S036-flowletter-topic-select.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S037 | [S037-flowletter-gameplay-nature.png](screenshots/S037-flowletter-gameplay-nature.png) | active | 788×1083 | "Display" profile | Nature topic, 1/30. |
| S039 | [S039-flowletter-lobby-resume.png](screenshots/S039-flowletter-lobby-resume.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S040 | [S040-flowletter-difficulty-select-screen.png](screenshots/S040-flowletter-difficulty-select-screen.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S041 | [S041-flowletter-settings.png](screenshots/S041-flowletter-settings.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S042 | [S042-flowletter-help-guide.png](screenshots/S042-flowletter-help-guide.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S043 | [S043-language-select-screen.png](screenshots/S043-language-select-screen.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S044 | [S044-language-level-select-screen.png](screenshots/S044-language-level-select-screen.png) | active | 788×1083 | "Display" profile | Active, canonical. |
| S045 | [S045-paywall-plus.png](screenshots/S045-paywall-plus.png) | inactive | 788×1083 | "Display" profile | Inactive; structure/layout only — colours CANDIDATE. |
| S046 | [S046-home-ai-composer-sheet-empty.png](screenshots/S046-home-ai-composer-sheet-empty.png) | inactive | 788×1083 | "Display" profile | Inactive; structure/layout only — colours CANDIDATE. |
| S047 | [S047-gramify101-detail-3-modes-554x772.png](screenshots/S047-gramify101-detail-3-modes-554x772.png) | inactive | **554×772** (alt) | Display P3 | Inactive; structure/layout only — colours CANDIDATE. |
| S048 | [S048-settings-lesson-settings-554x772.png](screenshots/S048-settings-lesson-settings-554x772.png) | inactive | **554×772** (alt) | Display P3 | Inactive; structure/layout only — colours CANDIDATE. |
| S049 | [S049-settings-appearance-554x772.png](screenshots/S049-settings-appearance-554x772.png) | inactive | **554×772** (alt) | Display P3 | Inactive; structure/layout only — colours CANDIDATE. |
| S050 | [S050-settings-voice-no-models-554x772.png](screenshots/S050-settings-voice-no-models-554x772.png) | inactive | **554×772** (alt) | Display P3 | Inactive; structure/layout only — colours CANDIDATE. |
| S051 | [S051-writing-editor-filled-more-menu-open-active-908x1083.png](screenshots/S051-writing-editor-filled-more-menu-open-active-908x1083.png) | active | **908×1083** (alt) | untagged (P3-valued, INFERRED) | Third canvas (908 = window 788 + desktop strip); popup spills outside the window. Window geometry = 788. |
| S052 | [S052-srs-card-back-active.png](screenshots/S052-srs-card-back-active.png) | active | 788×1083 | Display P3 | **Canonical.** No grade pressed. |
| S054 | [S037-flowletter-deck-gameplay-active.png](screenshots/S037-flowletter-deck-gameplay-active.png) | active | 788×1083 | Display P3 | **Canonical S054** (deck source, 1/10). Legacy `S037-` filename prefix; not renamed. |

| S009 | [S009-grammar-lesson-list-active-recapture.png](screenshots/S009-grammar-lesson-list-active-recapture.png) | active | 788×1083 | Display P3 (INFERRED, same tool as 13:36+ captures) | **Canonical S009** (final crawl). Lesson card 02 "Sự tin tưởng và thấu hiểu" visible. |
| S027 | [S027-conversation-chat-reply-received-active-recapture.png](screenshots/S027-conversation-chat-reply-received-active-recapture.png) | active | 788×1083 | as above | Content instance with chip "86"; template = S027. |
| S028 | [S028-conversation-score-popover-rendered-active.png](screenshots/S028-conversation-score-popover-rendered-active.png) | active | 788×1083 @2x (1576×2166 px) | screencapture default | **Canonical S028.** Rendered only in a display-region capture. macOS notification banner overlaps top-right (not app UI). |
| S055 | [S055-writing-grading-loading-sheet-active.png](screenshots/S055-writing-grading-loading-sheet-active.png) | active | 788×1083 | as above | Canonical. NB: window capture kept showing this frame after AX already held the verdict (render lag). |
| S056 | [S056-writing-feedback-sheet-correct-excellent-active.png](screenshots/S056-writing-feedback-sheet-correct-excellent-active.png) | active | 788×1083 | as above | Canonical (sheet re-opened via the sparkle chip). |
| S057 | [S057-writing-step2-editor-after-correct-next-active.png](screenshots/S057-writing-step2-editor-after-correct-next-active.png) | active | 788×1083 | as above | Canonical. |
| S058 | [S058-grammar-editor-empty-active.png](screenshots/S058-grammar-editor-empty-active.png) | active | 788×1083 | as above | Canonical; supersedes S010 (inactive) for colours. |
| S059 | [S059-grammar-editor-filled-incorrect-answer-submit-enabled-active.png](screenshots/S059-grammar-editor-filled-incorrect-answer-submit-enabled-active.png) | active | 788×1083 | as above | Canonical. |
| S060 | [S060-grammar-feedback-sheet-incorrect-active.png](screenshots/S060-grammar-feedback-sheet-incorrect-active.png) | active | 788×1083 | as above | Canonical. |
| S061 | [S061-grammar-feedback-sheet-correct-active.png](screenshots/S061-grammar-feedback-sheet-correct-active.png) | active | 788×1083 | as above | Canonical. |
| S062 | [S062-conversation-end-confirm-alert-no-message-active.png](screenshots/S062-conversation-end-confirm-alert-no-message-active.png) | active | 788×1083 @2x | screencapture default | **Canonical S062.** Alert panel appears only in display-region capture (`see` showed backdrop only). |
| S062 | [S062-conversation-end-confirm-alert-after-one-scored-turn-active.png](screenshots/S062-conversation-end-confirm-alert-after-one-scored-turn-active.png) | active | 788×1083 @2x | screencapture default | Re-capture (scored chat behind the alert; sent bubble ends with stray Telex "này"). |
| S063 | [S063-conversation-picker-fab-scenario-mode-selected-active.png](screenshots/S063-conversation-picker-fab-scenario-mode-selected-active.png) | active | 788×1083 | as above | Canonical. |
| S064 | [S064-conversation-scenario-chat-opening-active.png](screenshots/S064-conversation-scenario-chat-opening-active.png) | active | 788×1083 | as above | Canonical. |
Duplicate-ID note: S001 ×4, S002/S003/S005/S011/S013/S015/S037 ×2, S004 ×3 (one is the step-2 dimmed editor, see row), S007 ×2 (the old file was moved here under its real identity: *invalid for S007*). These are re-captures of one state, not distinct states.

## AX register (21 snapshots + 2 TXT-only reads, 43 files)

Raw AX archive; `.json` is authoritative (the `.txt` is a separate, slightly earlier read — snapshot IDs differ, element counts differ by 1, and for the editor menu the `.txt` is an **incomplete read**). S019–S050 have **no** raw AX archive (prose tables in the screen docs only).

| State | Files | JSON snapshot ID | Elements (json) | Notes |
|---|---|---|---|---|
| S001 | [home--default.json](accessibility/home--default.json), [home--default.txt](accessibility/home--default.txt) | `ps1_b2244379c6528efd2c98cd51e730f6d7` | 67 |  |
| S002 | [picker--writing-default.json](accessibility/picker--writing-default.json), [picker--writing-default.txt](accessibility/picker--writing-default.txt) | `ps1_d8c75e6a57baf070985348e249c60ee2` | 55 |  |
| S003 | [lesson-list--writing-default.json](accessibility/lesson-list--writing-default.json), [lesson-list--writing-default.txt](accessibility/lesson-list--writing-default.txt) | `ps1_917bc16a8079a81b33ded9e61b02079e` | 37 |  |
| S004 | [editor--writing-empty.json](accessibility/editor--writing-empty.json), [editor--writing-empty.txt](accessibility/editor--writing-empty.txt) | `ps1_2fd03097b7dc9967ed0d7bf5c6aa7565` | 22 |  |
| S005 | [editor--writing-filled-submit-enabled.json](accessibility/editor--writing-filled-submit-enabled.json), [editor--writing-filled-submit-enabled.txt](accessibility/editor--writing-filled-submit-enabled.txt) | `ps1_7d66eb7922419bd482032ded3f51f6c7` | 31 |  |
| S007 | [dialog--exit-confirm-alert.json](accessibility/dialog--exit-confirm-alert.json), [dialog--exit-confirm-alert.txt](accessibility/dialog--exit-confirm-alert.txt) | `ps1_76c579717d83e58bde414c91a169f39b` | 23 | `alert` 260×161; buttons "Ở lại" / "Thoát" 112×30; `is_dialog=true`. |
| S011 | [overlay--home-menu-open.json](accessibility/overlay--home-menu-open.json), [overlay--home-menu-open.txt](accessibility/overlay--home-menu-open.txt) | `ps1_fb6e6573e6448e6b00a6fb282ba75e60` | 80 |  |
| S013 | [flashcards--deck-detail.json](accessibility/flashcards--deck-detail.json), [flashcards--deck-detail.txt](accessibility/flashcards--deck-detail.txt) | `ps1_6e23824dc5ddf552aba8a2849bb0be14` | 85 |  |
| S015 | [srs--session-front.json](accessibility/srs--session-front.json), [srs--session-front.txt](accessibility/srs--session-front.txt) | `ps1_1ee8d3812e22af29011ee3b63598d09f` | 29 |  |
| S051 | [menu--editor-more-open.json](accessibility/menu--editor-more-open.json), [menu--editor-more-open.txt](accessibility/menu--editor-more-open.txt) | `ps1_73ba6118d21d7d145770a3b97ab35bf8` | 41 | Menu items: Hiện tất cả · Màu nền › · Hiển thị gợi ý · Từ điển bài · Thích · Không thích (menu 143×176). The `.txt` is an **incomplete read** (20 elements, no menu items) — use the `.json`. |
| S052 | [srs--card-back.json](accessibility/srs--card-back.json), [srs--card-back.txt](accessibility/srs--card-back.txt) | `ps1_9de21abee1e07ddd18d5f7934bd6b5d6` | 31 | Grade buttons 1m Học lại · 6m Khó · 1d Tốt · 4d Dễ (49×78); VERB badge; "Ví dụ" example. No grade pressed. |
| S053 | [menu--srs-more-open.json](accessibility/menu--srs-more-open.json) | `ps1_01b5b01e5cd1e73cae641eb049b4cbcf` | 45 | JSON only. Menu 144×82: Tự động phát · Màu thẻ · Hướng dẫn. No PNG exists (S053 is AX-only). |
| S054 | [flowletter--deck-gameplay.json](accessibility/flowletter--deck-gameplay.json), [flowletter--deck-gameplay.txt](accessibility/flowletter--deck-gameplay.txt) | `ps1_b57954f3c9f9c7901e4b5a533cb76f0a` | 34 | Deck "Nấu ăn & Ẩm thực", 1/10, LEVEL 1. |
| S028 | [conversation--score-popover-AX-EMPTY.txt](accessibility/conversation--score-popover-AX-EMPTY.txt) | — | — | TXT only. Proof that the popover has **no AX elements** (window chrome only). |
| S056 | [writing-feedback-sheet--correct.json](accessibility/writing-feedback-sheet--correct.json), [.txt](accessibility/writing-feedback-sheet--correct.txt) | `ps1_5a22f3e96542c76b4851967dc26d1ba6` | 39 | "Xuất sắc", word chips, Edit, Next, Thích/Không Thích, Sheet Grabber "Half screen". |
| S059 | [grammar-editor--filled.json](accessibility/grammar-editor--filled.json), [.txt](accessibility/grammar-editor--filled.txt) | `ps1_ea2f72bfb937e4a3c554cc8b01ad7836` | 20 |  |
| S060 | [grammar-feedback-sheet--incorrect.json](accessibility/grammar-feedback-sheet--incorrect.json), [.txt](accessibility/grammar-feedback-sheet--incorrect.txt) | `ps1_7439883e253b42b03bb4664a97c60c30` | 41 | Buttons "Sửa", "Tiếp theo". |
| S061 | [grammar-feedback-sheet--correct.json](accessibility/grammar-feedback-sheet--correct.json), [.txt](accessibility/grammar-feedback-sheet--correct.txt) | `ps1_02c0cf4346ae2466604a22ddff4c7072` | 22 | "Xem phân tích AI", "Câu tiếp theo", grabber "Collapsed". |
| (S010/S058 menu) | [menu--grammar-editor-more-open.json](accessibility/menu--grammar-editor-more-open.json), [.txt](accessibility/menu--grammar-editor-more-open.txt) | `ps1_acd6c8e183a2c8c48c438fbc800ad4ce` | 20 | Grammar editor "Thêm": Màu nền · Hiển thị gợi ý · Từ điển bài · 2 disabled · Thích · Không thích. AX only, no PNG; not a separate state ID (same PopupMenu as S051). |
| S062 | [dialog--conversation-end-confirm.json](accessibility/dialog--conversation-end-confirm.json), [.txt](accessibility/dialog--conversation-end-confirm.txt), [after-scored-turn.txt](accessibility/dialog--conversation-end-confirm-after-scored-turn.txt) | `ps1_114d68ec6293399c5cb1819a260e4c70` | 15 | Ở lại / Thoát. |
| S063 | [picker--conversation-fab-scenario-mode.json](accessibility/picker--conversation-fab-scenario-mode.json), [.txt](accessibility/picker--conversation-fab-scenario-mode.txt) | `ps1_9ff19dd5a478d4747b99a2eff83bde08` | 40 | Pill "Chế độ Kịch bản". |
| S064 | [conversation--scenario-chat-opening.json](accessibility/conversation--scenario-chat-opening.json), [.txt](accessibility/conversation--scenario-chat-opening.txt) | `ps1_a6140ad00d66379bbf0c0d4df292200f` | 25 | Role labels, "DỊCH CÂU NÀY", composer "Dịch sang tiếng Anh...", send "Lên". |
