.PHONY: all index

DOCS ?= .
-include config.mk

RST_HTML := --stylesheet=/usr/lib/python3.8/site-packages/docutils/writers/html4css1/html4css1.css,simple.css

TARGETS := \
	$(DOCS)/guide.html
#	$(DOCS)/guide.pdf

all: $(TARGETS)

index:
	#tree -H . -I index.html -o $(DOCS)/index.html -- $(DOCS)
	echo > $(DOCS)/index.html

$(DOCS)/%.html: %.rst simple.css
	test "$(DOCS)" != "." && cp -v *.png $(DOCS) || true
	(echo -e ".. sectnum::\n"; cat $<) | \
		sed -r 's/^\.\. figure:: (.*)\.\*/.. figure:: \1.png/' | \
		rst2html.py ${RST_HTML} > $@

#$(DOCS)/%.pdf: %.rst
#	(echo -e ".. sectnum::\n"; cat $<) | \
#		sed -r 's/^\.\. figure:: (.*)\.\*/.. figure:: \1.pdf/' | \
#		rst2pdf -o $@
