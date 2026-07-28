<#
.SYNOPSIS
    Imports all PowerShell scripts from a module folder.

.DESCRIPTION
    Dot-sources each .ps1 file in alphabetical order to ensure
    deterministic module initialization.
#>

function Import-ModuleFolder {
    [CmdletBinding()]
    [OutputType([void])]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Path
    )

    if (-not (Test-Path -Path $Path -PathType Container)) {
        throw "Module folder not found: $Path"
    }

    $Files = Get-ChildItem -Path $Path -Filter '*.ps1' -File |
        Sort-Object Name

    foreach ($File in $Files) {
        try {
            . $File.FullName
        }
        catch 
        {
            $Message = "Failed to import module script '$($File.FullName)'."

            throw [System.InvalidOperationException]::new($Message, $_.Exception)
        }
    }
}