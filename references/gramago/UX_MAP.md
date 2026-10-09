# GramaGo UX Map

Reconciled 2026-10-09 from 53 evidenced states. The first diagram is the session-1 map with stale branch labels corrected in place; session-2 additions follow it. Arrows = navigation; [M] = modal, [S] = sheet/dialog.

```
                        ┌──────────────────────────── HOME (S001) ────────────────────────────┐
                        │                                                                    │
   mode cards           │  bottom bar:  [left icon] [streak pill] [Menu pill] [right icon]   │
        │               │                  │            │ (S011 [S])         │               │
        ├─ 01 LUYỆN VIẾT ─► Topic Picker (S002)          ├─ Insight ─► S033 (zero-state)     ├─► History "Ôn tập" (S017)
        │                      │                         ├─ Plus ──► Paywall S045 (view-only)│
        ├─ 02 NGỮ PHÁP ──► Topic Picker (S008)           ├─ Học flashcard ─► Deck List (S012)│
        │                      │                         │        └► Deck Detail (S013)     │
        └─ 03 GIAO TIẾP ─► Conversation S019–S032 │            ├─ "Ôn tập" ─► SRS      │
                               │                         │            │    tutorial (S014)   │
                        Lesson List "Bài học"            │            │      └► active (S015)│
                        (S003 writing / S009 grammar)    │            └─ "Flow Letter" tab ─► S054 (implied)
                               │                         └─ Chuỗi của tôi ─► Streak (S018)  │
                        Exercise Editor [M]                     ▲                        │
                        (S004 empty → S005 filled)               └── also from streak pill  │
                               │  submit                                                  │
                        AI Feedback Sheet [S]                          right icon ─► Profile/Settings (S016)
                        (S006 "Chưa đúng"; Edit/Next/thumbs; Next → step 2)                    (13 rows; 4 blocked by policy)
                               │  "Đóng" on editor
                        Exit-confirm Dialog [S] (S007: "Ở lại" / "Thoát")
```

## Session-2 additions (OBSERVED)

```
Home ── card 03 GIAO TIẾP ─► Picker (S019/S020) ─┬─ topic card ─► Lesson list (S021) ─┬─ "Bắt đầu chat" ─► Chat [M] (S022–S028)
                                                   │                                    │      ├─ "Thêm" menu: Ẩn/Hiện bản dịch · Kết thúc bài làm
                                                   │                                    │      ├─ send ─► AI reply + score chip ─► popover [S] (S028, blank)
                                                   │                                    │      └─ "Đóng" ─► "Thoát bài tập?" (same as S007)
                                                   │                                    └─ AI card ─► AI scenario generator [M] (S029) ─► "Tạo Hội Thoại" [S] (S030)
                                                   ├─ "AI" nav button ─► S029
                                                   └─ FAB ─► expanded pills (S031) ─► ⓘ ─► "Hướng dẫn Cài đặt" [S] (S032)
Home ── Menu overlay (S011) ─┬─ Insight (S033)   ├─ Chơi FlowLetter ─► tutorial (S034) ─► lobby (S035/S039) ─┬─ Chơi ─► topics (S036) ─► round (S037)
                             ├─ Nâng cấp ─► paywall [S] (S045, via Plus banner)                            ├─ Độ khó (S040)  ├─ Cài đặt (S041)  └─ ? (S042)
                             ├─ Học flashcard ─► …(S012–S015)  └─ Chuỗi của tôi ─► Streak (S018)
Home ── flag "US" ─► Language (S043) ─► Level CEFR (S044)          Home ── "Tạo bài học với AI" ─► AI composer sheet (S046)
Home ── Gramify 101 tile ─► explainer article (S047)               Profile (S016) ─► Lesson Settings (S048) · Appearance (S049) · Voice (S050)
```

- **Per-mode feedback model differs**: writing = verdict half sheet; conversation = inline score chip per user message (+ popover); grammar feedback unseen.
- The flag is a **language + level preference screen**, not a quick toggle (only English selectable). The level feeds AI lesson generation (INFERRED).
- Three AI entry points exist: Home composer (S046), conversation scenario generator (S029/S030), picker "AI" buttons (S002/S008/S020). Only the last two were opened below the composer level, none submitted.
- Flow Letter is a mini-app with its own chrome; it closes with no confirm dialog even mid-round.
- Home customisation: card style (Regular/Mono/Minimal/Glass), card order, and the editor answer-box colour are user settings (S048/S049).

## User-facing journey summary

