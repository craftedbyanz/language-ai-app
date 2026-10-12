# UI Contract: Grammar Fidelity Alignment

## Home mode entry

`ModeCard` exposes category, title, decorative index, description, and action in that visual order while acting as one coherent accessible target. Pointer hover, focus, Enter, and Space resolve to the same callback.

## Topic browsing

The Grammar Topic Picker exposes the existing two-tone hero and horizontal filter rail, followed by localized topic-section context and accurate visible count. Topic cards expose a meaningful icon slot, title, and lesson/exercise count, and adapt their column count to available width.

## Lesson collection

A reusable centered collection header accepts collection label, title, description, and optional level. `LessonCard` accepts index, title, description, action, and optional decorative illustration. The carousel reveals adjacent content, supports directional/direct movement, and exposes localized `current/total` semantics.

## Exercise workspace

`ExerciseTemplate` supports a Grammar balanced-workspace variant. On regular/tall layouts, prompt and answer are the dominant stacked surfaces; on constrained height they use one scrollable reading order. Grammar prompt and editable response are centered. Hints and Submit always follow the surfaces and remain reachable.

## Correction feedback

The design system accepts ordered correction segments classified as retained, removed, or inserted. Retained text is neutral, removed text uses strike-through plus a semantic label, and inserted text uses underline/emphasis plus a semantic label. The renderer does not compute grading state.

## Feedback overlay

Correct compact and incorrect detailed feedback may select different canonical vertical anchors. Both retain canonical width/height constraints, no full-screen scrim, scrolling when necessary, Escape dismissal, minimize/reopen state preservation, and focus restoration.

## Compatibility

All new shared APIs provide defaults matching existing consumers. Writing behavior remains unchanged unless it explicitly opts into a new variant. No feature imports another feature's internals.
