# ADR-0001: Architecture style

Status: Accepted

## Context

The repository needs clear ownership across four Flutter client targets without empty layers or duplicated backend rules.

## Decision

Use feature-first MVVM/UDF with pragmatic adapters and selective pure-Dart domain modeling. Add application/use-case layers only for meaningful orchestration.

## Consequences

Simple features stay small. Complex capabilities gain repository contracts and tests at the appropriate boundary. Automated dependency checks support code review.
