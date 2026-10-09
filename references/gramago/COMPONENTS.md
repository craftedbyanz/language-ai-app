# GramaGo Component Model

Reconciled 2026-10-09 from 53 evidenced states; stale rows corrected in place (marked *corrected*), new section "Reconciliation additions" at the end. Supersedes `specs/components.md` (Home-only evidence, kept for history).
Component names are ours, not the app's. Evidence counts are states where the component appears.
Tags: OBSERVED / MEASURED / ESTIMATED / INFERRED.

## Navigation & chrome

| Component | Evidence | Key measurements | Notes |
|---|---|---|---|
| **TitleBar** (macOS) | every state | controls 16×16; bar ≈ 32 pt | Standard window chrome, centered window title "Gramify" |
| **NavBar** (SwiftUI NavigationStack) | S002–S003, S008–S009, S012–S013, S016–S018 | bar 788×41; Back 33×33; titles 46–105×17 | Leading Back (identifier `BackButton`), centered AXHeading title; optional trailing button ("AI" 27×27, "Thêm" 27–46) |
| **FloatingBottomBar** (Home only) | S001 | icon buttons 36×36; streak pill 133×24 | Left history icon · centre streak + Menu pill · right settings icon; blur backdrop |
| **MenuOverlay** *(corrected; was MenuSheet)* | S011 active | rows 54 pitch; coloured round icons ≈ 30; the 502×242 AX frame is not the visual | Full-window frosted overlay, 5 centred shortcut rows over the dimmed/blurred Home; dismissal untested |

## Content display

