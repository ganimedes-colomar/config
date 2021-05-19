"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	Alejandro Colomar Andres					"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load VIM defaults
"source	/usr/share/vim/vim*/defaults.vim

" Show margin
set	colorcolumn=81

" Don't wrap lines visually
set	nowrap

" Enables syntax highlighting
syntax	on

" Switch off all auto-indenting
set		nocindent
set		nosmartindent
set		noautoindent
set		indentexpr=
filetype	indent off
filetype	plugin indent off

" YAML only works with spaces :(
au filetype yaml	setlocal expandtab
au filetype yaml	setlocal shiftwidth=8
au filetype yaml	setlocal softtabstop=8
au filetype yaml	setlocal tabstop=8
