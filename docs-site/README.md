# docs-site

This folder contains the Nanoc site used to publish documentation from this repository.

Documentation source files live in:

```text
../documentation
```

During the build, Markdown files are copied into:

```text
docs-site/content
```

Nanoc compiles `docs-site/content` into `docs-site/output`, which is then published to GitHub Pages.

## Local compile

Run:

```powershell
.\scripts\compile-local.ps1
```
