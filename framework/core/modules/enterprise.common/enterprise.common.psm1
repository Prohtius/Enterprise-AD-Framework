<#
    Enterprise.Common
    Module entry point.

    Responsibilities:
      - Determine the module root.
      - Load the bootstrap subsystem.
      - Initialize the module.
      - Export public functions.
#>

# Resolve module root
$ModuleRoot = Split-Path -Parent $PSCommandPath

# Import bootstrap helpers
. "$ModuleRoot\Private\Bootstrap\Import-Bootstrap.ps1"

$PublicFunctions = Initialize-EnterpriseModule

Export-ModuleMember -Function $PublicFunctions