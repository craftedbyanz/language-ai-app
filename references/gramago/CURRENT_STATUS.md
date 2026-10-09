# GramaGo UI/UX Research — Current Status

Audit date 2026-10-08 (read-only; no app interaction, no Peekaboo, no new captures, no commits). Sources read: the eight top-level docs, `FINAL_GAP_AUDIT.md` in full, SCREEN_INDEX/STATE_GRAPH/COMPONENTS/DESIGN_SYSTEM/tokens/UX_MAP/REPORT in full, headings + claim-bearing passages of the 15 screen docs and 3 flow logs, `docs/implementation-plan.md`, all 12 AX `.txt` snapshots (+ the SRS-menu JSON), and the 14 screenshots made after the gap audit plus a spot-check of ~12 originals. Pixel reads (window-active state from the traffic-light pixel, a few colour samples at 1x) were done with a throwaway decoder in `/tmp` and are **audit-side MEASURED, 1x, ±few levels**; they are not promoted into any token.
Tags follow CLAUDE.md: OBSERVED / MEASURED / ESTIMATED / INFERRED.

**Key discovery.** `FINAL_GAP_AUDIT.md` (written 12:56) is **no longer the latest state**. A verification pass ran 13:36–14:45 and left **14 PNGs and 25 AX files** (13 JSON + 12 TXT) that are **not referenced by any document** (0 of 14 PNGs and 0 of 25 AX files are linked from any `.md`; there is no log, no index row, no report entry for that pass). It closed some P0 items of the gap audit and settled its central hypothesis (inactive-window artefacts). Every document except the gap audit is older than 10:27 and none of the gap audit's "documentation fixes" has been applied (file mtimes; `design-tokens.json` 10:23).

---


> ## FINAL TARGETED CRAWL — 2026-10-09 (last app-interaction pass) — supersedes every status box below
>
> **Recommendation: READY_FOR_UI_UX_FREEZE.** Every P0 is VERIFIED or explicitly bounded (one DEFERRED_BY_AI_BUDGET). Log: [flows/final-targeted-crawl-log.md](flows/final-targeted-crawl-log.md).
>
> | Metric | Before crawl | Now |
> |---|---|---|
> | State IDs | 54 (S001–S054, S038 unused → 53) | **S001–S064** (S038 unused) = 63 IDs |
> | Distinct evidenced states | 53 | **62** (S058 is the active alias of S010) |
> | Fully verified (active + canonical + defining content + spec) | 29 / 53 | **≈ 40 / 62 (≈ 65 %)** = 29 + S055, S056, S057, S059, S060, S061, S062, S063, S064 (9 new) + S028 rendered + S009 & S010 (via S058) active (ESTIMATED; the 21 → 18 inactive-only states remain *partial*) |
> | PNGs / AX files registered | 63 / 25 | **77 / 43** — 0 broken links, 0 unindexed PNGs, 0 unreferenced AX, 0 ID collisions |
> | AI_CALLS_USED | — | **6 / 15** |
>
> | P0 | Item | Result | Evidence |
> |---|---|---|---|
> | P0-1 | Documentation reconciliation | **VERIFIED** (done earlier) | — |
> | P0-2 | Writing correct feedback, loading, Next → step 2 | **VERIFIED** — C03 settled for correct verdicts too | S055, S056, S057 |
> | P0-3 | Grammar filled editor, incorrect, correct feedback | **VERIFIED** — grammar uses distinct copy (MẸO, Sửa/Tiếp theo) and a compact correct sheet | S058–S061 |
> | P0-4 | One lesson-complete/result screen | **DEFERRED_BY_AI_BUDGET** — ≈ 9+ further gradings (writing 10 steps, grammar 20); no shortcut in either editor's "Thêm" menu. Explicit research gap; not needed to derive the reusable system | — |
> | P0-5 | Conversation end-of-session result | **VERIFIED_NO_RESULT_FOR_ONE_TURN** — "Kết thúc bài làm" → exit alert → lesson list, with 0 and with 1 scored user turn. A threshold for a real result may exist (alert says "chưa hoàn thành"); longer chats = P2 | S062 (+ scored-turn re-capture) |
> | P0-6 | Score popover contents | **VERIFIED** — rendered with one display-region capture; feedback sheet "Gần đúng", "Trôi chảy 88", SỬA LỖI, PHẢN HỒI, LỖI SAI ×3, NHỮNG ĐIỂM CẦN CẢI THIỆN ×2; **no AX elements** | S028-rendered + AX-empty proof |
> | P0-7 | Scenario mode | **VERIFIED** — FAB pill toggles "Chế độ Kịch bản" (persists; restored to "Trò chuyện Tự do"); Scenario chat = ConversationShell + ScenarioVariant | S063, S064 |
>
> **Remaining gaps (none blocks freeze):**
> - DEFERRED_BY_AI_BUDGET: lesson-set completion/result (writing & grammar).
> - UNRESOLVED: S023 chat "Thêm" popup visual (AX-only; items known); chip 86 vs "Trôi chảy 88" meaning; disabled 3rd chat-menu item label; window-scoped capture rendering quirks (popover/alert/lagging skeleton).
> - BLOCKED (policy): purchase/trial/restore, profile/account, logout, deletions, language/level "Xác nhận".
> - P1: active recapture of the 18 remaining inactive-only states; S047–S050 at 788×1083; Home carousel pages 2/3; SRS grade → next card; flashcard create/sort surfaces; history detail; Notifications page; AI-generator typed state; hex measurement of the new verdict/bullet colours (tokens `meta.finalCrawl` lists them as unmeasured).
> - P2: conversation result for longer chats; Scenario grading/next step/result; high score bands; "Xem phân tích AI"; Flow Letter solve/game-over; thumbs/word lookup; card styles; motion; dark mode; other Gramify 101 tiles.
>
> **Session caveats (OBSERVED):** GramaGo hung once and was restarted; the Telex input method injected stray text into the chat composer (one sent message ends with "này"); the user performed classifier-blocked steps manually. All new captures are active windows at 788×1083 logical.

---

