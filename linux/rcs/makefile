rcpath = .blog/10linux/rcs

.PHONY: rcs blog

rcs: $(rcpath)/_xinitrc $(rcpath)/Xdefaults\
	$(rcpath)/openbox $(rcpath)/musca_start \
	$(rcpath)/_bashrc $(rcpath)/profile\
	$(rcpath)/conkyrc $(rcpath)/tint2rc\
	$(rcpath)/gtkrc-2.0 $(rcpath)/gtkrc.zh_CN\
	$(rcpath)/local.conf $(rcpath)/mplayer-config\
	$(rcpath)/dosboxrc $(rcpath)/terminator\
	$(rcpath)/makefile\
	.blog/20research/p2p-streaming.bib

$(rcpath)/_xinitrc: .xinitrc
	cp $< $@
$(rcpath)/Xdefaults: .Xdefaults
	cp $< $@
$(rcpath)/openbox: .config/openbox
	cp -r .config/openbox/*  $@
	touch $@
$(rcpath)/musca_start: .musca_start
	cp $< $@
$(rcpath)/_bashrc: .bashrc
	cp $< $@
$(rcpath)/profile: .profile
	cp $< $@
$(rcpath)/conkyrc: .conkyrc
	cp $< $@
$(rcpath)/tint2rc: .config/tint2/tint2rc
	cp $< $@
$(rcpath)/gtkrc-2.0: .gtkrc-2.0
	cp $< $@
$(rcpath)/gtkrc.zh_CN: .gtkrc.zh_CN
	cp $< $@
$(rcpath)/local.conf: /etc/fonts/local.conf
	cp $< $@
$(rcpath)/mplayer-config: .mplayer/config
	cp $< $@
$(rcpath)/dosboxrc: .dosboxrc
	cp $< $@
$(rcpath)/terminator: .config/terminator/config
	cp $< $@
$(rcpath)/makefile: makefile
	cp $< $@
.blog/20research/p2p-streaming.bib: texmf/bibtex/bib/p2p-streaming.bib
	cp $< $@

vim:
	tar czvf /data/_vim.tar.gz .vim

emacs:
	tar czvf /data/_emacs.tar.gz .emacs .emacs-site-lisp/

blog: 
	tar czvf /data/blog.tar.gz .blog/


pwm: /data/pwm.tar.gz

/data/pwm.tar.gz: pwm/
	tar czvf $@ $<

fonts: /data/fonts.tar.gz

/data/fonts.tar.gz: .fonts/
	tar czvf $@ $<

texmf: /data/texmf.tar.gz

/data/texmf.tar.gz: texmf/
	tar czvf $@ $<

