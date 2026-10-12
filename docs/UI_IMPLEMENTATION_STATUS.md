# UI/UX implementation status

Last checked: 2026-10-12. `design-system/` remains the canonical product specification.
This document tracks the Flutter implementation, not the archived research.

| Canonical template | Current Flutter state | Remaining work |
|---|---|---|
| HomeDashboard | Partial | Quick-topic rail, direct language entry, composer sheet, Flow Letter game destination and backend-backed streak remain. Carousel, pager, flashcard banner, Flow Letter preview tile, four bottom-bar controls and MenuOverlay now follow the canonical variants; Word game is shown as unavailable until its flow exists. |
| TopicPicker | Partial: Writing and Grammar | Complete loading/empty/error behavior and shared filter interactions; Conversation picker absent. |
| LessonList | Partial: Writing and Grammar | Complete empty/loading states and carousel snap behavior; Conversation list absent. Both existing lists now show pager dots. |
| Exercise | Partial: Writing and Grammar | Writing and Grammar now reach the shared completion flow; Writing canceled grading responses are ignored. Writing failure UI, menu actions, preference-controlled answer palette and Writing feedback minimisation remain. |
| Conversation (Free) | Absent | Shell, bubbles, composer, score feedback, exit flow and backend adapter. |
| Conversation (Scenario) | Absent | Variant of the shared conversation shell, persistent mode preference, scripted task flow. |
| FlashcardDeck | Partial: list/detail | Deck list, detail, counters, segmented control, word rows and typed navigation render with local development content. Backend data/loading/error states, review and game destinations, speech and delete actions remain. Review is disabled while due count is zero. |
| SRSReview | Absent | Front/back card, four grade buttons, keyboard controls and queue-empty state. Scheduling remains backend-owned. |
| SettingsList | Partial | Guest account card and grouped rows render; Language opens a typed route. Level, lesson settings, appearance and voice are visible as unavailable until their controls and ownership exist. |
| SettingsDetail | Partial: Language | English/Vietnamese selection applies after the CTA, updates app localization and persists as a device preference. Additional languages, level, lesson settings, appearance and voice variants remain. |
| Insight | Partial: overview/history/streak | Stats, month calendar, week chart, searchable History empty state and typed destinations render with an empty local repository. Backend data, populated history grouping and progress updates remain. |
| FlowLetterGame | Absent | Visual world and lobby; rules/results require DD-16 product decision. |
| Paywall | Deferred | Intentionally off in v1 under DD-24. |
| Completion | Implemented for Writing and Grammar | DD-01 floating summary over the lesson list shows completed steps and incorrect grading outcomes; Next lesson and Done use typed routes. Scenario conversation remains absent. Product copy and stats still need DD-01 review. |

## Verification required for completion

- Compare rendered compact, regular and wide layouts to every implemented template.
- Confirm touch, mouse, keyboard, focus and screen-reader behavior for each active control.
- Run design-token verification, architecture checks, static analysis and relevant tests.
- Keep user-facing chrome in EN/VI localization; keep backend-owned grading, scoring and scheduling in adapters.
