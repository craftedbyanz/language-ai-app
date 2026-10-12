# Implementation Plan: Grammar Fidelity Alignment

**Branch**: `002-grammar-fidelity-alignment` | **Date**: 2026-10-11 | **Spec**: [spec.md](./spec.md)

## Summary

Reconcile the canonical design system and the existing Home-to-Grammar vertical slice with the seven authorized frozen reference states. The implementation keeps the product's English sentence-correction model, branding, localization, adaptive behavior, typed routing, and repository boundary. Work is limited to shared design-system components, Grammar presentation/domain demo data, and focused tests; no backend, persistence, AI grading, or new dependency is introduced.

## Technical Context

**Language/Version**: Dart on Flutter stable 3.47.3 through FVM  
**Primary Dependencies**: Flutter, Riverpod, go_router typed routes; existing project dependencies only  
**Storage**: N/A; deterministic in-memory Grammar repository  
**Testing**: `flutter_test`, unit/widget/golden tests through `fvm flutter test`  
**Target Platform**: Android, iPhone, iPad, macOS  
**Project Type**: Adaptive Flutter mobile/desktop client  
**Performance Goals**: Responsive 60 fps interaction; no grading duplication; no avoidable rebuild-heavy diff computation  
**Constraints**: Offline deterministic demo, localized chrome, 200% text support, keyboard/touch/pointer parity, no raw design values, no new packages  
**Scale/Scope**: Home Grammar entry, three Grammar screens, two feedback variants, one 20-step demonstration lesson, shared component tests and relevant feature tests

## Constitution Check

*GATE: Passed before research and re-checked after design.*

- PASS — `design-system/` remains the product source of truth; authorized reference images are read-only verification evidence and accepted changes are reconciled into the design-system contract.
- PASS — Flutter 3.47.3 remains pinned and all commands use FVM.
- PASS — Feature-first boundaries remain intact: pure Dart domain entities, repository-owned data, presentation-only correction mapping, no generated API imports.
- PASS — Riverpod, typed go_router, and current dependency direction are preserved.
- PASS — No new package, backend contract, persistence mechanism, retry behavior, or unrelated product capability is introduced.
- PASS — Adaptive layout, localization, keyboard, semantics, focus restoration, and testability are explicit acceptance gates.
- PASS — Existing user-owned uncommitted changes are preserved and overlapping feedback-sheet work is reconciled rather than overwritten.

## Project Structure

### Documentation (this feature)

```text
specs/002-grammar-fidelity-alignment/
├── plan.md              # This file ($speckit-plan command output)
├── research.md          # Phase 0 output ($speckit-plan command)
├── data-model.md        # Phase 1 output ($speckit-plan command)
├── quickstart.md        # Phase 1 output ($speckit-plan command)
├── contracts/           # Phase 1 output ($speckit-plan command)
└── tasks.md             # Phase 2 output ($speckit-tasks command - NOT created by $speckit-plan)
```

### Source Code (repository root)
```text
design-system/
├── TOKENS.json
└── components/

lib/
├── design_system/
│   ├── components/
│   ├── patterns/exercise_template.dart
│   └── tokens/generated/design_tokens.dart
└── features/grammar/
    ├── data/repositories/in_memory_grammar_repository.dart
    ├── domain/entities/grammar_content.dart
    └── presentation/

test/
├── design_system/
└── features/grammar/
```

**Structure Decision**: Extend the established single Flutter application in place. Shared visual anatomy belongs in `lib/design_system/`; Grammar-specific content, correction mapping, and composition stay under `lib/features/grammar/`. No parallel UI framework or feature-level token source is created.

## Implementation Phases

1. Reconcile canonical component/token contracts and add focused component coverage.
2. Make the primary Grammar exercise a truthful dense 20-step lesson and align its workspace.
3. Align Home, Topic Picker, and Lesson List hierarchy with contextual metadata and optional owned illustrations.
4. Add word-level correction segments and contextual feedback presentation.
5. Validate adaptive, localization, semantics, feature flows, goldens, analysis, and visual landmarks.

## Complexity Tracking

No constitution violations require justification.
