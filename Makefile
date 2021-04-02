SHELL=/bin/bash

DESTDIR		=

HOMEDIR		= $(CURDIR)/home/user
sysconfdir	= /etc
SYSCONFDIR	= $(CURDIR)/etc


.PHONY: apt
apt:
	@cd $(SYSCONFDIR) && \
	find apt/ -type f \
	|while read -r f; do \
		echo "	INSTALL	$(DESTDIR)$(sysconfdir)/$$f"; \
		install -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: bash
bash:
	@cd $(HOMEDIR) && \
	find .bash* -type f \
	|while read -r f; do \
		echo "	INSTALL	$(DESTDIR)$(HOME)/$$f"; \
		install -DT "$$f" "$(DESTDIR)$(HOME)/$$f"; \
	done;

.PHONY: docker
docker:
	usermod -aG docker $(SUDO_USER);

.PHONY: git
git:
	@cd $(HOMEDIR) && \
	find .git* -type f \
	|while read -r f; do \
		echo "	INSTALL	$(DESTDIR)$(HOME)/$$f"; \
		install -DT "$$f" "$(DESTDIR)$(HOME)/$$f"; \
	done;

.PHONY: groff
groff:
	@cd $(SYSCONFDIR) && \
	find groff/ -type f \
	|while read -r f; do \
		echo "	INSTALL	$(DESTDIR)$(sysconfdir)/$$f"; \
		install -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: hosts
hosts:
	@cd $(SYSCONFDIR) && \
	find hosts -type f \
	|while read -r f; do \
		echo "	INSTALL	$(DESTDIR)$(sysconfdir)/$$f"; \
		install -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: ssh
ssh:
	@cd $(HOMEDIR) && \
	find .ssh* -type f \
	|while read -r f; do \
		echo "	INSTALL	$(DESTDIR)$(HOME)/$$f"; \
		install -DT "$$f" "$(DESTDIR)$(HOME)/$$f"; \
	done;

.PHONY: sshd
sshd:
	@cd $(SYSCONFDIR) && \
	find ssh/sshd* -type f \
	|while read -r f; do \
		echo "	INSTALL	$(DESTDIR)$(sysconfdir)/$$f"; \
		install -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: sudo
sudo:
	@cd $(SYSCONFDIR) && \
	find sudo* -type f \
	|while read -r f; do \
		echo "	INSTALL	$(DESTDIR)$(sysconfdir)/$$f"; \
		install -DT "$$f" "$(DESTDIR)$(sysconfdir)/$$f"; \
	done;

.PHONY: vim
vim:
	@cd $(HOMEDIR) && \
	find .vim* -type f \
	|while read -r f; do \
		echo "	INSTALL	$(DESTDIR)$(HOME)/$$f"; \
		install -DT "$$f" "$(DESTDIR)$(HOME)/$$f"; \
	done;
