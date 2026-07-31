# ADR-0001: Use Static Class Loading Instead of Dynamic Import for PowerShell Classes

## Status

Accepted

## Date

2026-07-28

## Decision Makers

- Development Team
- Architecture Team

---

## Context

This project makes extensive use of PowerShell classes to model business objects, configuration objects, and operational entities.

Examples include:

- User
- Device
- Server
- Asset
- Configuration
- Report

PowerShell functions and variables are normally resolved at runtime through mechanisms such as:

```powershell
Import-Module MyModule
```

However, PowerShell classes behave differently from functions.

When PowerShell parses a script, it must already know the definitions of any classes referenced in the script. Class definitions are processed during script parsing rather than at runtime.

This means that the following pattern can fail:

```powershell
Import-Module MyModule

$user = [User]::
```

if the parser encounters the class reference before the class definition has been loaded.

PowerShell therefore treats classes differently than functions, cmdlets, variables, aliases, and other module exports.

---

## Problem

Dynamic module importing creates uncertainty around class availability.

Issues include:

1. Type-not-found exceptions.
2. Parser errors during script loading.
3. Loss of IntelliSense support.
4. Reduced static validation.
5. Dependency ordering challenges.
6. Inconsistent behavior across development environments.

Example failure:

```powershell
Import-Module MyModule

[Asset]::
```

Error:

```text
Unable to find type [Asset].
```

The failure occurs because PowerShell must resolve the type before runtime execution begins.

---

## Decision

Classes shall be loaded statically at parse time rather than dynamically at runtime.

Consumers of project classes must use:

```powershell
using module MyModule
```

or

```powershell
using module ./MyModule.psd1
```

instead of relying on:

```powershell
Import-Module MyModule
```

for class visibility.

Class definitions shall reside in dedicated files under:

```text
src/Classes/
```

and be loaded by the module during initialization.

---

## Example Structure

```text
src/
├── Classes/
│   ├── Asset.ps1
│   ├── User.ps1
│   └── Device.ps1
├── Public/
├── Private/
├── MyModule.psm1
└── MyModule.psd1
```

Example:

```powershell
class Asset {
    [string]$Name

    Asset([string]$Name) {
        $this.Name = $Name
    }
}
```

Consumer:

```powershell
using module MyModule

$asset = [Asset]::
```

---

## Alternatives Considered

### Alternative 1: Import-Module

```powershell
Import-Module MyModule
```

Advantages:

- Familiar PowerShell pattern.
- Works well for functions.

Disadvantages:

- Classes may not be available during parsing.
- IntelliSense support reduced.
- Type resolution errors occur.

Decision:

Rejected.

---

### Alternative 2: Dot-Sourcing Class Files

```powershell
. .\Classes\Asset.ps1
```

Advantages:

- Simple.

Disadvantages:

- Manual dependency management.
- Difficult to scale.
- Increased maintenance burden.

Decision:

Rejected.

---

### Alternative 3: Load Classes from Compiled .NET Assembly

```powershell
Add-Type -Path MyAssembly.dll
```

Advantages:

- Strong typing.
- High performance.

Disadvantages:

- Additional build complexity.
- Requires C# project and build pipeline.

Decision:

Not selected for current project needs.

---

## Consequences

### Positive

- Predictable type resolution.
- Improved IntelliSense support.
- Better editor validation.
- Stronger compile-time checks.
- Easier maintenance.
- Reduced runtime failures.

### Negative

- Scripts must use:

```powershell
using module
```

instead of relying solely on:

```powershell
Import-Module
```

- Module loading order becomes more explicit.

---

## Technical Rationale

Although PowerShell is interpreted, scripts are first parsed into an Abstract Syntax Tree (AST).

Class declarations are processed during parsing and type resolution occurs before statement execution.

Functions can be discovered and imported dynamically at runtime:

```powershell
Import-Module MyModule
Get-Thing
```

Classes cannot be resolved the same way because the parser requires the type definition while building the AST:

```powershell
[Thing]::
```

As a result, PowerShell class usage behaves similarly to compile-time type resolution in statically typed languages, even though the overall language remains interpreted.

---

## Implementation Standard

All future PowerShell projects shall:

1. Store class files separately under:

```text
src/Classes/
```

2. Load classes through the module root.

3. Require consumers to use:

```powershell
using module MyModule
```

4. Avoid direct dot-sourcing of classes in consumer scripts.

5. Avoid relying on runtime Import-Module for class visibility.

---

## References

Microsoft PowerShell language specification

PowerShell Class Documentation

PowerShell "using module" directive documentation

# Example Code

## MyModule.psm1

```powershell
# Load Classes First
. $PSScriptRoot\Classes\Asset.ps1
. $PSScriptRoot\Classes\User.ps1
. $PSScriptRoot\Classes\Device.ps1

# Load Private Functions
Get-ChildItem "$PSScriptRoot\Private\*.ps1" |
    ForEach-Object { . $_.FullName }

# Load Public Functions
Get-ChildItem "$PSScriptRoot\Public\*.ps1" |
    ForEach-Object { . $_.FullName }

Export-ModuleMember -Function *
```

## Consumer Script

```powershell
using module MyModule

$asset = [Asset]::
```
