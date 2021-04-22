#!/usr/bin/make -f
SHELL	= /bin/bash -Eeuo pipefail

DESTDIR		=

HOMEDIR		= $(CURDIR)/home/user
sysconfdir	= /etc
SYSCONFDIR	= $(CURDIR)/etc

INSTALL_OPTS	= -v
INSTALL		= install $(INSTALL_OPTS)
INSTALL_DATA	= $(INSTALL) -m 644
INSTALL_DIR	= $(INSTALL) -m 755 -d

remotes	= \
	builder0 \
	builder1 \
	builder2 \
	manager0 \
	manager1 \
	manager2 \
	worker0 \
	worker1 \
	worker2

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

.PHONY: docker
docker:
	usermod -aG docker $(SUDO_USER);

.PHONY: docker-contexts
docker-contexts:
	for c in $(remotes); do \
		r="ssh://$${c}.alejandro-colomar.es"; \
		echo "	DOCKER context	$$c $$r"; \
		docker context create "$$c" --docker "host=$$r" >/dev/null ||:; \
	done;

.PHONY: git
git:
	cd $(HOMEDIR) && \
	find .git* -type f \
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

.PHONY: hosts
hosts:
	cd $(SYSCONFDIR) && \
	find hosts -type f \
	|while read f; do \
		sed '/# alejandro-colomar.es\s*BEGIN/,/# alejandro-colomar.es\s*END/d' \
			-i "$(DESTDIR)$(sysconfdir)/$$f" ||:; \
		cat "$(SYSCONFDIR)/$$f" >> "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: ssh
ssh:
	cd $(HOMEDIR) && \
	find .ssh/ -type f \
	|while read f; do \
		sed '/# alejandro-colomar.es\s*BEGIN/,/# alejandro-colomar.es\s*END/d' \
			-i "$(DESTDIR)$(HOME)/$$f" ||:; \
		cat "$(HOMEDIR)/$$f" >> "$(DESTDIR)$(HOME)/$$f"; \
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
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: vim
vim:
	cd $(HOMEDIR) && \
	find .vim* -type f \
	|while read f; do \
		$(INSTALL_DATA) -DT "$$f" "$(DESTDIR)$(HOME)/$$f"; \
	done;
