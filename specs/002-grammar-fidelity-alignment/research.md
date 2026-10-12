# Research: Grammar Fidelity Alignment

## Decisions

### Authorized evidence is verification-only

Use S001, S008, S009, S058, S059, S060, and S061 from `references/gramago/` as read-only evidence for hierarchy, proportions, and interaction behavior. Do not copy brand assets, proprietary illustrations, names, or lesson copy. Reconcile accepted observations into `design-system/` before relying on them in feature code.

### Preserve the product learning model

The reference exercise is translation-oriented, while this product's approved vertical slice is English sentence correction. Preserve the latter: an intentionally incorrect source sentence, an instruction, acceptable authored answers, hints, explanation, and tips. Fidelity applies to the workspace and feedback interaction, not third-party curriculum content.

### Extend shared components instead of forking them

Evolve shared components through backward-compatible parameters or explicit variants. Grammar screens compose those APIs; they do not reproduce private versions. Writing defaults must remain unchanged.

### Use truthful dense progress

Populate the primary demonstration lesson with 20 authored sentence-correction exercises so its dense stepper mirrors the approved Grammar treatment without fabricating progress. Other lessons remain data-driven.

### Use a height-aware exercise workspace

At a regular/tall viewport, allocate the dominant available height between prompt and answer surfaces and center reading content. At short heights or large text, fall back to a single scrollable logical order with hints and Submit reachable.

### Compute correction differences in Grammar presentation

Tokenize learner and expected sentences into words and punctuation, then use a deterministic longest-common-subsequence mapping to classify retained, removed, and inserted segments. Keep this presentation model outside the pure domain entity and pass neutral segments to the shared design-system renderer.

### Make feedback placement variant-aware

Keep the established overlay/no-scrim behavior, canonical max width, focus, and minimize/reopen lifecycle. Allow compact correct feedback and detailed incorrect feedback to use distinct canonical anchors while remaining height-constrained and scrollable.

### Treat the Home golden change as intentional

Changing shared `ModeCard` anatomy can affect Home baselines. Review and update that baseline explicitly; non-Home Writing behavior and visual defaults remain regression gates.

## Alternatives rejected

- Screenshot tracing or bitmap-backed UI: inaccessible, non-adaptive, and not maintainable.
- Showing 20 progress segments over two exercises: visually close but semantically false.
- Adding a diff package: unnecessary for short authored sentences and adds maintenance cost.
- Copying the reference translation task or assets: conflicts with product scope and ownership.
- Building Grammar-only card/sheet forks: creates drift from the canonical design system.
