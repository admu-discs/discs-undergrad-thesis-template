# Getting Started with LaTeX

This guide takes you from a fresh computer to a built thesis PDF. If you'd rather not install LaTeX locally, follow [Building in a VS Code dev container](dev-containers.md) and come back here for the writing sections.

## 1. Install a TeX distribution

A TeX distribution provides `pdflatex`, BibTeX, `latexmk`, and the packages the template uses.

- **Windows:** [MiKTeX](https://miktex.org/download) or [TeX Live](https://tug.org/texlive/windows.html). MiKTeX installs missing packages on first use; allow it when prompted. `latexmk` also needs Perl, which you can get from [Strawberry Perl](https://strawberryperl.com/).
- **macOS:** [MacTeX](https://tug.org/mactex/).
- **Linux:** the full TeX Live from your package manager, for example `sudo apt install texlive-full` on Ubuntu or Debian.

Check the install from a terminal:

```sh
pdflatex --version
latexmk --version
```

## 2. Get your own copy of the template

1. On GitHub, use **Fork** or **Use this template** to create your own repository, or download the ZIP from **Code → Download ZIP**.
2. Clone your copy:

   ```sh
   git clone https://github.com/<your-account>/<your-repo>.git
   cd <your-repo>
   ```

Keeping the thesis in Git gives you history and backups, and makes it easy to share drafts with your adviser.

## 3. Pick an editor

- **VS Code** with the [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) extension builds on save and shows the PDF beside your source. The [dev container guide](dev-containers.md) sets this up for you.
- **TeXstudio** or **TeXworks** are standalone LaTeX editors that work with any TeX distribution.
- **Overleaf** works in the browser with nothing to install. Open the [Overleaf version of this template](https://www.overleaf.com/project/6adc2cb5429f3d746e41847c) and choose **Menu → Copy Project** to get your own copy, already set up to build. If you skip the local install, go straight to [Make it your thesis](#5-make-it-your-thesis).

## 4. Build the sample thesis

Build the sample once before editing so you know your setup works:

```sh
latexmk -pdf FinalManuscript.tex
```

Open `FinalManuscript.pdf`. It should match the copy committed in the repository. To remove build files, run `latexmk -c`.

## 5. Make it your thesis

### Title page

Edit the details near the top of `FinalManuscript.tex`:

```latex
\ThesisTitle{YOUR THESIS TITLE\\IN AN INVERTED TRIANGLE}
\ThesisAuthor{First Author\\Second Author}
\ThesisDefenseYear{2027}
%\ThesisDegree{Bachelor of Science in Computer Science}
```

- Use `\\` to break the title into lines that form an inverted triangle.
- List one author per line, separated by `\\`.
- The degree defaults to *Bachelor of Science in Computer Science*. Uncomment `\ThesisDegree` to change it, for example to *Bachelor of Science in Management Information Systems*.

### Front matter, chapters, and appendices

Each part of the thesis lives in its own file and is pulled in with `\input` from `FinalManuscript.tex`:

- `frontmatter/abstract.tex` and `frontmatter/acknowledgements.tex`
- `chapters/01_introduction.tex` through `chapters/06_recommendations.tex`
- `appendices/a_*.tex`, `b_*.tex`, and so on

Replace the sample text with your own. To add, remove, or reorder a chapter or appendix, add, remove, or reorder its `\input` line. Long chapters can be split further, as `chapters/01_introduction.tex` does with `chapters/introduction/`.

Start each chapter with `\chapter{TITLE IN CAPITALS}`, and use `\section{...}` and `\subsection{...}` inside it. Numbering, headings, and the table of contents follow automatically.

### Citations

Add entries to `references.bib`. Google Scholar, the ACM Digital Library, and IEEE Xplore all offer a BibTeX export for each paper.

```bibtex
@inproceedings{albuz2000,
  title     = {Quantized CIELab* space and encoded spatial structure for scalable indexing of large color image archives},
  author    = {Albuz, Elif and Kocalar, Erturk D and Khokhar, Ashfaq A},
  booktitle = {Proceedings of ICASSP 2000},
  pages     = {1995--1998},
  year      = {2000}
}
```

Cite with the entry key:

```latex
Prior work indexed colour images by quantised colour space \cite{albuz2000}.
```

Only cited entries appear in the bibliography, formatted in ACM style with numeric labels such as [1].

### Figures

Put images in `images/` and include them like this:

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.8\textwidth]{images/architecture.png}
  \caption{System architecture}
  \label{fig:architecture}
\end{figure}
```

Refer to it with `Figure~\ref{fig:architecture}`. The class places figure captions below the image.

### Tables

```latex
\begin{table}[htbp]
  \centering
  \caption{Model accuracy}
  \label{tab:accuracy}
  \begin{tabular}{lcc}
    \hline
    Model & Precision & Recall \\
    \hline
    Baseline & 0.71 & 0.65 \\
    Proposed & 0.84 & 0.80 \\
    \hline
  \end{tabular}
\end{table}
```

Put `\caption` before the tabular so the caption sits above the table, as the department format requires. `FinalManuscript.tex` already loads `tabularx`, `multirow`, `longtable`, and `lscape` for wider or longer tables.

## 6. Common errors

LaTeX writes the full log to `FinalManuscript.log`. The first line that starts with `!` is usually the real problem.

- **`File 'something.sty' not found`:** your distribution is missing a package. MiKTeX can install it on demand; on TeX Live, install the full scheme or use `tlmgr install <package>`.
- **`Undefined control sequence`:** a misspelled command or a missing `\usepackage`. The log shows the line number.
- **Citations show as `[?]`:** the bibliography hasn't been built yet, or the key doesn't match `references.bib`. Run `latexmk -pdf` again and check the key's spelling.
- **References show as `??`:** run the build again. `latexmk` normally handles this for you.
- **Special characters break the build:** escape `%`, `&`, `_`, `#`, and `$` as `\%`, `\&`, `\_`, `\#`, and `\$` in normal text.
- **The build is stuck on an old error:** run `latexmk -C` to remove all build files, including the PDF, and build again.

## Learning more

- [Learn LaTeX](https://www.learnlatex.org/): short, interactive lessons
- [Overleaf documentation](https://www.overleaf.com/learn): searchable how-tos for tables, figures, maths, and bibliographies
- [TeX Stack Exchange](https://tex.stackexchange.com/): answers to specific questions

Stuck on something this template should handle? See [Reporting issues](../README.md#reporting-issues).
