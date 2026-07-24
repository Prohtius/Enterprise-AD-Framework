function GEt-EnterpriseRoot {
    <#
    .SYNOPSIS
    Returns the root directory of the Enterprise AD Framework repository.
    
    .DESCRIPTION
    Determines the repository root relative to the Enterprise.Common module.
    This avoids hardcoded paths throughout the framework.
    
    .EXAMPLE
    Get-EnterpriseRoot
    #>

    [CmdletBinding()]
    param()

    Set-StrictMode -Version Latest

    $moduleRoot = Resolve-ModuleRoot

    return (Resolve-Path (
        Join-Path $moduleRoot '..\..\..'
    )).Path
}