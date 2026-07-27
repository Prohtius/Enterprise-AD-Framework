class EnterpriseBootstrapContext {

    [string]$ModuleName
    [string]$ModuleRoot
    [string]$RepositoryRoot
    [string]$RuntimePath
    [string]$BuildPath
    [string]$DocsPath
    [version]$ModuleVersion
    [version]$FrameworkVersion
    [Version]$PowerShellVersion
    [string]$PowerShellEdition
    [bool]$IsAdministrator
    [bool]$IsCI    

    EnterpriseBootstrapContext() {

    }

}