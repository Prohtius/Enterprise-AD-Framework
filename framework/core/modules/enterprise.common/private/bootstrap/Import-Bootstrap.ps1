<#
.SYNOPSIS
    Imports the Enterprise.Common bootstrap subsystem.

.DESCRIPTION
    Loads all bootstrap and utility helper scripts required before
    Initialize-EnterpriseModule can execute.

    This script intentionally does not import classes or public
    functions. Those responsibilities belong to
    Initialize-EnterpriseModule.

.NOTES
    This file defines the bootstrap loading order for all
    Enterprise.* modules.
#>

# Import bootstrap helper scripts

. "$ModuleRoot\Private\Bootstrap\Import-ModuleFolder.ps1"
. "$ModuleRoot\Private\Bootstrap\Import-ModuleClasses.ps1"
. "$ModuleRoot\Private\Bootstrap\Resolve-EnterpriseModuleRoot.ps1"
. "$ModuleRoot\Private\Bootstrap\Resolve-EnterpriseRepositoryRoot.ps1"
. "$ModuleRoot\Private\Bootstrap\Initialize-EnterpriseModule.ps1"

# Import utility helper scripts

. "$ModuleRoot\Private\Utilities\Get-EnterprisePublicFunctionList.ps1"