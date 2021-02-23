########################################################################
#	Copyright (C) 2020        Alejandro Colomar Andres
#	SPDX-License-Identifier:  GPL-2.0-only
########################################################################

[ -v ALX_CONFIG_SH ] \
	&& return;
ALX_CONFIG_SH="${BASH_SOURCE[0]}";


_d="$(dirname "${BASH_SOURCE[0]}")";
. "${_d}/sysexits.sh";


function alx_config_set()
{
	local key="$1";
	local val="$2";
	local file="$3";

	if [ $# -ne 3 ]; then
		>&2 echo "Usage: ${FUNCNAME[0]} <key> <value> <file>";
		return ${EX_USAGE};
	fi;

	sed -i "/^#*${key}\b/d" "${file}";
	echo "${key}" "${val}" \
	>>"${file}";
}
