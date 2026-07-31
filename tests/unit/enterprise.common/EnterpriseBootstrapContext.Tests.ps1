#Requires -Modules Pester

using module ../../../framework/core/modules/enterprise.common/enterprise.common.psd1

BeforeAll {

    $ModuleRoot = (Resolve-Path (
            Join-Path $PSScriptRoot '..\..\..\Framework\Core\Modules\Enterprise.Common'
        )).ProviderPath

    Import-Module $ModuleRoot -Force
}

Describe 'EnterpriseBootstrapContext' -Tag 'Unit', 'Enterprise.Common' {

    Context 'Construction' {

        It 'Creates a new EnterpriseBootstrapContext instance' {

            $Context = [EnterpriseBootstrapContext]::new()

            $Context | Should -Not -BeNullOrEmpty
            $Context.GetType().Name | Should -Be 'EnterpriseBootstrapContext'
        }
    }

    Context 'Module Information' {

        It 'Stores module metadata' {

            $Context = [EnterpriseBootstrapContext]::new()

            $Context.ModuleName = 'Enterprise.Common'
            $Context.ModuleVersion = [version]'1.0.0'

            $Context.ModuleName | Should -Be 'Enterprise.Common'
            $Context.ModuleVersion | Should -Be ([version]'1.0.0')
        }
    }

    Context 'Framework Paths' {

        It 'Stores framework paths' {

            $Context = [EnterpriseBootstrapContext]::new()

            $Context.ModuleRoot = 'C:\Framework\Modules\Enterprise.Common'
            $Context.RepositoryRoot = 'C:\Framework'
            $Context.RepositoryName = 'Enterprise-AD-Framework'
            $Context.RuntimePath = 'C:\Framework\Runtime'
            $Context.BuildPath = 'C:\Framework\Build'
            $Context.DocsPath = 'C:\Framework\Docs'

            $Context.ModuleRoot     | Should -Be 'C:\Framework\Modules\Enterprise.Common'
            $Context.RepositoryRoot | Should -Be 'C:\Framework'
            $Context.RepositoryName | Should -Be 'Enterprise-AD-Framework'
            $Context.RuntimePath    | Should -Be 'C:\Framework\Runtime'
            $Context.BuildPath      | Should -Be 'C:\Framework\Build'
            $Context.DocsPath       | Should -Be 'C:\Framework\Docs'
        }
    }

    Context 'Framework Information' {

        It 'Stores framework version' {

            $Context = [EnterpriseBootstrapContext]::new()

            $Context.FrameworkVersion = [version]'1.0.0'

            $Context.FrameworkVersion | Should -Be ([version]'1.0.0')
        }
    }

    Context 'PowerShell Environment' {

        It 'Stores PowerShell information' {

            $Context = [EnterpriseBootstrapContext]::new()

            $Context.PowerShellVersion = $PSVersionTable.PSVersion
            $Context.PowerShellEdition = $PSVersionTable.PSEdition

            $Context.PowerShellVersion | Should -Be $PSVersionTable.PSVersion
            $Context.PowerShellEdition | Should -Be $PSVersionTable.PSEdition
        }
    }

    Context 'Execution Environment' {

        It 'Stores execution state' {

            $Context = [EnterpriseBootstrapContext]::new()

            $Context.IsAdministrator = $true
            $Context.IsCI = $false

            $Context.IsAdministrator | Should -BeTrue
            $Context.IsCI            | Should -BeFalse
        }
    }

    Context 'Property Types' {

        It 'Uses strongly typed version properties' {

            $Context = [EnterpriseBootstrapContext]::new()

            $Context.ModuleVersion = [version]'1.0.0'
            $Context.FrameworkVersion = [version]'2.0.0'
            $Context.PowerShellVersion = [version]'7.5.0'

            $Context.ModuleVersion     | Should -BeOfType ([version])
            $Context.FrameworkVersion  | Should -BeOfType ([version])
            $Context.PowerShellVersion | Should -BeOfType ([version])
        }
    }
}