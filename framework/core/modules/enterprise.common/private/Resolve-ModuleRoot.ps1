function Resolve-ModuleRoot {
    [CmdletBinding()]
    param()

    Set-StrictMode -Version Latest

    return $PSScriptRoot | Split-Path -Parent
}