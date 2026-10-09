# ADR-0005: Canonical design-system source

Status: Accepted

## Context

Canonical values and approved production/fidelity behavior already exist in design-system/TOKENS.json.

## Decision

Generate typed Flutter tokens at build time and implement theme/primitives from them. Production is default; fidelity is opt-in. Keep answer colors paired and use canonical responsive boundaries.

## Consequences

No runtime JSON or copied token tables. Generator freshness is checked in CI. Source confidence metadata stays in the canonical specification; server score thresholds are intentionally excluded from runtime constants.
