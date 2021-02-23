########################################################################
#	Copyright (C) 2020        Alejandro Colomar Andres
#	SPDX-License-Identifier:  GPL-2.0-only
########################################################################

[ -v ALX_CONTAINERS_OPENSHIFT_SH ] \
	&& return;
ALX_CONTAINERS_OPENSHIFT_SH="${BASH_SOURCE[0]}";


_d="$(dirname "${BASH_SOURCE[0]}")";
. "${_d}/common.sh";
. "${_d}/kubernetes.sh";


function alx_oc_create_configmaps__()
{
	local	stack="$1";

	local usage="Usage: sudo ${FUNCNAME[0]} <stack>";

	if [ $# -ne 1 ]; then
		>&2 echo "${usage}";
		return ${EX_USAGE};
	fi;
	if [ $(id -u) -ne 0 ]; then
		>&2 echo "${usage}";
		return ${EX_NOPERM};
	fi;

	alx_kube_create_configmaps__ "${stack}" "oc";
}

function alx_oc_create_secrets__()
{
	local	stack="$1";

	local usage="Usage: sudo ${FUNCNAME[0]} <stack>";

	if [ $# -ne 1 ]; then
		>&2 echo "${usage}";
		return ${EX_USAGE};
	fi;
	if [ $(id -u) -ne 0 ]; then
		>&2 echo "${usage}";
		return ${EX_NOPERM};
	fi;

	alx_kube_create_secrets__ "${stack}" "oc";
}

function alx_oc_deploy()
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

	oc new-project "${stack}";
	alx_oc_create_configmaps__	"${stack}";
	alx_oc_create_secrets__		"${stack}";

	find -L "etc/docker/openshift/" -type f \
	|sort \
	|while read -r f; do
		oc apply -f "${f}" -n "${stack}";
	done;
}

function alx_oc_delete()
{
	local stack="$1";

	if [ $# -ne 1 ]; then
		>&2 echo "Usage: ${FUNCNAME[0]} <stack>";
		return ${EX_USAGE};
	fi;

	oc delete project "${stack}";
}
