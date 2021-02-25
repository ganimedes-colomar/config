########################################################################
#	Copyright (C) 2020        Alejandro Colomar Andres
#	SPDX-License-Identifier:  GPL-2.0-only
########################################################################

[ -v ALX_CONTAINERS_KUBERNETES_SH ] \
	&& return;
ALX_CONTAINERS_KUBERNETES_SH="${BASH_SOURCE[0]}";


_d="$(dirname "${BASH_SOURCE[0]}")";
. "${_d}/common.sh";


function alx_kube_create_configmaps__()
{
	local ns="$1";
	local kubectl="${2:-kubectl}";

	local usage="Usage: sudo ${FUNCNAME[0]} <namespace> [<kubectl>]";

	if [ [ $# -lt 1 ] || [ $# -gt 2 ] ]; then
		>&2 echo "${usage}";
		return ${EX_USAGE};
	fi;
	if [ $(id -u) -ne 0 ]; then
		>&2 echo "${usage}";
		return ${EX_NOPERM};
	fi;

	alx_cp_configs;

	local project="$(find run/configs/* -maxdepth 0 | xargs basename)";

	find -L "/run/configs/${project}/" -type f \
	|while read -r f; do
		echo "${f}" \
		|sed "s%^/run/configs/${project}/%%" \
		|tr '/._' '[-*]' \
		|sed "s/$/-${project}-cm/" \
		|xargs -I 'cm' \
		 ${kubectl} create configmap 'cm' --from-file ${f} -n "${ns}";
	done;

	alx_shred_configs;
}

function alx_kube_create_secrets__()
{
	local namespace="$1";
	local kubectl="${2:-kubectl}";

	local usage="Usage: sudo ${FUNCNAME[0]} <namespace> [<kubectl>]";

	if [ [ $# -lt 1 ] || [ $# -gt 2 ] ]; then
		>&2 echo "${usage}";
		return ${EX_USAGE};
	fi;
	if [ $(id -u) -ne 0 ]; then
		>&2 echo "${usage}";
		return ${EX_NOPERM};
	fi;

	alx_cp_secrets;

	local project="$(find run/secrets/* -maxdepth 0 | xargs basename)";

	find -L "/run/secrets/${project}/" -type f \
	|while read -r f; do
		echo "${f}" \
		|sed "s%^/run/secrets/${project}/%%" \
		|tr '/._' '[-*]' \
		|sed "s/$/-${project}-secret/" \
		|xargs -I 'sec' \
		 ${kubectl} create secret generic 'sec' --from-file ${f} -n "${ns}";
	done;

	alx_shred_secrets;
}

function alx_kube_deploy()
{
	local ns="$1";
	local kubectl="${2:-kubectl}";

	local usage="Usage: sudo ${FUNCNAME[0]} <namespace> [<kubectl>]";

	if [ [ $# -lt 1 ] || [ $# -gt 2 ] ]; then
		>&2 echo "${usage}";
		return ${EX_USAGE};
	fi;
	if [ $(id -u) -ne 0 ]; then
		>&2 echo "${usage}";
		return ${EX_NOPERM};
	fi;

	${kubectl} create namespace "${ns}";
	alx_kube_create_configmaps__	"${ns}" "${kubectl}";
	alx_kube_create_secrets__	"${ns}" "${kubectl}";

	find -L "etc/docker/kubernetes/" -type f \
	|sort \
	|while read -r f; do
		${kubectl} apply -f "${f}" -n "${ns}";
	done;
}

function alx_kube_delete()
{
	local ns="$1";
	local kubectl="${2:-kubectl}";

	if [ [ $# -lt 1 ] || [ $# -gt 2 ] ]; then
		>&2 echo "Usage: ${FUNCNAME[0]} <namespace> [<kubectl>]";
		return ${EX_USAGE};
	fi;

	${kubectl} delete namespace "${ns}";
}
