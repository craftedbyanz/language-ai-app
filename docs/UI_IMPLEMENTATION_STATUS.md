# UI/UX implementation status

Last checked: 2026-10-13. `design-system/` remains the canonical product specification.
This document tracks the Flutter implementation, not the archived research.

Motion baseline: the Home mode carousel now snaps to cards after drag and honours reduced motion. Writing and Grammar share a single animated feedback surface with tokened timing and travel; outgoing feedback is removed from interaction and semantics. Live GramaGo interaction confirms the two-stage correct Writing feedback and loading states for topic and lesson screens. Exact animation durations remain unmeasured.

Validation on 2026-10-12: `flutter analyze`, the app test suite, design-token verification and architecture checks pass. Two existing design-system goldens (`vertical_slice_components` and `grammar_components_regular`) fail with the same pixel counts on an isolated clean HEAD worktree, so their renderer baseline needs a separate review before regeneration.

2026-10-13: the client now bundles Plus Jakarta Sans from the OFL release. The macOS starting content size is 788×1083 logical points when the visible display allows it; smaller displays clamp the initial window to the available space. Live macOS inspection confirmed that the Profile exposes separate learning and app language rows, and switching to Tiếng Việt updates the Profile immediately. App tests (77), analysis, token verification, architecture check and macOS debug build pass.

Follow-up Profile comparison on 2026-10-13: live GramaGo showed the avatar ring, Plus CTA, English/A1 card, grouped rows, and a version/credit footer in its accessibility tree. The Flutter header height was reduced after comparing the two rendered top sections; the dock's right shortcut now uses a Profile glyph and label. The client footer uses its own product text rather than copying GramaGo's author credit. The language flow test now scrolls to and checks the end of Profile at compact, reference and wide widths.

| Canonical template | Current Flutter state | Remaining work |
|---|---|---|
| HomeDashboard | Partial | Quick-topic rail, direct language entry, composer sheet, Flow Letter game destination and backend-backed streak remain. The full-width dock now places History and Settings at its edges, Menu at its centre, and the streak pill above it. Menu now follows the live five-row full-screen overlay; Upgrade and FlowLetter await routes. |
| TopicPicker | Partial: Writing and Grammar | Complete loading/empty/error behavior and shared filter interactions; Conversation picker absent. |
| LessonList | Partial: Writing and Grammar | Complete empty/loading states and carousel snap behavior; Conversation list absent. Both existing lists now show pager dots. |
| Exercise | Partial: Writing and Grammar | Writing and Grammar now reach the shared completion flow; Writing canceled grading responses are ignored. Writing correct feedback now starts with an answer recap, then offers a loading state before detailed analysis. The local repository already contains the analysis, so production still needs a separate backend request for that stage. Writing failure UI, menu actions, preference-controlled answer palette and Writing feedback minimisation remain. |
| Conversation (Free) | Absent | Shell, bubbles, composer, score feedback, exit flow and backend adapter. |
| Conversation (Scenario) | Absent | Variant of the shared conversation shell, persistent mode preference, scripted task flow. |
| FlashcardDeck | Partial: list/detail | Deck list, detail, counters, segmented control, word rows and typed navigation render with local development content. Backend data/loading/error states, review and game destinations, speech and delete actions remain. Review is disabled while due count is zero. |
| SRSReview | Absent | Front/back card, four grade buttons, keyboard controls and queue-empty state. Scheduling remains backend-owned. |
| SettingsList | Partial | The Profile page now has the double-ring avatar and plan badge, Plus preview with Upgrade pill, English/A1 language card, circular row icons, original General/Other order, and a version/footer at the end of the scroll. A separate App language row after the original General rows opens a typed route. Account-backed actions and the other detail routes remain unavailable. |
| SettingsDetail | Partial: App language | English/Vietnamese selection applies after the CTA, updates app localization and persists as a device preference. Additional languages, level, lesson settings, appearance and voice variants remain. |
| Insight | Partial: overview/history/streak | Streak now has the live summary/calendar/stats order and month navigation. Review has a centred title, search, and grouped rails when entries exist. The repository remains empty until backend progress data is connected; no account history is fabricated. |
| FlowLetterGame | Absent | Visual world and lobby; rules/results require DD-16 product decision. |
| Paywall | Deferred | Intentionally off in v1 under DD-24. |
| Completion | Implemented for Writing and Grammar | DD-01 floating summary over the lesson list shows completed steps and incorrect grading outcomes; Next lesson and Done use typed routes. Scenario conversation remains absent. Product copy and stats still need DD-01 review. |

## Verification required for completion

- Compare rendered compact, regular and wide layouts to every implemented template.
- Confirm touch, mouse, keyboard, focus and screen-reader behavior for each active control.
- Run design-token verification, architecture checks, static analysis and relevant tests.
- Keep user-facing chrome in EN/VI localization; keep backend-owned grading, scoring and scheduling in adapters.
