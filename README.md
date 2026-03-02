# assets/grants_common

Shared Typst formatting assets for NIH-style grant documents. Intended to be used as a git submodule.

## Adding as a submodule

```bash
git submodule add git@github.com:BonhamLab/assets_grants_common assets/grants_common
```

## Usage

In your Typst document, import and apply the NIH template:

```typst
#import "/assets/grants_common/lib.typ": *
#show: nih-format
```

Compile with `--root .` so that absolute imports resolve from the project root:

```bash
typst compile --root . main.typ grant.pdf
typst watch --root . main.typ grant.pdf
```

To "export" a version that contains the current commit hash:

```fish
typst compile --root . main.typ ~/Downloads/(basename $PWD)-(git rev-parse --short HEAD).pdf
```

### Formatting applied

- **Page**: US Letter (8.5″ × 11″), 0.5″ margins on all sides
- **Font**: Liberation Serif, 11 pt
- **Paragraphs**: justified, single-spaced
- **Headings**: all at 11 pt per NIH rules — bold (h1), bold italic (h2), italic (h3+)

### Overriding settings

Pass `page:` or `text:` dicts to override specific fields:

```typst
#show: nih-format.with(
  page: (margin: (all: 0.75in)),
  text: (size: 12pt),
)
```

The exported dicts `nih-page` and `nih-text` can also be spread directly into `set` rules if you need more control:

```typst
#import "/assets/grants_common/lib.typ": nih-page, nih-text

#set page(..nih-page, margin: (left: 1in))
#set text(..nih-text)
```

## GitHub Actions workflow

`github_workflows/release.yml` is a template workflow for consumer repos. Copy it into your repo:

```bash
cp assets/grants_common/github_workflows/release.yml .github/workflows/release.yml
```

The workflow triggers on GitHub release creation (or manually). It:
1. Checks out all submodules recursively (including `assets/grants_common`)
2. Installs Liberation Serif via `apt` and Typst 0.14
3. Compiles `main.typ` → `grant.pdf` with `--root .`
4. Creates a source archive (with all submodule contents) and SHA256 checksums
5. Uploads `grant.pdf`, the source `.tar.gz`, and `checksums.sha256` to the GitHub release

Release artifacts are named after the repository (e.g., `my-grant-v1.0.0-source.tar.gz`).

## Requirements

- [Typst](https://typst.app/) 0.14
- Liberation Serif font installed (available in most Linux distros via `fonts-liberation`)
