<#
.SYNOPSIS
    Represents the bootstrap state for an Enterprise module.

.DESCRIPTION
    Stores module metadata, framework paths, and execution environment
    information established during module initialization.
#>

class EnterpriseBootstrapContext {

    #
    # Module Information
    #

    [string]  $ModuleName
    [version] $ModuleVersion

    #
    # Framework Paths
    #

    [string] $ModuleRoot
    [string] $RepositoryRoot
    [string] $RepositoryName
    [string] $RuntimePath
    [string] $BuildPath
    [string] $DocsPath

    #
    # Framework Information
    #

    [version] $FrameworkVersion

    #
    # PowerShell Environment
    #

    [version] $PowerShellVersion
    [string]  $PowerShellEdition

    #
    # Execution Environment
    #

    [bool] $IsAdministrator
    [bool] $IsCI

    EnterpriseBootstrapContext() {
    }
}