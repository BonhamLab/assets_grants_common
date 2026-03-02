# assets/grants_common

Shared Typst formatting assets for NIH-style grant documents. Intended to be used as a git submodule.

## Adding as a submodule

```bash
git submodule add <this-repo-url> assets/grants_common
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

## Requirements

- [Typst](https://typst.app/) 0.13.1
- Liberation Serif font installed (available in most Linux distros via `liberation-fonts`)
