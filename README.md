# DISCS Undergraduate Thesis Template

A LaTeX template for undergraduate theses in the Department of Information Systems and Computer Science (DISCS), Ateneo de Manila University. The `discsthesis` class follows the layout of the official Word template, *CS Thesis Template (with biblio in PCSC-ACM format) A4 v202102*, so you can write in LaTeX and still meet the department's formatting rules.

## Quickstart

1. Create a free account at [Overleaf](https://www.overleaf.com/register).
2. Open the [Overleaf version of this template](https://www.overleaf.com/project/6adc2cb5429f3d746e41847c) and choose **Menu → Copy Project**.
3. Edit and build your thesis in the cloud. Overleaf compiles the PDF for you, with nothing to install.

## Features

- A4 paper with 1.5 in left margin and 1 in top, bottom, and right margins
- Times 12 pt, double spaced, justified, with 0.5 in paragraph indents
- Title page built from a few commands in the preamble (see [Title page](#title-page))
- Roman page numbers in the front matter, Arabic from Chapter I, placed top right
- `CHAPTER I` / `TITLE` headings, bold numbered sections, and Word-style table of contents, list of figures, and list of tables
- Bold centred captions, with figures captioned below and tables above
- ACM reference format with numeric citations (`natbib` + `ACM-Reference-Format.bst`)
- Lettered appendices
- A sample thesis split into front matter, chapters, and appendices, ready to replace with your own content

## Repository layout

```text
FinalManuscript.tex      main file: title page details and chapter order
discsthesis.cls          the thesis class (layout rules live here)
frontmatter/             abstract and acknowledgements
chapters/                one file per chapter, with optional subfolders
appendices/              one file per appendix
images/                  figures
references.bib           bibliography entries
ACM-Reference-Format.bst bibliography style
```

## Building

To build locally with a TeX distribution installed (TeX Live, MacTeX, or MiKTeX), run this from the repository root:

```sh
latexmk -pdf FinalManuscript.tex
```

`latexmk` runs `pdflatex` and BibTeX as many times as needed and writes `FinalManuscript.pdf`. Run `latexmk -c` to clear the build files.

## Title page

Set the title page details in the preamble of `FinalManuscript.tex`, before `\begin{document}`. Then call `\maketitle` as the first thing in the document.

```latex
\documentclass{discsthesis}

\ThesisTitle{TOWARDS A MORE FINE-TUNED GEOLOCATION\\APPROXIMATION MODEL FOR DISASTER TWEETS}
\ThesisAuthor{Juan Dela Cruz\\Maria Santos}
\ThesisDefenseYear{2027}

\begin{document}
\maketitle
```

- `\ThesisTitle{...}` sets the title, in capitals. Use `\\` to break it into lines that form an inverted triangle.
- `\ThesisAuthor{...}` lists the authors, one per line, separated by `\\`.
- `\ThesisDefenseYear{...}` sets the year of the defense. It defaults to the current year.

These three have defaults that fit most DISCS theses. Set them only when yours differs:

```latex
\ThesisDegree{Bachelor of Science in Management Information Systems}
\ThesisDepartment{Department of Information Systems\\and Computer Science}
\ThesisUniversity{Ateneo de Manila University}
```

- `\ThesisDegree{...}` defaults to *Bachelor of Science in Computer Science*.
- `\ThesisDepartment{...}` defaults to *Department of Information Systems and Computer Science*, split over two lines.
- `\ThesisUniversity{...}` defaults to *Ateneo de Manila University*.

## Guides

- [Getting started with LaTeX](docs/getting-started-with-latex.md): installing a TeX distribution, editing the template, citations, figures, tables, and common errors
- [Building in a VS Code dev container](docs/dev-containers.md): a full LaTeX setup inside Docker, with nothing to install on your computer except VS Code and Docker

## Reporting issues

Found a formatting difference from the department's Word template, a build error, or a gap in the guides? [Open an issue](https://github.com/admu-discs/discs-undergrad-thesis-template/issues/new) and include:

- what you expected and what you saw, with a screenshot or page number from the PDF when it is a layout problem
- your TeX distribution and version (`pdflatex --version`), or that you used the dev container
- the first error from `FinalManuscript.log` when the build fails

Check the [open issues](https://github.com/admu-discs/discs-undergrad-thesis-template/issues) first in case someone has already reported it.

## Credits

Based on `discsthesis.cls` v3.1 (Coronel, Estuar, Vergara, Vidal, 2005), itself based on `admuthesis.cls` by F. P. Muga II.
