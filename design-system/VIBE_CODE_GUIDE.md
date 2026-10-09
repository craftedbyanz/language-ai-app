# Vibe Code Guide

For Claude Code, Codex and similar coding agents building our product. **You do not need to read all 14 files for a task.** `references/gramago/` is never needed.

## 1. Reading path

**ALWAYS READ (about 10 minutes, every task)**
1. [README.md](README.md): what is canonical.
2. [TOKENS.json](TOKENS.json): the vocabulary. Skim the group names; note the `accessible` group (text colours) and `state`, `focus`, `motion`, `layout`.
3. [IMPLEMENTATION_CONTRACT.md](IMPLEMENTATION_CONTRACT.md): the rules your diff is judged on.

**THEN TASK-SPECIFIC (read only the part you need)**
4. [SCREEN_TEMPLATES.md](SCREEN_TEMPLATES.md): the one template you are building (page composition, regions, states).
5. [COMPONENTS.md](COMPONENTS.md) + [COMPONENT_VARIANTS.md](COMPONENT_VARIANTS.md): only the families the template lists. Pick exact `Component/Variant` names. Read the **Composition constraints** table at the end of COMPONENTS.md.
6. [INTERACTION_PATTERNS.md](INTERACTION_PATTERNS.md): the flow section for your feature (exercise §1, conversation §2, scenario §3, SRS §4, exit §5, overlays §6, loading/errors §8/§11).

**ONLY WHEN NEEDED**
- [DESIGN_DECISIONS.md](DESIGN_DECISIONS.md): when your task touches completion, errors, scores, menus, motion, paywall, game. Every DD has a default; the classification table at the top tells you if anything is blocking (none for the core screens).
- [ACCESSIBILITY.md](ACCESSIBILITY.md): §8A when choosing a colour for text/outline/indicator; §1-§4 when building any interactive component.
- [RESPONSIVE_RULES.md](RESPONSIVE_RULES.md): when laying out widths, grids, sheets, safe areas. §14 has the matrix.
- [FOUNDATIONS.md](FOUNDATIONS.md) / [PATTERNS.md](PATTERNS.md): tone, and recurring compositions (P1-P22).
- [QA_REPORT.md](QA_REPORT.md): readiness status and known limitations.

**TRACEABILITY ONLY (never required)**: [UI_MAPPING.md](UI_MAPPING.md). It maps archived research state ids to components. Ordinary screens never need it.

| Task | Files beyond the always-read set |
|---|---|
| Dashboard | TEMPLATES §1, COMPONENTS (GreetingBlock…StreakPill, ModeCard, Banner, CategoryChip, FloatingBottomBar, MenuOverlay) |
| Topic picker / lesson list | TEMPLATES §2-3, TopicCard, LessonCard, SectionHeader |
| Exercise + feedback | TEMPLATES §4, §14, ExerciseEditor… SubmitButton, FeedbackSheet family, INTERACTION §1 |
| Free conversation | TEMPLATES §5, ConversationShell, ChatBubble, ChatComposer, ScoreChip, INTERACTION §2 |
| Scenario | TEMPLATES §6, ConversationShell/Scenario, INTERACTION §3 |
| Flashcards / SRS | TEMPLATES §7-8, FlashcardDeckHeader…SRSGradeButton, INTERACTION §4 |
| Settings | TEMPLATES §9-10, SettingsRow, SelectableRow, Toggle |

## 2. How to work

1. **Name the target.** Which template? Which components and variants? Write the list before code.
2. **Check decisions.** Search `DESIGN_DECISIONS.md` for the areas you touch. Use the default and add `// DD-XX default`.
3. **Generate tokens once.** Derive theme variables or a typed token module from `TOKENS.json` (resolve `{aliases}`). Components import tokens; no literals.
4. **Pick colours by role.** Production profile is the default and fidelity is opt-in only (DD-22). Text, icons, links, outlines and state indicators use `accessible.*` (ACCESSIBILITY §8A). Fills, dots, bars and previews may use raw tokens. Answer cards use `answerPalette.<key>` background+foreground pairs only.
5. **Build components first (all states), then compose the template.**
6. **Wire accessibility as you go.**
7. **Validate** (section 4).

