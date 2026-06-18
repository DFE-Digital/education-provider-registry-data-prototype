# docs-site

This folder contains the [Nanoc](https://nanoc.ws/) site used to turn the generated markdown files in `content/` into the static Education Provider Registry data documentation site.

Nanoc is a Ruby static site generator. In this repo the docs site is intentionally contained in `docs-site/`: local build scripts live in `docs-site/scripts/`, generated markdown lives in `docs-site/content/`, Ruby dependencies are installed under `docs-site/vendor/bundle/`, and the generated HTML is written to `docs-site/output/`.

The vocabulary and taxonomy pages are generated from the Turtle files in `../models/`.

## Compile the docs locally

Run this command from `docs-site/`:

```powershell
.\scripts\compile-local.ps1
```

The script:

1. Generates vocabulary markdown from `../models/establishment-details-vocabulary-skos.ttl`.
2. Generates taxonomy markdown from `../models/establishment-details-taxonomy-skos.ttl`.
3. Configures Bundler to install dependencies under `docs-site/vendor/bundle/`.
4. Installs the Ruby gems if needed.
5. Compiles the Nanoc site into `docs-site/output/`.

After the first successful install, you can skip the Bundler install step when you only want to regenerate and compile the site:

```powershell
.\scripts\compile-local.ps1 -SkipBundleInstall
```

To check the result locally, open `docs-site/output/index.html` in a browser.

If a layout, filter, or generated page change does not appear in the output, delete `docs-site/output/` and `docs-site/tmp/`, then run `.\scripts\compile-local.ps1` again.

## Individual generation scripts

The local page generators are kept under `docs-site/scripts/` so the docs-site build remains isolated from the repository root.

Run these only when you want to refresh generated markdown without compiling the full Nanoc site:

```powershell
.\scripts\generate-vocabulary-pages.ps1
.\scripts\generate-taxonomy-pages.ps1
```

The generated markdown files under `content/vocabulary/` and `content/taxonomy/` are build artefacts and are ignored by Git.

## Publish with GitHub Pages

This repository includes a GitHub Actions workflow at `../.github/workflows/publish-docs-site.yml` that builds `docs-site/output/` and deploys it to GitHub Pages.

The published site is intended to be served from:

`https://dfe-digital.github.io/education-provider-registry-data/`

GitHub Pages should be configured to publish from GitHub Actions:

1. In the repository on GitHub, go to `Settings` -> `Pages`.
2. Under `Build and deployment`, set `Source` to `GitHub Actions`.
3. In `Settings` -> `Environments` -> `github-pages`, make sure the deployment branch rules allow the branch you want to publish from.
4. Push to the repository default branch, or run the workflow manually from the `Actions` tab.
