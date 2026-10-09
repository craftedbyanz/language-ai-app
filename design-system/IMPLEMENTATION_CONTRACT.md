# Implementation Contract

Hard rules for every coding agent and contributor. Violating a rule is a defect, not a style choice.

## 1. Source of truth
1. **`design-system/` is the UI/UX source of truth.** If the code and this folder disagree, one of them is wrong and it must be reconciled in this folder first.
2. `references/gramago/` is archived evidence. It is **not required for routine implementation** and you must not read its screenshots or accessibility files to decide how something looks. Only a human may authorise opening it, for a DD item that explicitly says evidence exists there.

0. **Precedence when files disagree**: `TOKENS.json` (values) > `COMPONENT_VARIANTS.md` (names, variants) > `COMPONENTS.md` (anatomy, behaviour) > `SCREEN_TEMPLATES.md` (composition) > `INTERACTION_PATTERNS.md` > `PATTERNS.md` / `FOUNDATIONS.md` (rationale). `UI_MAPPING.md` and `QA_REPORT.md` never override anything. A contradiction you find is a defect: fix it in `design-system/` in the same change, do not pick silently.

## 2. Tokens
3. **Use semantic tokens.** **Never invent a colour** when a semantic token exists. Never write a raw hex, `rgb()`, or named colour in component code. Reference `TOKENS.json` paths (generate theme variables from the file; do not hand-copy values).
4. **Never hard-code spacing, radius, type size, shadow, icon size or control height.** Use `space.*`, `radius.*`, `typography.*`, `shadow.*`, `icon.*`, `control.*`, `layout.*`.
5. **No duplicated spacing literals.** The scale is 4/8/12/16/24/32; in-between values are not allowed.
5a. **Arbitrary styles require justification.** A literal that is not a token (a one-off size, colour, shadow, z-index, timing) is allowed only with a comment `// style-exception: <reason>` and a line in the PR description. If it recurs twice, add a token instead.
5b. **Colour profile (DD-22, APPROVED_V1).** Default = `production`: use `accessible.*` wherever a colour carries text, an icon, an outline or a state indicator (ACCESSIBILITY §8A). Raw `color.*`/`feedback.*`/`score.*`/`grade.*` fidelity tokens are for decorative fills, dots, bars and previews. `fidelity` is an explicit product-owner opt-in via `meta.colorProfile.fidelityOverrides`; never enable it yourself, never delete or edit a fidelity token.
5c. **Answer-card colours come only from `answerPalette.<key>.background` + `.foreground` of the same key** (DD-26). Never guess, compute or override the foreground.
6. Tokens whose confidence is `CANDIDATE` or `ESTIMATED` may be used but must be centralised (one definition) so they can change in one place. Never fork them per component.
7. Do not mark a token `VERIFIED` without an active-window, canonical-viewport measurement. Do not promote a value from inactive-window, alternate-viewport or unmeasured evidence.

## 3. Components
8. **Reusable variants beat duplicate components.** Build components with variants, never screen-specific duplicates. If a screen needs something that does not exist, add the component or variant to `COMPONENTS.md` / `COMPONENT_VARIANTS.md` *before* using it.
9. **All AI verdicts use `FeedbackSheet`.** Do not build a separate verdict UI per mode.
10. **Scenario is `ConversationShell/Scenario`.** Do not build a separate scenario screen family.
11. Use exact names from `COMPONENT_VARIANTS.md` (`Component/Variant`). Do not rename.
12. Components accept data-driven counts/lists (steps, hints, topics); do not bake in the numbers seen in research.
13. Every interactive component implements the states in its entry and the accessibility expectations in `ACCESSIBILITY.md`.

## 4. Screens
14. **Templates determine page composition.** Compose screens from **SCREEN_TEMPLATES.md**. A new screen is a new template entry or an existing template with different slots.
15. **Do not copy screenshot coordinates** or any absolute size. Derive from `layout.*` tokens and `RESPONSIVE_RULES.md`.
16. Do not encode lesson-specific content in templates or components. Content arrives through slots and props.

## 5. Unresolved decisions
17. **Unresolved design decisions must not be silently invented.** Anything in `DESIGN_DECISIONS.md` Part B is a decision, not a fact. Use the listed default (it is always sufficient to build) and say so; do not improvise a different one.
18. If you implement a DD **default** (not an `APPROVED_V1` decision), add a comment `// DD-XX default` at the point of use, and list it in the PR description.
19. Never implement a completion screen, error design, score threshold or game state other than the documented default (`CompletionTemplate`, `InlineError`, `score.thresholds`, DD-16) without a recorded decision and a matching template/variant entry.
19a. **Optional/deferred features are not built unless asked**: paywall (`paywallEnabled = false`, not in default navigation, DD-24; `BenefitRow`/`PlanCard` deferred), SRS swipe grading and tutorial (DD-25; grade buttons are canonical; swipe may come later only as a progressive enhancement), dark mode (DD-09), explainer tiles rail.
19b. **APPROVED_V1 decisions (DD-22…DD-26) are decisions, not defaults**: implement as written; do not add `DD-XX default` comments for them.

## 6. Changes
20. **Visual changes must first update the design system** (tokens → component/variant → template → code). A PR that changes visuals without touching `design-system/` is rejected, unless it only fixes a deviation from it.
21. Record why in `DESIGN_DECISIONS.md` (new row in Part A, or resolve a DD with date and rationale).
22. Keep `TOKENS.json`, `COMPONENTS.md`, `COMPONENT_VARIANTS.md` and `UI_MAPPING.md` consistent in one commit.

## 7. Accessibility is part of done
23. Each screen meets `ACCESSIBILITY.md` §1–§10: roles, names, focus, announcements, contrast, targets, non-gesture alternatives.
24. Verdict, diff and score state are never communicated by colour alone.

## 8. Scope limits
25. No purchase, subscription, account, profile or destructive-data flows are specified here. Do not build them from this folder.
26. No name, copy, logo, illustration or asset of the reference application may appear in code or UI. The design system is product-independent; copy is written for our product.
27. Do not install a UI kit that overrides these tokens.

## 9. Definition of done for a UI change
- [ ] Only semantic tokens are used (search the diff for `#` colours and bare numbers in styles).
- [ ] Components and variants match `COMPONENT_VARIANTS.md` names.
- [ ] The screen matches a template; deviations documented.
- [ ] States covered: default, pressed, focused, disabled, loading, empty (where applicable).
- [ ] DD defaults commented.
- [ ] Keyboard and screen-reader pass.
- [ ] Compact and regular layouts checked.
- [ ] Text/outline/indicator colours chosen from ACCESSIBILITY §8A; any `// style-exception` listed in the PR.
