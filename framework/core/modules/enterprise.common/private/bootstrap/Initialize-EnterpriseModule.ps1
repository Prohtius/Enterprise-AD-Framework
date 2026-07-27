<#
.SYNOPSIS
    Initializes the Enterprise module bootstrap process.

.DESCRIPTION
    Resolves framework paths, creates the bootstrap context,
    imports module components, and returns the list of
    exported public functions.
#>

function Initialize-EnterpriseModule {
    [CmdletBinding()]
    [OutputType([string[]])]
    param()

    #
    # Resolve framework paths
    #

    $ModuleRoot = Resolve-EnterpriseModuleRoot
    $RepositoryRoot = Resolve-EnterpriseRepositoryRoot -Path $ModuleRoot

    #
    # Build bootstrap context
    #

    $Context = [EnterpriseBootstrapContext]::new()

    $Context.ModuleRoot = $ModuleRoot
    $Context.RepositoryRoot = $RepositoryRoot
    $Context.ModuleName = Split-Path -Leaf $ModuleRoot

    $script:EnterpriseBootstrapContext = $Context

    #
    # Import module components
    #

    $ClassesPath = Join-Path $ModuleRoot 'Classes'
    $PublicPath = Join-Path $ModuleRoot 'Public'

    if (-not (Test-Path -Path $ClassesPath -PathType Container)) {
        throw "Classes folder not found: $ClassesPath"
    }

    if (-not (Test-Path -Path $PublicPath -PathType Container)) {
        throw "Public folder not found: $PublicPath"
    }

    Import-ModuleClasses -Path $ClassesPath
    Import-ModuleFolder -Path $PublicPath

    #
    # Discover exported functions
    #

    Get-EnterprisePublicFunctionList -Path $PublicPath
}