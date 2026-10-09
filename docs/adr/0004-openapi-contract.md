# ADR-0004: OpenAPI contract boundary

Status: Accepted

## Context

The backend is maintained separately and no real contract is available to this task.

## Decision

Reserve lib/generated/api for generated output. Place services/adapters behind repositories; prevent direct presentation imports. Add no schema, transport or generator yet.

## Consequences

Integration requires a real contract and regeneration workflow. Backend grading/scoring rules stay server-owned. Result/AppFailure supplies a minimal client outcome boundary.
