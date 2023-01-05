[ -v ALX_MAN_SH ] \
	&& return;
ALX_MAN_SH="${BASH_SOURCE[0]}";


function man()
{
	if command man "$@"; then
		command man --warnings=w "$@" >/dev/null;
	fi;
}
