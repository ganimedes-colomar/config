########################################################################
#	Copyright (C) 2020        Alejandro Colomar Andres
#	SPDX-License-Identifier:  GPL-2.0-only
########################################################################

[ -v ALX_PRINT_SH ] \
	&& return;
ALX_PRINT_SH="${BASH_SOURCE[0]}";


alias lp2s='lp -o sides=two-sided-long-edge -o collate=true';
