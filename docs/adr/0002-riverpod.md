# ADR-0002: Riverpod

Status: Accepted

## Context

The engineering contract requires one lifecycle-aware state and DI mechanism.

## Decision

Use Riverpod with a root ProviderScope, injectable contracts and managed router disposal. Prefer Notifier/AsyncNotifier for future shared state. Disable automatic retry at the root.

## Consequences

No service locator or extra generator is needed. Safe reads opt into retry; mutations require explicit intent. Local ephemeral widget state remains local.
