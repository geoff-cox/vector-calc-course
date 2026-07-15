# Convenience wrappers around the PreTeXt CLI.
# Target names come from project.ptx — read it before adding rules here.

PRETEXT = pretext build

.PHONY: all homepage notes book deploys clean

# Default: everything that deploys (homepage + both HTML notes builds)
all: homepage notes

homepage:
	$(PRETEXT) homepage

# All three guided-lecture-notes builds (student HTML, key HTML, key PDF)
notes:
	$(PRETEXT) web-stu
	$(PRETEXT) web-key
	$(PRETEXT) pdf-key

book:
	$(PRETEXT) book

# Exactly what CI builds for GitHub Pages (targets with a deploy-dir)
deploys:
	pretext build --deploys

clean:
	rm -rf output/ logs/
