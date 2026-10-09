---
paths:
  - "lib/design_system/**/*.dart"
---

# Flutter Design System Rules

- `design-system/` is the canonical specification.
- This directory implements that specification in Flutter.
- Never import feature code.
- Use generated typed tokens.
- Do not introduce raw design values when a token exists.
- Build components as reusable families with explicit variants.
- Consider compact, medium, and expanded window classes.
- Support keyboard/focus/hover semantics where the component is interactive.
