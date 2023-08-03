"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"	Alejandro Colomar Andres
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"source /usr/share/vim/vim*/defaults.vim

set colorcolumn=73,81
set nowrap
set hlsearch
set scrolloff=4

syntax on

set nocindent
set nosmartindent
set noautoindent
set indentexpr=
filetype indent off
filetype plugin indent off

au filetype make setlocal noexpandtab

au filetype yaml setlocal expandtab
au filetype yaml setlocal shiftwidth=4
au filetype yaml setlocal softtabstop=4
au filetype yaml setlocal tabstop=5

au bufnewfile,bufread ~/src/linux/man-pages/*/man*/*.[0-9]* setlocal expandtab
au bufnewfile,bufread ~/src/linux/man-pages/*/man*/*.[0-9]* setlocal shiftwidth=4
au bufnewfile,bufread ~/src/linux/man-pages/*/man*/*.[0-9]* setlocal softtabstop=4
au bufnewfile,bufread ~/src/linux/man-pages/*/man*/*.[0-9]* setlocal tabstop=5

au bufnewfile,bufread ~/src/nginx/* setlocal expandtab
au bufnewfile,bufread ~/src/nginx/* setlocal shiftwidth=4
au bufnewfile,bufread ~/src/nginx/* setlocal softtabstop=4
au bufnewfile,bufread ~/src/nginx/* setlocal tabstop=5