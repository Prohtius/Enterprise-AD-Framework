Set-StrictMode -Version Latest

$ModuleRoot = $PSScriptRoot

# Load private function first
$privateFolder = Join-Path $ModuleRoot 'Private'

if (Test-Path $privateFolder) {
    Get-ChildItem -Path $privateFolder -Filter '*.ps1' |
    Sort-Object Name | 
    ForEach-Object {
        . $_.FullName
    }
}

# Load public functions
$publicFolder = Join-Path $ModuleRoot 'Public'

if (Test-Path $publicFolder) {
    Get-ChildItem -Path $publicFolder -Filter '*.ps1' |
    Sort-Object Name | 
    ForEach-Object {
        . $_.FullName
    }
}

# Export every public function automatically
Export-ModuleMember -Function (
    Get-ChildItem $publicFolder -Filter '*.ps1' | 
    Select-Object -ExpandProperty BaseName
)