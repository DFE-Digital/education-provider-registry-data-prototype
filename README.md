# Education Provider Registry Data Prototype

This repository contains early data-modelling artefacts for the Education Provider Registry.

## Documentation Site

The repository includes a Nanoc documentation site under `docs-site`.

The vocabulary pages are generated from:

```text
models/establishment-details-vocabulary-skos.ttl
```

The normal publishing path is GitHub Actions:

```text
push to main
  -> generate vocabulary Markdown pages from Turtle
  -> run Nanoc
  -> publish docs-site/output to GitHub Pages
```

GitHub Pages should be configured to publish from GitHub Actions.

To build locally:

```powershell
cd .\docs-site
.\scripts\compile-local.ps1
```

The generated pages resolve under:

```text
https://dfe-digital.github.io/education-provider-registry-data/vocabulary/
```
