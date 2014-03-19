
args= --stylesheet=theme.css --link-stylesheet --section-numbering

source = $(wildcard *.rst)

objects: $(source:.rst=.html)

%.html:%.rst
	rst2html $(args) $< $@
