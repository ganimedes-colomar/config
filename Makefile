#!/usr/bin/make -f
SHELL	= /bin/bash -Eeuo pipefail

DESTDIR		=

bindir		= /usr/local/bin
BINDIR		= $(CURDIR)/bin
HOMEDIR		= $(CURDIR)/home
sysconfdir	= /etc
SYSCONFDIR	= $(CURDIR)/etc

INSTALL_OPTS	= -v
INSTALL		= install $(INSTALL_OPTS)
INSTALL_DATA	= $(INSTALL) -m 644
INSTALL_DIR	= $(INSTALL) -m 755 -d
INSTALL_PROGRAM	= $(INSTALL) -m 755


.PHONY: bin
bin:
	cd $(BINDIR) && \
	find * -type f \
	|while read f; do \
		$(INSTALL_PROGRAM) -DT "$$f" "$(DESTDIR)$(bindir)/$$f"; \
	done;

.PHONY: apt
apt:
	cd $(SYSCONFDIR) && \
	find apt/ -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: sh
sh:
	cd $(SYSCONFDIR) && \
	find profile.d/ -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: bash
bash:
	cd $(SYSCONFDIR) && \
	find bash.bashrc -type f \
	|while read f; do \
		sed '/# alx\s*BEGIN/,/# alx\s*END/d' \
			-i "$(DESTDIR)$(sysconfdir)/$$f" ||:; \
		cat "$(SYSCONFDIR)/$$f" >> "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: console
console:
	cd $(SYSCONFDIR) && \
	find . -type f \
	|grep console-setup \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: crypttab
crypttab:
	cd $(SYSCONFDIR) && \
	find crypttab -type f \
	|while read f; do \
		sed '/# alx\s*BEGIN/,/# alx\s*END/d' \
			-i "$(DESTDIR)$(sysconfdir)/$$f" ||:; \
		cat "$(SYSCONFDIR)/$$f" >> "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: doas
doas:
	cd $(SYSCONFDIR) && \
	find doas* -type f \
	|while read f; do \
		$(INSTALL) -m 440 -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: fstab
fstab:
	cd $(SYSCONFDIR) && \
	find fstab -type f \
	|while read f; do \
		sed '/# alx\s*BEGIN/,/# alx\s*END/d' \
			-i "$(DESTDIR)$(sysconfdir)/$$f" ||:; \
		cat "$(SYSCONFDIR)/$$f" >> "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: git
git:
	cd $(SYSCONFDIR) && \
	find git* -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: git.home
git.home:
	cd $(HOMEDIR) && \
	find .gitconfig -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(HOME)/$$f"; \
	done;

.PHONY: groff
groff:
	cd $(SYSCONFDIR) && \
	find groff/ -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: mbsync
mbsync:
	cd $(HOMEDIR) && \
	find .mbsyncrc -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(HOME)/$$f"; \
		cat $(DESTDIR)$(HOME)/$$f \
		| grep PassCmd \
		| sort \
		| uniq \
		| while read -r l; do \
			echo "$$l" \
			| cut -f2 -d'"' \
			| cut -f3 -d ' ' \
			| xargs pass show \
			| xargs -I {} sed -i "s,$$l,Pass \"{}\"," \
				$(DESTDIR)$(HOME)/$$f; \
		done; \
	done;

.PHONY: mutt
mutt:
	cd $(SYSCONFDIR) && \
	find Muttrc.d/ -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: mutt.home
mutt.home:
	cd $(HOMEDIR) && \
	find .config/mutt/ -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(HOME)/$$f"; \
		cat $(DESTDIR)$(HOME)/$$f \
		| grep -o '`pass show .*`' \
		| sort \
		| uniq \
		| while read -r l; do \
			echo "$$l" \
			| tr -d '`' \
			| cut -f3 -d ' ' \
			| xargs pass show \
			| xargs -I {} sed -i "s,$$l,{}," \
				$(DESTDIR)$(HOME)/$$f; \
		done || true; \
	done;

.PHONY: neomutt
neomutt: mutt
	cd $(SYSCONFDIR) && \
	find neomuttrc.d/ -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: sshd
sshd:
	cd $(SYSCONFDIR) && \
	find ssh/sshd* -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;
	service sshd restart;

.PHONY: sudo
sudo:
	cd $(SYSCONFDIR) && \
	find sudo* -type f \
	|while read f; do \
		$(INSTALL) -m 440 -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: vim
vim:
	cd $(SYSCONFDIR) && \
	find vim/ -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;
