# Models

This folder contains machine-readable semantic model files for the Education Provider Registry data prototype.

## Files

- `establishment-details-vocabulary-skos.ttl` - a SKOS vocabulary for Establishment Details concepts, including preferred labels, alternative labels, definitions, relationships, statuses and source notes.
- `establishment-details-taxonomy-skos.ttl` - a SKOS taxonomy for Establishment Details classifications, expressed as facets and narrower taxons evidenced by the current modelling work.

## SKOS

SKOS, the Simple Knowledge Organization System, is a W3C standard for representing vocabularies, thesauri, taxonomies and concept schemes using RDF. These `.ttl` files use Turtle syntax to make the concepts readable by both people and RDF tooling.

See more: <https://www.w3.org/TR/skos-reference/>

## Viewing The Files

The TTL files can be opened as text, but they are easier to inspect graphically with an RDF viewer.

Suggested VS Code extension:

<https://marketplace.visualstudio.com/items?itemName=Zazuko.vscode-rdf-sketch>
