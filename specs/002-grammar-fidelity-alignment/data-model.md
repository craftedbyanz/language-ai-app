# Data Model: Grammar Fidelity Alignment

## GrammarTopic

- `id`: required stable identity.
- `title`: required authored display title.
- `description`: required authored collection context.
- `level`: required authored level label.
- `lessonCount`: non-negative count matching the repository catalog.

The entity remains framework-free and immutable.

## GrammarLesson

- `id`, `topicId`, `level`, `title`, `description`: required authored fields.
- `illustrationKey`: optional product-owned illustration selector; absence preserves layout.
- `exercises`: non-empty ordered list.

The primary demonstration lesson contains exactly 20 authored exercises. UI progress derives from `exercises.length`.

## GrammarSentenceExercise

The existing pure-Dart entity remains an intentionally incorrect English source sentence with non-empty acceptable answers, hints, explanation, and tips.

## CorrectionSegment

A presentation-only immutable value passed to the design system:

- `text`: non-empty word or punctuation run.
- `kind`: exactly one of `retained`, `removed`, or `inserted`.

Order reconstructs a readable correction sequence. Removed and inserted content have non-color visual and semantic cues. Repeated words and punctuation resolve deterministically.

## VisualLandmark

A validation-only record containing authorized state id, landmark name, expected relationship, actual observation, result, and a required note for intentional divergence or failure.

## Relationships and invariants

- A topic owns an ordered set of lessons through the repository.
- A lesson belongs to exactly one topic and owns at least one exercise.
- Exercise progress is one-based in human-readable semantics and zero-based internally.
- Correction segments are derived from current learner text and the canonical accepted answer; they are never persisted.
- Product chrome is localized; authored learning data remains unchanged across chrome locale changes.
