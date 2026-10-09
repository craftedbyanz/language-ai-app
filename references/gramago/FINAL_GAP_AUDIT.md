# GramaGo UI/UX Research — Final Gap Audit

Audit date 2026-10-08. **Audit only**: no app interaction, no application code, no packages installed. Evidence = the repo's own indexes and docs, all 49 PNGs in `screenshots/` (each viewed), plus pixel reads of those PNGs (stdlib decoder in `/tmp`, not in the repo; re-derivable from the screenshots). Tags follow CLAUDE.md: OBSERVED / MEASURED / ESTIMATED / INFERRED. Anything labelled **audit-side** was produced by this audit, not by the crawl, and is *not* promoted into the tokens.

# Executive Summary

The crawl reached every product area (17/17) and the internal bookkeeping is sound (49 states, 49 screenshots, 49 index rows, 144 doc links, 0 broken). But the research is **not freeze-ready**. Three things drive that:

1. **Flows stop before their result states.** No writing/grammar lesson-complete screen, no correct-answer feedback, no grammar feedback of any kind, no conversation end-of-session result, no SRS flip/grade/summary, no Flow Letter solve/game-over. 11 of 16 flows end before the screen a user reaches when they finish.
2. **Documented "facts" contradicted by the screenshots** (details in *Contradictions Found*, C01–C19). The ones that change a rebuild: the writing editor is a **10-segment, sentence-by-sentence** flow and "Next" **advances to the next sentence** (S007's capture shows sentence 2 highlighted; the docs say "same exercise"); the saved lesson-card captures contradict the documented per-card gradients (flat white) and **the docs' side is unresolved** because every such capture was taken with the window inactive; grammar's accent is **lime**, not orange; the S006 feedback sheet is a **floating card**, not bottom-attached; wrong words are **struck through**, not underlined; the Home menu is still described as bottom-anchored in four files.
3. **Two capture-validity problems affect tokens.** (a) S047–S050 (554×772) render content at ≈ 0.70× (Back button 25 px against 36 px; window width ratio 0.703) while the OS title bar does not scale, so every size and radius from them needs dividing by ≈ 0.70. The docs say radii and relative layout are comparable; they are not. (b) **30 of 49 captures were taken with the window inactive** (grey traffic lights, pixel-verified), including all four Home captures. Inactive windows grey out materials and tinted controls: the "flat grey" Home mode card, the grey submit/Next/CTA buttons and the grey S046 sheet are probably artefacts. The docs record these as unexplained or as "disabled".

## Completion Score

No figure below is a measurement of "the app"; each is a ratio over a denominator **the audit enumerated**, so treat them as ± 10 points.

| Metric | Score | Basis |
|---|---|---|
| Product-area coverage | **≈ 60 %** | 17/17 areas reached: 2 COMPLETE (Language/CEFR; Gramify 101 at template level, non-canonical viewport), 13 PARTIAL, 1 BLOCKED (Paywall), 1 UNRESOLVED (Menu/overlays: three popups never rendered), 0 NOT EXPLORED. Weights COMPLETE 1.0 / PARTIAL 0.55 / BLOCKED-but-template-captured 0.7 / UNRESOLVED 0.4 → 10.25/17. Strictly complete: 2/17 ≈ 12 %. The weights are a judgement, not a measurement. |
| Screen-template coverage | **≈ 73 %** | ≈ 36 distinct templates seen vs 13 known to exist but never seen: lesson-set completion, conversation result, SRS summary, Flow Letter result, Scenario chat, SRS card back, add deck/card form, history detail, Notifications, word-lookup popover, score-popover contents, exit alert (visual), popup menus (visual). Shared templates (picker, lesson list, editor shell) counted once. |
| Meaningful-state coverage | **≈ 54 %** | 49 captured vs 42 further meaningful states enumerated in *Missing Unique States* (M01–M42; the audit's list, not exhaustive). Count-based scores overstate: the 49 states contain **zero** result/completion states and one of four feedback families. |
| Screenshot coverage | **90 %** of captured states (44/49); **48 %** of all enumerated states (44/91) | Strict = file exists, is indexed, shows the state's defining content, and the filename describes that state. Fail: S007 (alert absent), S023 (menu absent), S028 (contents absent), S009 and S012 (filename names a different screen). 82 % (40/49) if the four vague session-1 names (S008, S013, S014, S016) also fail; 73 % (36/49) if the four 554×772 captures are also treated as non-canonical. AX-only evidence is not counted. |
| Flow coverage | **5/16 ≈ 31 %** strict | 5 flows end where they naturally (or by policy) end: Insight, Streak, Gramify 101 article, Language/CEFR, Paywall. 11 stop earlier. ≈ 60 % if a partial flow earns half credit and *not explored* earns none. |
| Component-system confidence | **≈ 60 %** | Chrome, lists, cards, chat, settings are well supported. Weak: no generic Sheet/Popover, no ProgressStepper, no hint-chip bar, no HeroHeader, no FAB family, a duplicated LetterTile, MenuSheet mis-described, LessonCard fill wrong, WordSpan styling wrong. |
| Design-system confidence | **≈ 50 %** | Colour inventory is strong and sampled. Small-text sizes are unsound, borders absent, the "cards are flat" claim is contradicted, no mode-accent token, and the JSON omits 6 state colours that the docs list. |

**Decision: `ONE_MORE_TARGETED_CRAWL_REQUIRED`** (plan at the end).

## How the evidence was weighed

- Index, graph, map, components, design system, tokens and report were read in full. Per-screen docs: 12 of 15 read in full (home-menu, conversation-mode, settings-subpages, language-and-level, writing-feedback-sheet, flow-letter, profile-history-streak, flashcards, grammar-mode, insight, paywall-plus, writing-exercise-editor); `home.md`, `writing-topic-picker.md` and `writing-lesson-list.md` by heading, range and grep only. Flow logs: session-2 log in full; `home-to-writing.md` and `grammar-and-flashcards.md` in part. Statements about what those unread passages do *not* contain rest on grep and could miss a mention.
- Every screenshot was opened. Where a doc and an image disagreed, the image was treated as authoritative (the docs themselves say so for S006).
- Pixel reads were limited to: page backgrounds on all 49 files, scrims, shadows under four card types, corner-radius fits on four cards, Back-button extent across viewports, cap-height of micro labels, wrong-word styling in S006, pager dot counts, window-active state from the traffic-light pixel.



# Fully Complete Areas

Complete = unique screens captured, meaningful states known, navigation in/out documented, visual evidence exists, components identified, visuals represented in the tokens.

| Area / sub-area | Why it qualifies | Residual caveat |
|---|---|---|
| **Language / CEFR preferences** (S043, S044) | Both screens captured at 788×1083; in/out edges OBSERVED; disabled "Coming soon" cards, selected radio and per-level colour bars are sampled; LanguageCard and LevelRow exist. | "Xác nhận" outcome unknown — a policy boundary, not a gap in the research. |
| **Gramify 101 article template** (S047) | One screen defines the template; 6 other tiles share it (INFERRED, acceptable under the criteria). Entry/exit OBSERVED; ExplainerArticle exists. | Only capture is 554×772 (see *Alternate Viewport Issues*); sizes must be rescaled or re-shot. Counted COMPLETE on template grounds only. |
| **Content-funnel templates** (picker → lesson list, ×3 modes: S002/S003, S008/S009, S019–S021) | Three modes verified to reuse one template; per-mode deltas (hero colour, CTA fill, chip count, PLUS tile) captured. | Mis-specified in docs: lesson-card fill, per-mode accent (C01, C02). Correct the record, no new capture needed. |
| **Flow Letter chrome** (S034–S036, S039–S042) | Seven non-gameplay screens, all edges OBSERVED, glass components sampled. | Gameplay outcome states are *not* chrome; area stays PARTIAL. |
| **Settings sub-page template** (S048–S050) | Three sub-pages share one card-list template; preview/swatch/empty-state components exist. | 554×772 captures. |

# Partially Complete Areas

## Product-area matrix (Audit 1)

| # | Area | Class | Exactly why |
|---|---|---|---|
| 1 | Home | PARTIAL | S001/S011/S043/S045/S046/S047 cover entry points. But: all Home captures were taken with the window **inactive**, so mode-card fill, bottom-bar and primary-button colours are unreliable (C11); mode cards 02/03 and carousel pages never active; 10 topic chips never opened; below-fold Flow Letter card and Gramify 101 strip are AX-only; 3 of 4 card styles unseen. |
| 2 | Writing | PARTIAL | Funnel → editor → incorrect verdict (S002–S007). Absent: correct/partial feedback, grading-in-flight, Edit/thumbs/word-lookup, "Thêm" menu, lesson completion. The editor is a **10-step sentence loop** the docs never identify (C03, C10). |
| 3 | Grammar | PARTIAL | Funnel + empty editor only (S008–S010). **No feedback of any kind**, no step 2, no completion. Grammar is the weakest mode. |
| 4 | Conversation | PARTIAL | Richest area (14 states): picker, coachmark, lesson list, chat, loading, reply, score chip, FAB, info sheet. Absent: score-popover contents, "Thêm" menu visual, end-of-session result, Scenario mode, other score bands, multi-turn, any error state. |
| 5 | AI generator | PARTIAL | Entry sheets (S029, S030, S046) captured; nothing downstream — preset selection, submit, loading, the generated lesson. |
| 6 | Insight | PARTIAL | Zero-data state only (S033). Populated chart, dot-matrix, stat values, grammar-mistake list and the "Tạo bởi AI ›" target unseen. Becomes capturable once a lesson is completed (P0-5). |
| 7 | Flashcards | PARTIAL | Deck list, deck detail (S012/S013). Add-deck/add-card, search, Filters/Newest popups, "Flow Letter" tab, non-"MỚI" status badges unseen; delete blocked. |
| 8 | SRS review | PARTIAL | Tutorial + front of first card (S014/S015). Card back, grade outcome, next card, session summary, empty queue unseen. |
| 9 | History | PARTIAL | Index with seeded cards (S017). Detail, "Xem thêm", search, "Thêm", floating "+" unseen. |
| 10 | Streak | PARTIAL | Zero state (S018). Non-zero streak, filled calendar, past months unseen; the flame hero is a grey glyph in this capture (inactive window or zero-state — unknown). |
| 11 | Flow Letter | PARTIAL | Chrome complete; **gameplay stops at the first frame**. Solve, wrong word, hint reveal, skip, combo/XP, level-up, round result, game-over unseen. The docs say "not reachable via accessibility clicks"; `peekaboo drag` exists and was never tried. |
| 12 | Profile | PARTIAL | Account card, trial banner, language row captured (S016, inactive window). Edit profile / Upgrade / avatar targets blocked or unopened. |
| 13 | Settings | PARTIAL | 3 of 13 rows opened. Notifications, invite, rate, feedback, terms, privacy and subscription unopened (some leave the app; some blocked). |
| 14 | Language / CEFR | COMPLETE | See above. |
| 15 | Gramify 101 | COMPLETE | See above (template-level, non-canonical viewport). |
| 16 | Paywall | BLOCKED | View-only by policy. Sheet top ≈ 60 % captured; scrolled benefits, monthly-selected state, purchase/restore/success/error cannot be captured. The template itself is adequately known. |
| 17 | Menu / overlays | UNRESOLVED | S011 menu overlay and 5 sheets captured; but **three overlay surfaces never rendered**: "Thêm" popup (S023), score popover contents (S028), exit alert (S007 capture shows only the dimmed editor). |

Tally: **2 COMPLETE, 13 PARTIAL, 1 BLOCKED, 1 UNRESOLVED, 0 NOT EXPLORED**. Weighted 2×1.0 + 13×0.55 + 1×0.7 + 1×0.4 = 10.25 / 17 ≈ 60 %.

## State-variant coverage by feature family (Audit 2)

Only meaningful variants are listed (variants that clearly do not apply are omitted). ● captured · ◐ captured with a validity problem · ○ missing.

| Family | Captured | Meaningful variants missing |
|---|---|---|
| Writing editor | ● initial/empty (S004), ● filled (S005), ◐ editing (caret visible, window inactive), ◐ disabled (S004) | ○ **enabled-submit visual** (S005 is grey: C09), ○ hint chip tapped, ○ "Thêm" menu, ○ swap-direction result, ○ grading in flight, ○ step 2…10 progress states, ○ last-step state |
| Grammar editor | ● initial (S010) | ○ filled, ○ submit enabled, ○ **any feedback**, ○ step 2, ○ completion |
| Feedback sheet | ● incorrect verdict (S006) | ○ **correct**, ○ partial (if it exists), ○ loading, ○ Edit pressed, ○ thumbs selected, ○ word-lookup popover, ○ sheet dragged/expanded, ○ error |
| Exit alert | ◐ AX copy + dimmed backdrop only | ○ rendered alert, ○ "Ở lại" outcome |
| Chat | ● initial, ● hidden translation, ● composer filled, ● loading, ● reply+score (58), ◐ "Thêm" menu (AX only), ◐ score popover (blank) | ○ popover contents, ○ other score bands, ○ end-of-session result, ○ multi-turn scroll, ○ voice pill options, ○ error/quota |
| Scenario mode | — | ○ entire UI (entry from FAB pill, scenario list/script, difficulty and question-count controls the coachmark promises) |
| AI generator | ● list (S029), ● empty sheet (S030) | ○ typed/enabled CTA, ○ chip chosen, ○ loading, ○ generated lesson, ○ preset-row → lesson |
| Flashcards | ● list, ● detail | ○ empty deck state, ○ add forms, ○ search active, ○ filter/sort popups, ○ "Learning"/"Review" badge variants, ○ Flow Letter tab |
| SRS | ● tutorial overlay, ● front of card | ○ **flipped back**, ○ graded + next card, ○ **session summary**, ○ empty queue |
| History / Streak / Insight | ● one zero/seeded state each | ○ populated Streak, ○ populated Insight, ○ History detail/search/empty |
| Profile / Settings | ● profile, ● 3 sub-pages | ○ Notifications and remaining rows, ○ toggle on/off pairs, ○ populated voice list |
| Flow Letter | ● 7 chrome states, ● first gameplay frame | ○ drag in progress, ○ correct word, ○ wrong word, ○ hint revealed, ○ skip, ○ level-up, ○ round result/game-over |
| Language / CEFR | ● selected + disabled + level list | — (confirm is blocked by policy) |
| Paywall | ● annual selected | ○ monthly selected, ○ scrolled end, (success/error/restore blocked) |
| Home | ● default, ● menu, ● AI composer, ● paywall behind | ○ **active-window default**, ○ carousel page 2/3, ○ chip selected → effect, ○ below-fold, ○ card styles Regular/Mono/Minimal |
| Picker / lesson list | ● default ×3 modes | ○ non-default category chip selected, ○ writing/grammar "AI" button, ○ lesson-list carousel page ≥ 2 as active card, ○ level-pill ⓘ |

**Not required (clearly n/a):** empty/focused/disabled variants for read-only screens (Insight, Streak, Gramify 101, Language list); error states for local-only screens.


# Missing Unique States

42 meaningful states with no capture. `Cap.` = can likely be captured safely (Y / Y* with a caveat / N blocked by CLAUDE.md or by tooling). Priority is defined in *Recommended Final Capture List*.

| ID | Missing state | Family | Cap. | Pri |
|---|---|---|---|---|
| M01 | Writing feedback — **correct** verdict (incl. any score) | Feedback | Y* needs input method fixed | P0 |
| M02 | Grammar feedback — incorrect verdict | Feedback | Y* same | P0 |
| M03 | Grammar feedback — correct verdict | Feedback | Y* same | P0 |
| M04 | Writing lesson-set completion / result screen | Completion | Y* needs ≈ 10 correct steps | P0 |
| M05 | Grammar lesson completion / result screen | Completion | Y* needs 5 steps | P0 |
| M06 | Conversation end-of-session result ("Kết thúc bài làm") | Completion | Y* ends a throwaway chat | P0 |
| M07 | Conversation score popover **contents** (S028) | Popover | Y* render workaround needed | P0 |
| M08 | Exit alert **rendered** (S007 shows only the dimmed editor) | Dialog | Y — alert is system-drawn; try `peekaboo dialog` / full-screen capture | P0 |
| M09 | Conversation "Thêm" popup **rendered** (S023) | Menu | Y* same render problem | P1 |
| M10 | Writing editor: **step ≥ 2** (progress 2/10, new highlighted sentence) | Editor | Y* follows M01 or a wrong-answer Next | P0 |
| M11 | Writing editor: submit **enabled** in an active window (S005's grey is probably inactive-window; C11) | Editor | Y | P0 |
| M12 | Writing editor: grading in flight (loading) | Loading | Y* timing | P1 |
| M13 | Feedback sheet: word-lookup popover | Popover | Y | P1 |
| M14 | Feedback sheet: thumbs selected | Feedback | Y — rating is a write; ambiguous (rule 14) | P2 |
| M15 | Writing/grammar editor: "Thêm" menu (may hold a skip/finish shortcut that decides how M04/M05 are reached) | Menu | Y | P0 |
| M16 | Grammar editor: filled + submit enabled | Editor | Y* | P1 |
| M17 | Conversation: **Scenario mode** chat / script | Mode | Y* toggling the FAB mode pill is a preference change — decide first | P0 |
| M18 | Conversation FAB: mode / voice option lists | Preference | Y* same | P1 |
| M19 | Conversation: score chip in a **higher band** (colour/dot) | Chat | Y* costs one AI call | P1 |
| M20 | Conversation: multi-turn, scrolled transcript | Chat | Y* costs AI calls | P2 |
| M21 | AI generator: preset row selected → what starts | Generator | Y* AI call; rule 14 | P1 |
| M22 | AI generator S030: text typed, CTA enabled | Generator | Y — type, do not submit | P1 |
| M23 | Home AI composer: text typed, send enabled; generated result | Generator | Y for typed, N for result | P1 |
| M24 | SRS card **back** (after "CHẠM ĐỂ LẬT") | SRS | Y — flip only, grade nothing | P0 |
| M25 | SRS graded → next card | SRS | Y* mutates study data | P1 |
| M26 | SRS session summary / queue-empty | SRS | Y* needs all 10 cards graded | P1 |
| M27 | Flashcards: add-card form / "Thêm" menu | Flashcards | Y — open, do not save | P1 |
| M28 | Flashcards: add-deck form (FAB on S012) | Flashcards | Y — open, do not save | P1 |
| M29 | Deck detail: Filters / Newest popups | Flashcards | Y | P2 |
| M30 | History detail (card or "Xem thêm") | History | Y | P1 |
| M31 | History: search active, "Thêm" menu, floating "+" | History | Y | P2 |
| M32 | Streak populated (non-zero, filled calendar) | Streak | Y* after M04 | P1 |
| M33 | Insight populated | Insight | Y* after M04 | P1 |
| M34 | Flow Letter: drag in progress | Game | Y* via `peekaboo drag` (never tried) | P1 |
| M35 | Flow Letter: word solved (success feedback) | Game | Y* same | P1 |
| M36 | Flow Letter: round result / level-up / game-over (round is 30 words) | Game | Y* same | P2 |
| M37 | Flow Letter: hint revealed (tap-hold) | Game | Y* same | P2 |
| M38 | Home in an **active** window + carousel pages 2/3 | Home | Y | P0 |
| M39 | Home card styles Regular / Mono / Minimal | Appearance | N preference change | P2 |
| M40 | Settings → Notifications (and other in-app rows) | Settings | Y for in-app rows; N for external-link rows | P1 |
| M41 | Voice screen: "Xem hướng dẫn" guide; populated voice list | Settings | Y for guide; populated list N (needs system voices) | P2 |
| M42 | Paywall: monthly selected / scrolled end | Paywall | N purchase boundary | — |

**Under-appreciated items covered above:** M08, M10, M11 and M38 are not in the crawl's own "known but not explored" list. They are new findings of this audit.

# Missing Transitions

## Flow completeness (Audit 3)

ENTRY → intermediate → primary action → result → exit. ✔ present · ✘ missing · — n/a.

| # | Flow | Entry | Mid | Action | **Result** | Exit | Verdict |
|---|---|---|---|---|---|---|---|
| 1 | Writing | ✔ | ✔ | ✔ submit | ✘ only incorrect; no correct, no completion | ✔ (alert → list) | PARTIAL |
| 2 | Grammar | ✔ | ✔ | ✘ never submitted | ✘ none | ✔ | PARTIAL (premature) |
| 3 | Conversation chat | ✔ | ✔ | ✔ send | ✘ chip yes, popover blank, no session result | ✔ | PARTIAL |
| 4 | Scenario mode | ✘ | ✘ | ✘ | ✘ | ✘ | NOT EXPLORED |
| 5 | AI generator (picker / lesson-list / Home) | ✔ | ✔ | ✘ never submitted | ✘ | ✔ | PARTIAL (premature) |
| 6 | SRS review | ✔ | ✔ tutorial | ✘ no flip/grade | ✘ no summary | ✔ | PARTIAL (premature) |
| 7 | Flashcard management (add/search/filter/delete) | ✔ | ✔ | ✘ | ✘ | ✔ | PARTIAL |
| 8 | History | ✔ | ✔ | ✘ no card opened | ✘ | ✔ | PARTIAL |
| 9 | Flow Letter gameplay | ✔ | ✔ | ✘ no drag | ✘ no solve / game-over | ✔ | PARTIAL (premature) |
| 10 | Flow Letter chrome (difficulty / settings / help) | ✔ | ✔ | ✔ view | — | ✔ | COMPLETE |
| 11 | Insight | ✔ | ✔ | — | ✔ zero state | ✔ | COMPLETE (zero-state only) |
| 12 | Streak | ✔ | ✔ | — | ✔ zero state; months unvisited | ✔ | COMPLETE (zero-state only) |
| 13 | Language / CEFR | ✔ | ✔ | policy | — | ✔ | COMPLETE |
| 14 | Paywall | ✔ | ✔ | policy | — | ✔ | BLOCKED |
| 15 | Settings sub-pages | ✔ | ✔ | policy | — | ✔ | PARTIAL (3/13) |
| 16 | Gramify 101 | ✔ | ✔ | — | ✔ article | ✔ | COMPLETE (1/7 tiles) |

Strictly complete = flows 10–13, 16 → **5/16**. Flows with **no result screen at all**: #2, #5, #6, #7, #8, #9 (and #4, never entered). The remaining PARTIAL/BLOCKED flows (#1, #3, #14, #15) end with one result variant or a policy stop.

## Navigation-graph findings (Audit 4)

**Orphan states (no documented incoming transition).** None in the strict sense; every state has an OBSERVED incoming edge. *Weakly attached* (reachable only by an INFERRED or lossy edge): S007 "Ở lại" return (INFERRED); S028 dismissal observed only via a foreground click-away.

**Dead-end transitions (action with unknown destination)** — every one is listed in SCREEN_INDEX "Known but not explored". Material ones:
- Home: 10 topic chips; carousel pages; below-fold Flow Letter "Thử ngay" card; 6 Gramify 101 tiles (template-inferred); "Mở Flashcard" banner.
- Menu → "Chuỗi của tôi" and "Nâng cấp Gramify Plus": **no OBSERVED edge**. STATE_GRAPH lists only three S011 edges; grammar-and-flashcards.md L30 tags "Chuỗi" INFERRED; UX_MAP still labels Insight "unexplored" and Plus "unvisited" (stale, C14). The Plus banner edge (S001→S045) *is* observed; the Menu one is not.
- Editors: "Thêm" menu, swap icon, "Hoàn Tác". S006: Edit, Next-on-correct, thumbs, word lookup, dismiss.
- S012/S013: "Thêm", "Filters", "Newest", search, FAB, "Flow Letter" tab.
- S017: all card/"Xem thêm"/search/"Thêm"/"+" targets. S018: month chevrons.
- S016: 10 of 13 rows. S002/S008/S020: 18 other chips (conversation 10), level-pill ⓘ (S003/S009/S021).
- S022 menu items 2 and 3 ("Kết thúc bài làm" and the disabled item).

**Back/return behaviour gaps.** Pushed screens: all OBSERVED except session-1 docs still tagged INFERRED after later confirmation — writing-topic-picker.md L213, writing-lesson-list.md L93, writing-exercise-editor.md L61 (stale tags: the STATE_GRAPH edges are OBSERVED). Overlays: Menu has *no documented dismissal* (home-menu.md "tapping elsewhere presumably dismisses", untested); S045 ✕, S046 chevron, S030/S029 ✕, S032 ✕, S031 ✕ are OBSERVED.

**Undocumented outgoing actions seen in screenshots but absent from every doc:**
1. S004/S005/S010: a **10- (writing) / 20- (grammar) segment progress bar** at the top. Not in COMPONENTS, no doc mentions it.
2. S004/S005/S006: a **row of blurred word-pill chips** (5 chips) at the bottom — hint/word-bank affordance; docs call it "a segmented pill row (ESTIMATED: word counter/progress)". S006 additionally shows a new ✦ chip at the left of that row.
3. Lesson-list pager: **15 dots** on S003 against "14 Sets", **6** on S009 against "5 Qs", 2 on S021 (1 lesson + the AI card). That pattern fits a trailing AI card in every lesson rail, as S021 shows; the docs mention that card only for conversation. INFERRED, not verified.

## Audit 9 — status of the known-unresolved states, re-checked against current evidence

| Item | Status in repo | Audit verdict |
|---|---|---|
| Correct-answer feedback (writing) | Documented as "UNREACHED; Telex corrupts typing" | **Still missing.** The block is a *tooling* problem with untried paths: `peekaboo set-value` (writes the AX value without keystrokes; exists in the installed CLI), `peekaboo type --foreground --clear` with an ABC input source. Not an app limitation. |
| Incorrect-answer feedback, grammar | "NOT REACHED" | **Still missing**; same cause. |
| Conversation end-of-session result | "Not pressed" | **Still missing.** Policy-ambiguous (ends a session) but low risk on a throwaway chat. |
| Scenario mode | "Never entered" | **Still missing.** Gated on a preference toggle. |
| Score popover contents | "blank render; contents UNKNOWN" | **Still missing.** The contents of one sibling surface (S006) render fine, so the failure is popover-specific; the window-active state was *on* for S028 (active, coloured lights) while S006 was inactive — so inactivity does not explain it. |
| Conversation "Thêm" popup | AX only | **Still missing.** Same render class as S028. |
| Flow Letter drag/solve/result | "not reachable via AX clicks" | **Still missing; was never tried via `peekaboo drag`**, which exists. |
| Viewport normalisation | S047–S050 flagged | **Not resolved** — and the flag understates it (see *Alternate Viewport Issues*). |
| Home "flat grey" cards | "cause unknown" | **Probable cause found by this audit**: S001, S011, S045 are *inactive-window* captures (grey traffic lights); all active-window Home captures do not exist. The "blue" unsaved capture is consistent with an active window. INFERRED — M38 would settle it. |


# Missing Visual Evidence

## Per-state screenshot audit (Audit 5)

Checks per state: file exists · indexed · filename describes the *verified* state (CLAUDE.md) · defining content visible · viewport recorded.

| Result | States |
|---|---|
| Valid (44) | S001–S006, S008*, S010, S011, S013*, S014*, S015–S022, S024–S027, S029–S046 (S038 unused), S047†–S050† |
| **Defining content absent** (3) | **S007** — filename and index say "exit confirm dialog"; the capture is the dimmed editor at *step 2* with no alert drawn. **S023** — "Thêm" menu absent (filename admits it). **S028** — popover panel drawn blank (filename admits it). |
| **Filename names a different state** (2) | **S009** `grammar-question` is the grammar *lesson list*; **S012** `flashcard-study` is the deck *list* (study/review is S014–S015). |

\* vague but not wrong: S008 `grammar-mode` (is the picker), S013 `flashcard-deck-study` (is deck detail, not a study state), S014 `srs-review-session` (is the first-run tutorial overlay), S016 `settings` (is Profile). † 554×772.

- **Index/file integrity:** 49 index rows ↔ 49 files, 144 links, 0 broken. S038 is correctly absent.
- **Viewport recording:** S047 is labelled in the index table; S048–S050 only by a footnote (index L61) and `settings-subpages.md`. COMPONENTS.md rows for S047–S050 carry no viewport tag. Four of 49 captures are alternate-viewport; one of the four is labelled at row level.
- **Window-active state is not recorded anywhere.** 30/49 captures are inactive-window (pixel-verified, traffic-light colour): S001–S024, S045–S050. Active: S025–S044.

## Visual gaps that block reconstruction

| Gap | Why it matters |
|---|---|
| No active-window capture of Home, S004–S006, S010, S016, S022 | Grey mode cards, grey Next/submit/Edit buttons and the grey streak flame may be inactive-window artefacts (C11); the clone could ship the wrong colours. |
| S001 below the fold; S016 rows 10–13 and footer | S001 content height is 1464 against a 1083 viewport; the Flow Letter card and Gramify 101 strip are AX-only (FeatureTile, LetterTile in COMPONENTS are "AX-only evidence"). S016 image ends at the "Khác" caption. |
| Alert, two popups | Three overlay surfaces have no pixels (S007, S023, S028). |
| No Retina capture | Every radius and hairline is a 1x fit with ±1.5 pt uncertainty — the same size as the differences the docs rely on (C16). |
| Scroll states of S013 (2 rows hidden), S045 (benefits) | Minor. |
| S032 / S030 over S031 / S029 | Both sheets drawn over scrims captured while the window was active; fine. |

# Missing / Weak Design Tokens

Class legend: **VERIFIED** (≥ 3 independent states, consistent) · **SUPPORTED** (2 states or one clean measurement) · **CANDIDATE** (1 state, or inferred) · **ESTIMATED** · **MISSING**.

| Category | Class | Evidence and defect |
|---|---|---|
| **Colour: page / surface** | VERIFIED values, **wrong rule** | `#F9FAFB` page, `#FFFFFF` card, `#F3F4F6` muted, `#EDEEEF` topic card, `#E5E7EB` divider are solid. The JSON/DESIGN_SYSTEM say only Insight and Profile have a white page; pixel reads show a `#FFFFFF` page on **S013, S016, S018, S029, S030, S033, S044** (7 screens, i.e. 5 more than the two the docs name) and `#F8F9FA` on S015. The rule must be "per screen family", not "two exceptions" (C13). |
| Colour: brand / accent | SUPPORTED | Four blues + `#007AFF` listed as a *problem*, but there is a pattern: **per-mode accent** — writing = grey hero line 2, navy CTA `#141B29`, lime title period `#CBFD00`; grammar = lime hero line 2 `#CAFD00`, lime CTA `#D0FC3F`, lime period; conversation = blue hero line 2 `#4270F3`, indigo CTA `#495FE7`, indigo period `#3B53E7` (all audit-side, inactive window) **No `mode.accent` token exists**; lime appears in tokens only as "active Home carousel dot". |
| Colour: semantic | success VERIFIED; error SUPPORTED; **warning / score bands MISSING** | `#2CB782` on 5 screens. Only one error red per context. Score colour bands unseen (one score, red). SRS grade-icon colours (red/orange/blue/green) **not tokenised**. Wrong-word red not sampled. |
| Colour: borders | **MISSING** | Hairlines are visible on topic cards, chat bubbles, chips, composer, plan cards; no colour or width exists. DESIGN_SYSTEM "Gaps" admits border widths. |
| Colour: text hierarchy | SUPPORTED | Five values, but "darkest glyph pixel" (lower bound). **Missing:** text-on-accent, text-on-glass (Flow Letter), link colours (`#208DAF` teal in S044, blue in S050), disabled text. |
| Colour: selected / unselected | CANDIDATE | Selection styles are four unrelated recipes (orange outline chip, blue-tint chip, green radio, blue-border plan card, dark-outline tile). Not a token group. |
| Colour: JSON omissions | **MISSING in JSON** | DESIGN_SYSTEM/screens list but `design-tokens.json` omits: `#D2D5DB` (send disabled), `#B9B9BA` (toggle off), `#FDEFE6` ("Coming soon"), `#208DAF` (link), `#E5EEFD` (AI card), `#F0F5FF` (selected plan). |
| Colour: scrims | **ESTIMATED** | `#C4C5C6` (FAB scrim, S031/S032), `#CACACA` (alert backdrop, audit-side S007), `#959595` (SRS tutorial, audit-side S014). **No scrim behind the floating sheets** (S006, S028, S030, S045) — DESIGN_SYSTEM L109 claims "dimmed backdrop behind sheets": false for four of five sheet types (C06). |
| **Typography: family** | **MISSING** | Unknown. |
| Typography: sizes | **ESTIMATED and internally inconsistent** | Sizes = AX frame ÷ 1.2. Micro labels: frames 7–9 pt, estimated 6–7 pt. **Audit-side cap-height of the same labels is 6–7 px** ("DANH" 7, "CHỦ ĐỀ" 7, "KEY IMPROVEMENTS" 6). Cap-height ≈ 0.7 em ⇒ ≈ 9–10 pt, i.e. the estimate is ≈ 35 % low *or* AX frames are not line boxes. Either way the ramp cannot be used below `body`. No weights, no tracking values, no line-heights measured. |
| Typography: levels | SUPPORTED structure | Display / title / heading / body / caption / micro are all present. The two-tone hero (S002/S008/S020) and ghost numeral ("01", "DAYS") are undocumented as styles. |
| Spacing | SUPPORTED | Home 12, pushed 18/19, grid 9, chip gap 8, sheet inner margin 18. The `space.5 = 12.5` and `space.6 = 16 (range 13–39)` tokens are **CANDIDATE/INFERRED and should be dropped**. |
| Radii | SUPPORTED, one wrong | 23 (cards), 17 (banner/list), 14 (bubble), pill, circle. **`previewCard 18.5` is from a 554×772 capture** (≈ 26 normalised, C15). **`homeModeCard: not measured` is measurable**: audit-side fit on S001 = **≈ 31 pt (rms 0.10, clean)**; consistent with S049's preview (23 ÷ 0.703 ≈ 33) and with the original 28–36 estimate that DESIGN_SYSTEM L102 *over-corrected*. Independent topic-card refit (S002): **20.5 pt (rms 0.29, n = 18)** vs the documented 23 (rms 1.6) — the two methods disagree by 2.5 pt, so "±1.5" is optimistic. Sheet and alert radii missing. |
| Borders (width) | **MISSING** | Selected plan `#4383FC`, selected tile 2 pt, chip outline — no widths. |
| Shadows / elevation | **ESTIMATED; "cards are flat" is contradicted** | Audit-side reads at 1x: white **lesson card** casts a soft shadow (≈ −13 per channel just below the edge, fading over ≈ 28 px); **deck card** −5; **CTA** faint; SRS cards visibly shadowed (S015); **topic cards** are flat + hairline. Sheet shadow remains single-sample. No elevation scale. |
| Icon sizes | SUPPORTED | 14–16 inline, 36 buttons, 254 hero; fine. |
| Button variants | **CANDIDATE → MISSING** | At least 7 recipes (solid CTA ×3 per-mode, full-width CTA ×3 per-screen, glass pair Edit/Next, round ghost, round glass, text link, tab/segment, FAB ×3) with sizes but no state matrix (hover/pressed/disabled/loading). Only chat-send has a verified disabled → enabled pair. |
| Card variants | CANDIDATE | Flat topic, shadowed list, muted panel, glass, plan (selected/unselected), PLUS gradient tile (S008 pale lavender gradient, purple badge — **no values**), AI card (`#E5EEFD`). |
| Chips | SUPPORTED | h 29–31; two selected styles; trailing chevron on category chips undocumented in COMPONENTS. |
| Inputs | CANDIDATE | Composer 709×31, answer card r 24 (user colour), multiline field, search pill, AI-composer gradient border. **No focus / error / filled-border tokens**; caret colour not recorded. |
| Navigation | SUPPORTED | Nav 41, back 33 (AX) / 36 (visible), title bar 32. Bottom-bar blur and pager dot sizes missing. |
| Overlays | **ESTIMATED / MISSING** | Two sheet geometries (floating card 446 wide, bottom y = 811, ~272 pt above the window bottom; bottom-attached S032 y 503 → window bottom), one full-window (S046), one full-screen modal (S029), the frosted menu. Frosted-blur radius, sheet corner radius, grabber size/colour, alert style: none. |
| Motion | MISSING | No timing; typing-indicator dots seen. |
| Dark mode | UNRESOLVED | Not observed; "Giao diện" is not a theme switch. |

**Do not promote** (per brief): the audit-side values above (mode accents, Home mode-card radius 31, topic-card 20.5, scrim hexes, shadow reads) are *CANDIDATE* until a second state or a Retina capture confirms them. They are listed so the next pass knows what to confirm, not so they can be used.


# Component Gaps

Class legend as in tokens, applied to the component's *structure and reuse*, not only to measurements. Evidence = states in which the component was seen.

## Audit 7 — named families

| Family (brief) | Model name | Class | Evidence / defect |
|---|---|---|---|
| AppHeader | NavBar | VERIFIED | S002–S003, S008–S009, S012–S013, S016–S018, S020–S021, S033, S043–S044, S047–S050 (Back + centred title + optional trailing). **Three further header types are not unified with it:** ModalHeader (✕ + progress/title + ⋯ on S004, S010, S014–S015, S022), Flow Letter header (glass round/rounded-square Back + title), and the **hero header** (eyebrow + two-tone title + "DANH MỤC", S002/S008/S020, which replaces the title on pickers). HeroHeader has no row. |
| BackButton | (inside NavBar) | SUPPORTED | Four renderings: plain ring, glass pink/purple round, glass rounded-square (S040/S041), ✕/Đóng. Measured 33 (AX) but visibly 36 px at 788 and 25 px at 554. Needs its own IconButton row (see duplicates). |
| ModeCard | ModeCard | SUPPORTED | Structure clear; **fill unresolved** (inactive window, C11), 4 style variants known only from S049's preview, radius audit-side ≈ 31. |
| TopicCard | TopicSetCard (+ PlusTile) | VERIFIED | S002, S008, S020 identical geometry; PLUS tile's lavender gradient and purple badge unspecified. |
| CategoryChip | CategoryChip | VERIFIED | 3 pickers; selected = white + orange outline. Trailing chevron not documented. |
| LessonCard | LessonCard | SUPPORTED, **mis-specified** | Fill white; per-mode CTA fill (navy / lime / indigo), pager colour and illustration vary — see C01. The carousel's trailing **AI card** (S021) is a different card (pale blue, "Tạo tình huống?") with no row. |
| ExerciseEditor | EditorShell, SourceTextCard | SUPPORTED, **incomplete** | Missing parts: ProgressStepper, HintChipBar, the highlighted-sentence rendering of SourceTextCard, the swap pill, the answer-card colour setting. |
| FeedbackPanel | FeedbackSheet, WordSpan | SUPPORTED (1 verdict) | Struck-through red / green-chip WordSpan styling documented wrongly (C08); other verdicts unseen. |
| ExitDialog | ConfirmDialog | **CANDIDATE** | Copy and 260×161 from AX only; **no pixel evidence** (C04). |
| ConversationBubble | ChatBubble (AI / user) | VERIFIED | S022, S024–S027. |
| ScoreChip | ScoreChip | SUPPORTED | One value (58, red). Band colours, popover content unknown. |
| FlashcardRow | WordRow | VERIFIED | 8 rows in S013; only the MỚI badge variant. |
| SRSGradeButton | IntervalButtons | SUPPORTED | S014/S015: round white buttons with coloured icons (red ↩, orange clock, blue ✓, green ★), "1m/6m/1d/4d" above, label below. Icon colours not in tokens; pressed/after-grade unseen. |
| MenuOverlay | MenuSheet | **CANDIDATE; misnamed** | Frosted full-window overlay, 5 centred rows, coloured round icons (S011). Name and 4 docs still say "sheet" (C05). Dismissal untested. |
| SettingsRow | SettingsRow (+ toggle row) | VERIFIED | S016 ×13; S048 toggle row. |
| PaywallPlan | PlanCard, BenefitRow | SUPPORTED | Selected + unselected in one state. |
| InsightCard | StatGrid / StatCell, DotMatrixCalendar, WeekChart | CANDIDATE | One zero-data state. |
| FlowLetterTile | LetterTile | SUPPORTED | Defined **twice** (COMPONENTS L31 27×27 AX-only Home preview; L98 ≈ 40×44 glass tile). One component, two sizes. |
| ScoreChip popover | — | **MISSING** | Contents never rendered. |
| Dialog | ConfirmDialog | CANDIDATE | see above |
| Sheet | FeedbackSheet, CreateSheet, InfoSheet, AIComposerSheet, paywall sheet, ScorePopover | **MISSING as a unified component** | Six rows describing one surface with three presentations (C07). |
| Toast | CoachMark | CANDIDATE | One state, first-run only. |

## UI present in screenshots with no component representation

| UI | Where | Note |
|---|---|---|
| **ProgressStepper** (10 segments writing, 20 grammar, first segment green) | S004, S005, S006, S007, S010 | Undocumented anywhere. Grammar's 20 against "5 Qs" is unexplained. |
| **HintChipBar** (5 blurred word chips + undo, ✦ chip appears after feedback) | S004–S006, S010, S048/S049 preview | Docs call it "a segmented pill row". |
| **PagerDots** (S001 3 + banner 2, S003 15, S009 6, S021 2, S045 3-segment) | 6 states | Appears in 6 states, never listed; active style differs per mode (black / indigo / lime / blue). |
| **HeroHeader** (eyebrow + two-tone title + counter chip) | S002, S008, S020 | |
| **AICard** (peeking pale-blue card) | S021 | |
| **FloatingActionButton** family (dark "+" 46 px S012; light "+" S017; search S013; sliders FAB S020) | S012, S013, S017, S020 | Only the sliders FAB has a row. |
| **Badge** family (PLUS purple, "Giảm 40%" blue, "Coming soon" orange, "Free", "MỚI", "A1" level chip) | S008, S045, S043, S016, S013 | StatusBadge covers three of six. |
| Trailing nav buttons (AI, Thêm, ⋯, ?, +) | S002/S008/S020, S012/S013/S017, S050, S034 | Described per screen. |
| **Scrollbar**, macOS | S029 | Platform chrome, ignore. |

## Duplicated concepts that should be variants

| Concept | Currently separate | Collapse to |
|---|---|---|
| Sheet | FeedbackSheet, CreateSheet, InfoSheet, AIComposerSheet, paywall sheet | `Sheet(presentation: floatingCard \| bottomAttached \| fullWindow, content)` |
| Button | PrimaryButton, FullWidthCTA, GlassButton, feedback Edit/Next, lesson CTA | `Button(variant: solid \| glass \| outline \| text, size, tone)` |
| IconButton | Back ×4, AI, Thêm, ✕, ?, FAB | `IconButton(glyph, material: plain \| ring \| glass \| roundedSquare, size)` |
| Chip | TopicChip (Home), CategoryChip, suggestion chips (S030, S046) | `Chip(selected style, leading icon, trailing chevron)` |
| Radio | RadioRow, LevelRow radio, PlanCard radio | `RadioIndicator` + row shells |
| Banner | PromoBanner, FeatureBanner | `Banner` with optional preview slot |
| Letter tile | two LetterTile rows | one, two sizes |
| Badge | StatusBadge + 4 others | `Badge(tone)` |

Estimated effect: ≈ 60 rows in COMPONENTS.md → ≈ 28 distinct components (ESTIMATED).


# Contradictions Found

Severity: **H** changes a rebuild decision · **M** wrong record, small rebuild effect · **L** hygiene. "Doc" = the file's text; "Image" = what the saved PNG shows (authoritative when they differ). Nineteen items.

| ID | Sev | Contradiction | Where | Evidence and resolution |
|---|---|---|---|---|
| C01 | H | **Lesson-card fill.** Docs: per-card gradients (navy→blue / purple→pink / green), white CTA. Images: flat **white** cards, dark / lime / indigo CTA. | Doc: writing-lesson-list.md L73–74, COMPONENTS L28, DESIGN_SYSTEM L86–87, conversation-mode.md L42 ("writing/grammar … gradients"). Image: S003, S009, S021. | S003/S009/S021 card centre `#FFFFFF`. **All three are inactive-window captures** (grey traffic lights), and the doc's colours came from an earlier session. Which rendering is canonical is **UNRESOLVED**; see C11. Do not tokenise either. |
| C02 | M | **Grammar accent is orange.** Image shows **lime `#CAFD00 / #D0FC3F`**: hero line 2, lesson-list CTA, title period. The lesson-title period is lime on writing too (`#CBFD00`); on conversation it is indigo. | Doc: DESIGN_SYSTEM L82, grammar-mode.md L19, writing-lesson-list.md L31 ("orange '.'"). Image: S003, S008, S009. | Orange `#F37A29` appears only on the selected category chip outline. Pattern is a **per-mode accent**: writing (grey line 2, navy CTA, lime dot), grammar (lime / lime / lime), conversation (blue / indigo / indigo). |
| C03 | **H** | **"Next" retries the same exercise.** Image: after Next the editor is at **sentence 2 of 10**: second progress segment active, second sentence highlighted. | Doc: STATE_GRAPH L18, writing-exercise-editor.md L80, flows/home-to-writing.md L55. Image: **S007**. | The writing "exercise" is a sentence loop; the editor's bottom chip group changed width (374→304) because it is per-sentence (C10). Edge S006 --Next--> S004 is wrong; target is "S004, step 2". |
| C04 | H | **S007 is a captured exit dialog.** Image has **no alert** (0 near-white pixels in the 260×161 centre); it is the dimmed step-2 editor. | SCREEN_INDEX L17, STATE_GRAPH L19–21/L29/L58, COMPONENTS ConfirmDialog, DESIGN_SYSTEM "Dialog 260×161". | The dialog is AX-only (copy, 260×161, 112×30). Name/dimension/radius are unverified. The dimming covers the title bar too (`#CACACA` everywhere). |
| C05 | M | **Menu is a bottom-anchored (dark navy) panel.** Image: **frosted full-window overlay**, five centred rows, coloured round icons. The correction exists but four files still carry the old text. | home-menu.md L14, L37 (body below the correction banner), UX_MAP L66, COMPONENTS L14, DESIGN_SYSTEM L86 ("dark navy | menu sheet"); naming "sheet" in SCREEN_INDEX L21, STATE_GRAPH L89, flows/grammar-and-flashcards.md L17; docs/implementation-plan.md §4. | S011 viewed. Rename to **MenuOverlay**; delete the stale text. |
| C06 | M | **"Dimmed backdrop behind sheets/dialogs/menu."** Not dimmed behind the S006 feedback sheet, S028 popover, S030 create sheet or S045 paywall (page pixel `#F9FAFB`); dimmed behind the alert (S007), SRS tutorial (S014 `#959595`) and FAB overlay (S031/S032 `#C4C5C6`). | DESIGN_SYSTEM L109. Image: S006, S028, S030, S045 vs S007, S014, S031. | paywall-plus.md L8 already says "not dimmed" for S045, so the docs disagree with each other. Scrim is a per-surface property: **modal alert/overlay = scrim; floating card sheet = none.** |
| C07 | M | **S006 is "attached to the bottom … rounded top corners" / "bottom sheet".** Image: a **floating card, all four corners rounded**, bottom edge y = 811 with the purple editor visible below it. S032 *is* bottom-attached (x 171–617 to window bottom). Report/graph say all share y-range 304–811. | writing-feedback-sheet.md L14, L62; flows/home-to-writing.md L47; STATE_GRAPH L91; REPORT L56. Image: S006, S030, S032. | Three presentations: floating card (S006, S028, S045, S030), bottom-attached half sheet (S032), full-window sheet (S046). Collapses to one `Sheet` component (see Component Gaps). |
| C08 | M | **Wrong words are underlined red; reference words green.** Image: wrong words are **struck through** (red line through x-height; red pixels peak on the mid row) and reference words sit in **pale-green rounded chips** with green bold text. A ✦ chip also appears in the bottom row after feedback. | writing-feedback-sheet.md L64, COMPONENTS L41. Image: S006. | Update WordSpan to two variants: `wrong(strikethrough, red)` / `reference(chip, green)`. |
| C09 | M | **Submit enabled = "dark filled in screenshot".** Image: the enabled-state submit (S005) is **grey** (`#E3E3E4` centre on `#D4D4D5`), essentially identical to disabled (S004). | writing-exercise-editor.md L52, L71. Image: S004, S005. | Chat-send does show a clean pair (`#D2D5DB` → `#475DE8`). The editor's pair was captured in an inactive window and is not valid. Capture M11. |
| C10 | M | **Bottom-centre group "ESTIMATED: word counter/progress".** Image: a **5-chip blurred hint row**; progress is the **top segmented bar** (10 segments writing, **20 grammar**, first segment green). Grammar shows "5 Qs" per set but 20 steps — unexplained. | writing-exercise-editor.md L45; grammar-mode.md (silent). Image: S004, S005, S010. | Add ProgressStepper and HintChipBar. The 5-vs-20 relation is UNKNOWN (do not infer). |
| C11 | H | **Home mode cards "flat grey, cause unknown".** 30 of 49 captures — S001–S024, S045–S050 — were taken with the window **inactive** (coloured traffic lights are grey). All Home/Menu/paywall captures are among them; the one blue Home capture was unsaved (active). | home.md L169, settings-subpages L28, paywall-plus L8, REPORT unresolved #5, DESIGN_SYSTEM L102, tokens `modeCardObserved`. | Probable cause found (INFERRED). Same suspicion applies to the translucent grey Edit/Next/CTA buttons, the grey Streak flame (S018), the grey S046 sheet (`#E9E9E9`), the SRS tutorial and lesson cards (C01). **No Home/editor/lesson/feedback colour is VERIFIED until recaptured active (M38/M11/M10).** |
| C12 | M | **Home mode-card radius "could not be measured".** Audit-side fit on S001: **≈ 31 pt, rms 0.10** (clean: high-contrast `#D4D4D5` on `#F9FAFB`). DESIGN_SYSTEM L102 then dismisses the earlier 28–36 estimate as "too high" using lesson/topic cards — a different card. | DESIGN_SYSTEM L102, tokens `homeModeCard`. Image: S001. | CANDIDATE until confirmed on a coloured (active-window) card and at 2x. |
| C13 | M | **Page background `#F9FAFB` except Insight and Profile.** Image: `#FFFFFF` page also on S013, S018, S029, S030, S033, S044; `#F8F9FA` on S015. | DESIGN_SYSTEM L43, tokens `page`. Image: pixel at (w/2, h−120) and edge samples on all 49. | Rule is per-screen-family; update. |
| C14 | L | **Stale tags and notes after later sessions.** UX_MAP diagram still shows "Insight (unexplored)", "PAYWALL (unvisited)", "card 03 (unvisited)"; flows/grammar-and-flashcards.md shows Insight/Plus/Flow Letter/flag as INFERRED-unvisited and a "Crawl stop" block; writing-topic-picker.md L4/L225 "screenshot not yet saved" (S002 exists); Back edges tagged INFERRED in writing-topic-picker L213, writing-lesson-list L93, writing-exercise-editor L61 while STATE_GRAPH has them OBSERVED. Menu → "Chuỗi" and "Nâng cấp" have **no observed edge** yet STATE_GRAPH lists nothing for them. | as listed | Retag. |
| C15 | M | **Radii from 554×772 stored beside 788×1083 radii.** `previewCard 18.5` (S048) is at ≈ 0.70× scale (≈ 26 normalised). | DESIGN_SYSTEM L96, tokens `previewCard`. | See *Alternate Viewport Issues*. |
| C16 | L | **"±1.5 pt" fit precision.** Independent refit of the S002 topic card gives **20.5 pt (rms 0.29, n = 18)** against the documented 23 (rms 1.6) — a 2.5 pt gap, wider than the stated tolerance. S003/S021 white-card refits are unusable (rms 6–9, shadow bleed). | DESIGN_SYSTEM L90, tokens `radius._status`. | Treat 20–24 as one band; confirm at 2x. |
| C17 | M | **Screenshot filenames that do not name the state.** S009 `grammar-question` → lesson list; S012 `flashcard-study` → deck list; S007 → no dialog. Vague: S008 `grammar-mode`, S013 `flashcard-deck-study` (deck detail), S014 `srs-review-session` (tutorial overlay), S016 `settings` (Profile). CLAUDE.md: filename must describe the verified state. | SCREEN_INDEX housekeeping lists 12 renames and claims all are fixed. | Rename the 3 invalid, consider the 4 vague. |
| C18 | M | **"Thêm" = Add.** S013's top-right "Thêm" is an **ellipsis (⋯) circle** like the chat/editor "Thêm" menus, not a "+": flashcards.md L28 labels it "Add card". The deck list's "+" is a separate dark **FAB** (46×46, bottom-right). | flashcards.md L14, L28, L82; S012/S013 images. | Add-card affordance is unknown; M27/M28 split accordingly. |
| C19 | M | **"Colours, radii and relative layout are comparable" across viewports.** Radii measured on S047–S050 are scaled (C15); layout margins differ (8–14 px against 17–18 px). | settings-subpages.md L5, language-and-level.md L57. | See next section. |

**No contradiction found:** per-screen colour hexes agree across docs where they are repeated (`#475DE8`, `#2CB782`, `#4383FC`…); the six CEFR bar colours; S019–S032 chat flows; paywall copy.

# Alternate Viewport Issues

## What was measured (Audit 6)

| Item | 788×1083 | 554×772 | Ratio |
|---|---|---|---|
| Window | 788 × 1083 | 554 × 772 | 0.703 W · 0.713 H (aspect 0.728 vs 0.718: not identical) |
| Title-bar traffic-light span | x 9–119 | x 9–119 | **1.00** (OS chrome does not scale) |
| Back button, visible width (audit-side, same row) | 36 px (S003/S012/S043) | 25 px (S047/S048/S050) | **0.69** |
| Back button, AX frame | 33 | not recorded | — |
| Side margin of full-width card | 17–18 | 8 (S048/S049), 13–14 (S047/S050) | varies by page (0.45–0.8) |

- Reading: **content scales by ≈ 0.70 with the window; the title bar does not.** A window-width scale is consistent with the Back-button ratio. The *cause* of the resize is not inferred (instruction).
- Margins on S048/S049 (8) are not 18×0.70 (≈ 12.6), so **no S048–S050 margin can be mapped back to a canonical value**; the 788 versions of these pages do not exist.

## Tokens and components derived from 554×772 captures

| Item | Source | Where stored | Issue |
|---|---|---|---|
| `radius.previewCard 18.5` | S048 | DESIGN_SYSTEM L96, tokens | Unscaled; ≈ 26 normalised (audit-side). Rename or remove. |
| `ColorSwatchGrid ≈ 28` | S048 | COMPONENTS L109 | Normalised ≈ 40. |
| `StyleTile ≈ 126×86` | S049 | COMPONENTS L110 | Normalised ≈ 179×122. |
| `ExplainerArticle ≈ 528×448` | S047 | COMPONENTS L108 | Normalised ≈ 751×637 (width ties to content width 751 — plausible). |
| `Toggle` track (S041, **S048**) | mixed | COMPONENTS L101 | Colours fine; the S041 one is at canonical size, S048's is at 0.70. No size given — keep it that way. |
| "page margins 8–14", "Settings row" geometry on S048–S050 | S048–S050 | settings-subpages.md | Not comparable with S016's 751-wide rows. |
| `windowSizesSeen` | — | tokens L500 | States the two sizes; carries no "scaled" warning. |
| Hex colours and tonal relations | all | all | **Viewport-independent; safe.** |

**Not mixed:** S001–S046 are uniformly 788×1083 (all files verified at 788×1083). No canonical measurement was derived from the 554 set except the items above.

**Recommendation:** re-shoot S047–S050 at 788×1083 (navigation + capture only). Until then mark all four `viewport: 554×772 (×0.70) — non-canonical` in the index, COMPONENTS and tokens.

# Blocked / Unresolvable States

| Branch | Why | Class |
|---|---|---|
| Purchase, trial, restore, plan switch, promo code, subscription row | CLAUDE.md rules 2–3 | BLOCKED (policy) |
| Edit profile, log out, language/level "Xác nhận" | Rule 3 | BLOCKED (policy) |
| Deck word delete (trash) | Rules 4–5 | BLOCKED (policy) |
| External-link rows (Rate, Feedback, Terms, Privacy) | Leave the app | BLOCKED (scope) |
| Home card style / card order, answer-box colour, difficulty, sound, haptics | Preference changes; the earlier session treated them as a boundary. **Rules do not forbid preference edits** (rule 3 covers subscription/account/profile) — user decision | AMBIGUOUS → rule 14 |
| Scenario-mode toggle | Preference change; same as above | AMBIGUOUS |
| AI-consuming actions (sending chat, generator submit, grading) | Quota cost; first session crossed it once, reversed nothing | AMBIGUOUS (cost) |
| "Kết thúc bài làm", "Thoát" | Ends/discards a session: literal rule 4 reading "never delete data"; the report's own safety log already flags it | AMBIGUOUS |
| SRS grading | Mutates study data (not account) | AMBIGUOUS |
| Populated voice list | Requires voices installed in macOS Settings | BLOCKED (environment) |
| Typing a correct English answer | Telex corrupts letters **w s f r x j z, doubled vowels**; `peekaboo set-value` and an ABC input source were not tried | UNRESOLVED (tooling), **not** an app limit |
| Score popover, "Thêm" popup, exit alert pixels | Render into no capture path tried (window, area, native `screencapture`) | UNRESOLVED (tooling); try screen-mode capture + `peekaboo dialog` before declaring BLOCKED |
| Flow Letter drag | `peekaboo drag` exists (help read, not run) | UNRESOLVED (tooling) |
| Dark mode, motion timing | Not observable from the UI; motion needs video capture (`peekaboo capture` ingests video) | BLOCKED / not required for UI freeze |


# Recommended Final Capture List

IDs refer to *Missing Unique States* (M…) and *Contradictions* (C…). "Safe" uses CLAUDE.md as the standard: **Y** = read-only / navigation; **Y\*** = state-changing but not account/subscription/profile/purchase, needs a user decision under rule 14; **N** = blocked.

## Prerequisites (apply to every item below)

| # | Prerequisite | Why |
|---|---|---|
| Q1 | Verify the live screen with `peekaboo see --tree --no-screenshot` before each action (CLAUDE.md). | Never trust assumed state across sessions. |
| Q2 | Restore the window to **788×1083** and **activate** it; confirm from a capture that the traffic lights are coloured. | 30/49 captures are inactive-window; 4 are 554×772 (C11, C19). |
| Q3 | For typing, try `peekaboo set-value` on the answer field first; use the ABC input source only if that fails and the user approves a system input-source change. | Telex block is a tooling problem (Audit 9). |
| Q4 | Capture one baseline (S001, active, canonical) and compare against S001 before doing anything else. | Settles C11 cheaply; if S001 still renders grey the "inactive-window" theory is dead and C01/C11 change. |

## P0 — required before the UI/UX freeze

| ID | Item | Why it matters | Source state | Action | Expected new state | Safe? |
|---|---|---|---|---|---|---|
| P0-1 | **Active, canonical Home** + carousel pages 2/3 (M38) | Colour of mode cards, bottom bar and every CTA is unverified; mode-card radius/fill are open (C11, C12). | S001 | Activate and resize window; capture; swipe/scroll the carousel (or click its page dots) twice; capture each. | S001′ (active), S001-p2, S001-p3 | Y |
| P0-2 | **Exit alert rendered** (M08) | The only dialog in the app has no pixels (C04). | S004 | Click "Đóng"; capture with screen-mode capture and read `peekaboo dialog list`; click "Ở lại" to prove the INFERRED edge. | S007 (real), then S004 | Y |
| P0-3 | **Editor "Thêm" menu** (M15) | May hold a skip/finish shortcut that changes how P0-5 is done; also an undocumented menu type. | S004 | Click "Thêm"; read AX; capture. Press nothing inside. | S004 + menu (visual if renderable) | Y |
| P0-4 | **Writing: correct answer, step 2, enabled submit, completion** (M01, M10, M11, M04) | Without a correct verdict and a result screen the product's core loop has no ending. | S004 | Type a correct translation of the highlighted sentence (Q3); capture enabled-submit (S005′); submit; capture feedback; Next; capture step 2; repeat to the end only if no shortcut exists. | correct feedback; step-2 editor; **lesson-complete screen** | Y\* (≈ 10 AI grading calls, history entries — user decision) |
| P0-5 | **Grammar: filled, feedback (incorrect & correct), completion** (M02, M03, M05; M16 on the way) | Grammar is the weakest-documented mode: zero feedback states. | S010 | Same as P0-4 on S010, once wrong and once right. | filled editor; both feedback sheets; completion | Y\* |
| P0-6 | **SRS card back** (M24) | Defines the flashcard learning loop; one tap, no data change. | S015 | Click the front card ("CHẠM ĐỂ LẬT") once; capture. **Do not press a grade.** | S015-back | Y |
| P0-7 | **Conversation end-of-session result** (M06) | The flow ends with an unseen screen. | S022/S027 (after ≥ 1 exchange) | "Thêm" → "Kết thúc bài làm"; capture. Does not require "Thoát". | session result screen | Y\* (ends a throwaway chat; the first session already made the same call) |
| P0-8 | **Score popover contents** (M07) | A feature with no visual; blank render is a tooling problem, S006 sheets render fine. | S027 | Click the chip, wait, capture via screen mode, `window` + `peekaboo capture` fallback; if AX has text read it. If still blank after 2 methods, classify BLOCKED and stop. | S028′ with content | Y* (needs a 2nd chat message) |
| P0-9 | **Scenario mode** (M17) | A named product mode with zero UI evidence. | S020 FAB → mode pill | Tap "Trò chuyện Tự do" pill; read AX; capture each resulting state. Revert if it persisted. | Scenario picker/chat | Y\* (preference change; **needs the user's go-ahead**) |

## P1 — valuable, not blocking

| ID | Item | Why | Source → Action → New state | Safe? |
|---|---|---|---|---|
| P1-1 | Re-shoot S047–S050 at 788×1083 | Removes the viewport-mixing in C15/C19. | S001 → Gramify 101 tile; S016 → three rows → 4 captures | Y |
| P1-2 | Grading in flight (M12) and word-lookup popover (M13) | Loading/feedback-depth states for the main loop. | S005′ submit (capture immediately, then +1 s); tap a corrected word in S006 | Y* / Y |
| P1-3 | Conversation "Thêm" popup rendered (M09) and FAB option lists (M18) | Menu visuals and the options inside "mode" / "voice" pills. | S022 "Thêm"; S031 pills (tap and revert) | Y / Y* |
| P1-4 | Conversation higher-score chip (M19) | Score colour bands (only red seen). | S022 → send a natural sentence | Y* |
| P1-5 | AI generator typed state (M22, M23); preset-row selection (M21) | Generator is entry-only; typed/enabled CTA is cheap; submit is not. | S030 / S046 → type without sending | Y; M21 Y* |
| P1-6 | SRS graded + summary (M25, M26) | Completes the SRS loop. | S015 → grade a card; repeat ×10 | Y* (mutates study data) |
| P1-7 | Flashcard add-deck / add-card forms (M27, M28) | Missing create surfaces; also resolves the "Thêm" ambiguity (C18). | S012 FAB; S013 ⋯ → open, do not save | Y |
| P1-8 | History detail (M30) | The only list with a detail screen unseen. | S017 → open first card / "Xem thêm" | Y |
| P1-9 | Populated Streak and Insight (M32, M33) | Zero-state-only today; unlocks calendar fill, chart bars, stat values. | After P0-4: S018 and S033 | Y |
| P1-10 | Flow Letter: drag + word solved (M34, M35) | Core game feedback; `peekaboo drag` never tried. | S037 → `drag` a tile; solve one word | Y\* (progress) |
| P1-11 | Settings → Notifications and other in-app rows (M40) | Unseen rows. | S016 → each row; stop at any external link | Y / N external |

## P2 — optional

| ID | Item | Note |
|---|---|---|
| P2-1 | M14 thumbs selected | A rating write; ambiguous. |
| P2-2 | M20 multi-turn transcript | Costs AI calls. |
| P2-3 | M29 Filters/Newest popups, M31 History search/"Thêm"/"+" | Cheap; low novelty. |
| P2-4 | M36 Flow Letter round result / game-over (round = 30 words), M37 hint | Long play; mini-game. |
| P2-5 | M39 Home card styles Regular/Mono/Minimal | Preference change. |
| P2-6 | M41 voice guide / populated voices | Environment dependent. |
| P2-7 | 2x (`--retina`) capture of key cards, one canonical screen each | Tightens radii and hairlines (C16). |
| P2-8 | Motion: `peekaboo capture` video of one sheet and one carousel scroll | Timing only. |

Excluded (blocked): M42 monthly/scrolled paywall; everything in *Blocked / Unresolvable States* tagged policy.

## Documentation fixes that need **no** capture (do before the freeze)

1. Correct or retag C01–C10 and C13–C14 as listed; mark every Home/Menu/lesson-list/editor/SRS colour as *inactive-window, unverified* (C11).
2. Add `ProgressStepper`, `HintChipBar`, `PagerDots`, `HeroHeader`, `AICard`, `Badge` rows; unify `Sheet`, `Button`, `IconButton`, `Chip`, `LetterTile` (Component Gaps).
3. Add to `design-tokens.json`: the six omitted state colours, a `modeAccent` group, border and scrim tokens (as CANDIDATE), and a `viewport`/`activeWindow` field per screen; remove `space.5 = 12.5` and `space.6 = 16`.
4. Rename `S007`, `S009`, `S012` screenshots to what they show (C17); record window-active state and viewport per row of SCREEN_INDEX.
5. Rewrite UX_MAP and `flows/grammar-and-flashcards.md` stale blocks; update `docs/implementation-plan.md` (stale: "18 states", "no colours", "likely chat").
6. Commit the research (everything under `references/gramago/` except three files is untracked) and archive or drop the empty `accessibility/` directory — **AX snapshots are not archived**, so all AX-derived bounds are unreproducible from the repo.


# Final Decision

**ONE_MORE_TARGETED_CRAWL_REQUIRED**

Why not READY_TO_FREEZE: the repository can reconstruct navigation architecture, the three-mode content funnel, chrome, the chat surface, the settings family and a colour palette. It cannot yet reconstruct the **result half of any learning loop** (writing, grammar, conversation, SRS, Flow Letter), and its Home / editor / lesson-card colours may be inactive-window artefacts. Both are cheap to close, and both would otherwise be baked into the clone.

## Targeted crawl plan (P0 and P1 only — **not performed in this session**)

**Setup (once, ≈ 4 actions).** Verify the live screen; resize to 788×1083; activate the window and confirm coloured traffic lights; capture S001′ and diff against S001. If S001′ still has a grey mode card, stop and re-plan: the inactive-window theory is wrong and C01/C11 stay open.

**Pass A — read-only, no AI, no data change (do first).**

| Step | From → action | Capture (filename describes the verified state) |
|---|---|---|
| A1 | Home (active) → carousel page 2, page 3 | `S0xx-home-active-default`, `…-mode-card-2`, `…-mode-card-3` |
| A2 | S004 → "Đóng" → read AX/`dialog` → "Ở lại" | `…-exit-alert-rendered` |
| A3 | S004 → "Thêm" | `…-editor-more-menu` (or AX-only note) |
| A4 | S015 → tap card once (no grade) | `…-srs-card-back` |
| A5 | S012 → FAB (open, do not save); S013 → "⋯" (open, do not save) | `…-add-deck-form`, `…-deck-more-menu` |
| A6 | S017 → open a card / "Xem thêm" | `…-history-detail` |
| A7 | S016 → Notifications (stop at any external hand-off) | `…-settings-notifications` |
| A8 | S001 → Gramify 101 tile; S016 → three rows, **at 788×1083** | four re-shoots replacing S047–S050 |
| A9 | S030/S046 → type text, do not send | `…-ai-create-sheet-filled`, `…-home-ai-composer-filled` |

**Pass B — AI grading, user approval required (≈ 12–25 AI calls; creates history).** Ask the user to approve once.

| Step | Action | Capture |
|---|---|---|
| B1 | Q3 typing fix (try `set-value` first). Writing S004: enabled submit, submit, correct feedback | `…-editor-filled-enabled`, `…-feedback-correct` |
| B2 | Immediately after submit: capture at +0 s and +1 s | `…-editor-grading-loading` |
| B3 | Tap one corrected word | `…-feedback-word-lookup` |
| B4 | "Next" → step 2; continue to the end (or use a shortcut found in A3) | `…-editor-step-2`, `…-lesson-complete` |
| B5 | Grammar S010: filled → wrong answer → feedback → correct answer → feedback → completion | five captures |
| B6 | Conversation: send a natural sentence → read chip; open popover with the screen-mode capture workaround; "Thêm" → "Kết thúc bài làm" | `…-score-popover-contents`, `…-chat-more-menu`, `…-chat-session-result` |
| B7 | S018 and S033 again | `…-streak-populated`, `…-insight-populated` |

**Pass C — preference changes, user decision per item (can be dropped).**

| Step | Action | Capture |
|---|---|---|
| C1 | FAB mode pill → "Chế độ Kịch bản" (revert after) | `…-scenario-picker`, `…-scenario-chat` |
| C2 | FAB voice pill → options (revert) | `…-voice-options` |
| C3 | Flow Letter: `peekaboo drag` a tile; solve one word | `…-flowletter-dragging`, `…-flowletter-solved` |
| C4 | SRS: grade one card → next card; (all 10 → summary only if the user approves) | `…-srs-next-card`, `…-srs-summary` |
| C5 | Preset scenario row → what starts (S029) | `…-ai-preset-start` |

**Stop conditions.** Any action whose destination is ambiguous, any external link or account/subscription/profile control, any purchase surface, a lock screen, a window that can't be found: stop and ask (CLAUDE.md rule 14).

**Estimated yield.** ≈ 28 new captures + 4 re-shoots. If Passes A and B succeed, meaningful-state coverage rises from ≈ 54 % to ≈ 75 % and flow coverage from 31 % to ≈ 60 %, with the documented fixes (previous section) bringing design-system confidence to ≈ 65–70 % without further capture (ESTIMATES). A freeze after A + B + the documentation fixes is defensible; C is optional.
