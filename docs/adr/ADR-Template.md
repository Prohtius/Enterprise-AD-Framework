# ADR-0004 - Repository Discovery

## Status

Accepted

## Date

2026-07-27

## Context

The framework requires a reliable method of locating the repository root without relying on hardcoded relative paths.

## Decision

The repository root shall be determined during module initialization by walking upward from the module root until a `.git` directory is located.

The discovered repository root is stored in the `EnterpriseBootstrapContext` and reused throughout the lifetime of the module.

## Consequences

### Positive

- Independent of repository depth.
- Works after folder reorganizations.
- Repository root is resolved only once.
- Path services are faster because they use cached data.

### Negative

- Requires execution from within a Git working tree during development.
- Additional bootstrap logic.