# UI/UX implementation status

Last checked: 2026-10-13. `design-system/` remains the canonical product specification.
This document tracks the Flutter implementation, not the archived research.

Motion baseline: the Home mode carousel now snaps to cards after drag and honours reduced motion. Writing and Grammar share a single animated feedback surface with tokened timing and travel; outgoing feedback is removed from interaction and semantics. Live GramaGo interaction confirms the two-stage correct Writing feedback and loading states for topic and lesson screens. Exact animation durations remain unmeasured.

Validation on 2026-10-12: `flutter analyze`, the app test suite, design-token verification and architecture checks pass. Two existing design-system goldens (`vertical_slice_components` and `grammar_components_regular`) fail with the same pixel counts on an isolated clean HEAD worktree, so their renderer baseline needs a separate review before regeneration.

2026-10-13: the client now bundles Plus Jakarta Sans from the OFL release. The macOS starting content size is 788×1083 logical points when the visible display allows it; smaller displays clamp the initial window to the available space. Live macOS inspection confirmed that the Profile exposes separate learning and app language rows, and switching to Tiếng Việt updates the Profile immediately. App tests (77), analysis, token verification, architecture check and macOS debug build pass.

Follow-up Profile comparison on 2026-10-13: live GramaGo showed the avatar ring, Plus CTA, English/A1 card, grouped rows, and a version/credit footer in its accessibility tree. The Flutter header height was reduced after comparing the two rendered top sections; the dock's right shortcut uses a sun glyph and opens Profile, matching the live app's `Sun--Streamline-Flex` icon. The client footer uses its own product text rather than copying GramaGo's author credit. The language flow test now scrolls to and checks the end of Profile at compact, reference and wide widths.

Live interaction on 2026-10-13 confirmed that GramaGo lets a new card enter Review even with zero due cards, shows its four grades on both sides, and advances the queue after grading. The Flutter client now offers a local flashcard practice session with flip, grades and completion. Grades only advance the local session; SRS dates require the backend. Profile Lesson settings now stores an answer palette and hint visibility, both applied in Writing and Grammar. Profile Appearance stores and applies the Home learning-card style. Both use device preferences. The other account, purchase, voice, notification and external-destination rows remain unconnected.

| Canonical template | Current Flutter state | Remaining work |
|---|---|---|
| HomeDashboard | Partial | Quick-topic rail, direct language entry, composer sheet, Flow Letter game destination and backend-backed streak remain. The full-width dock now places History and Settings at its edges, Menu at its centre, and the streak pill above it. Menu now follows the live five-row full-screen overlay; Upgrade and FlowLetter await routes. |
| TopicPicker | Partial: Writing and Grammar | Complete loading/empty/error behavior and shared filter interactions; Conversation picker absent. |
| LessonList | Partial: Writing and Grammar | Complete empty/loading states and carousel snap behavior; Conversation list absent. Both existing lists now show pager dots. |
| Exercise | Partial: Writing and Grammar | Writing and Grammar now reach the shared completion flow; Writing canceled grading responses are ignored. Writing correct feedback now starts with an answer recap, then offers a loading state before detailed analysis. The local repository already contains the analysis, so production still needs a separate backend request for that stage. Writing failure UI, menu actions, preference-controlled answer palette and Writing feedback minimisation remain. |
| Conversation (Free) | Absent | Shell, bubbles, composer, score feedback, exit flow and backend adapter. |
| Conversation (Scenario) | Absent | Variant of the shared conversation shell, persistent mode preference, scripted task flow. |
| FlashcardDeck | Partial: list/detail/review entry | Deck list, detail, counters, segmented control, word rows and typed navigation render with local development content. New cards can enter review. Backend data/loading/error states, deck editing, game destination, speech and delete actions remain. |
| SRSReview | Partial: local practice | Front/back card, four grade buttons and queue-empty state work with local sample cards. Scheduling, server progress, intervals and richer card content remain backend-owned or unauthored. |
| SettingsList | Partial | The Profile page has the double-ring avatar and plan badge, Plus preview, English/A1 language card, grouped rows, and a version/footer. App language, Lesson settings and Appearance open typed routes. Account-backed and external actions remain unavailable. |
| SettingsDetail | Partial: language/lesson/appearance | EN/VI app language persists. Lesson answer palette and hint visibility persist and apply in exercises; Appearance style persists and applies to Home cards. Voice, notifications, profile editing and account actions remain. |
| Insight | Partial: overview/history/streak | Streak now has the live summary/calendar/stats order and month navigation. Review has a centred title, search, and grouped rails when entries exist. The repository remains empty until backend progress data is connected; no account history is fabricated. |
| FlowLetterGame | Absent | Visual world and lobby; rules/results require DD-16 product decision. |
| Paywall | Deferred | Intentionally off in v1 under DD-24. |
| Completion | Implemented for Writing and Grammar | DD-01 floating summary over the lesson list shows completed steps and incorrect grading outcomes; Next lesson and Done use typed routes. Scenario conversation remains absent. Product copy and stats still need DD-01 review. |

## Verification required for completion

- Compare rendered compact, regular and wide layouts to every implemented template.
- Confirm touch, mouse, keyboard, focus and screen-reader behavior for each active control.
- Run design-token verification, architecture checks, static analysis and relevant tests.
- Keep user-facing chrome in EN/VI localization; keep backend-owned grading, scoring and scheduling in adapters.
