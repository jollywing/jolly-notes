objects = 017cmmusic.html 05deal-with-image.html vpn.html

args= --stylesheet=../theme.css --link-stylesheet

.PHONY: all
all: $(objects)

$(objects):%.html:%.rst
	rst2html $(args) $< $@
