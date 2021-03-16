SHELL=/bin/bash

DESTDIR	=

.PHONY: apt
apt:
	find etc/apt/ -type f \
	|while read -r f; do \
		install -DT "$$f" "$(DESTDIR)/$$f"; \
	done;

.PHONY: bash
bash:
	cd home/user/; \
	find .bash* -type f \
	|while read -r f; do \
		install -DT "$$f" "$(DESTDIR)$(HOME)/$$f"; \
	done;

.PHONY: docker
docker: | containers
	usermod -aG docker $(SUDO_USER);

.PHONY: git
git:
	cd home/user/; \
	find .git* -type f \
	|while read -r f; do \
		install -DT "$$f" "$(DESTDIR)$(HOME)/$$f"; \
	done;

.PHONY: groff
groff:
	find etc/groff/ -type f \
	|while read -r f; do \
		install -DT "$$f" "$(DESTDIR)/$$f"; \
	done;

.PHONY: hosts
hosts:
	find etc/hosts -type f \
	|while read -r f; do \
		install -DT "$$f" "$(DESTDIR)/$$f"; \
	done;

.PHONY: sshd
sshd:
	find etc/ssh/sshd* -type f \
	|while read -r f; do \
		install -DT "$$f" "$(DESTDIR)/$$f"; \
	done;

.PHONY: sudo
sudo:
	find etc/sudo* -type f \
	|while read -r f; do \
		install -DT "$$f" "$(DESTDIR)/$$f"; \
	done;

.PHONY: vim
vim:
	cd home/user/; \
	find .vim* -type f \
	|while read -r f; do \
		install -DT "$$f" "$(DESTDIR)$(HOME)/$$f"; \
	done;
