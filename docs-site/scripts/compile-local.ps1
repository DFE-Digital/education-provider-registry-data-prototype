param(
    [switch]$SkipBundleInstall
)

$ErrorActionPreference = "Stop"

$docsSiteRoot = Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")

function Invoke-Native {
    param(
        [Parameter(Mandatory = $true)]
        [scriptblock]$Command,
        [Parameter(Mandatory = $true)]
        [string]$Description
    )

    & $Command
    if ($LASTEXITCODE -ne 0) {
        throw "$Description failed with exit code $LASTEXITCODE."
    }
}

Push-Location $docsSiteRoot
try {
    & (Join-Path $PSScriptRoot "copy-documentation-pages.ps1")

    Invoke-Native -Description "Bundler configuration" -Command { bundle config set path vendor/bundle }

    if (-not $SkipBundleInstall) {
        Invoke-Native -Description "Bundler install" -Command { bundle install }
    }

    Invoke-Native -Description "Nanoc compile" -Command { bundle exec nanoc compile }
}
finally {
    Pop-Location
}
