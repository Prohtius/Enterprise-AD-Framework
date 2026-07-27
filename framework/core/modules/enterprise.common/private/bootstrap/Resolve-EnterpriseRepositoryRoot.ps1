function Resolve-EnterpriseRepositoryRoot {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    $Current = (Resolve-Path -Path $Path).ProviderPath

    while ($null -ne $Current) {

        if (Test-Path (Join-Path $Current '.git')) {
            return $Current
        }

        $Parent = Split-Path -Parent $Current

        if ($Parent -eq $Current) {
            break
        }

        $Current = $Parent
    }

    throw @"
Unable to locate the Enterprise Framework repository root.

Starting path:
$Path

Expected to find a '.git' directory while walking parent directories.
"@
}