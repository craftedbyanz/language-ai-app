This repository reverse-engineers GramaGo as a black-box UI/UX reference.

Rules:

1. GramaGo is reference-only.
2. Never make purchases.
3. Never modify subscription/account/profile.
4. Never delete data.
5. Never perform destructive actions.
6. Before every interaction, inspect the current state.
7. Perform only one UI action at a time.
8. Capture the resulting state after every action.
9. Prefer accessibility targeting over coordinates.
10. Record all state transitions.
11. Separate:
   - OBSERVED
   - MEASURED
   - ESTIMATED
   - INFERRED
12. Never present inferred values as facts.
13. Avoid unnecessary Peekaboo calls.
14. Stop if an action is ambiguous.
15. Store research under references/gramago/.

Never trust assumed app state across turns or sessions.
Before capture, interaction, or state-specific documentation,
verify the current screen using Peekaboo.
A filename must describe the VERIFIED current state,
not the expected state.
