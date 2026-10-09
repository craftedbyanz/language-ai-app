# Accessibility

Reusable expectations distilled from the accessibility-tree evidence of the research (desktop accessibility APIs, 21 snapshots, 43 files) and from standard guidance (WCAG 2.2 AA). Each rule is labelled **OBSERVED** (the reference app already behaved this way) or **REQUIRED** (this design system adds it; the reference did not demonstrate it). Raw trees are archived; do not copy them.

---

## 1. Semantic roles

| UI | Role | Notes | Tag |
|---|---|---|---|
| Screen title in `AppHeader` | heading | Centre title exposed as heading; hero is level 1 | OBSERVED |
| Back / close / more / submit | button | Distinct names (see §2) | OBSERVED |
| Mode card, topic card, deck card, banner, history card | button | One control; name concatenates child text (P1) | OBSERVED |
| Grammar/writing answer field | text field (multiline) | Labelled; value exposed | OBSERVED |
| Source text | read-only text field / region | Value readable, not settable | OBSERVED |
| Chat composer | text field | Placeholder text is its name in the reference; add an explicit label | OBSERVED / REQUIRED |
| Chip rail (filter) | radiogroup of radios | Selected exposed | REQUIRED |
| Segmented control | tablist or radiogroup | Selected exposed | REQUIRED |
| Toggle | switch | Checked exposed | REQUIRED |
| Progress stepper | progressbar with `valuenow`, `valuemax` | Not a list of decorative boxes | REQUIRED |
| Sheet grabber | button, value "Half screen" | Operable: expand/minimise | OBSERVED |
| Alert dialog | alertdialog | Title + body as description | OBSERVED |
| Menu / popup | menu with menuitem (disabled items present) | | OBSERVED |
| Chat list | log | New messages announced | REQUIRED |
| Score chip | button | Name includes the number and summary | REQUIRED |
| Decorative icons, index numerals, illustrations | hidden from AT | | REQUIRED |

## 2. Button labels (names are a contract)
- Every icon-only button has a text name: `Back`, `Close`, `More`, `Submit`, `Undo`, `Show last feedback`, `Speak`, `Delete`, `Menu`, `History`, `Settings`.
- Name = **function**, not icon description (reference icons were exposed with auto-generated names; do not repeat that).
- Toggle-like names do not include the state; state is a separate property (a status pill such as the streak may bake its value into the name: "Streak: 3 days").
- Grade buttons: "`<Label>, <interval>`" (e.g. "Good, 1 day"). OBSERVED pattern (interval-then-label).
- Sheet close and rating: `Close`, `Like`, `Dislike`.

## 3. Focus and keyboard
- Everything interactive is focusable in reading order; focus ring is always visible: `focus.ringWidth` thick, `accessible.focusRing`, offset `focus.ringOffset` so it sits on the page colour (≥ 3:1).
- Dialog/sheet/menu open: focus moves in (dialog → *stay* action; sheet → its title; menu → first item). Close: focus returns to the trigger.
- `Esc` closes dialogs, sheets, menus, FAB fan, overlays. `Enter`/`Space` activate. Arrow keys navigate menus, radiogroups, tabs, SRS grade row.
- Composer: `Enter` sends, `Shift+Enter` newline. Editor: `Cmd/Ctrl+Enter` submits (recommended).
- Modal surfaces trap focus; non-modal feedback sheets do not.

## 4. State announcements
| Event | Announcement |
|---|---|
| Grading started | "Grading" (polite) |
| Verdict ready | "`<Verdict title>`" then summary (polite) |
| New chat message | speaker + text; translation only if visible |
| Stepper advances | "Step N of M" |
| Score available | "Score N" |
| Hint revealed | the hint text |
| Submit enabled/disabled | state change exposed via `disabled`, not announced |
| SRS card flipped | back content read; grade row announced as a group |
Use `aria-live=polite` regions for results; never `assertive` except blocking errors (DD-04).

## 5. Selected / disabled behaviour
- Disabled controls (submit with empty field, send with empty composer, create CTA, "coming soon" rows) remain **in the tree**, flagged disabled, with a reason in the description when non-obvious. OBSERVED for submit/send; REQUIRED for the rest.
- Selected state is exposed on chips, rows, plan cards, segments and style tiles (`selected`/`checked`), never by colour alone: pair with outline weight, check icon or radio.
- Locked content (PlusTile) is a normal enabled button that opens the paywall; do not disable it.

## 6. Modal and dialog behaviour
- `Dialog/Confirm`: role alertdialog; title and body in the accessible description; two buttons; default focus on the non-destructive action; Esc = stay. OBSERVED (structure).
- Scrimmed sheets (info) are modal: background inert. Non-scrimmed sheets (feedback, create, paywall) behave as non-modal dialogs but still take focus when opened. The page behind a scrimless sheet stays **visible but secondary**; if it must be inert, mark it so.
- Menu overlay: modal, background inert.
- Sheets announce their title when opened; the grabber exposes its state ("half screen" → "expanded").

## 7. Text input labelling
- Every input has a visible or programmatic label. Placeholders (`Type your answer…`) are hints, not labels.
- Answer card: label "Your answer" (and prompt linked via description); max-length and language hints are exposed via description.
- Search field: role searchbox, label "Search".
- Answer cards take their text colour only from the paired `answerPalette.<key>.foreground` token (≥ 4.5:1 by construction).

