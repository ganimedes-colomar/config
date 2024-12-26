unset $(set | grep '^ALX_' | cut -f1 -d=);

ALX_BASH_ALIASES="${BASH_SOURCE[0]}";

_d="$(dirname "${BASH_SOURCE[0]}")";
if [ -d "${_d}/.bash_aliases.d" ]; then
	for f in ${_d}/.bash_aliases.d/*.sh; do
		. "${f}";
	done;
fi;

if [ -f /srv/src/linux/man-pages/man-pages/main/scripts/bash_aliases ]; then
	. /srv/src/linux/man-pages/man-pages/main/scripts/bash_aliases;
fi;
