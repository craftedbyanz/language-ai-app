# Home Menu Sheet — S011

> **Corrected 2026-10-09 (C05):** the body below that mentions a bottom-anchored / bottom-left panel and a 'dimmed Home' is superseded by the active capture [S011](../screenshots/S011-home-menu-open-active-verification.png): frosted full-window overlay, five centred rows. AX: [overlay--home-menu-open](../accessibility/overlay--home-menu-open.json).

> **Correction (second session, 2026-10-08).** The screenshot [S011](../screenshots/S011-home-menu-open-inactive-original.png) and a second capture show the menu as a **full-window blurred/frosted overlay** over Home, with the five items **centred horizontally** in a vertical stack (y ≈ 636–852, 54 pt pitch) and each item a coloured round icon (≈ 30 pt: teal, orange-gold, purple, orange, green) + bold label. It is not a dark navy bottom-left panel; the "502×242 container" below is only the AX frame of that stack. Items were followed this session: **Insight → S033**, **Chơi FlowLetter → S034**; **Nâng cấp Gramify Plus** was *not* followed here (its paywall was opened from the Home banner, S045). See [insight.md](insight.md), [flow-letter.md](flow-letter.md), [paywall-plus.md](paywall-plus.md). The original text is kept unchanged below.

State ID: `S011 home--menu-open` (Home with menu overlay)
Source: snapshot `ps1_fefd445b0ca77b912110ecd55e93e20f`, screenshot [S011-home-menu-open-inactive-original.png](../screenshots/S011-home-menu-open-inactive-original.png).
Reached from Home by pressing the star icon of the "Menu" pill in the floating bottom bar (OBSERVED).
Tags: OBSERVED / MEASURED / ESTIMATED / INFERRED. Local = global − (1362, −1174).

## Identity

| Field | Value | Tag |
|---|---|---|
| Presentation | Overlay sheet anchored at the bottom-left, over dimmed Home content | OBSERVED |
| Container | AXStaticText "Menu" 502×242 at local (316,680); container group 788×269 at local (0,609) | MEASURED |
| Decorative | Large "Star-Circle--Streamline-Flex" graphic 254×254 at global (1331,−500) — 31 pt off the window's left edge, so it is intentionally cropped | MEASURED |
| Items | 5 rows, vertical list, 54 pt pitch | MEASURED |

## Items (icon image is the actionable element; text beside it)

| Icon (AXImage) | Label | Global x,y of label | Label size |
|---|---|---|---|
| Multiple-Stars--Streamline-Flex (15×15) | "Insight" | 1755,−547 | 48×18 |
| Star-Badge--Streamline-Flex (15×15) | "Nâng cấp Gramify Plus" | 1699,−493 | 159×18 |
| Show-Layer--Streamline-Flex (15×15) | "Học flashcard" | 1730,−439 | 98×18 |
| flame.fill (12×16) | "Chuỗi của tôi" | 1733,−385 | 92×18 |
| Investing-And-Banking--Streamline-Flex (15×15) | "Chơi FlowLetter" | 1722,−331 | 113×18 |

- "Học flashcard" was followed and opens the flashcard deck list (S012). OBSERVED.
- Other items: destinations INFERRED (Insight → analytics/progress; Nâng cấp → paywall — paywall boundary, not opened; Chuỗi của tôi → S018 streak screen, likely the same destination as the Home streak pill; Chơi FlowLetter → mini-game).
- All five destinations are also reachable from other Home controls (streak pill, Flow Letter card, Plus banner), so the Menu is a shortcut hub, not exclusive navigation. INFERRED.

## Visual design

| Observation | Tag |
|---|---|
| Dark navy rounded panel; items as icon + white label rows | OBSERVED |
| Icons small (15×15) and consistent; one SF Symbol (flame.fill) mixed with Streamline set | OBSERVED |
| Row height ≈ 54 (label y −547, −493, −439, −385, −331) | MEASURED |
| No close button; tapping elsewhere presumably dismisses | INFERRED, untested |

## Notes
- The Menu pill itself is not an AXButton: only its star icon (AXImage, actionable) and "Menu" text (static) exist. This repeated pattern (icon actionable, pill not) also appears on the flag button region and editor swap icon. OBSERVED.
