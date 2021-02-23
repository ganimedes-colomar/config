########################################################################
#	Copyright (C) 2020        Alejandro Colomar Andres
#	SPDX-License-Identifier:  GPL-2.0-only
########################################################################

[ -v ALX_CONTAINERS_SH ] \
	&& return;
ALX_CONTAINERS_SH="${BASH_SOURCE[0]}";

_d="$(dirname "${BASH_SOURCE[0]}")";
. "${_d}/sysexits.sh";
if [ -d "${_d}/containers.d" ]; then
	for f in ${_d}/containers.d/*.sh; do
		. "${f}";
	done;
fi;


function alx_stack_deploy()
{
	local orchestrator="$1";
	local stack="$2";

	local usage="Usage: sudo ${FUNCNAME[0]} swarm|kubernetes|openshift <stack>";

	if [ $# -ne 2 ]; then
		>&2 echo "${usage}";
		return ${EX_USAGE};
	fi;
	if [ $(id -u) -ne 0 ]; then
		>&2 echo "${usage}";
		return ${EX_NOPERM};
	fi;

	case "${orchestrator}" in
	"kubernetes")
		alx_kube_deploy "${stack}";
		;;
	"openshift")
		alx_oc_deploy "${stack}";
		;;
	"swarm")
		alx_swarm_deploy "${stack}";
		;;
	esac;
}

function alx_stack_delete()
{
	local orchestrator="$1";
	local stack="$2";

	if [ $# -ne 2 ]; then
		>&2 echo "Usage: ${FUNCNAME[0]} swarm|kubernetes|openshift <stack>";
		return ${EX_USAGE};
	fi;

	case "${orchestrator}" in
	"kubernetes")
		alx_kube_delete "${stack}";
		;;
	"openshift")
		alx_oc_delete "${stack}";
		;;
	"swarm")
		alx_swarm_delete "${stack}";
		;;
	esac;
}
