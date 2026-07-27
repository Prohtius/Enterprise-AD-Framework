function Import-ModuleFolder {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Path
    )

    begin {}

    process {
        if (-not (Test-Path -Path $Path)) {
            return
        }

        $Files = Get-ChildItem -Path $PAth -Filter '*.ps1' -File | 
        Sort-Object Name

        foreach ($File in $Files) {
            . $File.FullName
        }
    }

    end {}
}