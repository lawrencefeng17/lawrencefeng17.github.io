# Resume build + Overleaf sync.
#
#   make               compile resume.tex and publish to ../assets/pdf/resume.pdf
#   make watch         recompile + republish automatically on every save
#   make clean         remove LaTeX build artifacts (keeps resume.pdf)
#
#   make overleaf-init OVERLEAF_URL=https://git.overleaf.com/<project-id>
#                      one-time: clone the Overleaf project into $(OVERLEAF_DIR)
#   make push          copy resume.tex -> Overleaf clone, commit, push
#   make pull          pull Overleaf, copy resume.tex -> here
#
# Publishing (the copy into ../assets/pdf/) is configured in .latexmkrc.
# The Overleaf clone is a SEPARATE git repo kept outside this site repo, so
# the two histories never collide. Only resume.tex is synced; if you add
# figures or a custom .cls, extend the cp lines below.

# Where the separate Overleaf clone lives (override on the command line if you
# keep it elsewhere: make push OVERLEAF_DIR=/some/path).
OVERLEAF_DIR ?= $(HOME)/Projects/overleaf-resume
OVERLEAF_URL ?=
# Name of the .tex file at the root of the Overleaf project (Overleaf calls it
# main.tex by default; local source is resume.tex).
OVERLEAF_TEX ?= main.tex

.PHONY: all watch clean overleaf-init push pull

all:
	latexmk

watch:
	latexmk -pvc

clean:
	latexmk -c

overleaf-init:
	@test -n "$(OVERLEAF_URL)" || { \
	  echo "Usage: make overleaf-init OVERLEAF_URL=https://git.overleaf.com/<project-id>"; exit 1; }
	@test ! -e "$(OVERLEAF_DIR)" || { \
	  echo "$(OVERLEAF_DIR) already exists; remove it or set OVERLEAF_DIR."; exit 1; }
	git clone "$(OVERLEAF_URL)" "$(OVERLEAF_DIR)"

push:
	@test -d "$(OVERLEAF_DIR)/.git" || { \
	  echo "No Overleaf clone at $(OVERLEAF_DIR). Run: make overleaf-init OVERLEAF_URL=..."; exit 1; }
	cp resume.tex "$(OVERLEAF_DIR)/$(OVERLEAF_TEX)"
	cd "$(OVERLEAF_DIR)" && git add -A && \
	  (git diff --cached --quiet || git commit -m "Sync resume.tex from local ($(shell date +%Y-%m-%d))") && \
	  git push

pull:
	@test -d "$(OVERLEAF_DIR)/.git" || { \
	  echo "No Overleaf clone at $(OVERLEAF_DIR). Run: make overleaf-init OVERLEAF_URL=..."; exit 1; }
	cd "$(OVERLEAF_DIR)" && git pull
	cp "$(OVERLEAF_DIR)/$(OVERLEAF_TEX)" resume.tex
