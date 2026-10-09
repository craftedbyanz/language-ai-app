# GramaGo State Graph

Reconciled 2026-10-09. 49 indexed nodes (S038 unused) + S051–S054 = 53, + **S055–S064 (final targeted crawl, 2026-10-09)** = 63 IDs / **62 evidenced nodes** (S058 ≡ S010, active). Edge tags: OBSERVED (destination verified by an AX read or capture after the action) / INFERRED.
All clicks return "unconfirmed" from Peekaboo but land; every OBSERVED edge below was verified by a following state read.

## Nodes

See [SCREEN_INDEX.md](SCREEN_INDEX.md) for docs/screenshots. Abbrev. for S001–S018: S001 Home, S002 picker-writing, S003 lesson-list-writing, S004 editor-empty, S005 editor-filled, S006 feedback-incorrect, S007 exit-dialog, S008 picker-grammar, S009 lesson-list-grammar, S010 editor-grammar, S011 home+menu, S012 deck-list, S013 deck-detail, S014 srs-tutorial, S015 srs-active, S016 profile, S017 history, S018 streak. S019–S050: see SCREEN_INDEX.

## Edges

```
S001 --card 01 LUYỆN VIẾT----------> S002   OBSERVED
S002 --topic card-------------------> S003   OBSERVED
S003 --"Bắt đầu"--------------------> S004   OBSERVED
S004 --type answer------------------> S005   OBSERVED
S005 --"Thêm"-----------------------> S051   OBSERVED (AX + 908px capture; items not pressed)
S005 --"Chuyển Tiếp" (submit)-------> S006   OBSERVED (submit enabled = dark filled circle; S005 active)
S005 --"Chuyển Tiếp" (submit)-------> S055 (grading) --verdict--> S056 (correct "Xuất sắc")   OBSERVED (final crawl)
S056 --"Next"-----------------------> S057 (step 2, same set)   OBSERVED — C03 settled for the CORRECT verdict too
S056 --grabber tap------------------> S057-like editor + sparkle chip ; sparkle chip --> S056   OBSERVED
S006 --"Next"-----------------------> S004-step2  OBSERVED after an INCORRECT verdict: progress segment 2 + 2nd sentence highlighted (10-step loop; file S004-writing-editor-step2-modal-dimmed-alert-absent.png). The earlier 'same exercise' reading is superseded (C03). Next after a CORRECT verdict: not seen.
S004 --"Đóng"-----------------------> S007   OBSERVED
S007 --"Ở lại"----------------------> S004   INFERRED (not chosen). S007 = rendered alert file S007-exit-confirm-alert-rendered.png
S007 --"Thoát"----------------------> S003   OBSERVED
S003 --Back-------------------------> S002   OBSERVED
S002 --Back-------------------------> S001   OBSERVED

S001 --card 02 NGỮ PHÁP-------------> S008   OBSERVED
S008 --topic card-------------------> S009   OBSERVED
S009 --"Sửa nhanh"------------------> S010   OBSERVED
S009 --"Sửa nhanh" (active)---------> S058 --type--> S059 --submit--> S060 (incorrect "Chưa đúng")   OBSERVED (final crawl)
S060 --"Sửa"------------------------> S059-like (same question, text kept)   OBSERVED
S059 --submit (correct)-------------> S061 (correct "Chính xác"; no loading frame seen)   OBSERVED
S061 --"Câu tiếp theo"--------------> S058-like question 2 (progress seg 2)   OBSERVED
S010 --"Đóng"-----------------------> S007   OBSERVED (same dialog template)
S007 --"Thoát"----------------------> S009   OBSERVED
S009 --Back-------------------------> S008   OBSERVED
S008 --Back-------------------------> S001   OBSERVED

S001 --Menu star icon---------------> S011   OBSERVED (frosted full-window overlay)
S011 --"Học flashcard"--------------> S012   OBSERVED
S012 --deck card--------------------> S013   OBSERVED
S013 --"Ôn tập (10)"----------------> S014   OBSERVED
S014 --"Đã hiểu, bắt đầu học"-------> S015   OBSERVED
S015 --tap card ('CHẠM ĐỂ LẬT')-----> S052   IMPLIED (capture + AX exist; click not logged)
S015/S052 --"Thêm"----------------> S053   OBSERVED in AX only (no PNG)
S015 --"Đóng"-----------------------> S013   OBSERVED (no exit dialog)
S013 --Back-------------------------> S012   OBSERVED
S012 --Back-------------------------> S001   OBSERVED

S001 --bottom-right icon (gear)-----> S016   OBSERVED
S016 --Back-------------------------> S001   OBSERVED
S001 --bottom-left icon-------------> S017   OBSERVED
S017 --Back-------------------------> S001   OBSERVED
S001 --streak pill------------------> S018   OBSERVED
S018 --Back-------------------------> S001   OBSERVED (second session)

--- Conversation (second session) ---
S001 --card 03 GIAO TIẾP------------> S019   OBSERVED (first visit shows the coachmark)
S019 --coachmark "Đóng"-------------> S020   OBSERVED
S020 --topic card "Mở rộng vốn…"----> S021   OBSERVED
S021 --"Bắt đầu chat"---------------> S022   OBSERVED (AI speaks first)
S022 --"Thêm"-----------------------> S023   OBSERVED (menu in AX only)
S023 --"Ẩn bản dịch"----------------> S024   OBSERVED ; S024 --"Thêm" > "Hiện bản dịch"--> S022-like   OBSERVED
S022 --type + send------------------> S025 -> S026 -> S027   OBSERVED (reply + score chip ≈ 7 s)
S027 --score chip-------------------> S028   OBSERVED (contents rendered in final crawl: feedback sheet "Gần đúng"/"Trôi chảy 88") ; S028 --×/click outside--> S027   OBSERVED (dismissed manually by the user in the final crawl)
S023 --"Kết thúc bài làm"-----------> S062 --"Thoát"--> S021   OBSERVED (final crawl, 0 and 1 user turns; NO result screen)
S022/S027 --"Đóng"------------------> S007 dialog (same copy) --"Thoát"--> S021   OBSERVED
S021 --AI card "Tạo tình huống?"----> S029   OBSERVED ; S020 --"AI"--> S029   OBSERVED (different scenario list)
S029 --"MÔ TẢ CHỦ ĐỀ"---------------> S030   OBSERVED ; S030 --✕--> S029   OBSERVED ; S029 --✕--> S021 / S020   OBSERVED
S031 --mode pill "Trò chuyện Tự do"--> S063 (pill "Chế độ Kịch bản")   OBSERVED ; S063 --pill--> S031 (restored)   OBSERVED ; mode persists across navigation
S021 --"Bắt đầu chat" (Scenario mode)-> S064 --"Đóng"--> S062 --"Thoát"--> S021   OBSERVED (final crawl)
S020 --FAB--------------------------> S031   OBSERVED ; S031 --ⓘ--> S032   OBSERVED ; S032 --✕--> S031 ; S031 --✕--> S020   OBSERVED
S021 --Back-------------------------> S020 --Back--> S001   OBSERVED

--- Insight / Flow Letter (second session) ---
S011 --"Insight"--------------------> S033   OBSERVED ; S033 --Back--> S001 (menu closed)   OBSERVED
S011 --"Chơi FlowLetter"------------> S034   OBSERVED ; S034 --"Chạm để bắt đầu"--> S035   OBSERVED
S035 --"Chơi"-----------------------> S036 --topic--> S037   OBSERVED ; S037 --Quay Lại--> S036 --Quay Lại--> S039   OBSERVED
S013 --"Flow Letter" tab-----------> S054   IMPLIED (deck-source gameplay, 1/10; click not logged)
S035/S039 --"Độ khó"----------------> S040 --Quay Lại--> lobby   OBSERVED
S035/S039 --"Cài đặt"---------------> S041 --Quay Lại--> lobby   OBSERVED
S035/S039 --"?"---------------------> S042 --Quay Lại--> lobby   OBSERVED
S039 --"Đóng"-----------------------> S001   OBSERVED (no confirm dialog, even with a round in progress)

--- Home extras (second session) ---
S001 --flag "US"--------------------> S043 --level row--> S044   OBSERVED ; S044 --Back--> S043 --Back--> S001   OBSERVED (nothing confirmed)
S001 --Plus banner------------------> S045   OBSERVED (view-only) ; S045 --✕--> S001   OBSERVED
S001 --"Tạo bài học với AI"---------> S046   OBSERVED ; S046 --chevron--> S001   OBSERVED
S001 --Gramify 101 tile "3 Chế Độ…"-> S047   OBSERVED ; S047 --Back--> S001   OBSERVED
S016 --"Cài đặt bài học"------------> S048 ; --"Giao diện"--> S049 ; --"Giọng đọc"--> S050   OBSERVED ; each --Back("Profile")--> S016   OBSERVED
```

