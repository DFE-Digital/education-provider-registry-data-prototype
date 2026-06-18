# Models

This folder contains machine-readable semantic model files for the Education Provider Registry data prototype.

## Files

- `establishment-details-vocabulary-skos.ttl` - a SKOS vocabulary for Establishment Details concepts, including preferred labels, alternative labels, definitions, relationships, statuses and source notes.
- `establishment-details-taxonomy-skos.ttl` - a SKOS taxonomy for Establishment Details classifications, expressed as facets and narrower taxons evidenced by the current modelling work.
- `establishment-details-conceptual-model.md` - a Markdown conceptual model for the Establishment Details submodel, using several Mermaid diagrams split by business concern.

## SKOS

SKOS, the Simple Knowledge Organization System, is a W3C standard for representing vocabularies, thesauri, taxonomies and concept schemes using RDF. These `.ttl` files use Turtle syntax to make the concepts readable by both people and RDF tooling.

See more: <https://www.w3.org/TR/skos-reference/>

## Canonical Identifiers

The canonical identifier for a concept is its expanded RDF IRI, not its GitHub line link.

For example, in the TTL file:

```ttl
@prefix epr: <https://education.gov.uk/epr/vocabulary/> .

epr:EstablishmentLifecycle
    a skos:Concept ;
    skos:prefLabel "Establishment lifecycle"@en .
```

The persistent concept identifier is:

```text
https://education.gov.uk/epr/vocabulary/EstablishmentLifecycle
```

The GitHub link to a line in `establishment-details-vocabulary-skos.ttl` is useful for review and navigation, but it should not be treated as the canonical identifier because line numbers can change as the file evolves.

## Viewing The Files

The TTL files can be opened as text, but they are easier to inspect graphically with an RDF viewer.

Suggested VS Code extension:

<https://marketplace.visualstudio.com/items?itemName=Zazuko.vscode-rdf-sketch>
