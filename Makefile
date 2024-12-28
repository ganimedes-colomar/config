#!/usr/bin/make -f
SHELL	= /bin/bash -Eeuo pipefail

DESTDIR		=

HOMEDIR		= $(CURDIR)/home
sysconfdir	= /etc
SYSCONFDIR	= $(CURDIR)/etc

INSTALL_OPTS	= -v
INSTALL		= install $(INSTALL_OPTS)
INSTALL_DATA	= $(INSTALL) -m 644
INSTALL_DIR	= $(INSTALL) -m 755 -d

.PHONY: apt
apt:
	cd $(SYSCONFDIR) && \
	find apt/ -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: bash
bash:
	cd $(HOMEDIR) && \
	find .bash* -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(HOME)/$$f"; \
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
	done;

.PHONY: mutt
mutt:
	cd $(SYSCONFDIR) && \
	find mutt/ -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;
	cd $(SYSCONFDIR) && \
	find Muttrc neomuttrc -type f \
	|while read f; do \
		sed '/# alx\s*BEGIN/,/# alx\s*END/d' \
			-i "$(DESTDIR)$(sysconfdir)/$$f" ||:; \
		cat "$(SYSCONFDIR)/$$f" >> "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: mutt.home
mutt.home:
	cd $(HOMEDIR) && \
	find .config/mutt/ -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(HOME)/$$f"; \
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
