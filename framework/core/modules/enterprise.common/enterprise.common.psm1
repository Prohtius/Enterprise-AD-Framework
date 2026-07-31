<#
    Enterprise.Common
    Module entry point.

    Responsibilities:
      - Determine the module root.
      - Load the bootstrap subsystem.
      - Load PowerShell classes.
      - Initialize the module.
      - Export public functions.
#>

#
# Resolve module root
#

$ModuleRoot = Split-Path -Parent $PSCommandPath

#
# Import bootstrap subsystem
#

. "$ModuleRoot\Private\Bootstrap\Import-Bootstrap.ps1"

#
# Import PowerShell classes BEFORE module initialization.
# Classes must be available before Initialize-EnterpriseModule
# creates an EnterpriseBootstrapContext object.
#

Import-ModuleClasses -Path (Join-Path $ModuleRoot 'Classes')

#
# Initialize module
#

$PublicFunctions = Initialize-EnterpriseModule

#
# Export public functions
#

Export-ModuleMember -Function $PublicFunctions