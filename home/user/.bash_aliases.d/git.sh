########################################################################
#	Copyright (C) 2020        Alejandro Colomar Andres
#	SPDX-License-Identifier:  GPL-2.0-only
########################################################################

[ -v ALX_GIT_SH ] \
	&& return;
ALX_GIT_SH="${BASH_SOURCE[0]}";


#  alx_gitstaged  prints a list of all files with changes staged for commit,
# separated by ", ".
# Usage example:  $ git commit -m "$(alx_gitstaged): msg";

function alx_gitstaged()
{
	git diff --staged --name-only					\
	|sed "s/$/, /"							\
	|tr -d '\n'							\
	|sed "s/, $//"
}
