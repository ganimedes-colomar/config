##########################################################################
##	Alejandro Colomar Andres					##
##########################################################################

##########################################################################
##	Exit status
EX_OK=0;

EX_USAGE=64;

##########################################################################
##	Printer
alias lp2s='lp -o sides=two-sided-long-edge -o collate=true';

##########################################################################
##	Linux kernel
function grep_syscall()
{
	if ! [ -v 1 ]; then
		>&2 echo "Usage: ${FUNCNAME[0]} <syscall>";
		return ${EX_USAGE};
	fi

	find * -type f \
	|grep '\.c$' \
	|sort -V \
	|xargs pcregrep -Mn "(?s)^\w*SYSCALL_DEFINE.\(${1},.*?\)" \
	|sed -E 's/^[^:]+:[0-9]+:/&\n/';

	find * -type f \
	|grep '\.h$' \
	|sort -V \
	|xargs pcregrep -Mn "(?s)^asmlinkage \w+ \**sys_${1}\(.*?\)" \
	|sed -E 's/^[^:]+:[0-9]+:/&\n/';
}

function grep_syscall_def()
{
	if ! [ -v 1 ]; then
		>&2 echo "Usage: ${FUNCNAME[0]} <syscall>";
		return ${EX_USAGE};
	fi

	find * -type f \
	|grep '\.c$' \
	|sort -V \
	|xargs pcregrep -Mn "(?s)^\w*SYSCALL_DEFINE.\(${1},.*?^}" \
	|sed -E 's/^[^:]+:[0-9]+:/&\n/';
}

##########################################################################
##	Linux man-pages
function man_section()
{
	if ! [ -v 2 ]; then
		>&2 echo "Usage: ${FUNCNAME[0]} <dir> <section>";
		return ${EX_USAGE}
	fi

	find "${1}" -type f \
	|xargs grep -l "\.SH ${2}" \
	|sort -V \
	|while read -r manpage; do
		<${manpage} \
		sed -n \
			-e '/^\.TH/,/^\.SH/{/^\.SH/!p}' \
			-e "/^\.SH ${2}/p" \
			-e "/^\.SH ${2}/,/^\.SH/{/^\.SH/!p}" \
		|man -P cat -l - 2>/dev/null;
	done \
;#	|pager;
}

function pdfman()
{
	if ! [ -v 1 ]; then
		>&2 echo "Usage: ${FUNCNAME[0]} <man-page.n>";
		return ${EX_USAGE};
	fi;

	man -Tps -l ${1} \
	|ps2pdf - - \
	|zathura -;
}

##########################################################################
##
function grep_syscall_wrapper()
{
	if ! [ -v 1 ]; then
		>&2 echo "Usage: ${FUNCNAME[0]} <syscall>";
		return ${EX_USAGE};
	fi

	find * -type f \
	|grep '\.h$' \
	|sort -V \
	|xargs pcregrep -Mn \
		"^[^\s][\w\s]+\s+\**${1}\s*\((?s)[\w\s()*,]*?(...)?\)[\w\s()]*;" \
	|sed -E 's/^[^:]+:[0-9]+:/&\n/';
}

##########################################################################
##########################################################################
