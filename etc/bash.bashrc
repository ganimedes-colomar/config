# alx BEGIN
export GPG_TTY="$(tty)";
export HISTTIMEFORMAT="%F %T%z ";

if [ -f ~/src/linux/man-pages/man-pages/main/scripts/bash_aliases ]; then
	. ~/src/linux/man-pages/man-pages/main/scripts/bash_aliases;
fi;
# alx END
