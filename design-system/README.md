# Design System

The canonical, implementation-ready UI/UX specification for our language-learning product.

| Folder | Role |
|---|---|
| `references/gramago/` | **Archived evidence.** Forensic research (screenshots, accessibility trees, measurements). Frozen on 2026-10-09. Read-only; no further research is required for the initial implementation. |
| `design-system/` (this folder) | **Canonical UI/UX source of truth.** Product-independent. Future product development depends on this folder only. |

Freeze record: `references/gramago/UI_UX_FREEZE.md` (READY_FOR_UI_UX_FREEZE; 62 evidenced states; S001–S064, S038 unused).

The live GramaGo app was interacted with on 2026-10-12 at the user's request to verify the Writing flow and loading states. The resulting decisions are recorded in `INTERACTION_PATTERNS.md` and `SCREEN_TEMPLATES.md`; implementation still takes this design system as its source of truth. The frozen archive remains unchanged.

## Files

| File | Purpose |
|---|---|
| [FOUNDATIONS.md](FOUNDATIONS.md) | Visual language, density, hierarchy, surfaces, navigation, feedback philosophy |
| [TOKENS.json](TOKENS.json) | Semantic design tokens with confidence and evidence |
| [COMPONENTS.md](COMPONENTS.md) | Component families: anatomy, states, dimensions, accessibility |
| [COMPONENT_VARIANTS.md](COMPONENT_VARIANTS.md) | Canonical `Component/Variant` names and differences |
| [SCREEN_TEMPLATES.md](SCREEN_TEMPLATES.md) | 14 page archetypes with regions and slots |
| [INTERACTION_PATTERNS.md](INTERACTION_PATTERNS.md) | Flows: exercise, conversation, scenario, SRS, exit, overlays, loading, errors |
| [PATTERNS.md](PATTERNS.md) | Recurring visual compositions |
| [RESPONSIVE_RULES.md](RESPONSIVE_RULES.md) | Layout rules from the 788×1083 reference |
| [ACCESSIBILITY.md](ACCESSIBILITY.md) | Roles, names, focus, announcements, contrast |
| [UI_MAPPING.md](UI_MAPPING.md) | Traceability from research states to components (not needed for building) |
| [IMPLEMENTATION_CONTRACT.md](IMPLEMENTATION_CONTRACT.md) | Hard rules for coding agents |
| [DESIGN_DECISIONS.md](DESIGN_DECISIONS.md) | Verified rules vs. open decisions (DD-01…DD-26) |
| [VIBE_CODE_GUIDE.md](VIBE_CODE_GUIDE.md) | Reading order and prompts for coding agents |
| [QA_REPORT.md](QA_REPORT.md) | Final implementation-readiness QA (verdict, simulation, gaps) |

## How to use

1. Read [VIBE_CODE_GUIDE.md](VIBE_CODE_GUIDE.md) (2 minutes). You do **not** need every file for a task.
2. Pick a template, then components and variants; use tokens only (prefer `accessible.*` for text).
3. For anything unresolved, check [DESIGN_DECISIONS.md](DESIGN_DECISIONS.md).
4. If you need a visual change, update the design system first.

## Confidence

Tokens carry `VERIFIED | SUPPORTED | CANDIDATE | ESTIMATED`. Colours and radii are the strongest areas; absolute type sizes, shadows, breakpoints and motion are ESTIMATED defaults chosen by this design system. Typography family, dark mode, motion, error states, lesson completion and several mode-specific details are intentionally open (see DESIGN_DECISIONS).

## Out of scope
Purchases, subscriptions, accounts, destructive data flows, and any third-party branding or assets.
