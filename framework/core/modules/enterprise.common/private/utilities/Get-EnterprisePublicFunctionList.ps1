<#
.SYNOPSIS
    Returns the list of public functions exported by a module.

.DESCRIPTION
    Enumerates PowerShell scripts in the Public folder and derives
    exported function names from the filenames.
#>

function Get-EnterprisePublicFunctionList {
    [CmdletBinding()]
    [OutputType([string[]])]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$PublicFolder
    )

    if (-not (Test-Path -Path $PublicFolder -PathType Container)) {
        throw "Public folder not found: $PublicFolder"
    }

    $FunctionNames = Get-ChildItem `
        -Path $PublicFolder `
        -Filter '*.ps1' `
        -File |
    Sort-Object Name |
    Select-Object -ExpandProperty BaseName

    $Duplicates = $FunctionNames |
    Group-Object |
    Where-Object Count -gt 1

    if ($Duplicates) {
        $Names = $Duplicates.Name -join ', '

        throw "Duplicate public function names detected: $Names"
    }

    return @($FunctionNames)
}