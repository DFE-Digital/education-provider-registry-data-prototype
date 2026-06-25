param(
    [string]$DocumentationPath = (Join-Path (Join-Path $PSScriptRoot "..\..") "documentation"),
    [string]$OutputRoot = (Join-Path (Join-Path $PSScriptRoot "..") "content")
)

$ErrorActionPreference = "Stop"

$resolvedDocumentationPath = Resolve-Path -LiteralPath $DocumentationPath
$resolvedOutputRoot = New-Item -ItemType Directory -Force -Path $OutputRoot

Get-ChildItem -LiteralPath $resolvedOutputRoot -Filter "*.md" -File | Remove-Item -Force

$markdownFiles = Get-ChildItem -LiteralPath $resolvedDocumentationPath -Filter "*.md" -File |
    Sort-Object Name

if ($markdownFiles.Count -eq 0) {
    Write-Warning "No markdown files found to copy in $resolvedDocumentationPath"
    return
}

foreach ($file in $markdownFiles) {
    $destinationName = $file.Name
    if ($file.Name -ieq "readme.md" -and -not (Test-Path -LiteralPath (Join-Path $resolvedDocumentationPath "index.md"))) {
        $destinationName = "index.md"
    }

    Copy-Item -LiteralPath $file.FullName -Destination (Join-Path $resolvedOutputRoot $destinationName) -Force
}

Write-Host "Copied $($markdownFiles.Count) documentation markdown file(s) from documentation/ to $resolvedOutputRoot"