> ## Reconciliation update — 2026-10-09 (documentation only; no app contact, no new captures, no commit)
>
> **Status: NOT_READY_TO_FREEZE** (unchanged: result states still missing) — but the written record is now **internally consistent**: this file was updated last, after SCREEN_INDEX, STATE_GRAPH, UX_MAP, COMPONENTS, DESIGN_SYSTEM, design-tokens.json, REVERSE_ENGINEERING_REPORT, README, the per-screen stale blocks and `docs/implementation-plan.md` (now marked SUPERSEDED).
>
> | Metric | Before | Now |
> |---|---|---|
> | Indexed states | 49 | **49** (S001–S050, S038 unused) — unchanged |
> | Distinct evidenced states | 53 (4 un-indexed) | **53, all registered** (S051 editor menu, S052 SRS back, S053 SRS menu [AX only], S054 deck-source Flow Letter) |
> | PNGs registered in SCREEN_INDEX | 49 of 63 | **63 of 63** (window state, viewport, encoding per file) |
> | AX files registered | 0 of 25 | **25 of 25** (13 snapshots; `.json` authoritative) |
> | Fully verified (active + canonical + defining content + spec) | 26 / 49 | **29 / 53 (55 %)** = 26 + S007 rendered + S052 + S054 (ESTIMATED; S051 is a 908 canvas → partial, S053 AX-only) |
> | Partially verified | 22 / 49 | 24 / 53 (21 inactive-only + S028 + S051 + S053) |
> | Contradictions fixed in docs | 0 | **22 of 25** (see table); 3 remain open |
> | Docs known-wrong claims | ≥ 12 | 0 known; claims about colours of the 21 inactive-only states are tagged CANDIDATE |
>
> **Three new findings from the reconciliation (all from existing PNGs):**
> 1. **Three colour encodings** coexist in `screenshots/`: untagged sRGB (S001–S018 originals, 18 files), an embedded "Display" profile (S019–S046, 27 files), Display P3 (13:36+ re-captures, 16 files; S007/S051 untagged but P3-valued, INFERRED). Raw hex from P3/Display files is **not** sRGB. **N1 and N3 are encoding differences, not window-state or gradient differences**: `#A855F7` (untagged) = `#9D59EF` (P3); `#3B82F6` (untagged) = `#4E80EE` (P3) = banner = deck bar = answer-box "default". The documented "at least four blues" collapse to ≈ 2–3 after normalisation (INFERRED). Window state still matters independently (ModeCard `#D4D4D5` vs `#3A81F5` is *not* an encoding effect).
> 2. **Radii now measured from active canonical captures** (circle fit, 1x, ±1.5 pt): Home ModeCard **≈ 28** (rms 0.34–0.40), alert **≈ 24** (rms 0.31), sheets **≈ 19.5**, SRS card ≈ 25.5, lesson/answer card ≈ 24, banner ≈ 17.5. **Scrim is per-surface**: alert ≈ 60 % grey (page → `#CACACA`), FAB/info sheet ≈ 21 % black (→ `#C4C5C6`), SRS tutorial → `#959595`, none behind S006/S028/S030/S045.
> 3. **Active topic cards read near-white** (`#FCFDFE`) vs inactive `#EDEEEF` — topic-card fill is now CANDIDATE.
>
> **Remaining P0 (6):** P0-2 writing correct feedback · P0-3 grammar feedback ×2 · P0-4 lesson-complete · P0-5 conversation result · P0-6 S028 contents · P0-7 Scenario decision. **P0-1 is done.** **One targeted crawl is still required.** Details in *Remaining Work* (updated below). The older sections that follow are the 2026-10-08 audit and are retained for evidence; where they conflict with this box, this box wins.

---

# Executive Summary

## Overall Status

**NOT_READY_TO_FREEZE**

Two blockers remain: (1) **no learning loop has a result half** — no correct-answer feedback, no grammar feedback of any kind, no lesson-complete screen, no conversation session result, no SRS grade/summary, no Flow Letter solve/game-over; (2) **the written record is internally contradictory and stale** — the colour/shape conclusions in DESIGN_SYSTEM, tokens and COMPONENTS were drawn partly from inactive-window captures that the newer captures now disprove, and none of the 14 new captures is indexed.

Rough completeness (ESTIMATED, ±10 pts; ratios over denominators this audit enumerated, not a measurement of "the app"):

| Metric | Value | Basis |
|---|---|---|
| Meaningful-state coverage | **≈ 59 %** (≈ 54 / 91) | 49 indexed + 5 newly closed items of the gap audit's 42 missing (M08, M11, M15, M24, M38-partial) over 91 |
| Navigation / chrome / templates | ≈ 85 % | Every product area reached; every funnel template captured |
| Result / completion states | **≈ 0 %** | None captured in any mode |
| Product areas strictly DONE | 2 of 29 listed areas | See classification below |
| Documentation accuracy | ≈ 60 % | ≥ 12 known-wrong claims still in the docs (Contradictions) |

## Completed

Genuinely finished (evidence is active-window or window-independent, edges OBSERVED, nothing material left that does not need a policy decision):

- **Language / CEFR preference screens** (S043, S044) — active, canonical; "Xác nhận" intentionally untouched (policy).
- **Home menu overlay** (S011) — now confirmed in an *active* capture as a full-window frosted overlay with five centred rows (new file `S011-…-active-verification`). Menu → Insight / Flow Letter edges were observed in session 2.
- **Exit-confirm alert** — now actually *rendered* (`S007-exit-confirm-alert-rendered.png`: "Thoát bài tập?" body + "Ở lại"/"Thoát", dimmed backdrop including the title bar) plus AX (`dialog--exit-confirm-alert`). Only "Ở lại" outcome is still INFERRED.
- **SRS card back** — captured active (`S052-srs-card-back-active.png`: translation, EN gloss, VERB badge, speaker, "Ví dụ" example, four grade buttons 1m/6m/1d/4d) with AX; **no grade pressed** (rule respected).
- **Editor "Thêm" menu** — rendered, active (`S051-writing-editor-filled-more-menu-open-active-908x1083.png`, 908×1083 capture that includes the popup spilling outside the window): *Hiện tất cả · Màu nền › · Hiển thị gợi ý · Từ điền bài · Thích · Không thích*.
- **Writing editor enabled-submit** — active (`S005-…-submit-enabled-active.png`): submit is a **dark filled circle**, not grey; resolves C09.
- **Content-funnel template** (picker → lesson list ×3 modes), **chat surface up to the score chip**, **Flow Letter chrome (7 screens)**, **Settings sub-page template**, **Streak/Insight zero-states** — template-level only (see Partial for what is missing in each).

## Partial

Meaningful coverage, but states/evidence missing (full list in Feature-Area table): Home, Writing, Grammar, Conversation, AI generator, Insight, Flashcards, SRS, History, Streak, Flow Letter, Profile, Settings (+ sub-pages), Gramify 101, Menus/overlays, Sheets, Loading states, Incorrect-answer feedback (writing only), Exercise feedback.

## Missing

Unique UI never captured anywhere in the repo:

