PACKAGE_PATHS ?=  \
	README.md \
	osda.pdf \
	osda.ins \
	osda.dtx \
	example.png 

PACKAGE_NAME ?= osda
PACKAGE_EXT ?= tar.gz

TAR_COMMAND=tar
TAR_OPTIONS=-czvv
TAR_EXCLUDE_PATTERNS=\
	.*.sw?
TAR_EXCLUDE=$(TAR_EXCLUDE_PATTERNS:%=--exclude=%)

.PHONY: help sty doc package

help:
	@echo "make sty"
	@echo "    Generate LaTeX package"
	@echo ""
	@echo "make doc"
	@echo "    Generate package documentation"
	@echo ""
	@echo "make package"
	@echo "    Generate shareable zipped archive (e.g., upload to CTAN)"
	@echo ""

sty:
	latex osda.ins

doc:
	pdflatex osda.dtx
	pdflatex osda.dtx
	pdflatex osda.dtx

package: sty doc
	VERSION=$(shell cat osda.sty | grep "^\s*\[" | sed "s/.*\[[0-9]\{4\}\/[0-9]\{2\}\/[0-9]\{2\} v\([^ ]*\) .*/\1/g"); \
	$(TAR_COMMAND) $(TAR_EXCLUDE) $(TAR_OPTIONS) -f $(PACKAGE_NAME)-$$VERSION.$(PACKAGE_EXT) $(PACKAGE_PATHS)
