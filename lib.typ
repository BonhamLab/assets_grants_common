// NIH-style grant formatting template
//
// Usage (when this repo is a submodule at assets/grants_common/):
//
//   #import "/assets/grants_common/lib.typ": *
//   #show: nih-format
//
// Or with customization:
//
//   #show: nih-format.with(page-overrides: (margin: 0.75in))

/// NIH page settings: US Letter, ½″ margins on all sides.
/// Exported so callers can spread/override individual fields.
#let nih-page = (
  paper: "us-letter",
  margin: 0.5in,
)

/// NIH text settings: Liberation Serif, 11 pt (minimum per NIH guidelines).
/// Exported so callers can spread/override individual fields.
#let nih-text = (
  font: "Liberation Serif",
  size: 11pt,
  lang: "en",
)

/// Apply NIH grant formatting to a document.
///
/// Parameters:
///   page-overrides  - dict of overrides merged into nih-page
///   text-overrides  - dict of overrides merged into nih-text
///   doc             - document content (pass implicitly via #show: nih-format)
///
/// Example:
///   #show: nih-format
///   #show: nih-format.with(text-overrides: (size: 12pt))
#let nih-format(page-overrides: (:), text-overrides: (:), doc) = {
  set page(..nih-page, ..page-overrides)
  set text(..nih-text, ..text-overrides)
  set par(
    justify: true,
    leading: 0.65em,
    first-line-indent: 0pt,
  )

  // NIH does not permit heading font sizes larger than body text.
  // Catch-all first (level 3+): italic only. Specific rules below override it.
  // Level 1: bold; level 2: bold italic; deeper: italic only.
  show heading: set text(size: 11pt, weight: "regular", style: "italic")
  show heading.where(level: 1): set text(size: 11pt, weight: "bold", style: "normal")
  show heading.where(level: 2): set text(size: 11pt, weight: "bold", style: "italic")

  doc
}
