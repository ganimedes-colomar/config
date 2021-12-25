"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	Alejandro Colomar Andres
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"source /usr/share/vim/vim*/defaults.vim

set colorcolumn=81
set nowrap

syntax on

set nocindent
set nosmartindent
set noautoindent
set indentexpr=
filetype indent off
filetype plugin indent off

au filetype yaml setlocal expandtab
au filetype yaml setlocal shiftwidth=8
au filetype yaml setlocal softtabstop=8
au filetype yaml setlocal tabstop=40

au bufnewfile,bufread ~/src/nginx/* setlocal expandtab
au bufnewfile,bufread ~/src/nginx/* setlocal shiftwidth=4
au bufnewfile,bufread ~/src/nginx/* setlocal softtabstop=4
au bufnewfile,bufread ~/src/nginx/* setlocal tabstop=40
