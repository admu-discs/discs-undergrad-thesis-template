# Building in a VS Code Dev Container

A dev container runs VS Code's tools inside a Docker container, so you get a complete TeX Live installation without installing LaTeX on your computer. Everyone who uses the container builds with the same TeX version, which keeps the PDF consistent between teammates and machines.

## What you need

- [Visual Studio Code](https://code.visualstudio.com/)
- The [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension
- A container runtime:
  - **Windows and macOS:** [Docker Desktop](https://www.docker.com/products/docker-desktop/). On Windows, use the WSL 2 backend.
  - **Linux:** [Docker Engine](https://docs.docker.com/engine/install/)

Start Docker before opening the project. The TeX Live image is several gigabytes, so the first download takes a while; later starts are fast.

## 1. Add the dev container configuration

Create `.devcontainer/devcontainer.json` in your copy of the template:

```json
{
  "name": "DISCS Thesis (TeX Live)",
  "image": "texlive/texlive:latest",
  "customizations": {
    "vscode": {
      "extensions": ["James-Yu.latex-workshop"],
      "settings": {
        "latex-workshop.latex.outDir": "%DIR%",
        "latex-workshop.latex.autoBuild.run": "onSave",
        "latex-workshop.view.pdf.viewer": "tab"
      }
    }
  }
}
```

- `texlive/texlive:latest` is the official full TeX Live image. It already includes `pdflatex`, BibTeX, `latexmk`, and every package the template needs.
- LaTeX Workshop builds with `latexmk` by default and shows the PDF in a VS Code tab.
- Commit this file so your teammates get the same setup.

## 2. Open the project in the container

1. Open the repository folder in VS Code.
2. When VS Code offers **Reopen in Container**, select it. If you miss the prompt, open the Command Palette (`Ctrl+Shift+P`, or `Cmd+Shift+P` on macOS) and run **Dev Containers: Reopen in Container**.
3. Wait for the image to download and the container to start. The bottom-left corner of VS Code shows **Dev Container: DISCS Thesis (TeX Live)** when you are inside.

Your files stay on your computer. The container mounts the folder, so edits, Git commits, and the built PDF are all in your normal project directory.

## 3. Build the thesis

Either way works:

- **From the editor:** open `FinalManuscript.tex` and save. LaTeX Workshop builds automatically. Use **LaTeX Workshop: View LaTeX PDF** from the Command Palette, or the preview icon at the top right of the editor, to open the PDF.
- **From the terminal:** open a terminal in VS Code (**Terminal → New Terminal**). It runs inside the container. Then run:

  ```sh
  latexmk -pdf FinalManuscript.tex
  ```

Build errors appear in the **Problems** panel. The full log is in `FinalManuscript.log`.

## 4. Working with chapter files

LaTeX Workshop needs to know which file is the main document. Chapter files don't have `\documentclass`, so add this as the first line of any file under `chapters/`, `frontmatter/`, or `appendices/` that you want to build on save:

```latex
% !TEX root = ../FinalManuscript.tex
```

For files one folder deeper, such as `chapters/introduction/`, use `../../FinalManuscript.tex`.

## Troubleshooting

- **Reopen in Container doesn't appear:** confirm the Dev Containers extension is installed and that `.devcontainer/devcontainer.json` is at the repository root.
- **"Docker is not running" or the container fails to start:** start Docker Desktop, or on Linux check `docker info`, then run **Dev Containers: Rebuild Container**.
- **Permission errors writing files on Linux:** add your user to the `docker` group (`sudo usermod -aG docker $USER`), log out and back in, and rebuild the container.
- **The build is slow on Windows:** keep the repository inside the WSL file system (for example `~/thesis` in Ubuntu) and open it from WSL. Builds on `C:\` go through a slower file-sharing layer.
- **A newer TeX Live changed something:** pin the image to a yearly release, for example `texlive/texlive:latest` → `texlive/texlive:TL2025-historic`, and rebuild the container.

## Without VS Code

The same image builds the thesis from any terminal with Docker:

```sh
docker run --rm -v "$PWD":/thesis -w /thesis texlive/texlive:latest latexmk -pdf FinalManuscript.tex
```

On Windows PowerShell, replace `"$PWD"` with `"${PWD}"`.

For writing help, including citations, figures, and tables, see [Getting started with LaTeX](getting-started-with-latex.md). To report a problem with the template, see [Reporting issues](../README.md#reporting-issues).