## Structural findings

| Finding | Tag |
|---|---|
| Two navigation stacks: a content stack (Home → picker → lesson list; editors presented modally with "Đóng") and utility screens pushed from the bottom bar | OBSERVED / INFERRED |
| Editors (S004/S010) have no Back button and close via "Đóng" + confirm dialog; SRS session (S015) closes with no dialog | OBSERVED |
| The Home floating bottom bar exists only on Home; pushed screens use a nav bar with Back; modal editors use close buttons | OBSERVED |
| Every mode reuses the same picker → lesson list → editor template chain | OBSERVED |
| Home Menu sheet (S011) is a shortcut hub whose destinations are otherwise reachable from Home controls | OBSERVED (one item) / INFERRED (rest) |
| Modal dimming is per-surface (C06): alert (S007 ≈ 60% grey), FAB menu/info sheet (S031/S032 ≈ 21% black), SRS tutorial (S014 page → #959595); NONE behind S006/S028/S030/S045 | MEASURED |
| Content is dynamic: topic grids and lesson order reshuffle between visits | OBSERVED |
| Floating card sheets share a width of 445–446 (x 171–616) with all four corners rounded (radius ≈ 19–20 for S030/S032): S006 feedback, S028 score popover, S030 create, S032 info, S045 paywall. They are **not** bottom-attached (C07) and are **not** dimmed, except S032 (FAB scrim #C4C5C6) | MEASURED / INFERRED (shared container) |
| The Home Menu (S011) is a **full-window frosted overlay with 5 centred items** (active capture), not a bottom-anchored sheet (C05 resolved); its items push full screens or the paywall sheet; dismissal untested | OBSERVED |
| "Đóng" on exercises always asks "Thoát bài tập?" when work is unsaved (writing, grammar, **conversation**); SRS and Flow Letter close without a dialog | OBSERVED |
| Flow Letter is a self-contained mini-app (own chrome, own backgrounds, own back-stack "Quay Lại"/"Đóng") entered from the Home menu | OBSERVED |
| Preference screens (S043/S044/S048–S050) are pushed with Back labelled by the parent's title | OBSERVED |
| The AI feedback surface differs by mode: writing = half sheet with verdict, conversation = inline score chip + popover | OBSERVED |
| **Final crawl:** every AI verdict uses ONE floating FeedbackSheet family with verdict variants — writing correct (S056) / incorrect (S006), grammar incorrect (S060, MẸO + Sửa/Tiếp theo), grammar correct compact (S061), conversation score popover (S028, "Trôi chảy" score) — plus a loading skeleton (S055) | OBSERVED |
| Ending a chat (0–1 user turns) never shows a result: "Kết thúc bài làm" → same exit alert → lesson list | OBSERVED |
| Scenario mode is a persistent preference on the picker FAB; Scenario chat = translate-task loop in chat chrome (S064) | OBSERVED / INFERRED |

## Unexplored edges

See "Known but not explored" in [SCREEN_INDEX.md](SCREEN_INDEX.md). (Updated after final crawl: S028, Scenario mode and "Kết thúc bài làm" are now resolved; the lesson-complete result is DEFERRED_BY_AI_BUDGET.) Highest-value remaining: S028 score-popover contents (render problem), Conversation **Scenario** mode, "Kết thúc bài làm" result screen, a high-scoring chat message, correct-answer feedback for writing/grammar (Telex input source corrupts typing), S006 remaining controls, drag-based Flow Letter play, Notifications / invite / feedback pages.

## Reconciliation notes (2026-10-09)

- Edges *to* new nodes S051–S054 are OBSERVED or IMPLIED as tagged above; none was exercised in this documentation pass.
- Duplicate-ID files (S001 ×4, S004 ×3, S007 ×2 …) are re-captures; see the Capture register in [SCREEN_INDEX.md](SCREEN_INDEX.md). The old `S007` file is a step-2 editor, not a dialog.
- Orphans: none. Weak edges: S007 "Ở lại" return (INFERRED), S028 dismissal (click-away only), S015→S052 and S013→S054 (implied).

## Final-crawl notes (2026-10-09)

- New edges above are OBSERVED (AX read or capture after each action). Log: [flows/final-targeted-crawl-log.md](flows/final-targeted-crawl-log.md).
- Lesson-set completion (writing step 10 / grammar step 20 → result) remains **unobserved — DEFERRED_BY_AI_BUDGET**.
- Scenario grading/next-step and Scenario result: not explored (P2).
