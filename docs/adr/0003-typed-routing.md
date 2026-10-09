# ADR-0003: Typed routing

Status: Accepted

## Context

Semantic navigation must survive changes to adaptive chrome without string construction across features.

## Decision

Use go_router with go_router_builder/build_runner. Define only FoundationRoute in v1, with a localized unknown-route fallback.

## Consequences

Generated helpers are committed and regenerated in CI. Future app-owned composition connects feature widgets to typed routes; the design system has no routing dependency.
