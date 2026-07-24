$ModuleRoot = Split-Path -Parent $PSCommonPath

# Import bootstrap helpers
. "$ModuleRoot\private\Import-ModuleFolder.ps1"
. "$ModuleRoot\private\Import-ModuleClasses.ps1"

# Import private functions
Import-ModuleFolder -Path (Join-Path $ModuleRoot 'private')

# Import Classes
Import-ModuleClasses -Path (Join-Path $moduleRoot 'classes')

# Import Public functions
Import-ModuleFolder -Path (Join-Path $ModuleRoot 'public')

# Export public functions
$PublicFunctions = Get-ChildItem `
    -Path (Jion-Path $moduleRoot 'public') `
    -Filter '*.ps1' `
    -File |
Select-Object -ExpandProperty BaseName

Export-ModuleMember -Function $PublicFunctions

<#
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
#>