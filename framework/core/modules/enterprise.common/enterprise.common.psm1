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
$PublicFunctions = Get-EnterprisePublicFunctionList -PublicFolder (Join-Path $moduleRoot 'public')    

Export-ModuleMember -Function $PublicFunctions