---
paths:
  - "lib/features/**/presentation/**/*.dart"
---

# Presentation Rules

- Views render immutable state and dispatch user intent.
- Business/data logic belongs outside widgets.
- Use Riverpod ViewModels/controllers for non-trivial screen behavior.
- Prefer sealed UI workflow states over combinations of booleans.
- Feature UI must consume the canonical design-system implementation.
- Do not import generated API clients.
