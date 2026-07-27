function Initialize-EnterpriseModule {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$ModuleRoot
    )

    begin {
    }

    process {

        Import-ModuleFolder -Path (Join-Path $ModuleRoot 'private')

        Import-ModuleClasses -Path (Join-Path $ModuleRoot 'classes')

        Import-ModuleFolder -Path (Join-Path $ModuleRoot 'utilities')

        Import-ModuleFolder -Path (Join-Path $ModuleRoot 'public')        

        return Get-EnterprisePublicFunctionList `
            -PublicFolder (Join-Path $ModuleRoot 'public')

    }

    end {
    }
}