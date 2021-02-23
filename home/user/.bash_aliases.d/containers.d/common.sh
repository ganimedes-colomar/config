########################################################################
#	Copyright (C) 2020        Alejandro Colomar Andres
#	SPDX-License-Identifier:  GPL-2.0-only
########################################################################

[ -v ALX_CONTAINERS_COMMON_SH ] \
	&& return;
ALX_CONTAINERS_COMMON_SH="${BASH_SOURCE[0]}";


_d="$(dirname "${BASH_SOURCE[0]}")";
. "${_d}/../sysexits.sh";


function alx_cp_configs()
{
	if [ $(id -u) -ne 0 ]; then
		>&2 echo "Usage: sudo ${FUNCNAME[0]}";
		return ${EX_NOPERM};
	fi;

	mkdir -pv /run/configs/;
	cp --remove-destination -Lrvt /run/configs/ run/configs/* ||:;
}

function alx_shred_configs()
{
	if [ $(id -u) -ne 0 ]; then
		>&2 echo "Usage: sudo ${FUNCNAME[0]}";
		return ${EX_NOPERM};
	fi;

	local project="$(find run/configs/* -maxdepth 0 | xargs basename)";

	find -L "/run/configs/${project}/" -type f \
	|xargs shred -f --remove=wipe;
	rm -rfv "/run/configs/${project}/";
}

function alx_cp_secrets()
{
	if [ $(id -u) -ne 0 ]; then
		>&2 echo "Usage: sudo ${FUNCNAME[0]}";
		return ${EX_NOPERM};
	fi;

	mkdir -pv /run/secrets/;
	cp --remove-destination -Lrvt /run/secrets/ run/secrets/* ||:;
}

function alx_shred_secrets()
{
	if [ $(id -u) -ne 0 ]; then
		>&2 echo "Usage: sudo ${FUNCNAME[0]}";
		return ${EX_NOPERM};
	fi;

	local project="$(find run/secrets/* -maxdepth 0 | xargs basename)";

	find -L "/run/secrets/${project}/" -type f \
	|xargs shred -f --remove=wipe;
	rm -rfv "/run/secrets/${project}/";
}
