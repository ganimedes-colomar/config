########################################################################
#	Copyright (C) 2020        Alejandro Colomar Andres
#	SPDX-License-Identifier:  GPL-2.0-only
########################################################################

[ -v ALX_CONTAINERS_SWARM_SH ] \
	&& return;
ALX_CONTAINERS_SWARM_SH="${BASH_SOURCE[0]}";


_d="$(dirname "${BASH_SOURCE[0]}")";
. "${_d}/../sysexits.sh";
. "${_d}/common.sh";


function alx_swarm_deploy()
{
	local stack="$1";

	local usage="Usage: sudo ${FUNCNAME[0]} <stack>";

	if [ $# -ne 1 ]; then
		>&2 echo "${usage}";
		return ${EX_USAGE};
	fi;
	if [ $(id -u) -ne 0 ]; then
		>&2 echo "${usage}";
		return ${EX_NOPERM};
	fi;

	alx_cp_configs;
	alx_cp_secrets;

	docker stack deploy -c "etc/docker/swarm/compose.yaml" "${stack}";

	alx_shred_secrets;
	alx_shred_configs;
}

function alx_swarm_delete()
{
	local stack="$1";

	if [ $# -ne 1 ]; then
		>&2 echo "Usage: ${FUNCNAME[0]} <stack>";
		return ${EX_USAGE};
	fi;

	docker stack rm "${stack}";
}
