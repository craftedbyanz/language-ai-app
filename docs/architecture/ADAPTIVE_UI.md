# Adaptive UI

DD-12 defaults apply. `WindowSizeClass` derives from the available layout width: compact below `layout.breakpointCompact`, regular through `layout.breakpointWide` inclusive, wide above it. The canonical names are compact/regular/wide. There is no device-type branching.

`AdaptiveLayout` uses LayoutBuilder, falling back to MediaQuery only for an unbounded width. `ContentConstraints` adds canonical screen margins outside a centered `contentMaxWidth` column. `AppScaffold` supplies SafeArea and a reading-order focus traversal group. The foundation page scrolls at short heights and scales text naturally.

`AdaptiveNavigation` is a composition slot: app-owned chrome receives the size class and child, so route semantics remain unchanged. There is no bottom bar or rail in v1. Future chrome must follow canonical navigation rules; wide windows do not by themselves authorize a new rail design.

Fold and hinge posture are platform capabilities, not design-system plugin dependencies. Android adapters may translate `MediaQuery.displayFeatures`; a future iOS adapter may evaluate a dedicated foldable plugin. Components consume available regions and constraints only, keeping web, macOS and ordinary phones on the same adaptive path.

Future interactive components must expose semantics, token-sized hit areas, hover, visible offset focus rings, Enter/Space activation and Tab order. Overlay owners must implement Escape and focus restoration. v1 primitives are noninteractive; no custom control behavior is claimed. Widget tests cover breakpoint edges, embedded containers, window resizing and large text.
