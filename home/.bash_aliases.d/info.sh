########################################################################
#	This is in the public domain
########################################################################

[ -v ALX_INFO_SH ] \
	&& return;
ALX_INFO_SH="${BASH_SOURCE[0]}";


#  infoless  shows info manuals in less, which allows usual navigation.
# Usage example:  $ infoless bash;

function infoless()
{
	info $@ | less;
}
