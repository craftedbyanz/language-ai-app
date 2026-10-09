---
paths:
  - "test/**/*.dart"
  - "integration_test/**/*.dart"
---

# Testing Rules

- Prefer fakes over deep mocking when practical.
- Test behavior and contracts, not implementation trivia.
- Repository and ViewModel tests must not require real network access.
- Widget tests must use canonical app providers/themes.
- Golden tests are primarily for reusable design-system components and
  critical templates, not every content permutation.
