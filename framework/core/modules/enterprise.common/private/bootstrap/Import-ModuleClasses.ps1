<#
.SYNOPSIS
    Imports all PowerShell class scripts from a module.

.DESCRIPTION
    Dot-sources each class script in alphabetical order to ensure
    deterministic class loading before public functions are imported.
#>

function Import-ModuleClasses {
    [CmdletBinding()]
    [OutputType([void])]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Path
    )

    if (-not (Test-Path -Path $Path -PathType Container)) {
        throw "Classes folder not found: $Path"
    }

    $Files = Get-ChildItem -Path $Path -Filter '*.ps1' -File |
    Sort-Object Name

    Write-Host "Importing classes from: $Path"
    $Files | ForEach-Object { Write-Host "  $($_.FullName)" }

    foreach ($File in $Files) {
        try {
            . $File.FullName
        }
        catch {
            throw "Failed to import class script '$($File.FullName)': $($_.Exception.Message)"
        }
    }
}