1. Writing/Grammar **correct-answer** feedback sheet.
2. **Grammar** feedback — both verdicts (grammar editor has never been filled or submitted).
3. **Lesson-set completion/result** screen (writing and grammar).
4. Writing editor at **step ≥ 2** with correct progression; the "Next" target.
5. **Conversation end-of-session result** ("Kết thúc bài làm").
6. **Conversation Scenario mode** (entire UI).
7. SRS **graded → next card** and **session summary / queue empty**.
8. Flow Letter **drag, solved word, wrong word, hint revealed, level-up, round result, game-over**.
9. Flashcard **add-deck / add-card** forms and deck "Thêm" (⋯) menu; Filters/Newest popups.
10. **History detail**, Settings → Notifications and the other in-app rows.
11. Populated **Streak / Insight**.
12. **Error states** (AI quota/network/empty), any generic **loading** other than the chat typing indicator and a grading-in-flight frame.
13. Home **carousel pages 2/3 and chips → effect** in an active window; Home card styles.
14. Editor-menu items' effects ("Hiện tất cả", "Màu nền ›" submenu, "Từ điền bài"); SRS "Thêm" menu **visual** (AX only: *Hướng dẫn, Màu thẻ, Tự động phát*).
15. The AI-generator downstream (preset-row → lesson; typed/enabled CTA).

## Blocked

| Item | Why | Class |
|---|---|---|
| Purchase / trial / restore / plan switch / promo / subscription | CLAUDE.md rules 2–3 | BLOCKED (policy) |
| Edit profile, logout, language/level "Xác nhận" | Rule 3 | BLOCKED (policy) |
| Deck word delete | Rules 4–5 | BLOCKED (policy) |
| Rate / feedback / terms / privacy rows | Leave the app | BLOCKED (scope) |
| Populated voice list | Needs system voices | BLOCKED (environment) |
| Dark mode, motion timing | Not observable via still capture | BLOCKED (not required for a UI freeze) |
| Peekaboo MCP server | `CONNECTION_CLOSED` at session start; CLI is the workaround | BLOCKED (tooling, worked around) |
| Scenario mode, preference toggles (difficulty, sound, card style…), SRS grading, "Kết thúc bài làm" | Not forbidden by CLAUDE.md but state-changing; needs a user decision (rule 14) | AMBIGUOUS — awaiting user |

## Unresolved

Attempted, UI still unknown:

