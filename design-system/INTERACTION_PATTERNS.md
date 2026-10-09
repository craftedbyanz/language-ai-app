# Interaction Patterns

Reusable flows. Notation: `→` is a user or system transition. Tags: **OBSERVED** (seen in active captures), **INFERRED**, **DESIGN_DECISION_REQUIRED** (no evidence; see [DESIGN_DECISIONS.md](DESIGN_DECISIONS.md)), **DEFERRED_EVIDENCE**.

---

## 1. Exercise flow (writing and grammar)

```
TopicPicker → LessonList → Editor(empty) → [type] → Editor(filled, submit enabled)
  → Submit → FeedbackSheet(loading) → FeedbackSheet(verdict)
      ├─ Edit / Fix  → Editor(filled, same step, text kept) → Submit …
      └─ Next        → Editor(empty, step n+1, stepper advances, next sentence highlighted)
  → … → final step → CompletionTemplate  [DD-01 default]
```

| Step | Behaviour | Tag |
|---|---|---|
| Picker → list → editor | Same chain for every mode; each hop is a push, the editor is modal | OBSERVED |
| Empty editor | Submit disabled (ring); answer card autofocus; hints blurred | OBSERVED |
| Filled editor | Submit enabled (dark filled circle) | OBSERVED |
| Submit | Opens `FeedbackSheet` in `loading` with skeleton; editor stays visible and un-scrimmed | OBSERVED |
| Verdict (writing) | `WritingCorrect` / `WritingIncorrect`; both offer Edit + Next | OBSERVED |
| Verdict (grammar) | `GrammarIncorrect` offers Fix + Next; `GrammarCorrect` is compact, offers Next only; no loading frame was seen on a correct grammar answer (INFERRED: local exact-match) | OBSERVED / INFERRED |
| Next | Advances exactly one step; clears field; highlights the next source sentence (writing) or loads the next prompt (grammar). Works the same after correct and incorrect verdicts | OBSERVED |
| Edit / Fix | Closes the sheet, keeps the learner's text, returns focus to the field | OBSERVED |
| Minimise | Grabber hides the sheet; a sparkle chip appears at the start of the `HintChipBar`; tapping it reopens the last sheet | OBSERVED |
| Cancel while loading | A "Cancel" action exists on the skeleton; result of cancel not observed | OBSERVED (control) / DD-04 (outcome) |
| Rating | Thumbs like/dislike on writing verdicts; effect unobserved | DD-15 |

## 2. Conversation flow

```
TopicPicker → LessonList → [Start chat] → Chat(AI opens)
  → type → Send → (typing indicator, ≈ several seconds) → AI reply + ScoreChip under learner bubble
  → ScoreChip tap → FeedbackSheet/ConversationScoreFeedback → close
  → More → End session → Dialog/Confirm → Stay | Leave → LessonList
```
- AI always speaks first. OBSERVED.
- The chip appears after the AI reply, attached to the learner's message. OBSERVED.
- Translation lines: global toggle in the "More" menu; hides/shows italic translations in all bubbles. OBSERVED.
- Closing and "end session" **both** show the same confirmation (V11, DD-02). No result screen (DD-02 default).
- The More popup: `PopupMenu/Standard` with "Hide/Show translation" and "End session" (DD-03 default).

## 3. Scenario flow

```
TopicPicker → FAB → Mode pill = Scenario (persists) → LessonList → [Start chat]
  → ScenarioConversation(opening): scripted AI line (VI + gloss) + translation Task bubble + hint chips + composer
  → learner types translation → send → FeedbackSheet/Writing* → Next appends next AiScripted + Task, stepper advances → … → CompletionTemplate  [DD-06 default]
  → Close → Dialog/Confirm → LessonList
```
- Scenario is a *mode preference* set on the picker; selection persists across navigation and can be restored to Free by the same pill. OBSERVED.
- Stepper (8 segments) replaces the header title. OBSERVED.

## 4. SRS flow

```
Deck detail → [Review (N)] → (first time: tutorial overlay → "Got it") → Card front
  → tap card → Card back (translation, gloss, example, 4 grade buttons)
  → grade (Again/Hard/Good/Easy) → next card Front → empty queue → EmptyState "Review complete" [DD-07 default]
  → Close → deck detail (no confirmation)
```
- v1: the four grade buttons are the canonical interaction (keys 1–4 grade, Space flips). No swipe grading and no tutorial overlay in v1 (DD-25, APPROVED_V1); swipe may later be added as a progressive enhancement that mirrors the buttons.
- "More" offers: guide, card colour, autoplay (AX only). OBSERVED.

## 5. Exit confirmation