## 8. Contrast and colour (REQUIRED)
- Body text ≥ 4.5:1; large text and UI components ≥ 3:1.
- `textFaint` (#9AA0AB) fails 4.5:1 on white: decorative only.
- Lime accent text on white fails: lime is a fill; labels on lime use `textPrimary`.
- White text on `success` (2.5:1) fails: use `textPrimary` on success fills (7.5:1).
- White text on `primary` (#3B82F6) is 3.7:1 and on the default writing answer card (#A855F7) 4.0:1: both pass only for large or bold text. The production rule is §8A: brand surfaces use `accessible.brandFill` + `accessible.onBrand`; the answer card uses its `answerPalette.<key>.foreground` pair (`textPrimary` on the default purple 4.8:1 and grammar blue 4.7:1) (DD-26). DD-22.
- Red, green and orange **text** at body size use `accessible.errorText` / `successText` / `warningText`; `error` (3.8:1), `success` (2.5:1) and `warning` (2.8:1) are for icons, fills and dots.
- Verdict, diff and score always have a non-colour cue (icon, strike-through, number).
- Support increased contrast and reduced transparency (glass fallback, PATTERNS P20).

### 8A. Fidelity token vs accessible-production token

TOKENS.json keeps the **observed** colour (fidelity token: `color.*`, `feedback.*`, `score.*`, ...) and adds an **accessible-production** alias (the `accessible.*` group, plus `color.primaryStrong`, `errorText`, `successText`, `warningText`, `primaryTextOnTint`, `errorTextOnTint`). Never edit the fidelity value; choose by **role**:

| Role of the colour | Use | Do not use | Contrast on its background (fidelity → production) |
|---|---|---|---|
| Fill, dot, bar, icon *next to text*, decoration | fidelity: `color.primary/success/warning/error`, `score.*`, `feedback.*` | n/a | no text; a lone icon needs 3:1 and a shape/word cue |
| Blue text / link on white | `accessible.link` | `color.primary` | 3.7 → 5.2 |
| Blue text on a blue tint | `accessible.textOnPrimaryTint` | `color.primary` | 3.0 → 5.5 |
| Orange text / selected-filter outline | `accessible.warningText` | `color.warning` | 2.8 → 5.2 |
| Red text on white | `accessible.errorText` | `color.error` | 3.8 → 4.8 |
| Red text on `errorTint` (destructive action) | `accessible.errorTextOnTint` | `errorText` | 4.2 → 5.9 |
| Green text, selected radio/check, toggle on | `accessible.successText` / `selectedIndicator` / `toggleOn` | `color.success` | 2.5 → 5.5 |
| Diff added word | `accessible.diffAddedText` | `feedback.diff.addedText` | 2.1 → 4.6 |
| Toggle off track | `accessible.toggleOff` | `control_state.toggleOff` | 2.0 → 3.3 |
| Hero second line | `accessible.heroSecondLine` | `textFaint` | 2.6 → 5.2 |
| Focus ring | `accessible.focusRing` | `color.primary` | 3.7 → 5.2 |
| Text on a brand-blue surface | `accessible.brandFill` + `accessible.onBrand` (white in both profiles) | white on `color.primary` | 3.7 → 5.2 |
| Text on a mid-tone feature fill (writing/grammar home card, scenario task bubble, grade glyph) | `accessible.onFeatureFill` | white | 2.0-3.7 → 5.2-9.5 |
| Text, placeholder, caret, icons on an **answer card** | `answerPalette.<key>.foreground` (paired with `.background`) | any other colour; computing one | pairs 4.7-19:1 (DD-26) |
| Text on indigo (`feature.conversation.*`) | `accessible.onBrand` (white) | `textPrimary` | 5.2 |

**Profiles (DD-22, APPROVED_V1).** `production` is the **default**. `fidelity` is an **explicit opt-in only**, made by the product owner and recorded in DD-22: apply `TOKENS.json` `meta.colorProfile.fidelityOverrides` (each listed `accessible.*` key resolves to its fidelity token; `onBrand` stays white; `answerPalette` and `control_state.action*` do not change). Expect AA failures on body-size text in fidelity mode. A coding agent never selects it on its own. Raw fidelity tokens stay available in both profiles for decorative fills, dots, bars and previews.

**Unlisted pair:** compute contrast. Text below 4.5:1 or a non-text indicator below 3:1 means use a production alias; if none exists, add one to the TOKENS.json `accessible` group and to this table (never inline a hex).

## 9. Touch / pointer targets
- Minimum hit area `control.minTouchTarget` (44) even when the visual is smaller (submit 26, send 26, back 33, thumbs 16).
- Adjacent targets separated by ≥ 8 ru.

## 10. Gestures and motion
- Every gesture has a button/keyboard alternative (swipe grading → four grade buttons; drag letters → tap-select/tap-place; grabber drag → grabber button; carousel swipe → pager + arrow keys).
- Respect reduced motion: no scale/slide on carousel, sheets fade only.
- The typing indicator animates; offer a static "typing" label to screen readers.

## 11. Language and content
- Interface text language is a product setting (copy is content, never hard-coded); target-language and translation lines carry `lang` attributes so screen readers switch voice. REQUIRED.
- IPA text is exposed with the speaker button adjacent, not read as text.
- Case: uppercase microLabels use CSS transform, not literally uppercase source text, so screen readers don't spell them.

## 12. Known gaps
- Score popover exposed **no accessible elements** in the reference (rendered but empty tree). We require the opposite (see §6, §1).
- Menu popups in the reference were reachable only as AX items (never rendered visually): the visual spec for the chat More menu is open (DD-03).
- Game accessibility (Flow Letter) is unevidenced: apply §10 and DD-16.
