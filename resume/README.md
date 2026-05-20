# Resume

LaTeX source for the resume published at `/assets/pdf/resume.pdf` on the site.
Migrated off Overleaf; edit `resume.tex` here and compile locally.

## Build

```sh
make          # compile resume.tex and copy the PDF to ../assets/pdf/resume.pdf
make watch    # rebuild + republish on every save (Ctrl-C to stop)
make clean    # remove LaTeX aux files (.aux, .log, .fdb_latexmk, ...)
```

The copy into `../assets/pdf/resume.pdf` happens automatically after a
successful compile (see `.latexmkrc`). Commit that PDF along with any source
changes to update the live site.

## Requirements

MacTeX / TeX Live with `pdflatex` and `latexmk` (already installed). The
template uses `fontawesome5`, `latexsym`, `titlesec`, `enumitem`, and friends —
all part of a full TeX Live install.
