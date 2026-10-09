# GramaGo (Gramify) UI/UX Reference

Black-box reverse-engineering of GramaGo — a native SwiftUI Vietnamese→English learning app for macOS (`com.tranhuy.projectx`, "Gramify" v1.1.2 (17), developed by "Huyt in Vietnam") — as the design reference for our own language-learning app.

## Status

- **53 distinct evidenced states** (49 indexed S001–S050 with S038 unused, + S051–S054), 63 PNGs, 13 AX snapshots, reconciled 2026-10-09. Session 1: Home, writing/grammar to AI feedback, flashcards/SRS, profile, history, streak, menus. Session 2 (2026-10-08): conversation mode incl. a live AI chat, Insight, Flow Letter, language/CEFR select, paywall (view-only), Home AI composer, Gramify 101, three settings sub-pages, plus a pixel-sampled colour/radius pass.
- Session 2 used the Peekaboo **CLI** because the MCP server failed to connect. Two states are partial (popups that never rendered into a capture: S023 menu, S028 score popover).
- **Status: NOT_READY_TO_FREEZE** — see [CURRENT_STATUS.md](CURRENT_STATUS.md). Still unreached: every result half (correct/grammar feedback, lesson-complete, chat result, SRS grade/summary), Scenario mode, Flow Letter play, S028 contents, dark mode. See [REVERSE_ENGINEERING_REPORT.md](REVERSE_ENGINEERING_REPORT.md).

## Map

| File | Contents |
|---|---|
| [SCREEN_INDEX.md](SCREEN_INDEX.md) | every state, with doc + screenshot links |
| [STATE_GRAPH.md](STATE_GRAPH.md) | nodes, verified transitions, structural findings |
| [UX_MAP.md](UX_MAP.md) | visual app map and journey summary |
| [COMPONENTS.md](COMPONENTS.md) | reusable component model + clone inventory |
| [DESIGN_SYSTEM.md](DESIGN_SYSTEM.md) | spacing/type/colour/shape/icon system |
| [design-tokens.json](design-tokens.json) | machine-readable tokens |
| [screens/](screens/) | per-screen specs |
| [flows/](flows/) | transition-level flow logs (incl. session-2 step log) |
| [screenshots/](screenshots/) | 63 captures; register in SCREEN_INDEX |
| [accessibility/](accessibility/) | 13 raw AX snapshots (25 files); register in SCREEN_INDEX |
| [CURRENT_STATUS.md](CURRENT_STATUS.md) | authoritative status / contradictions / remaining work |
| [FINAL_GAP_AUDIT.md](FINAL_GAP_AUDIT.md) | earlier gap audit (superseded where CURRENT_STATUS differs) |
| [REVERSE_ENGINEERING_REPORT.md](REVERSE_ENGINEERING_REPORT.md) | totals, blockers, uncertainties |
| [specs/](specs/) | early Home-only research (superseded, kept for history) |

## Method & rules

- Driven read-mostly via Peekaboo (macOS accessibility + screenshots); one action at a time, state verified before and after every action and before any screenshot is saved.
- Every value is tagged **OBSERVED / MEASURED / ESTIMATED / INFERRED**; estimates are never presented as measurements.
- Safety: no purchases, no subscription/account/profile changes, no destructive actions (per CLAUDE.md). The paywall was **opened once, view-only** and closed with ✕. A full list of state-changing actions is in the report's Safety log.
- Coordinates: global macOS points; per-screen docs also give window-local coordinates (origin 1362, −1174 at capture time).

## Known hard limits

- Hex colours and corner radii are now **measured from 1x screenshots** (see DESIGN_SYSTEM.md); font family/sizes, border widths, dark mode and motion are still not measured.
- **Window-state and viewport rules:** inactive-window captures (32) support structure only; canonical viewport is 788×1083 (554×772 and 908×1083 are alternates, not geometry sources); PNG colour encodings differ (see design-tokens.json `meta.rules`).
- Peekaboo clicks on this app return "unconfirmed" while landing; every transition was verified by a following state read.
- Typed English is corrupted by the active Telex input method unless it avoids `w s f r x j z` and doubled vowels.