1. **Discover** on Home: greeting, AI prompt, Plus promo, three mode cards, topic chips, flashcard banner, Flow Letter, Gramify 101 tiles.
2. **Choose content**: mode → category rail (19 chips) → topic grid → lesson list (carousel) → exercise.
3. **Practise**: translate/correct in a shared editor shell (paragraph for writing, single sentence for grammar; conversation = chat, see session-2 additions).
4. **Get AI feedback** in a half sheet: verdict, corrected text with per-word spans, explanation, key improvements, Edit/Next, thumbs rating.
5. **Retain** via flashcards: decks, per-word rows (audio, status), SRS session with swipe grading and interval buttons (1m/6m/1d/4d).
6. **Track** progress: streak calendar (current/longest), history of past exercises grouped by type, settings/profile.

## Navigation architecture (for re-implementation)

- Root: Home dashboard with a floating glass bottom bar (shortcuts: history, streak+menu, settings).
- Content area: NavigationStack pushes (picker → lesson list). Nav bar 41 pt: leading Back 33×33, centered title.
- Exercises: full-screen modal editor (no Back; "Đóng" + confirm dialog on exit with unsaved work; no dialog for SRS sessions).
- Feedback: floating half-height card (all corners rounded) with grabber and PopoverDismissRegion; page behind it is **not** dimmed.
- Menu: full-window frosted overlay on Home, five centred rows (S011 active; dismissal untested).
- Utility screens: single pushes from the bottom bar.

Stale 'unvisited' labels removed. Still unreached: Scenario mode, conversation end-of-session result, grammar feedback (any verdict), correct-answer feedback, lesson-complete, SRS graded/summary, error states.

## Added 2026-10-09

```
Editor (S005) ── "Thêm" ─► popup S051: Hiện tất cả · Màu nền › · Hiển thị gợi ý │ Từ điển bài │ Thích · Không thích
SRS front (S015) ── flip ─► back S052 (4 grade buttons, none pressed) ; "Thêm" ─► S053 (AX only)
Deck detail (S013) ── "Flow Letter" tab ─► S054 deck-source round (1/10)
Editor (S004) ── "Đóng" ─► alert S007 (rendered)
```
- **Per-surface dimming**: alert dims whole window (≈60% grey); FAB/info sheet ≈21% black; other sheets none (C06).
- **Window-state caveat**: states marked † in [SCREEN_INDEX.md](SCREEN_INDEX.md) were captured with an inactive window — their structure is valid, their colours are not.

## Added 2026-10-09 — final targeted crawl (OBSERVED unless tagged)

```
Writing editor S005 ── submit ─► S055 grading skeleton ─► S056 "Xuất sắc" ── Next ─► S057 step 2 (same set)
                                              (grabber tap hides sheet; sparkle chip re-opens it)
Grammar  S009 ── "Sửa nhanh" ─► S058 ── type ─► S059 ── submit ─► S060 "Chưa đúng" ── Sửa ─► re-answer ── submit ─► S061 "Chính xác" ── Câu tiếp theo ─► question 2
Chat     S027 ── score chip ─► S028 feedback sheet ("Gần đúng", Trôi chảy 88)
         S023 ── "Kết thúc bài làm" ─► S062 alert ── Thoát ─► S021 lesson list      (NO result screen, 0–1 user turns)
Picker   S031 ── mode pill ─► S063 "Chế độ Kịch bản" (persists) ── S021 "Bắt đầu chat" ─► S064 Scenario chat ── Đóng ─► S062 ─► S021
```
- **One feedback family across all modes**: writing/grammar verdict sheets, the conversation score popover and the grading skeleton all use the floating FeedbackSheet (verdict header + SỬA LỖI diff + explanation + bullet lists). Variants differ in title colour/icon, section labels (KEY IMPROVEMENTS / MẸO / LỖI SAI + NHỮNG ĐIỂM CẦN CẢI THIỆN) and CTAs (Edit/Next · Sửa/Tiếp theo · Câu tiếp theo →).
- **Grammar correct = short path**: compact sheet with optional "Xem phân tích AI"; correct answers did not show a loading frame (INFERRED: exact match is checked locally).
- **Scenario mode** is a preference on the conversation picker FAB, not a separate screen; it re-skins the chat as a scripted translate loop (S064).
- **Not observed (bounded gaps):** lesson-set completion screen (DEFERRED_BY_AI_BUDGET), conversation result for longer chats (P2), Scenario grading/next step (P2).
