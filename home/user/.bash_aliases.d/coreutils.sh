[ -v ALX_COREUTILS_SH ] \
	&& return;
ALX_COREUTILS_SH="${BASH_SOURCE[0]}";


alias nauniq='awk '\''!mem[$0]++'\';