```
Active task (editor / chat) → Close
  → input empty? close immediately (default)
  → else Dialog/Confirm: "Leave exercise?" — Stay (default, left) | Leave (destructive, right)
      Stay  → returns to the task untouched (INFERRED: not chosen in research)
      Leave → pops to LessonList; progress is discarded (copy says so)
```
- Same dialog for writing, grammar, conversation, scenario. OBSERVED.
- Not shown for flashcard review and the word game (progress is inherently saved/disposable). OBSERVED.

## 6. Overlays and popups

| Surface | Trigger | Scrim | Dismiss | Focus | Evidence |
|---|---|---|---|---|---|
| `Dialog/Confirm` | Close with work | ≈ 20% black on page | Stay button / Esc | trapped; default Stay | S007, S062 |
| `FeedbackSheet` | submit / chip | none | close, grabber minimise, outside tap | moves to sheet | S006, S028 |
| `Sheet/Create` | create action | none | close | trapped | S030 |
| `Sheet/Info` | info pill | ≈ 20% black | close | trapped | S032 |
| `Sheet/Paywall` | banner / menu | none | close | trapped | S045 |
| `MenuOverlay` | Menu pill | frosted + dim | tap backdrop (INFERRED) | trapped | S011; DD-14 |
| `PopupMenu` | More button | none | outside tap / select | menu | S051 |
| `FAB` fan | FAB tap | ≈ 20% black | close pill / outside | menu | S031 |
| Tutorial overlay (not in v1, DD-25) | first SRS review | strong | "Got it" | trapped | S014 |

Rule: **scrim is a per-surface property** recorded in this table; do not invent a global overlay style.
Stacking: only one modal surface at a time; a non-modal sheet may coexist with the editor beneath it.

## 7. Mode switching

- **Between learning modes**: via the dashboard carousel (each mode runs the same chain). There is no in-flow switcher.
- **Free ↔ Scenario conversation**: persistent preference on the conversation picker `FAB` mode pill. After toggling, "Start chat" opens the selected variant.
- **Direction swap (writing)**: an icon swaps source/target language direction in the editor. Effect not exercised (INFERRED).
- **Answer card colour, card style, card order**: user preferences in settings; all reflect immediately (INFERRED).

## 8. Loading

| Context | Pattern | Tag |
|---|---|---|
| AI grading (any exercise) | `FeedbackSheet` skeleton + "Grading…" title + spinner + Cancel | OBSERVED |
| Chat reply | `ChatBubble/Typing` (three dots) for several seconds | OBSERVED |
| Opening AI turn | Typing indicator or skeleton, then first bubble | OBSERVED |
| Page/list loading | none seen | DD-04 |
Rule: loading always **preserves the user's work on screen** and offers cancel for AI calls ≥ 3 s (recommended).

## 9. Disabled / enabled submit

| Control | Disabled when | Visual |
|---|---|---|
| `SubmitButton` | field empty/whitespace | ring `control_state.submitDisabled` |
| `ChatComposer` send | field empty | `control_state.sendDisabled` fill |
| `Sheet/Create` CTA | text empty | dimmed |
| Language/Level confirm | no new selection (INFERRED) | dimmed |
Rule: disabled controls remain visible, are announced as disabled, and are never removed.

## 10. Empty states

Observed: zero-data insight (zeros + empty chart), no voice models (icon + title + body + link), no history result (not observed). Pattern: `EmptyState` = icon + title + 1-line body + optional action. Any other empty state: DD-04.

## 11. Error handling

**DEFAULT (DD-04).** No error was observed. Use `InlineError` / `EmptyState/Error` in the failed region with Retry; input is never discarded; never a full-screen error. Grading failure: sheet body becomes `InlineError`, actions "Cancel"/"Retry". Chat failure: `InlineError` row in the log, message kept. Quota/limit: `InlineError` (paywall only if `paywallEnabled`, DD-24). Blocking cases (rare): `Dialog/Confirm` with one action.

## 12. Lesson completion

**DEFAULT (DD-01).** After the last step of an exercise or scenario show `CompletionTemplate` (SCREEN_TEMPLATES §14). Free conversation ends without a result (DD-02). Do not invent any other completion design inside a feature.

## 13. Selection and filtering
- `CategoryChip/Filter`: single select; the grid filters immediately; the selected chip is outlined. OBSERVED.
- `SelectableRow`: single select; confirm button applies. OBSERVED (confirm not pressed).

## 14. First-run hints
- `CoachMark` appears once on first visit to the conversation picker; dismissed forever. OBSERVED.
- SRS tutorial appears on first review. OBSERVED.
- Hints persist state per user; never reshow after dismiss. INFERRED.

## 15. Motion (intentionally minimal)
Use `motion.fast` (state changes), `motion.sheet` (sheets, dialogs, popups, FAB fan) and `motion.easing`; carousel active scale `motion.carouselActiveScale`. Durations are defaults, not evidence (DD-10). Reduced motion: sheets and dialogs fade only, no scale/slide/shake, typing dots become a static label.