| Component | Evidence | Key measurements | Notes |
|---|---|---|---|
| **SectionHeader** | S001 ×3, S002/S008, S013 | title 19, subtitle 13 frames; gap 3–6 | Bold title + grey one-liner |
| **ModeCard** (Home carousel) | S001 ×3 | active 670×385, inactive 670/669×369; gap 12–13 | Category pill + title + faded index numeral + description + "KHÁM PHÁ ↗" footer. **Active fill raw #3A81F5 (P3) = sRGB #0883FD, radius ≈ 28** (grey #D4D4D5 in older captures = inactive-window artefact); card 02 peeks lavender. Cards 02/03 fill/radius not captured |
| **PromoBanner** | S001 ×1 | 763×77 | Full-width blue CTA banner; sits in a paged collection (2 dots) |
| **FeatureBanner** | S001 ×2 | 763×160 | Gradient banner + CTA pill + preview cards (Flashcard, Flow Letter) |
| **TopicChip** (Home) | S001 ×10 | h 29; gap 8 | Pill, icon + label; first chip highlighted state |
| **CategoryChip** (rail) | S002/S008 ×19 | h 30–31; gap 8–11 | Horizontal rail; selected = orange outline (S002) |
| **TopicSetCard** (grid) | S002 ×12, S008 ×13 | 371×123; gap 9; grid 2 cols | Flat card, icon-in-circle, title, "N Sets/Qs" badge; PLUS variant inserted first in grammar grid |
| **PlusTile** | S008 ×1 | 371×123 | Marketing tile in content grid ("Chế độ Vô tận"); paywall boundary |
| **LessonCard** (rail) | S003, S009 | ≈650×289; white card; number "01…" 15–17 | *Corrected*: flat **white** card, hairline border, radius ≈ 24; navy CTA (writing, #131A29), lime CTA (grammar), indigo (conversation). NOT per-card gradients. Faint illustration bottom-right |
| **LevelPill** | S003, S009 | 79×19 | "CẤP ĐỘ · A1" translucent capsule |
| **FeatureTile** (Gramify 101) | S001 ×7 (off-screen) | 123×146; gap 12–13 | AX-only evidence |
| **LetterTile** (Flow Letter) | S001 ×5 (off-screen) | 27×27; pitch 34 | AX-only evidence |

## Exercise & feedback

| Component | Evidence | Key measurements | Notes |
|---|---|---|---|
| **EditorShell** | S004/S005, S010 | entry 763×460 | Đóng xmark + Thêm menu top; **10-segment progress bar** (grammar 20) under the nav; undo, 5 blurred hint chips, submit at the bottom; swap icon centred; submit disabled = grey ring #898990, enabled = dark filled circle |
| **SourceTextCard** | S004 ×1 | 733×429 | Read-only paragraph in light card (writing); grammar uses compact sentence 354×21 |
| **SubmitButton / UndoButton** | S004/S005/S010 | 26×26 / 33×26 | Circular; enable/disable on content |
| **FeedbackSheet** | S006 | content 446×458; grabber 77×18 | Floating card (all corners rounded, not bottom-attached) 445–446 wide: verdict + close, "SỬA LỖI" corrected word-spans, "GIẢI THÍCH" paragraph, "KEY IMPROVEMENTS" bullets, Edit/Next 200×38, thumbs 16×17 |
| **WordSpan** (corrected text) | S006 ×16 | 19-tall frames | *Corrected*: wrong words **struck through** (red), reference words = pale-green chips; tap-to-lookup hint; a ✦ chip sits in the editor's bottom row |
| **ConfirmDialog** | S007 (×2 uses) | alert 260×161; actions 112×30 | Rendered S007: radius ≈ 24, whole-window scrim ≈60% grey; title, body, "Ở lại" (neutral) / "Thoát" (red text) 112×30 |

## Flashcards / SRS

| Component | Evidence | Key measurements | Notes |
|---|---|---|---|
| **DeckCard** | S012 | 369×98 | Deck summary in carousel |
| **DeckHeader** | S013 | stats row | Title, description, 3 counters (new/learning/review) with sparkles/book/clock icons |
| **SegmentedTabs** | S013 | 369×35 ×2 | "Ôn tập (N)" / "Flow Letter" |
| **WordRow** | S013 ×8 | pitch 87 | word + VN definition + IPA + MỚI badge + speaker 27×23 + trash 13×14 |
| **StatusBadge** | S013 (MỚI), S006 (verdict), S010 (VERB/NOUN) | 15×8 … 86×20 | Small caps micro-badges |
| **SRSCardStack** | S014/S015 | 3 stacked cards | "CHẠM ĐỂ LẬT" flip hint; front card word + POS + IPA |
| **GestureTutorial** | S014 | rows: icon 27×27 + label + caption | 4 swipe directions with explanations |
| **IntervalButtons** | S014/S015 | 49×77 ×4; gap ~16 | "1m Học lại / 6m Khó / 1d Tốt / 4d Dễ" |
| **PrimaryButton** | S014 CTA, S006 Edit/Next, S003 Bắt đầu | 170×40 / 200×38 / 89×35 | Rounded filled; sizes vary by context |

## Utility

| Component | Evidence | Key measurements | Notes |
|---|---|---|---|
| **SettingsRow** | S016 ×13 | 751×61; pitch 62–63 | Full-width row, chevron implied |
| **AccountCard** | S016 | avatar 43×43; "Free" badge | Plan + name + language selector row 752×63 |
| **TrialBanner** | S016 | + "Upgrade" 70×29 | "Dùng thử Gramify Plus" |
| **SearchField** | S017 | 184×27 | Nav-bar embedded, placeholder "Tìm kiếm…" |
| **HistoryCard** | S017 ×3 | 123×142 + "Xem thêm" 51×9 | Thumbnail + type label (Đoạn văn/Câu/Hội thoại) + topic |
| **CalendarGrid** | S018 | 7 cols; cell pitch ≈102×34; chevrons 9×13 | Month view, Vietnamese weekday abbreviations |
| **StatTile** | S018 ×2 | flame/bolt icons | "HIỆN TẠI" / "DÀI NHẤT" with big number |
| **StreakPill** | S001 | 133×24 | "Chuỗi: N ngày", orange value + flame |
| **FlagButton** | S001 | 40×27 | "US" locale pill |

## Cross-cutting patterns

- Micro-labels in ALL CAPS with wide tracking, 8–9 pt frames ("CHẾ ĐỘ TẠO", "SỬA LỖI", "ON FIRE", "MỚI", "CHẠM ĐỂ LẬT") — used as section/eyebrow text everywhere. OBSERVED.
- Icon duality: Streamline Flex set for decorative/chrome icons (`--Streamline-Flex` names) + SF Symbols for functional glyphs (`flame.fill`, `xmark`, `chevron.right`, `trash.fill`, `magnifyingglass`…). OBSERVED.
- Whole-card buttons: one AXButton whose label concatenates all child text (mode cards, topic cards, banners, history cards). OBSERVED.
- Pill family: chips (29–31), streak (24), level (19), CTA pills — all fully rounded. OBSERVED shapes.
- Numbers as design: faded large index numerals on ModeCard/LessonCard ("01", "02"…). OBSERVED.

## Session-2 components

| Component | Evidence | Key measurements | Notes |
|---|---|---|---|
| **ChatBubble (AI)** | S022, S027 | white, hairline border, ≤ 706 wide, radius ≈ 14 | English line + italic VI translation beneath (#676D7A); toggled globally from the "Thêm" menu |
| **ChatBubble (user)** | S026, S027 | #475DE8 fill, white text, ≈ 122×30 for one line, radius ≈ 14 | right-aligned |
| **ScoreChip** | S027 | capsule #F3F4F6, red dot #E8504B + bold number + caption + chevron | whole chip is one button → popover (S028, contents unknown) |
| **TypingIndicator** | S026 | grey capsule with 3 dots | AI is "typing" for ≈ 6 s |
| **ChatComposer** | S022, S025 | pill ≈ 709×31 + round send 26 | send #D2D5DB disabled → #475DE8 enabled |
| **CoachMark** | S019 | toast card with icon, title, body, ✕ | one-time hint |
| **FAB + FanMenu** | S020, S031 | FAB ≈ 38×38 white circle; fan pills ≈ 192×34 | sliders icon; pills = current mode, voice, ⓘ, ✕; grey scrim #C4C5C6 |
| **ScenarioWheel** | S029 | selected row ≈ 40 pt black caps, others ≈ 22 pt grey | vertical list with bottom bar (eyebrow, description, round → button) |
| **CreateSheet** | S030 | 446 wide half sheet; multiline field; suggestion chips; CTA 'Bắt Đầu Luyện Tập' | CTA disabled until text |
| **InfoSheet** | S032 | half sheet, icon rows with tinted rounded squares | "Hướng dẫn Cài đặt" |
| **StatGrid / StatCell** | S033 | 3×2, icon + number + unit + caption | Insight |
| **DotMatrixCalendar** | S033 | 7 cols × 5 rows grey dots (#E5E7EB) | Insight month heat-map (INFERRED) |
| **WeekChart (empty)** | S033 | card #F9FAFB, 7 English weekday labels | rolling week |
| **GlassButton / GlassCard** | S035–S042 | pill ≈ 725×38; stats card ≈ 725×72 | translucent white fill on gradient; Flow Letter only |
| **LetterTile** | S035, S037, S042 | ≈ 40×40–44 glass squares, white bold letter | the game piece |
| **GameHUD** | S037 | "LEVEL 1 / Nature", "1/30", "★ 0", tick progress, 3 glass pills | |
| **RadioRow (glass)** | S040 | ≈ 725×38, check circle at right | |
| **Toggle** | S041, S048 | track on #2CB782 / off #B9B9BA | |
| **LanguageCard** | S043 | ≈ 750×62, radius ≈ 17, flag + 2 lines + 'Coming soon' pill | disabled style = dimmed text |
| **LevelRow** | S044 | title + 1–2 line description + radio; 3-pt left bar in CEFR colour | |
| **FullWidthCTA** | S043 (#4CD0EC), S044 (#2CB782), S045 (#131827) | ≈ 746×40–42, pill-ish | accent differs per screen |
| **PlanCard** | S045 | selected: #F0F5FF fill + #4383FC border; badge 'Giảm 40%' | radio + per-month price + trial copy |
| **BenefitRow** | S045 | SF-symbol icon + title + 2-line body | 6 rows |
| **AIComposerSheet** | S046 | full-window; chips + gradient-bordered input + send | |
| **ExplainerArticle** | S047 | illustration card (≈ 528×448 *alt viewport*, #F1EFFD) + H1 + bullets | Gramify 101 |
| **ColorSwatchGrid** | S048 | 4×2 round swatches ≈ 28 *(554×772 alt viewport; not canonical)* | answer-box colour setting |
| **StyleTile** | S049 | ≈ 126×86 *(554×772 alt viewport; not canonical)* white card, dot + label, selected = dark outline | Regular/Mono/Minimal/Glass |
| **ReorderRow** | S049 | pastel icon tile + 2 lines + ≡ handle | Home card order |
| **EmptyStateCard** | S050 | icon + title + body + link | voice models |

## Component inventory for the clone

Priority for re-implementation (session-1 list; add ChatBubble, ScoreChip, ChatComposer, FAB+FanMenu, PlanCard, LanguageCard, LevelRow, StatGrid): NavBar, SectionHeader, ModeCard, CategoryChip, TopicSetCard, LessonCard, EditorShell, FeedbackSheet, ConfirmDialog, MenuOverlay, FloatingBottomBar, DeckCard, WordRow, SRSCardStack, IntervalButtons, SettingsRow, CalendarGrid, StatTile, HistoryCard, SearchField.

## Reconciliation additions (2026-10-09)

| Component | Evidence | Notes |
|---|---|---|
| **ProgressStepper** | S004–S007, S051 | 10 segments (writing), 20 (grammar); first segment green when step 1 done; idle #E5E7EB; step 2 highlights the 2nd sentence |
| **HintChipBar** | S004/S005/S006 | 5 blurred chips + undo, bottom row; relation to the 20-step grammar bar UNKNOWN |
| **PopupMenu** | S051, S053 (AX) | macOS-style menu, 143–144 wide, separators, one submenu (Màu nền ›) |
| **ConfirmDialog (rendered)** | S007 | see corrected row above; radius 24 |
| **GradeButtons** (SRS) | S052 | 4 round buttons, 49 wide, caption above (1m/6m/1d/4d) and label below; icon colours red/orange/blue/green (see tokens) |
| **PagerDots** | S001, S003 | active = lime (Home) / dark pill (lesson list); 16 dots on lesson list |
| **HeroHeader** | S002/S003/S008/S009 | eyebrow + two-tone title with coloured period (lime/blue) |
| **FAB family** | S020, S031 | listed under FAB + FanMenu above |
| **Sheet (unified)** | S006, S028, S030, S032, S045 | ONE component, 445–446 wide floating card, radius ≈ 19–20; only S032 sits over a scrim |
| LetterTile | duplicated above (Flow Letter row, session-2 row) | treat as one |

Naming: *MenuSheet → MenuOverlay*; sheet-family rows above (FeedbackSheet, CreateSheet, InfoSheet, PlanCard sheet) share the unified Sheet geometry. Radii in tokens: ModeCard ≈ 28, LessonCard/AnswerCard ≈ 24, Sheet ≈ 19.5, SRS card ≈ 25.5, Banner ≈ 17.5. Rows citing S047–S050 sizes (ColorSwatchGrid ≈ 28, StyleTile ≈ 126×86, ExplainerArticle ≈ 528×448) are **554×772 values (~0.70×) — not canonical geometry**.

## Final-crawl additions (2026-10-09)

Scenario is recorded as a **variant of the conversation shell**, not a separate design language. Shared components are not duplicated.

| Component | Evidence | Notes |
|---|---|---|
| **FeedbackSheet — verdict variants** | S056, S006, S060, S061, S028 | Same floating sheet (≈ 445 wide, grabber). Header = icon + coloured title: ✓ green "Xuất sắc" (writing correct) · ✕ red "Chưa đúng" (grammar incorrect) · ✓ green "Chính xác" (grammar correct, **compact**) · 👍 blue "Gần đúng" + "Trôi chảy NN" score (conversation). Body sections by mode: SỬA LỖI diff (all except grammar-correct) · GIẢI THÍCH (writing/grammar) / PHẢN HỒI (chat) · KEY IMPROVEMENTS (writing) / MẸO (grammar, lime bullets) / LỖI SAI (orange) + NHỮNG ĐIỂM CẦN CẢI THIỆN (purple) (chat). CTAs: Edit + Next (writing) · Sửa + Tiếp theo (grammar incorrect) · full-width navy "Câu tiếp theo →" + link "Xem phân tích AI" (grammar correct) · none, close × (chat). Thumbs Thích/Không thích on writing. |
| **FeedbackSheet — loading skeleton** | S055 | Title "Đang chấm điểm..." with spinner; grey skeleton bars in each section; secondary "Huỷ" button. |
| **AnswerRecapBox** | S061 | "CÂU TRẢ LỜI CỦA BẠN" label (green ✓) + the user's answer in a grey rounded box. |
| **VerdictReopenChip** (sparkle) | S057, S060 | ✦ chip that appears at the start of the HintChipBar after a verdict; re-opens the last FeedbackSheet. |
| **ScoreChip** | S027 | Inline under the user bubble: coloured dot + score + one-line summary + ›; opens the FeedbackSheet (S028). |
| **ConfirmDialog — conversation copy** | S062 | Same alert as S007; body "Bạn chưa hoàn thành bài tập. Tiến độ sẽ không được lưu nếu bạn thoát bây giờ." Used by "Kết thúc bài làm" and by Scenario "Đóng". |
| **ConversationShell** | S022, S064 | Close × · centre (title OR ProgressStepper) · ⋯ Thêm; eyebrow line; bubble list; composer + send. |
| **ScenarioVariant** (of ConversationShell) | S063, S064 | Activated by the FAB mode pill ("Chế độ Kịch bản", script icon). Swaps the centred title for a **ProgressStepper** (8 segments), adds **RoleLabels**, uses a grey-filled AI bubble with VI line + italic EN gloss, shows a **TranslationTaskBubble**, and uses **ScenarioComposer**; adds the shared **HintChipBar**. |
| ProgressStepper | (shared) S004, S058, S064 | Same component as the editors: 10 (writing) / 20 (grammar) / 8 (scenario) segments (MEASURED: segment count from S058/S064 pixel rows); current = light tint, done = solid. |
| **RoleLabels** | S064 | Small grey caption above each bubble ("Người bán hàng" left, "Khách hàng" right). |
| **TranslationTaskBubble** | S064 | Blue right-aligned bubble with the Vietnamese line to translate + micro-label "DỊCH CÂU NÀY"; tail dot. It is the task, not a sent message. |
| HintChipBar | (shared) S004, S058, S064 | Same blurred chips row as the editors; sits above the composer in Scenario. |
| **ScenarioComposer** | S064 | ChatComposer with placeholder "Dịch sang tiếng Anh..." and send "Lên" (disabled when empty). Free chat: "Nhập tin nhắn...". |

Note: the grammar ProgressStepper has **20** segments in the active capture S058 (confirms the earlier S010 count). A draft of this section said 18; that was wrong.
