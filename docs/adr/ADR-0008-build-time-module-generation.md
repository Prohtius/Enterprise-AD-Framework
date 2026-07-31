# ADR-0005

## Title

Build-Time PowerShell Module Generation

## Status

Accepted

## Context

PowerShell classes must exist in a module before the parser compiles the module.

Loading class definitions dynamically during module initialization is unreliable and
creates parser ordering issues.

The Enterprise AD Framework requires:

- deterministic builds
- one source of truth
- compatibility with Windows PowerShell 5.1 and PowerShell 7+

## Decision

Module source code shall be separated from generated module artifacts.

Classes remain in the Classes directory.

During build, class definitions are concatenated ahead of the module bootstrap
template to produce the final .psm1.

Developers never edit generated files.

## Consequences

Pros

- Single source of truth
- Deterministic builds
- CI friendly
- No runtime class loading

Cons

- Build step required
- Generated artifacts must not be edited manually
