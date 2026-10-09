# ADR-0006: No offline database yet

Status: Accepted

## Context

The foundation has no offline workflow or persistent product data requirement.

## Decision

Do not add a local database or storage SDK. Keep the reserved storage boundary documented until a real feature needs it.

## Consequences

No migration/schema burden now. Future persistence must justify platform support, data ownership, privacy and lifecycle behavior.