## 3. Example prompts

### Writing Topic Picker
> Build `TopicPickerTemplate` (mode = writing): `AppHeader/Pushed`, `SectionHeader/Hero`, `CategoryChip/Filter` rail (radiogroup), two-column grid of `TopicCard/Standard` (`TopicCard/Plus` only if `paywallEnabled`). Tokens only; topics and categories come from props; 1 column below `layout.breakpointCompact`; loading = skeleton cards; empty = `EmptyState`.

### Grammar exercise
> Build `ExerciseTemplate` with `ExerciseEditor/Sentence`, `ProgressStepper/Grammar`, `FeedbackSheet/GrammarIncorrect|GrammarCorrect`. Submit disabled until text. "Fix" keeps text; "Next" advances. Close with input shows `Dialog/Confirm`. After the final step show `CompletionTemplate` (`// DD-01 default`).

### Scenario conversation
> Build `ConversationShell/Scenario`: `AppHeader/Progress` + `ProgressStepper/Scenario`, `ChatBubble/AiScripted` with `RoleLabel`, `ChatBubble/Task`, `HintChipBar`, `ChatComposer/Scenario`. Reuse the bubble and composer primitives. Send opens `FeedbackSheet/WritingCorrect|Incorrect`; Next appends the next pair and advances the stepper (`// DD-06 default`).

### Others
- "Build `SRSReviewTemplate`: `SRSCard/Front|Back`, four `SRSGradeButton`s, keys 1-4 and Space. No swipe grading, no tutorial (DD-25, approved). Empty queue per DD-07."
- "Build `HomeDashboardTemplate`. `paywallEnabled = false` (DD-24, approved): omit `Banner/Promo`, the explainer rail and the Upgrade menu row."
- "Build the conversation score feedback: `ScoreChip` -> `FeedbackSheet/ConversationScoreFeedback`. Chip = overall score, sheet number = named sub-score (DD-05)."
- "Build `SettingsListTemplate`: `SettingsRow/Account` (read-only), grouped `Navigate|Toggle|Info` rows."

## 4. Validate before saying "done"

1. No raw colours/numbers in styles outside token definitions; every `// style-exception` is justified.
2. Every component and variant name exists in COMPONENTS / COMPONENT_VARIANTS.
3. The screen matches a template; slots are data-driven.
4. `FeedbackSheet` is the only verdict surface; Scenario uses `ConversationShell`.
5. States exist: default, pressed, focused, disabled, loading, empty/error where the template lists them.
6. Keyboard-only run-through; names match ACCESSIBILITY §2; contrast chosen per §8A.
7. Compact (~390) and regular (~788) render; nothing hard-coded to 788.
8. DD defaults are commented and listed in the PR.

## 5. Handling unresolved decisions
- A DD is either **APPROVED_V1** (implement as written; DD-22…26) or a **question with a safe default** (use it; centralise it; comment `// DD-XX default`; list it). Neither is a fact about the original app.
- If the user decides, move the DD to Part A with the date before coding.
- Never invent a visual and call it canonical; never tag a guessed token `VERIFIED`.
- Missing component? Propose the entry in COMPONENTS / COMPONENT_VARIANTS in the same change.

## 6. The research archive
`references/gramago/` is closed, forensic, and not required. If a gap exists it is a **product decision** (DESIGN_DECISIONS), not research. Never copy pixels, text or assets from it. Only a human may authorise opening it.

## 7. Tips
- Small composable components; tokens are the single styling input.
- Copy is content: write our own strings.
- Counts (steps, chips, bullets) are props.
- Keep sheets/dialogs inset and rounded; never dock to edges.
- Lime is for fills only; text on lime is `textPrimary`.
