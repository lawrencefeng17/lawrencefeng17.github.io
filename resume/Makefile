# Resume build.
#
#   make         compile resume.tex and publish to ../assets/pdf/resume.pdf
#   make watch   recompile + republish automatically on every save
#   make clean   remove LaTeX build artifacts (keeps resume.pdf)
#
# Publishing (the copy into ../assets/pdf/) is configured in .latexmkrc.

.PHONY: all watch clean

all:
	latexmk

watch:
	latexmk -pvc

clean:
	latexmk -c
