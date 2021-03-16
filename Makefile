DESTDIR?=

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
	find usr/local/bin/alx_swarm_* -type f \
	|while read -r f; do \
		install -DT "$$f" "$(DESTDIR)/$$f"; \
	done;

.PHONY: containers
containers:
	find usr/local/bin/alx_{containers,stack}_* -type f \
	|while read -r f; do \
		install -DT "$$f" "$(DESTDIR)/$$f"; \
	done;

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

.PHONY: kubernetes
kubernetes: | containers
	find usr/local/bin/alx_kube_* -type f \
	|while read -r f; do \
		install -DT "$$f" "$(DESTDIR)/$$f"; \
	done;

.PHONY: oc
oc: | containers kubernetes
	find usr/local/bin/alx_oc_* -type f \
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
