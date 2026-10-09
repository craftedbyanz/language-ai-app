# GramaGo Reverse-Engineering Report

Updated 2026-10-08 (second session); reconciled 2026-10-09 (documentation only). (The brief named this file `UI_UX_REVERSE_ENGINEERING_REPORT.md`; the repo's file is `REVERSE_ENGINEERING_REPORT.md` and is what was read and updated.)

## Totals

| Metric | Value |
|---|---|
| Indexed states | **49** (S001–S050; S038 unused) + **4 added** (S051 editor menu, S052 SRS back, S053 SRS menu [AX only], S054 deck-source Flow Letter) = 53, + **10 added by the final targeted crawl** (S055–S064) = 63 IDs / **62 distinct evidenced** (S058 = active alias of S010). S028 is now rendered; S023 stays *partial* (popup AX only) |
| Screenshots in `screenshots/` | **77 PNGs** (71 at 788×1083 logical incl. 3 @2x, 5 × 554×772, 1 × 908×1083; 45 active / 32 inactive) — all registered in SCREEN_INDEX. AX archive: 21 snapshots / 43 files, all registered |
| New states in session 2 | 32 (S019–S050); verification pass 13:36–14:45 added S051–S054 + 14 re-captures |
| Screen docs | 15 files (6 new: conversation-mode, insight, flow-letter, paywall-plus, language-and-level, settings-subpages) |
| Flow logs | 2 files + [flows/session-2-conversation-and-extras.md](flows/session-2-conversation-and-extras.md); transitions are listed in STATE_GRAPH.md (grouped, not individually counted) |
| Peekaboo calls | First session 92 (MCP). Second session used the **CLI** and calls were **not counted**; the 500-call / 150-state budget was only tracked for states (49 of 150) |

## Verification pass and reconciliation (2026-10-08 13:36–14:45; docs 2026-10-09)

A later verification pass (undocumented at the time) re-captured Home, picker, lesson list, editor, menu, deck, SRS in an **active** window and archived raw AX. It settled the central hypothesis: the grey Home/Menu/deck colours were **inactive-window artefacts** (Home ModeCard active = blue). The 2026-10-09 pass indexed all of it, corrected the contradictions (see CURRENT_STATUS.md C01–C19, N1–N6), measured radii/scrim from existing PNGs, and found a second contamination source: **three colour encodings** (untagged sRGB / "Display" / Display P3) — N1 (`#A855F7` vs `#9D59EF`) and N3 (`#3B82F6` vs `#4E80EE`) are the *same colours* in different encodings, not state differences.

## What changed in this session

1. Verified the app's real state before touching it: it was on S018 (Streak). Back → Home confirmed (edge was previously INFERRED).
2. **Conversation mode** fully walked: picker, lesson list, free chat with a real AI exchange, per-message score chip, AI scenario generator, customize FAB and info sheet.
3. **Insight**, **Flow Letter** (7 screens), **language/level select**, **paywall** (view-only), **Home AI composer**, **Gramify 101** detail, three **settings sub-pages**.
4. **Visual detail pass**: exact hex colours from pixels, fitted corner radii, shadow falloff (see DESIGN_SYSTEM.md, design-tokens.json).

## Environment problems and workarounds (OBSERVED)

| Problem | Effect | Workaround |
|---|---|---|
| The `peekaboo` MCP server failed to connect (CONNECTION_CLOSED); its stdio start reported the ScreenCaptureKit lane owned by another process (PID 41509) | MCP tools unavailable; default `see` capture refused | Peekaboo **CLI** via Bash; `see --no-remote --capture-engine classic --path …`. Recipe saved to memory |
| The GUI session lock from the first session had cleared | none | verified before any action |
| App window **resized** 788×1083 → 554×772 between S046 and S047 with no action of ours; the window was also briefly "not found" (candidates listed as minimized) | S047–S050 are 554×772; sizes from them are not comparable | noted per file; cause UNKNOWN |
| Popovers/menus (S023 menu, S028 score popover) do not render into window/area/native `screencapture` captures | those two states are partial | AX text recorded where available; S028 contents UNKNOWN |
| Telex Vietnamese input method active | typed English is corrupted (`w→ư`, `s→ế`, doubled vowels) | a phrase avoiding those letters ("Hello, I am OK, thank you.") typed correctly |
| AX tree lags a visual transition by one read | a click looked like it did nothing | capture before concluding failure |
| 12 first-guess screenshot filenames were wrong once the image was viewed | renamed (CLAUDE.md: filename = verified state) | see SCREEN_INDEX housekeeping |

## Safety log — every state-changing action this session

All actions were within the user's brief ("Conversation mode, Insight, Flow Letter, AI generator, Paywall UI, flag/language switch, …") and CLAUDE.md rules 2–5. The following changed app state or consumed resources; none is purchase/subscription/profile/account:

| Action | Effect | Reversed? |
|---|---|---|
| Typed and **sent one chat message** to the AI ("Hello, I am OK, thank you.") | one AI round-trip: **consumed AI usage** (free plan may be metered; not checked) and produced a score | no |
| Pressed **"Thoát"** in the exit dialog | discarded that throwaway chat (nothing existed to lose besides what we created). Rule 4/5 literal reading ("never delete data") could include this; the same click was used in the first session. Flagging it so you can decide whether the rule should cover it | n/a |
| Dismissed the "Tùy chỉnh Bài học" coachmark | one-time hint, did not return | no |
| Chat "Thêm" → "Ẩn bản dịch", then "Hiện bản dịch" | view toggle | yes |
| Started a Flow Letter round (Nature, 1/30) and backed out | lobby now shows "Tiếp tục Nature" | no |
| Pressed **Escape** (no effect) and made **two** foreground clicks outside the S028 popover (one per time it was opened); two foreground typing calls (the first put corrupted text in the composer, the second replaced it with `--clear`) | made GramaGo the frontmost app; the corrupted text was never sent | n/a |
| Opened the paywall | **view only**; no plan, CTA, Restore, Terms or Privacy control touched | closed with ✕ |
| Opened language and level screens | **"Xác nhận" never pressed, no language/level selected**; left via Back | nothing changed |

Not done on purpose: any preference toggle (Flow Letter sound/haptics/difficulty, input colour, card style, reorder, Reset), AI submits (generator, Home composer), "Kết thúc bài làm", Scenario mode, and everything in the earlier blocked list.

## Navigation architecture (OBSERVED unless noted)

- SwiftUI `NavigationStack`; nav bar 41 pt; Back labelled by the parent's title on preference pages ("Profile", "Ngôn ngữ học").
- Modal exercises (writing, grammar, **chat**) close via "Đóng" + the same "Thoát bài tập?" alert. SRS and Flow Letter close with no alert, even mid-round.
- Floating card sheets share one width (445–446, x 171–616), all corners rounded, radius ≈ 19–20: feedback (S006), score popover (S028), paywall (S045), create (S030), info (S032).
- The Home Menu is a **full-window frosted overlay with five centred items** (confirmed in an active capture; C05 resolved).
- Flow Letter is a **separate visual world**: gradient backgrounds, glass controls, own back-stack.

## Product findings worth knowing for the clone

| Finding | Tag |
|---|---|
| The flag button opens a **language + CEFR-level preference screen**, not a quick toggle; only English is available (Korean/Chinese/Japanese "Coming soon") | OBSERVED |
| Level A1–C2 has a traffic-light colour scale and writing-ability descriptions; it conditions AI lesson generation | OBSERVED / INFERRED |
| Chat: AI speaks first, bilingual bubbles (EN + italic VI), per-**user**-message score chip (red dot + number + one-line caption) | OBSERVED |
| Score for a trivially short but correct sentence was **58** with the caption "grammatically correct but not natural in conversation" — scoring is style-aware, not a pass/fail | OBSERVED (n = 1) |
| Conversation has far less content than writing/grammar (1 topic "Mở rộng vốn từ tự nhiên" vs 12–13 cards) plus an AI generator | OBSERVED |
| Three modes have **three naming sets**: Home (Đoạn văn / Sửa câu / Hội thoại), internal (Paragraph / Quick Fix / Speaking; Translation / Grammar / Dialogue), Gramify 101 (Paragraph / Sentence / Conversation) | OBSERVED |
| Home card style (Regular / Mono / Minimal / Glass) and card order are user-configurable; answer-box colour is user-configurable | OBSERVED |
| The Home greeting changed by time of day ("Chúc ngủ ngon," earlier, "Chào buổi sáng," now) | OBSERVED (2 values); time-based is INFERRED |
| Insight: all-zero, fresh-account data; "0ST" label unexplained; weekly chart empty | OBSERVED |
| Paywall: annual pre-selected with 7-day trial (349.000đ/yr) vs monthly 3-day trial (49.000đ/mo), pricing in VND, benefits list of 6, Restore present | OBSERVED |
| The "Free" plan has AI usage limits ("hạn mức"); how the limit manifests (a block / modal) was **not** triggered | INFERRED |

## Unresolved uncertainties

1. ~~S028 score-popover contents~~ **RESOLVED (final crawl)**: feedback sheet, rendered via display-region capture.
2. ~~Scenario mode UI, "Kết thúc bài làm" result~~ **RESOLVED**: Scenario = S063/S064; ending a chat with 0–1 user turns shows only the exit alert S062 (no result). Longer chats, high score bands, Scenario grading: not explored (P2).
3. ~~Correct-answer feedback, grammar feedback~~ **RESOLVED** (S056, S060, S061). **Lesson-complete result: DEFERRED_BY_AI_BUDGET** (≈ 9+ gradings needed).
4. Flow Letter drag/solve/level-up/game-over (`peekaboo drag` untried). Round length: topic source 1/30, deck source 1/10 (N2: depends on source).
5. ~~Why Home mode cards render grey~~ **RESOLVED**: inactive-window artefact (active card is blue, radius ≈ 28).
6. Why the app window resized and briefly vanished.
7. Typography: family, sizes, weights; border widths; dark mode; motion timing.
8. Whether "Xác nhận" on the language screen saves-and-returns (never pressed).
9. Meaning of the "0ST" label in Insight and of the third (disabled) chat menu item.
10. ~~Whether "Next" advances on a correct verdict~~ **RESOLVED**: S056 → Next → S057 (step 2). `_SC_SEARCH_FIELD` elements still unexplained.
11. Score 86 on the chip vs "Trôi chảy 88" in the popover: relationship unknown.
12. Rendering quirks (OBSERVED, cause UNKNOWN): window-scoped capture misses the score popover and the exit-alert panel, and once lagged on the grading skeleton after the verdict arrived; display-region capture renders them.

## Blocked / deliberately skipped

| Branch | Reason |
|---|---|
| Purchase / trial / restore / promo / subscription | Safety policy; paywall viewed only |
| Edit profile, log out, language/level "Xác nhận" | Account/profile boundary |
| Word deletion in decks | Destructive |
| Settings preference toggles, Reset, reorder | Would change preferences; not needed to document UI |
| AI-submitting actions (generator, Home composer, preset scenarios) | Ambiguous cost/state effect → rule 14 |

## Resume checklist

1. Verify state with `peekaboo see --app GramaGo --tree --no-screenshot --fresh` (expect Home S001, window possibly 554×772).
2. Try the MCP server first; fall back to the CLI recipe in memory.
3. **(Superseded by the final crawl — all P0 resolved or deferred; see CURRENT_STATUS.md.)** Highest value next (see CURRENT_STATUS.md P0 list): result screens, grammar feedback, correct-answer feedback, S028 contents, Scenario mode (toggle in the FAB's "Trò chuyện Tự do" pill — a preference change, decide first), S028 contents, Notifications/invite/feedback pages, S006 remaining controls, a 2x (`--retina`) capture pass to firm up radii and hairlines.
4. Text entry into the editor already works (S005 active); method not logged — log it next time. Telex caveat still applies to the keyboard route.

## Final targeted crawl (2026-10-09)

Log: [flows/final-targeted-crawl-log.md](flows/final-targeted-crawl-log.md). **AI_CALLS_USED = 6 / 15** (writing grade ×1, grammar ×2, chat message ×2, scenario opening ×1, counted conservatively).
- New states: S055 grading skeleton · S056 writing correct · S057 step 2 · S058/S059 grammar editor empty/filled (active) · S060 grammar incorrect · S061 grammar correct · S062 conversation exit alert · S063 Scenario mode pill · S064 Scenario chat. Plus active recaptures S009, S027 (86) and rendered S028.
- State-changing actions (all authorised for this pass): 3 gradings (history/streak data may have been created), 2 disposable chats ended via "Kết thúc bài làm"/"Đóng" → "Thoát", 2 sets exited with "Thoát", Flow Letter game exited ("Thoát game?"), Scenario mode toggled on then **restored** to "Trò chuyện Tự do". No purchase, account, profile or deletion action.
- Environment: GramaGo hung once (≈ 90 % CPU, frozen pixels vs moving AX) and was restarted by the user. Vietnamese Telex injected stray text ("c", "C ti", "này") into the chat composer while the window was not frontmost; fixed by switching the input source to ABC. One sent message carries a stray "này". The permission classifier blocked several GUI clicks; the user performed those steps manually ("Bắt đầu chat" ×3, FAB open ×2, popover dismiss, composer clear).
- Reliable text entry: click field → `peekaboo paste "<text>" --app GramaGo --foreground` (set-value writes AX but the app ignores it).
