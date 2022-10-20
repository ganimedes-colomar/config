[ -v ALX_COREUTILS_SH ] \
	&& return;
ALX_COREUTILS_SH="${BASH_SOURCE[0]}";


alias ll='ls -l';
alias la='ls -la';
alias nauniq='awk '\''!mem[$0]++'\';
