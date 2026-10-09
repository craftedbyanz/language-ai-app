# UI/UX Freeze Record

| Field | Value |
|---|---|
| Freeze date | **2026-10-09** |
| Status | **READY_FOR_UI_UX_FREEZE** |
| Distinct evidenced states | **62** |
| State IDs | **S001–S064**, **S038 unused** (63 IDs; S058 is the active alias of S010, so 62 distinct states) |
| Screenshots indexed | **77** PNGs (`screenshots/`) |
| AX files indexed | **43** files = 21 snapshots (`accessibility/`) |
| Fully verified states | **≈ 40 / 62 (≈ 65 %)**: active window, canonical 788×1083, defining content captured |
| AI calls used (final crawl) | **6 / 15** |
| App contact after this record | **none** (no GramaGo interaction, no Peekaboo, no new screenshots, no crawl) |

## Declaration

**No further GramaGo reverse-engineering is required for the initial design-system implementation.**

`references/gramago/` is now **archived forensic evidence**. It is frozen: do not add captures, do not "improve" it.
The canonical, product-independent output of this research is [`design-system/`](../../design-system/README.md).
Future work depends on `design-system/`, not on this folder.

## P0 outcomes (final targeted crawl, 2026-10-09)

| P0 | Item | Outcome | Evidence |
|---|---|---|---|
| P0-1 | Documentation reconciliation | **VERIFIED** | CURRENT_STATUS.md |
| P0-2 | Writing correct feedback, loading, Next → step 2 | **VERIFIED** (Next advances on a correct verdict too) | S055, S056, S057 |
| P0-3 | Grammar filled editor, incorrect + correct feedback | **VERIFIED** (grammar has its own copy: tips section, "fix / next" actions, compact correct sheet) | S058–S061 |
| P0-4 | Lesson-set completion / result screen | **DEFERRED_BY_AI_BUDGET** (needs ≈ 9+ further gradings for writing, 19 for grammar; no shortcut exists) | none |
| P0-5 | Conversation end-of-session result | **VERIFIED_NO_RESULT_FOR_ONE_TURN** (end-session → same exit alert → lesson list; 0 and 1 scored turns) | S062 |
| P0-6 | Score popover contents | **VERIFIED** (it is the shared feedback sheet; no AX elements) | S028 rendered |
| P0-7 | Scenario mode | **VERIFIED** (mode toggle on picker FAB; chat re-skinned as scripted translation loop) | S063, S064 |

## Known open items carried into the design system

These are **not** to be re-researched; each is recorded in `design-system/DESIGN_DECISIONS.md` with a recommended default.

1. **Lesson-completion screen**: deferred (budget). Unseen in writing and grammar.
2. **Conversation result after a fully completed session**: only 0–1 turn sessions observed; threshold for a result is unknown.
3. **Chat "Thêm" (more) menu visual**: popup never rendered in any capture; items known from AX only.
4. **Score-chip 86 vs feedback "Trôi chảy 88"**: relationship between the inline chip number and the sheet's fluency number unresolved (different metrics, rounding, or re-scoring: all unknown).
5. **Inactive-only states (≈ 18)**: structure valid, colours CANDIDATE.
6. **Some radii and compact-viewport values**: fit precision ±1.5 pt at 1×; sheet bottom corners unmeasured; 554×772 captures are adaptive evidence only.
7. **Generic error states** (AI quota, network, empty): never triggered.
8. Typography family, sizes, weights; border widths; dark mode; motion timing: never measured.

## Policy-blocked flows (intentionally not researched)

Purchase / trial / restore / plan switch / promo; edit profile, logout, language/level "confirm"; word or data deletion; destructive actions.
The paywall was viewed only (S045). The design system models the paywall *layout*, never a purchase flow.

## Remaining P1 / P2 research: intentionally WAIVED

- **P1 (waived):** active re-capture of the 18 inactive-only states; 788×1083 re-shoot of S047–S050; Home carousel pages 2/3; SRS grade → next card; flashcard create/sort surfaces; history detail; notifications page; AI-generator typed state; hex measurement of verdict/bullet colours.
- **P2 (waived):** longer-chat conversation result; Scenario grading / next step / result; high score bands; "view AI analysis" destination; Flow Letter solve / game-over; thumbs and word-lookup popovers; card styles; motion; dark mode; other explainer tiles.

Anything in these lists that the product needs is a **product design decision** (see `design-system/DESIGN_DECISIONS.md`), not a research task.

## Evidence-quality rules that were applied while distilling

1. Inactive-window captures (32 of 63 PNGs) → structure only; never colour, enabled/disabled state, or opacity.
2. Canonical viewport = 788×1083. 554×772 captures (S047–S050, one Home capture) → adaptive evidence only. 908×1083 (S051) is a canvas; window geometry = 788.
3. Three PNG colour encodings coexist (untagged sRGB, "Display" profile, Display P3). Hex from non-sRGB files was normalised; the same UI colour appears under several raw values.
4. Radii are circle fits to 1× pixels (±1.5 pt). Font sizes and shadows are ESTIMATED; font family unknown.

## Where things went

| Need | Go to |
|---|---|
| Build the product | `design-system/README.md` |
| Trace a design rule to its screenshot | `design-system/UI_MAPPING.md` → this folder's `SCREEN_INDEX.md` |
| Understand a measurement | `DESIGN_SYSTEM.md`, `design-tokens.json` (raw, with encodings) |
