########################################################################
#	Copyright (C) 2020        Alejandro Colomar Andres
#	SPDX-License-Identifier:  GPL-2.0-only
########################################################################

[ -v ALX_SCAN_SH ] \
	&& return;
ALX_SCAN_SH="${BASH_SOURCE[0]}";


alias scan-adf='hp-scan --dest pdf --adf -o';
alias scan-adf2='hp-scan --dest pdf --adf --duplex -o';
alias scan-fb='hp-scan --dest pdf -o';