- **S028 score-popover contents** — popover panel renders blank in an *active* window (so it is not an inactive-window artefact). Content unknown.
- **S023 conversation "Thêm" popup** — AX only, never in a capture. (A technique that rendered the *editor's* popup exists — a 908-px-wide capture — but was apparently not re-applied to the chat; no evidence it was tried.)
- Typing the *correct* answer **and submitting** it — text entry now demonstrably works (S005-active shows the exact English translation in the field, `value_settable=true`), but there is no submit-and-capture afterwards. How the text was entered (set-value / ABC input / paste) is **not logged anywhere**.
- Why the window resized 788×1083 → 554×772 (cause UNKNOWN).
- "0ST" label in Insight; third (disabled) chat-menu item.

## Stale Documentation

| File / claim | Why not to trust it |
|---|---|
| `docs/implementation-plan.md` | Says "18 states", "~60 % complete", conversation "unverified, likely chat", "design-tokens.json has no colours", "MenuSheet", "Next → next lesson". Every one is superseded. **Do not use as input.** |
| `FINAL_GAP_AUDIT.md` | Best analysis in the repo, but dated 12:56: still lists M08/M11/M15/M24/M38 as missing, still says "`accessibility/` is empty / AX not archived", still treats the inactive-window theory as INFERRED (now settled). Its C-items are valid *except* where marked resolved below. |
| `README.md` / `REVERSE_ENGINEERING_REPORT.md` / `SCREEN_INDEX.md` | Say "49 states / 49 screenshots", "S038 unused", "Still unreached: correct-answer feedback…" (partly true) and describe no verification pass. `screenshots/` actually holds **63 PNGs**. REPORT unresolved #5 ("why Home cards render grey") is answered by evidence now. REPORT "Resume checklist" step 4 (consider ABC input) may already have been done. |
| `STATE_GRAPH.md` | Edge `S006 --Next--> S004 (same exercise)` is contradicted by the old S007 capture (sentence 2 highlighted). "Dialog" edges point at the old S007 file. No edges for the new states. |
| `UX_MAP.md` | Still shows "Insight (unexplored)", "PAYWALL (unvisited)", "card 03 (unvisited)", "Menu: bottom-anchored sheet". |
| `COMPONENTS.md` | MenuSheet (bottom-anchored), LessonCard "per-card gradient", WordSpan "red underline", ConfirmDialog "no pixel evidence" (now has), LetterTile defined twice, no ProgressStepper/HintChipBar/PagerDots. |
| `DESIGN_SYSTEM.md` | "Home mode card could not be measured… flat grey", lesson cards gradient, grammar accent orange, "dimmed backdrop behind sheets", page bg `#F9FAFB` exceptions, `previewCard 18.5` (554 capture), `#A855F7` editor card (see N1). |
| `design-tokens.json` | `modeCardObserved #D4D4D5` is an **inactive-window artefact** (active card measures `#3A81F5`, audit-side); `homeModeCard "not measured"`; `previewCard 18.5` unscaled; `windowSizesSeen` has no scale warning; six state colours listed in docs are missing. `meta.evidence "49 UI states"`. |
| `screens/writing-lesson-list.md` L73–74, `screens/conversation-mode.md` L42 | Per-card gradients. Active capture shows flat white cards. |
| `screens/home-menu.md` body (below its correction banner), `flows/grammar-and-flashcards.md` | Original text kept "unchanged"; includes the bottom-anchored claim, INFERRED-unvisited blocks. |
| `screens/writing-exercise-editor.md` L52/L71 | "Submit enabled = dark filled in screenshot" was marked wrong by the gap audit; the new active capture shows it *is* dark filled — **the original doc text was right for the wrong reason**, and the gap audit's C09 conclusion (grey) is itself wrong. |
| `screens/home.md` | Header edit is uncommitted (only modified tracked file); body is 341 lines, mostly INFERRED navigation that has since been observed. |

---

## Contradictions

Status (updated 2026-10-09 — see the right-most column; 22 resolved in docs, open: C16, C17, N2). Original key: **EVIDENCE-RESOLVED** = the repo's newest images settle it, docs still wrong; **OPEN** = still undecidable; **NEW** = introduced by the unindexed captures.

| # | Topic | Docs say | Latest evidence says | Status |
|---|---|---|---|---|
| C01 | Lesson-card fill | per-card gradients | Active `S003-…-active-verification`: flat **white** card, **navy CTA** (`#151C2B` sampled) | RESOLVED in docs (2026-10-09) |
| C02 | Grammar accent | orange | Lime CTA/title period in S009 (inactive capture, but lime cannot be an inactivity artefact) | RESOLVED in docs |
| C03 | "Next" after verdict | retries same exercise (STATE_GRAPH, writing-exercise-editor L80, home-to-writing L55) | Old S007 capture: progress segment 2 + 2nd sentence highlighted → advances a sentence in a 10-step loop | RESOLVED in docs (advances to step 2 after an INCORRECT verdict); **Next after a CORRECT verdict still unseen** — P0-2 |
| C04 | S007 is a captured dialog | index says dialog; file has none | New `S007-exit-confirm-alert-rendered.png` shows it | RESOLVED (old file re-registered as step-2 editor; S007 = rendered alert) |
| C05 | Menu bottom-anchored | 4 files | Active S011: frosted full-window overlay, centred rows | RESOLVED in docs |
| C06 | "Dimmed backdrop behind sheets" | DESIGN_SYSTEM | Alert, SRS tutorial, FAB overlay dim; floating card sheets (S006/S028/S030/S045) don't | RESOLVED in docs (per-surface scrim measured) |
| C07 | S006 bottom-attached sheet | feedback-sheet doc, STATE_GRAPH | Floating card, all corners rounded | RESOLVED in docs |
| C08 | Wrong words underlined | feedback doc, COMPONENTS | Struck through; reference words = pale-green chips; ✦ chip appears in bottom row | RESOLVED in docs |
| C09 | Submit-enabled colour | doc: dark; gap audit: grey | **Dark** (`#060D1E` centre, audit-side) in active; grey in inactive | RESOLVED in docs (gap-audit reading reverted) |
| C10 | Bottom group = counter | "word counter/progress" | 5 blurred hint chips + undo; top 10-segment progress bar (grammar 20) | RESOLVED in docs; 5-hint-chips vs 20-step relation UNKNOWN |
| C11 | Home grey mode cards | "cause unknown" | **Inactive-window artefact confirmed**: active Home mode card blue (`#3A81F5` centre); same for menu backdrop and Flashcard deck header | RESOLVED in docs + tokens (`modeCardObserved` quarantined) |
| C12 | Home mode-card radius unmeasured | not measured | Now measurable on active S001 (not yet done) | RESOLVED — measured ≈ 28 |
| C13 | Page bg `#F9FAFB` except two | DESIGN_SYSTEM | `#FFFFFF` page on 7 screens | RESOLVED in docs/tokens |
| C14 | Stale tags | many | — | RESOLVED (stale blocks bannered/replaced) |
| C15 / C19 | 554×772 values mixed with 788×1083 | `previewCard 18.5`, `ColorSwatchGrid 28`, `StyleTile`, "radii comparable" | ≈ 0.70× scale (gap audit) | RESOLVED in tokens/docs (554 values un-tokenised); **no 788 re-shoot of S047–S050** → P1-2 |
| C16 | "±1.5 pt" radius precision | — | Independent refit disagreed by ≈ 2.5 pt | OPEN (precision note kept: fits ±1.5 pt nominal, ≈ 2.5 pt disagreement seen) — P2-5 `--retina` |
| C17 | Filenames not naming the state | S009, S012, S007, + vague S008/S013/S014/S016 | Still unrenamed; new files add `S015-srs-card-front-inactive.png` (an *inactive* capture whose "active" means session-active) | PARTLY: registered with window/viewport/role; **files not renamed** (S054 keeps legacy `S037-` prefix; S004-step2 keeps `S004-` prefix; renaming deferred to avoid link churn) — OPEN |
| C18 | "Thêm" = Add | flashcards.md | ⋯ circle (menu), FAB is the add | RESOLVED in docs |
| N1 | Editor card colour | `#A855F7` (S004/S005, inactive) | Active S004/S005: `#9D59EF` (audit-side). Also user-configurable ("Màu nền ›" in the editor menu, "Màu ô nhập" in settings) | RESOLVED — same colour, different encoding |
| N2 | Flow Letter round length | "1/30 Nature" everywhere; gap audit "round = 30 words" | New `S037-…deck-gameplay-active`: deck "Nấu ăn & Ẩm thực", **1/10**, "LEVEL 1", no ★ pill, purple | DOCUMENTED (topic 1/30 vs deck 1/10); cause UNKNOWN — OPEN (P1-8) |
| N3 | Banner / blue token | `brand/home-blue #3B82F6` | Banner sample is `#3B82F6` inactive vs `#4E80EE` active at the same point (gradient or state-dependent — unresolved) | RESOLVED — same colour, different encoding (banner = deck bar = `#3C82F6` sRGB) |
| N4 | Duplicate state IDs | one file per ID | S001 ×4, S004 ×3, S015 ×3, S037 ×2, S007 ×2 | RESOLVED by registration (re-captures, one Canonical per ID) |
| N5 | "AX not archived / accessibility/ empty" | gap audit L483, handoff | 25 AX files exist (but unreferenced) | RESOLVED (AX registered) |
| N6 | Unscripted capture size | all captures 788×1083 or 554×772 | `S004-…more-menu` is **908×1083** (window + desktop to the right) | RESOLVED (908 = canvas; geometry 788) |

Contradictions not found: hex values repeated across docs (`#475DE8`, `#2CB782`, `#4383FC`…), CEFR bar colours, S019–S032 chat flows, paywall copy.

## State Coverage

Counted from SCREEN_INDEX (49 states, S038 unused) plus the unindexed evidence. Window state read from the traffic-light pixel on every PNG (audit-side MEASURED).

| Metric | Value |
|---|---|
| Documented (indexed) states | **49** |
| Distinct states actually evidenced | **53** (49 + editor "Thêm" menu, SRS card back, SRS "Thêm" menu [AX only, no PNG], Flow Letter deck-mode gameplay) |
| PNG files in `screenshots/` | **63** |
| …canonical 788×1083 | 57 (29 active · 28 inactive) |
| …alternate | 5 × 554×772 (S047–S050 inactive + 1 new active Home), 1 × 908×1083 (active editor-menu capture) |
| …active window | 31 (19 original S025–S044 + 12 new; includes the 554 and 908 captures) |
| …inactive window | 32 (30 original + the deliberate inactive Home control + the modal-dimmed alert capture, which a traffic-light test reads as inactive) |
| Indexed states with a file | 49 / 49 = 100 % (**not reliable**) |
| …defining content visible | 47 / 49 (fail: S023 popup absent, S028 popover blank; original S007 alert absent but now replaced by the new file) → 96 % |
| **Fully verified** (active window, canonical, defining content, spec exists) | **26 / 49 = 53 %** (S001–S005, S011, S013, S015, S025–S027, S029–S037, S039–S044) |
| Valid-but-not-active (S007 alert is modal; window is dimmed by it) | +1 → 27 / 49 = 55 % |
| **Partially verified** | 22 / 49 = 45 % — **21 inactive-only** (list below) + S028 (active but blank) |
| Inactive-only states list | S006, S008, S009, S010, S012, S014, S016, S017, S018, S019, S020, S021, S022, S023, S024, S045, S046, S047, S048, S049, S050 |
| Alternate-viewport states | 4 (S047–S050; all also inactive) |
| States later corrected by evidence | S001/S011/S013/S003/S004/S005 (grey→coloured), S007 (dialog now rendered), S015 (back added) |
| Orphan states (no incoming edge) | **0** in the index; 4 *new* states have no edge (editor Thêm menu, SRS back, SRS Thêm menu, deck-mode Flow Letter) — the flip (S015→back) and S013 "Flow Letter" tab → gameplay are **implied but not logged** |
| Weak-edge states | S007 "Ở lại" return (INFERRED); S028 dismissal (click-away only) |
| States with screenshot but no spec | the 4 new states + all re-captures (not linked from any doc) |
| States with spec but weak evidence | S023, S028, S047–S050, every inactive-only state for colour |
| AX coverage | **Raw AX archived for 13 views** → 10 of 49 indexed states (S001, S002, S003, S004, S005, S007, S011, S013, S015, S037) + 3 new. In-doc AX tables (prose) for S001–S018 and parts of S019–S046. **S019–S050: no raw AX archive**, and `conversation-mode`, `flow-letter`, `insight`, `language-and-level`, `paywall-plus`, `settings-subpages` docs carry **no snapshot IDs** (reproducibility zero) |
| Canonical-viewport coverage | 45 / 49 states (92 %) have a 788×1083 capture; 26 / 49 (53 %) active+canonical |

## Flow Coverage

| Flow | Status | Missing states | Blocking issue |
|---|---|---|---|
| Writing | **PARTIAL** | Correct verdict; enabled-submit → submit in active window; grading-in-flight; step ≥ 2; **lesson-complete**; word-lookup; menu-item effects | None technical any more (text entry works); needs **AI quota ≈ 10 gradings** |
| Grammar | **PARTIAL** (weakest) | Filled editor, submit enabled, **both feedback sheets**, step 2, completion; no active-window capture of S008–S010 | AI quota; none technical |
| Conversation (free chat) | **PARTIAL** | Score-popover contents, higher score band, **end-of-session result**, multi-turn, chat "Thêm" popup visual, errors | S028 render problem; "Kết thúc bài làm" ambiguity |
| Conversation Scenario mode | **BLOCKED** (decision) | Entire UI | FAB mode pill = preference change; never approved |
| AI generator (3 entry points) | **PARTIAL** | Typed/enabled CTA, preset row → start, loading, generated lesson | AI cost, rule 14 |
| Flashcards / SRS | **PARTIAL** | Add forms, Filters/Newest, graded → next card, session summary, empty queue, SRS "Thêm" visual | Grading mutates study data (ambiguous) |
| Flow Letter | **PARTIAL** | Drag, solve, wrong, hint, skip, level-up, round result, game-over | `peekaboo drag` still untried (no evidence) |
| History | **PARTIAL** | Detail/"Xem thêm", search, "Thêm", floating "+" | — |
| Insight / Streak | **COMPLETE (zero-state only)** | Populated variants | Needs a completed lesson first |
| Language / CEFR | **COMPLETE** | — | Confirm blocked by policy |
| Paywall | **BLOCKED** | Monthly-selected, scrolled end, purchase paths | Policy |
| Settings sub-pages | **PARTIAL** (3 of ~13 rows) | Notifications + in-app rows; the 3 sub-pages only at 554×772 | Some rows leave the app |
| Gramify 101 | **PARTIAL** | 6 other tiles (INFERRED same template); only capture 554×772 | — |
| Home | **PARTIAL** | Carousel pages 2/3, chip effects, below-fold cards, card styles | Card styles = preference change |

Strictly COMPLETE: 4 of 14 (Insight/Streak counted as one). Flows with **no result screen at all**: Grammar, AI generator, SRS, Flashcard management, History, Flow Letter gameplay.

## Component Coverage

Reading COMPONENTS.md (≈ 60 rows) against the screenshots, plus the gap audit's component analysis; confidence is for *structure and reuse*, not measurements.

| Component family | Status | Evidence |
|---|---|---|
| NavBar / BackButton / title bar | **VERIFIED** | 15+ states; 4 back renderings (plain ring, glass round, glass rounded-square, ✕) not unified |
| FloatingBottomBar, StreakPill, FlagButton | **VERIFIED** | S001 ×4 captures incl. active |
| ModeCard | **SUPPORTED** | Now active-confirmed *blue* (writing) + purple peek (grammar); fill/radius of cards 02/03 and carousel pages not captured; 4 style variants only from S049 preview |
| TopicSetCard, CategoryChip, PlusTile | **VERIFIED** (Plus tile gradient unspecified) | S002 active + S008/S020 |
| LessonCard | **SUPPORTED** | Active S003 settles white fill/navy CTA; per-mode CTA fill (lime, indigo) only from inactive captures; trailing "AI card" has no row |
| EditorShell / SourceTextCard / answer card | **SUPPORTED** | Active S004/S005; colour is user-configurable (N1) |
| **ProgressStepper**, **HintChipBar** | **CANDIDATE → SUPPORTED** | Visible in 5+ screenshots, documented nowhere |
| FeedbackSheet / WordSpan | **SUPPORTED** (one verdict, inactive window) | S006 only; correct/partial/loading/error missing; docs describe it wrongly |
| ConfirmDialog | **SUPPORTED** (was CANDIDATE) | Rendered pixels now exist (S007-rendered) + AX; radius/shadow unmeasured |
| Popup menu (editor "Thêm") | **SUPPORTED** (new) | Rendered, 6 items, 1 submenu; no component row |
| ChatBubble ×2, ChatComposer, TypingIndicator | **VERIFIED** | S022–S027 active |
| ScoreChip | **SUPPORTED** | One value (58, red) |
| ScoreChip popover | **MISSING** | Blank |
| FlashcardRow (WordRow), DeckHeader, SegmentedTabs | **VERIFIED** | Active S013 |
| SRSCard front/back, IntervalButtons | **SUPPORTED** (was front-only) | Active front + back; grade-pressed/next-card/summary missing |
| MenuOverlay (was MenuSheet) | **SUPPORTED** | Active S011; dismissal untested; name still wrong in docs |
| SettingsRow, toggle row, preview/swatch/style tile | SUPPORTED / **CANDIDATE** for the S048–S050 trio (554×772) |
| Sheet (unified: floating card / bottom-attached / full-window) | **MISSING as component** | 6 separate rows describe 3 presentations |
| Button / IconButton / Chip / Badge / Radio unification | **MISSING** | Duplicated concepts (gap audit table still valid) |
| PagerDots, HeroHeader, AICard, FAB family | **MISSING** | In screenshots, not in COMPONENTS |
| Flow Letter: LetterTile, GameHUD, GlassButton | **SUPPORTED** | Active S035–S042 + deck gameplay; LetterTile duplicated in COMPONENTS |
| InsightCard family | **CANDIDATE** | Zero-data only |
| Toast/CoachMark | **CANDIDATE** | First-run only |

## Design-System Coverage

| Design category | Confidence | Remaining gaps |
|---|---|---|
| Colours — page/surface/neutral hexes | **VERIFIED** (values); rule wrong | "Per screen family", 7 white-page screens (C13) |
| Colours — brand/accent (blues, lime, indigo, orange) | **SUPPORTED → at risk** | Active-vs-inactive mismatch observed (N3, N1); 21 states sampled only inactive; per-mode accent (writing grey/navy/lime, grammar lime×3, conversation blue/indigo) not tokenised |
| Colours — semantic | success VERIFIED; error SUPPORTED; **warning/score bands MISSING** | SRS grade icon colours (red ↩ orange clock blue ✓ green ★) visible in active S015 but not tokenised; wrong-word red unsampled |
| Colours — borders | **MISSING** | No hex, no width |
| Colours — text hierarchy | **SUPPORTED** | Darkest-glyph lower bound; text-on-accent/glass, link, disabled missing |
| Colours — scrims/overlays | **ESTIMATED** | Per-surface rule unwritten (C06); alert scrim now measurable from the new file (not done) |
| Selected/unselected states | **CANDIDATE** | ≥ 5 unrelated recipes; no token group |
| Typography — family | **MISSING** | Unknown |
| Typography — sizes/weights/line-height | **ESTIMATED, unsound below body** | AX frame ÷ 1.2; micro labels ≈ 35 % low per gap audit |
| Spacing | **SUPPORTED** | `space.5`/`space.6` fabricated ranges should be dropped |
| Radii | **SUPPORTED, 2 wrong** | `previewCard` unscaled 554 value; `homeModeCard` now measurable on active S001; ±1.5 claim optimistic |
| Borders (width) | **MISSING** | — |
| Shadows / elevation | **ESTIMATED** | "Cards are flat" contradicted for lesson/deck/SRS cards; one sheet sample |
| Icon sizing | **SUPPORTED** | — |
| Cards | **CANDIDATE** | Flat topic, shadowed lesson/SRS, muted panel, glass, plan, PLUS |
| Buttons | **CANDIDATE** | ≥ 7 recipes; submit disabled→enabled pair now exists in active S004/S005 and chat; no pressed/loading |
| Chips | **SUPPORTED** | trailing chevron undocumented |
| Inputs | **CANDIDATE** | no focus/error; caret visible in new captures but unrecorded |
| Navigation | **SUPPORTED** | bottom-bar blur, pager sizes missing |
| Overlays / dialogs / sheets | **ESTIMATED** | Alert style now visible but not measured; sheet corner radius/grabber missing |
| Dark mode / motion | **MISSING / BLOCKED** | — |

**Inactive-window contamination check (explicit):** *Yes — it contaminated the record.* 30 of the original 49 captures were inactive; the colours below were derived from them and are contradicted or unconfirmed by active captures: Home mode-card fill (`#D4D4D5` vs blue), grey submit/Next buttons, the flat grey Menu backdrop (`#DFDFE2` vs blue), lesson-card "dark" CTA tone, SRS/flashcard/editor tints (N1, N3). Colour *hexes sampled from S025–S044* (19 active originals) are not affected. Everything sampled from S001–S024 and S045–S050 should be treated as CANDIDATE until recaptured active.

**554×772 vs 788×1083 mixing check (explicit):** *Not resolved.* Positionally the original records kept S047–S050 separate, but **tokens/DESIGN_SYSTEM/COMPONENTS still carry unscaled values from them** (`previewCard 18.5`, `ColorSwatchGrid ≈ 28`, `StyleTile ≈ 126×86`, `ExplainerArticle ≈ 528×448`) with no scale warning. The new `S001-…554x772` capture is correctly named but is the only 554 Home measurement and must not be used for geometry. No 788 version of S047–S050 exists.

---

# Feature-Area Classification

Exactly one class per area (DONE / PARTIAL / MISSING / BLOCKED / UNRESOLVED / STALE).

| Feature area | Class | Why |
|---|---|---|
| Home | **PARTIAL** | Active default now captured and spec'd colours settled; carousel pages 2/3, chips' effect, below-fold AX-only cards, card styles open |
| Writing | **PARTIAL** | Funnel → editor → enabled submit (active) → incorrect verdict (inactive). No correct, no step 2, no completion |
| Grammar | **PARTIAL** | Funnel + empty editor only (inactive); zero feedback |
| Conversation | **PARTIAL** | Richest area (S019–S032); popovers/result/scenario missing |
| Conversation Scenario mode | **MISSING** | Never entered |
| Conversation score / result | **UNRESOLVED** | Chip seen (58, red); popover blank; end-of-session result never seen |
| AI generator | **PARTIAL** | Entry surfaces only |
| Insight | **PARTIAL** | Zero-state |
| Flashcards | **PARTIAL** | Deck list/detail; add forms and popups unseen |
| SRS review | **PARTIAL** | Tutorial + front + **back (new)**; grade/next/summary unseen |
| History | **PARTIAL** | Index only |
| Streak | **PARTIAL** | Zero-state |
| Flow Letter | **PARTIAL** | Chrome + two first-frame gameplay captures; no play |
| Profile | **PARTIAL** | Inactive capture; account actions blocked |
| Settings | **PARTIAL** | 3 of ~13 rows |
| Settings sub-pages | **PARTIAL** | 3 captured, all 554×772 + inactive |
| Language / CEFR preferences | **DONE** | — |
| Gramify 101 | **PARTIAL** | 1 of 7 tiles; 554×772 + inactive |
| Paywall | **BLOCKED** | Policy; top ≈ 60 % captured |
| Menu / overlays | **PARTIAL** | Home overlay done; editor menu done; chat menu, SRS menu visual, score popover unresolved |
| Exercise feedback | **PARTIAL** | One verdict family (writing, incorrect) |
| Correct-answer state | **MISSING** | Not captured in any mode; tooling no longer blocks it |
| Incorrect-answer state | **PARTIAL** | Writing only (inactive); grammar missing |
| Lesson completion / result | **MISSING** | None, any mode |
| Dialogs | **DONE** | One alert template, rendered + AX; "Ở lại" outcome INFERRED (minor) |
| Sheets | **PARTIAL** | S006/S030/S032/S045/S046 captured; no sheet radius; no unified model; S006 inactive |
| Popovers | **UNRESOLVED** | Score popover blank; chat "Thêm" not rendered (editor "Thêm" rendered) |
| Loading states | **PARTIAL** | Chat typing indicator only; grading/AI-generator loading unseen |
| Error states | **MISSING** | None |

Documentation-quality class for the record: **STALE** applies to `docs/implementation-plan.md` (and to the tokens/DESIGN_SYSTEM/COMPONENTS/UX_MAP claims listed above), not to a UI feature.

---

# Screenshot Audit — reliability flags

- **Inactive-window captures whose visual state may be affected** (32): all of S001–S024 originals, S045–S050, plus `S001-home-inactive-verification` (intended control) and `S007-exit-confirm-alert-rendered` (modal-dimmed, so its colours are scrim-affected by design). Highest design risk: S001, S003–S006, S010, S011 (original), S013 (original), S015 (original), S016, S018 (grey flame), S046 (sheet `#E9E9E9`), S014 (tutorial overlay).
- **Alternate viewport**: S047–S050 and `S001-…-554x772` (554×772, content ≈ 0.70×, title bar unscaled); `S004-…more-menu` is 908×1083 (canvas wider than window).
- **Misleading filenames** (CLAUDE.md: filename = verified state): S009 `grammar-question` (is lesson list), S012 `flashcard-study` (is deck list), original `S007-exit-exercise-confirm-dialog` (no dialog drawn), `S015-srs-session-active` (inactive capture), vague S008/S013/S014/S016.
- **Files that exist but are not reliable**: S023 (no popup), S028 (blank popover), original S007 (dimmed editor).
- **Duplicate IDs**: S001 ×4, S004 ×3, S015 ×3, S037 ×2, S007 ×2 — new captures did not receive new IDs, and none is indexed.

---

# Known Historical Issues — current status

Checked against repository evidence only; none assumed.

| Issue | Status now | Evidence |
|---|---|---|
| Correct-answer feedback missing | **STILL MISSING** (path unblocked) | S005-active shows the exact English sentence in the field and submit enabled; **no submit/feedback capture exists** (next file is the alert, 14:09) |
| Grammar feedback missing | **STILL MISSING** | No file after S010; no grammar AX |
| Lesson-complete / result missing | **STILL MISSING** | No such screenshot; none described in any doc |
| Conversation end-of-session result missing | **STILL MISSING** | "Kết thúc bài làm" never pressed (REPORT safety log; nothing newer) |
| Conversation score popover blank | **STILL UNRESOLVED** | S028 is still blank (active window) |
| Conversation "Thêm" popup not visually captured | **STILL UNRESOLVED**, with a lead | S023 unchanged; the editor popup *did* render via a 908-px capture — same method on the chat is untried (no evidence) |
| SRS card back missing | **RESOLVED** | `S052-srs-card-back-active.png` + `srs--card-back` AX. Grade/next/summary still missing |
| Flow Letter solve/result missing | **STILL MISSING** | Only first-frame gameplay (Nature 1/30; deck-mode 1/10) |
| `set-value` never tested | **UNKNOWN** | `value_settable=true` appears in AX; text got into the field at 14:02 by an undocumented method |
| `drag` never tested | **STILL UNTESTED** | No capture of dragging or a changed board |
| Inactive-window screenshot issue | **RESOLVED as a diagnosis; NOT resolved as a remediation** | Active re-captures prove the theory for Home/menu/deck; 21 states still inactive-only; docs/tokens unfixed |
| 554×772 alternate viewport | **STILL OPEN** | No 788 re-shoot of S047–S050; tokens unfixed; a new 554 Home capture was added |
| Empty `accessibility/` archive | **RESOLVED (files) / OPEN (use)** | 25 files, 12 usable `.txt` snapshots; **no doc links to them** and S019–S050 have none |
| Stale `docs/implementation-plan.md` | **STILL STALE** | Unchanged since 02:11; "18 states", "no colours" |

---

# Remaining Work

Estimates of interactions/calls are ESTIMATED. "AI quota" = consumes AI grading/chat usage. "Pref/data" = changes preferences or study/history data (not account/subscription/profile/purchase).

### P0 — required before freeze (**FINAL: see the Final Targeted Crawl box at the top — all P0 resolved or deferred**; earlier note: P0-1 DONE; P0-2…P0-7 unchanged)

| # | Exact missing state / evidence | Why it matters | App interaction | AI quota | Pref / data change | Est. calls |
|---|---|---|---|---|---|---|
| ~~**P0-1**~~ **DONE 2026-10-09** | **Documentation reconciliation pass (no capture):** index the 14 new PNGs + AX files with new IDs, window-state and viewport per row; fix C01, C02, C03, C05, C07, C08, C09 (flip back), C10, C11, C13, C14, C15/C19, C17; retag tokens (`modeCardObserved`, `homeModeCard`, `previewCard`, add missing 6 colours, N1/N3); delete `windowSizesSeen` ambiguity; rewrite UX_MAP/grammar-and-flashcards stale blocks; mark `docs/implementation-plan.md` superseded; update README/REPORT/STATE_GRAPH counts | A freeze of a self-contradictory record bakes wrong colours/behaviours into the clone | No | No | No | 0 app calls (≈ 15–25 edits) |
| **P0-2** | **Writing correct-answer feedback** + submit-in-flight + step-2 editor (+ the "Next" target) | Core loop has no correct verdict; settles C03 | Yes (S005-active → submit → capture ×3–4) | Yes (≈ 1–2 gradings) | Adds a history entry/streak | ≈ 8–12 |
| **P0-3** | **Grammar: filled editor, incorrect feedback, correct feedback** (one wrong answer, one right), in an *active* window | Grammar has zero feedback states and no active capture | Yes | Yes (≈ 2 gradings) | History entry | ≈ 12–16 |
| **P0-4** | **One lesson-complete/result screen** (grammar preferred if the set is shorter; writing is a 10-sentence loop) — then treat the other mode's as INFERRED same template, explicitly tagged | Without it no mode has an ending; also unlocks populated Streak/Insight | Yes (inspect editor menu "Từ điền bài"/"Hiện tất cả" first — they may be shortcuts; do not assume) | Yes (≈ 5–10 gradings if no shortcut) | History/streak change | ≈ 15–30 |
| **P0-5** | **Conversation end-of-session result** ("Thêm" → "Kết thúc bài làm") | Chat flow has no ending | Yes | Possibly 1 chat message | Ends a throwaway chat (user decision under rule 4) | ≈ 6–8 |
| **P0-6** | **Score-popover contents** (S028) — retry with the wide-capture technique that rendered the editor menu; stop after 2 methods and mark BLOCKED | Only feature with a *known-existing but invisible* UI; also yields the chat "Thêm" popup visual (P1-1) at nearly zero cost | Yes | 1 chat message if no chip exists | None | ≈ 5–8 |
| **P0-7** | **Scenario mode — decision + capture, or explicit waiver.** Needs the user to approve toggling the FAB mode pill (and revert), else record as BLOCKED(policy) in the freeze | A named product mode with zero UI; coachmark advertises it | Yes | Probably none to enter | Preference change (revert) | ≈ 6–10 |

P0-2…P0-4 can share one session; each will also give active-window recaptures of S006/S010 for free (closing those two inactive-only states).

### P1 — valuable but not blocking (P1-11 done 2026-10-09: Home ModeCard ≈ 28, alert ≈ 24, sheets ≈ 19.5, scrims measured; still open: sheet/alert bottom radii, ModeCard 02/03, active topic-card fill)

| # | Exact missing state/evidence | Why | App? | AI? | Pref/data? | Calls |
|---|---|---|---|---|---|---|
| P1-1 | Chat "Thêm" popup rendered (S023 repair); editor menu "Màu nền ›" submenu; SRS "Thêm" menu visual (AX exists: *Hướng dẫn, Màu thẻ, Tự động phát*) | Menu family complete | Yes (read-only) | No | No | ≈ 8–10 |
| P1-2 | Re-shoot S047–S050 at 788×1083, active | Removes viewport mixing for 4 states | Yes (navigate + capture) | No | No | ≈ 12–16 |
| P1-3 | Active re-capture of remaining inactive-only states in priority order: S008–S010, S012, S014, S016–S018, S019–S022, S045, S046 | Colours/materials of 21 states are unconfirmed | Yes (read-only) | No | No | ≈ 40–60 |
| P1-4 | Home carousel pages 2/3 (active) | Mode cards 02/03 fill + radius | Yes | No | No | ≈ 6 |
| P1-5 | SRS grade → next card; summary (10 cards) | Completes SRS loop | Yes | No | Mutates study data | ≈ 6 (one card) / ≈ 40 (full) |
| P1-6 | Flashcard add-deck / deck ⋯ menu / Filters / Newest (open, don't save) | Create/sort surfaces | Yes | No | No | ≈ 10–12 |
| P1-7 | History detail; Settings → Notifications | Missing screens | Yes | No | No | ≈ 8–10 |
| P1-8 | Flow Letter drag + solve one word; resolve N2 (1/10 vs 1/30) | Core game feedback | Yes (`peekaboo drag`) | No | Game progress | ≈ 10–15 |
| P1-9 | Populated Streak/Insight after P0-4 | Calendar fill, stats | Yes | No | — | ≈ 6 |
| P1-10 | AI-generator typed state (type, don't submit) | Enabled CTA | Yes | No | No | ≈ 6 |
| ~~P1-11~~ DONE | Token tidy from existing PNGs: measure Home active mode-card radius, alert/sheet corner radii, scrims from new alert capture | Fills `homeModeCard`, dialog tokens | **No** (pixel reads) | No | No | 0 app calls |

### P2 — optional / diminishing returns

| # | Item | Notes |
|---|---|---|
| P2-1 | Flow Letter round result / game-over / hint / skip | Mini-game; long play |
| P2-2 | Higher score band, multi-turn chat | AI calls |
| P2-3 | Thumbs state, word-lookup popover | Writes a rating |
| P2-4 | Home card styles (Regular/Mono/Minimal) | Preference change |
| P2-5 | 2× (`--retina`) capture of one canonical screen per card type | Tightens radii/hairlines |
| P2-6 | Motion capture, voice guide | Timing/environment |
| P2-7 | Other six Gramify 101 tiles | Template likely shared (INFERRED) |

---

## Minimum Path To Freeze (step 1 completed 2026-10-09; steps 2–5 remain)

Smallest sequence that reaches READY_TO_FREEZE (everything else is P1/P2 and may be waived with explicit tags):

1. **No-app (do first, ≈ 0 calls):** P0-1 documentation reconciliation + P1-11 pixel-read tokens. This alone converts the corpus from "contradicted" to "internally consistent". It is the cheapest and most valuable step.
2. **Get one user decision in a single message:** (a) approve ≈ 25–45 AI grading calls and the resulting history/streak entries; (b) approve toggling the FAB mode pill to enter Scenario mode (revert after); (c) approve pressing "Kết thúc bài làm" on a throwaway chat. If (b) is declined, tag Scenario as BLOCKED(policy) and drop P0-7.
3. **One focused crawl, active 788×1083 window (≈ 55–85 calls):**
   - P0-6 score popover + chat "Thêm" (attempt budget 2 methods; accept BLOCKED);
   - P0-2 writing correct feedback, step 2;
   - P0-3 grammar wrong + right feedback;
   - P0-4 one lesson-complete screen (inspect editor menu for shortcuts first);
   - P0-5 conversation result;
   - P0-7 Scenario mode (if approved).
4. **Second doc pass (≈ 10 edits):** index the new captures, reflect the new states in SCREEN_INDEX/STATE_GRAPH/COMPONENTS, re-derive affected tokens, and write the freeze note listing everything explicitly waived (S047–S050 viewport, SRS grade/summary, Flow Letter play, populated Streak/Insight, blocked/policy items).
5. Commit (user-triggered).

After step 1, the repo can already honestly be called "documentation-consistent but result-states-missing"; after steps 3–4, **READY_TO_FREEZE** with the waivers listed in 4.

**Is one more crawl required?** Yes (re-confirmed 2026-10-09) — one targeted crawl (≈ 55–85 calls, AI quota required, with 2–3 user approvals). The documentation pass and token re-measurement can and should happen without any app contact.
