@AGENTS.md

# Claude Code Instructions

## Working Style

Before editing:

1. Understand the requested outcome.
2. Inspect the relevant existing code and documentation.
3. Identify the architectural boundary affected.
4. Prefer the smallest coherent change.

For substantial architecture or multi-file changes:
- plan first,
- state assumptions,
- identify files expected to change,
- then execute after the direction is clear.

Do not wander into unrelated cleanup.

## Project State

The UI/UX research phase is frozen.

Canonical UI/UX source:

`design-system/`

Frozen forensic evidence:

`references/gramago/`

Do not inspect `references/gramago/` during ordinary implementation.

The application architecture is intentionally:

Feature-first
+ MVVM/UDF
+ pragmatic Hexagonal boundaries
+ selective DDD

Do not convert it into ceremonial Clean Architecture.

## Architecture Documentation

When present, architecture decisions under:

`docs/architecture/`
`docs/adr/`

are authoritative for implementation architecture.

If code and an ADR disagree:
stop and report the conflict rather than silently choosing one.

## Flutter Development

Use the repository's pinned Flutter/Dart versions and existing dependencies.

Do not upgrade Flutter or packages as a side effect of unrelated work.

Prefer modern Dart language features:
- sealed classes
- patterns
- records where semantically useful
- exhaustive switches
- immutable state

Do not add code generation purely to avoid a small amount of handwritten code.

## Design-System Work

When touching UI:

read the relevant canonical files in `design-system/` first.

Implement canonical tokens/components/templates rather than reproducing
screens independently.

Do not modify canonical design decisions merely to make implementation easier.

If the specification is genuinely ambiguous:
report the ambiguity and propose a decision instead of silently inventing one.

## Verification

Always close the feedback loop when tooling permits.

At minimum after Dart/Flutter changes, run the relevant subset of:

- formatting
- static analysis
- architecture tests
- unit/widget tests
- token validation

For broad foundation changes, run the complete project validation suite.

Fix problems caused by your changes before declaring the task complete.

## Generated Code

Never manually edit generated files.

Change the source specification/generator and regenerate instead.

## Git

The user controls commits.

Never commit or push unless explicitly requested.

Preserve pre-existing staged changes.

## Final Report

For substantial tasks, finish with:

- what changed
- architectural decisions applied
- files/modules affected
- validation performed
- unresolved issues
- recommended next step
