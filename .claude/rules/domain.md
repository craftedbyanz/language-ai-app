---
paths:
  - "lib/features/**/domain/**/*.dart"
---

# Domain Rules

- Domain code must be pure Dart.
- Never import Flutter, Riverpod, Dio, generated API code, or platform plugins.
- Prefer immutable entities and value objects.
- Keep business invariants close to the domain type that owns them.
- Repository definitions here are ports/contracts only.
- Do not create use cases for simple pass-through repository calls.
