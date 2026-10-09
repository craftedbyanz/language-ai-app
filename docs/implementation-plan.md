> **SUPERSEDED (2026-10-09).** This plan was written against an 18-state, ~60%-complete reference. It is superseded by the current UI/UX research in [`references/gramago/`](../references/gramago/) — start from [CURRENT_STATUS.md](../references/gramago/CURRENT_STATUS.md) and [SCREEN_INDEX.md](../references/gramago/SCREEN_INDEX.md). Known-stale claims here: "18 states", "~60% complete", conversation "unverified, likely chat", "design-tokens has no colours", "MenuSheet", "Next → next lesson". **Do not use as input.** Kept for history only.

# Implementation Plan — Language AI App (Phase 2 mobile app)

Written 2026-10-08, based on the GramaGo reverse-engineering reference (`references/gramago/`, 18 states). The reference crawl is ~60% complete (see its REVERSE_ENGINEERING_REPORT); this plan will need a revision pass once the remaining branches (conversation mode, paywall, Insight, Flow Letter, AI generator) are captured. Backend is out of scope for now.

**Audience:** engineers starting the mobile app from zero.

## 1. Product shape (from the reference)

A Vietnamese→English learning app with:

- **Home dashboard**: greeting + AI prompt, promo banner, 3 mode cards (writing / grammar / conversation), topic chips, flashcard banner, mini-game banner, feature tiles, floating bottom bar (history / streak+menu / settings).
- **Content funnel**: mode → category rail → topic grid → lesson list (carousel) → exercise.
- **Exercises**: a shared editor shell — paragraph translation (writing), single-sentence correction (grammar), conversation (unverified, likely chat).
- **AI feedback**: half-sheet with verdict, corrected text (per-word spans), explanation, key improvements, Edit/Next, thumbs rating.
- **Flashcards/SRS**: decks, word rows (definition, IPA, audio, status), review sessions with 4-way grading (forgot/hard/remembered/easy → 1m/6m/1d/4d).
- **Progress**: streak calendar with current/longest stats, exercise history grouped by type, profile/settings.

## 2. Stack (decided)

| Concern | Choice |
|---|---|
| App | React Native + Expo (TypeScript), Expo Router |
| Local state | Zustand |
| Server state | TanStack Query |
| Forms | React Hook Form + Zod |
| Backend (later phase) | Go + PostgreSQL — **not built now**; the app ships with a mock data layer behind the same interfaces |

## 3. Proposed structure

```
apps/mobile/
  app/                      # Expo Router routes
    (tabs)/                 # no real tabs in reference; single dashboard + pushed screens
      index.tsx             # Home dashboard (S001)
    mode/[modeId]/          # topic picker (S002/S008/S023-conversation)
    lesson/[topicId].tsx    # lesson list (S003/S009)
    exercise/[lessonId].tsx # editor modal (S004/S005/S010)
    flashcards/
      index.tsx             # deck list (S012)
      [deckId].tsx          # deck detail (S013)
      review/[deckId].tsx   # SRS session (S014/S015)
    history/index.tsx       # S017
    streak/index.tsx        # S018
    profile/index.tsx       # S016
  src/
    components/             # one folder per reference component (see below)
    design-system/          # tokens.ts (from design-tokens.json), primitives (Pill, Card, SectionHeader, MicroLabel…)
    features/               # feature-level composition (home, exercise, feedback, srs…)
    services/               # api client interface + mock implementation
    stores/                 # zustand stores
    hooks/
    i18n/                   # vi/en strings (reference UI copy is Vietnamese)
```

## 4. Component build order (from COMPONENTS.md inventory)

1. Design primitives from `design-tokens.json` — fill hex colours first (see open questions).
2. Layout chrome: NavBar, FloatingBottomBar, MenuSheet.
3. Home content: SectionHeader, ModeCard, TopicChip, PromoBanner, FeatureBanner, FeatureTile.
4. Content funnel: CategoryChip rail, TopicSetCard grid, LessonCard carousel, LevelPill.
5. Exercise: EditorShell (TextEditor + disabled→enabled submit), exit ConfirmDialog.
6. Feedback: FeedbackSheet (verdict, WordSpan list, explanation, bullets, Edit/Next, thumbs).
7. Flashcards: DeckCard, DeckHeader, WordRow, SRSCardStack (flip), GestureTutorial, IntervalButtons.
8. Utility: SettingsRow, AccountCard, CalendarGrid, StatTile, HistoryCard, SearchField.

## 5. State model sketch

- `session` (Zustand): user, plan (free/plus), locale, streak cache.
- Server state (TanStack Query, mocked): `topics(mode, category)`, `lessons(topicId)`, `lesson(lessonId)`, `grade(submission)` (mock returns a canned feedback sheet), `decks`, `deckWords(deckId)`, `scheduleWord(wordId, grade)`, `history`, `streak`.
- Editor local state (RHF): answer text; submit disabled while empty (matches reference behaviour S004→S005).
- SRS session local state: card queue, current card, flipped flag; grading calls `scheduleWord`.

## 6. Design tokens to resolve before building screens

`design-tokens.json` has measurements but **no colours and no font**: schedule a pixel-sampling pass on the existing screenshots (or pick our own brand palette) and choose a type ramp (recommend mapping the measured frame heights 39/26/19/16/13/9/8 to a standard ramp). All radii are estimates; validate visually against screenshots.

## 7. Milestones

| # | Milestone | Exit criteria |
|---|---|---|
| M1 | Scaffold + tokens + primitives | app boots; primitives match screenshots side-by-side |
| M2 | Home + navigation (S001, S011) | dashboard renders from mock data; menu sheet works |
| M3 | Content funnel (S002–S003, S008–S009) | mode → topic → lessons navigation with mocked catalogs |
| M4 | Exercise + feedback (S004–S007, S010) | editor with disabled/enabled submit, exit dialog, mock feedback sheet |
| M5 | Flashcards/SRS (S012–S015) | deck list → detail → review session with grading |
| M6 | Utility (S016–S018) | profile, history, streak screens |
| M7 | Post-crawl revision | reconcile with the completed reference (conversation, paywall, Insight, Flow Letter) |

## 8. Explicit non-goals for now

- No backend, no auth, no payments (paywall screens render as static mockups only).
- No account/profile editing, no log out (mirror the blocked branches).
- No real AI grading — `grade()` returns structured mock feedback matching the S006 schema.
