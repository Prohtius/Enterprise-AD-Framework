function Resolve-EnterpriseModuleRoot {
    [CmdletBinding()]
    [OutputType([string])]
    param()

    $BootstrapRoot = Split-Path -Parent $PSScriptRoot
    $ModuleRoot = Split-Path -Parent $BootstrapRoot

    $ModuleRoot
}