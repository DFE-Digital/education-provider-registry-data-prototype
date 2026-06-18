param(
    [string]$TaxonomyPath = (Join-Path (Join-Path $PSScriptRoot "..") (Join-Path "models" "establishment-details-taxonomy-skos.ttl")),
    [string]$OutputRoot = (Join-Path (Join-Path (Join-Path $PSScriptRoot "..") "docs-site") (Join-Path "content" "taxonomy"))
)

$ErrorActionPreference = "Stop"

$resolvedTaxonomyPath = Resolve-Path -LiteralPath $TaxonomyPath
$resolvedOutputRoot = New-Item -ItemType Directory -Force -Path $OutputRoot
$ttl = Get-Content -LiteralPath $resolvedTaxonomyPath -Raw

function Get-PredicateText {
    param(
        [string]$Block,
        [string]$Predicate
    )

    $escapedPredicate = [regex]::Escape($Predicate)
    $match = [regex]::Match($Block, "(?ms)$escapedPredicate\s+(.*?)(?:\s*;\s*|\s*\.\s*(?:\r?\n|$))")
    if ($match.Success) {
        return $match.Groups[1].Value.Trim()
    }

    return ""
}

function Get-Literals {
    param(
        [string]$Block,
        [string]$Predicate
    )

    $predicateText = Get-PredicateText -Block $Block -Predicate $Predicate
    if ([string]::IsNullOrWhiteSpace($predicateText)) {
        return @()
    }

    return [regex]::Matches($predicateText, '"((?:[^"\\]|\\.)*)"(?:@en|\^\^xsd:[A-Za-z]+)?') |
        ForEach-Object {
            $_.Groups[1].Value.Replace('\"', '"')
        }
}

function Get-Refs {
    param(
        [string]$Block,
        [string]$Predicate
    )

    $predicateText = Get-PredicateText -Block $Block -Predicate $Predicate
    if ([string]::IsNullOrWhiteSpace($predicateText)) {
        return @()
    }

    return [regex]::Matches($predicateText, 'epr:([A-Za-z][A-Za-z0-9]*)') |
        ForEach-Object {
            $_.Groups[1].Value
        }
}

function Escape-MarkdownTableCell {
    param([AllowNull()][string]$Value)

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return ""
    }

    return ($Value -replace '\|', '\|' -replace "`r?`n", "<br>")
}

$conceptMatches = [regex]::Matches(
    $ttl,
    "(?ms)^epr:([A-Za-z][A-Za-z0-9]*)\s*\r?\n\s+a\s+skos:Concept\s*;\s*(.*?)(?=^\S|\z)"
)

$concepts = foreach ($match in $conceptMatches) {
    $localName = $match.Groups[1].Value
    $block = $match.Groups[2].Value
    $preferredLabel = (Get-Literals -Block $block -Predicate "skos:prefLabel" | Select-Object -First 1)

    if ([string]::IsNullOrWhiteSpace($preferredLabel)) {
        $preferredLabel = $localName
    }

    [pscustomobject]@{
        LocalName = $localName
        PreferredLabel = $preferredLabel
        Definition = (Get-Literals -Block $block -Predicate "skos:definition" | Select-Object -First 1)
        Status = (Get-Literals -Block $block -Predicate "epr:status" | Select-Object -First 1)
        Broader = @(Get-Refs -Block $block -Predicate "skos:broader")
        IsTopConcept = $block -match 'skos:topConceptOf\s+epr:establishmentDetailsTaxonomy'
    }
}

if ($concepts.Count -eq 0) {
    throw "No skos:Concept blocks were found in $resolvedTaxonomyPath"
}

$conceptLookup = @{}
foreach ($concept in $concepts) {
    $conceptLookup[$concept.LocalName] = $concept
}

$childrenByParent = @{}
foreach ($concept in $concepts) {
    foreach ($parent in $concept.Broader) {
        if (-not $childrenByParent.ContainsKey($parent)) {
            $childrenByParent[$parent] = New-Object System.Collections.Generic.List[string]
        }
        $childrenByParent[$parent].Add($concept.LocalName)
    }
}

function New-TaxonomyNode {
    param([string]$LocalName)

    $concept = $conceptLookup[$LocalName]
    $node = [ordered]@{
        id = $concept.LocalName
        name = $concept.PreferredLabel
    }

    if ($childrenByParent.ContainsKey($LocalName)) {
        $children = @(
            $childrenByParent[$LocalName] |
                Sort-Object { $conceptLookup[$_].PreferredLabel } |
                ForEach-Object { New-TaxonomyNode -LocalName $_ }
        )

        if ($children.Count -gt 0) {
            $node.children = $children
        }
    }

    return $node
}

$facets = $concepts | Where-Object { $_.IsTopConcept } | Sort-Object PreferredLabel
$taxons = $concepts | Where-Object { -not $_.IsTopConcept } | Sort-Object PreferredLabel

$tree = [ordered]@{
    id = "establishmentDetailsTaxonomy"
    name = "Establishment Details taxonomy"
    children = @($facets | ForEach-Object { New-TaxonomyNode -LocalName $_.LocalName })
}

$treeJson = $tree | ConvertTo-Json -Depth 30

$lines = @(
    "# Establishment Details Taxonomy",
    "",
    "This page is generated from `models/establishment-details-taxonomy-skos.ttl`.",
    "",
    "The taxonomy is a faceted SKOS taxonomy. Facets are represented as top concepts, and taxons sit beneath those facets using `skos:broader` relationships.",
    "",
    "## Taxonomy Tree",
    "",
    "The interactive tree starts with the taxonomy facets. Select a node to expand or collapse its taxons.",
    "",
    '<div id="taxonomy-tree-container" class="taxonomy-tree" aria-label="Interactive taxonomy tree"></div>',
    '<script type="application/json" id="taxonomy-tree-data">'
)

$lines += $treeJson
$lines += @(
    '</script>',
    "",
    "## Facets",
    "",
    "| Facet | Compact identifier | Definition |",
    "| --- | --- | --- |"
)

foreach ($facet in $facets) {
    $lines += "| $($facet.PreferredLabel) | ``epr:$($facet.LocalName)`` | $(Escape-MarkdownTableCell $facet.Definition) |"
}

$lines += @(
    "",
    "## Taxons",
    "",
    "| Taxon | Compact identifier | Broader concept | Status |",
    "| --- | --- | --- | --- |"
)

foreach ($taxon in $taxons) {
    $broaderLabels = @($taxon.Broader | ForEach-Object {
        if ($conceptLookup.ContainsKey($_)) {
            $conceptLookup[$_].PreferredLabel
        }
        else {
            "epr:$_"
        }
    }) -join "<br>"

    $lines += "| $($taxon.PreferredLabel) | ``epr:$($taxon.LocalName)`` | $(Escape-MarkdownTableCell $broaderLabels) | $(Escape-MarkdownTableCell $taxon.Status) |"
}

Set-Content -LiteralPath (Join-Path $resolvedOutputRoot "index.md") -Value $lines -Encoding UTF8

Write-Host "Generated taxonomy page with $($concepts.Count) concepts in $resolvedOutputRoot"
