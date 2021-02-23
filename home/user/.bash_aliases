_d="$(dirname "${BASH_SOURCE[0]}")";
if [ -d "${_d}/.bash_aliases.d" ]; then
	for f in ${_d}/.bash_aliases.d/*.sh; do
		. "${f}";
	done;
fi;
