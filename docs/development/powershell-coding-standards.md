1. Purpose
   The Enterprise AD Framework follows consistent PowerShell engineering practices to produce readable, testable, reusable infrastructure automation. Every module should look and behave consistently regardless of its purpose.

2. Supported PowerShell Versions
   Minimum:
   Windows PowerShell 5.1

Supported:
PowerShell 7.x

Development:
PowerShell 7.x recommended

3. Repository Philosophy
   Some guiding principles:

Convention over configuration where practical.
Deterministic execution.
Data-driven configuration.
Idempotent operations where applicable.
Reusable modules over monolithic scripts.
Single responsibility per function.
Clear separation between framework and implementation.

4. Naming Standards

### Modules

Enterprise.Common
Enterprise.AD
Enterprise.Logging
Enterprise.Configuration

### Functions

Get-EnterpriseRoot
Resolve-EnterpriseRepositoryRoot
Import-ModuleFolder
Test-EnterprisePath
New-EnterpriseOU

5. Repository Layout
   Framework/
   Core/
   Modules/
   Enterprise.Common/

Sample-Environments/

Docs/

Tests/

Reports/

6. Function Standards

```powershell
Comment-based help

function Verb-Noun {

    [CmdletBinding()]
    [OutputType(...)]

    param()

    #
    # Resolve paths
    #

    ...

    #
    # Validate inputs
    #

    ...

    #
    # Perform work
    #

    ...

    #
    # Return results
    #
}
```

7. Comment-Based Help

```powershell
<#
.SYNOPSIS

.DESCRIPTION
#>
```

Public functions should also include:

.PARAMETER
.OUTPUTS
.EXAMPLE

8. Error Handling
   Guidelines:

Validate early.
Throw on unrecoverable errors.
Include the affected path or object name.
Don't silently return unless that's the documented behavior.
Prefer contextual errors over generic messages.

9. Path Handling
   Resolve paths once.

```powershell
$ModuleRoot = ...

$PublicPath = ...

$ClassesPath = ...
```

Don't repeatedly call Join-Path throughout the function.

Validate paths before using them.

10. File Organization
    Public/

Private/

Classes/

Bootstrap/

Utilities/

One public function per file.

Helper functions belong under Private.

Classes belong under Classes.

11. Public vs Private Functions
    Public functions are exported.

Private functions are never exported.

Public functions form the module's supported API.

Private functions may change without notice.

12. Logging
    Use Write-Verbose for diagnostics.
    Avoid Write-Host in framework code.
    Future logging will be centralized through Enterprise.Logging.

13. Testing
    Every public function should eventually have Pester tests.

Framework helpers should also have unit tests where practical.

Tests should be deterministic and not depend on production infrastructure.

14. Code Formatting
    Four-space indentation.
    Consistent brace placement.
    Blank lines between logical sections.
    Meaningful variable names.
    Avoid aliases (Where-Object instead of ?, ForEach-Object instead of %).
    Prefer full parameter names over abbreviations in framework code.

15. Pull Request Requirements
    Code follows repository standards.
    Comment-based help added.
    Uses approved verbs.
    Includes parameter validation.
    Includes error handling.
    Pester tests added or updated.
    Documentation updated if behavior changed.

16. Future Standards
    Standardized exception types.
    Structured logging.
    Telemetry.
    Performance benchmarks.
    Script signing.
    PowerShell Gallery packaging.

17. Framework Design Principles
    Single Responsibility — Each function should perform one well-defined task.
    Deterministic Behavior — Given the same inputs, produce the same results.
    Every file in a module's Public folder shall contain exactly one public function, and the filename must match the function name.
    Convention Over Configuration — Prefer clear directory and naming conventions over additional configuration.
    Explicit Validation — Validate inputs and fail early with actionable errors.
    Framework Before Features — Reusable infrastructure belongs in Enterprise.Common; AD-specific logic belongs in feature modules.
    Stable Public APIs — Public functions are versioned contracts. Private helpers can evolve more freely.
    Context objects should be cohesive. Each context class should have a single responsibility. EnterpriseBootstrapContext contains only framework initialization state. Feature-specific state belongs in separate context classes rather than expanding the bootstrap context indefinitely.
