function Get-EnterprisePublicFunctionList {
    [CmdletBinding()]
    [OutputType([string[]])]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$PublicFolder
    )

    begin {
    }

    process {

        if (-not (Test-Path -Path $PublicFolder)) {
            throw "Public folder not found: $PublicFolder"
        }

        $FunctionNames = Get-ChildItem `
            -Path $PublicFolder `
            -Filter '*.ps1' `
            -File |
        Sort-Object Name |
        Select-Object -ExpandProperty BaseName

        if (-not $FunctionNames) {
            throw "No public functions were found in '$PublicFolder'."
        }

        $Duplicates = $FunctionNames |
        Group-Object |
        Where-Object Count -gt 1

        if ($Duplicates) {

            $Names = $Duplicates.Name -join ', '

            throw "Duplicate public function names detected: $Names"
        }

        return $FunctionNames

    }

    end {
    }
}