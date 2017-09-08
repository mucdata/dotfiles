source ~/.vimrc_shared

" your own settings that you do not want to publish in the git repository go
" here... mostly these can be hacks like the following...
set makeprg=make\ \-j3\ hlib
set makeprg=screen\ -S\ left\ -X\ stuff\ '\\033OA\\r'

" feel free to change anything here...
set background=light

colorscheme desert
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'pythoncomplete'
Plugin 'pangloss/vim-javascript'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
set ruler
set showmatch
set showmode

set modelines=0
set smarttab
set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smartindent
set nowritebackup
set showcmd
set statusline=%F%m%r%h\ [FORMAT={%ff}]\ [TYPE=%Y]\ [POS=%04l,%04v]
set ff=unix
" set encoding=utf-8
set encoding=latin1
set nu
" set nofoldenable
set foldmethod=syntax
set autoread
set wildignore+=*.o,*.obj,*.cmi,*.cmo,*.cma,*.cmx,*.a,*.cmxa,*.rem,*.lib,*.dll,*.exe
set wildignore+=*.aux,*.blg,*.dvi,*.log,*.pdf,*.ps,*.eps
" disable expandtab for makefiles, so that command lines start with a \t
autocmd BufRead,BufWrite,BufNew *.mak set noexpandtab
autocmd BufRead,BufWrite,BufNew [mM]akefile* set noexpandtab
" files with name make.ti_c6x... are not recognized as makefiles
autocmd BufRead [mM]ake* set syntax=make

" commenting/uncommenting
au FileType vim let b:comment_leader = '" '
au FileType c,cpp,java let b:comment_leader = '// '
au FileType sh,make,perl,python,cmake let b:comment_leader = '# '
au FileType tex let b:comment_leader = '% '
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

" python
au BufRead,BufNewFile *.py call SetPythonOptions()
function SetPythonOptions()
  map <S-F5> <ESC>:w<CR>:!python %<CR>
  noremap X :!pydoc <cword><cr>
  set foldmethod=indent
  set shiftwidth=4
  set tabstop=4
  set expandtab
  " remove trailing spaces on save
  autocmd BufWritePre * :%s/\s\+$//e
endfunction

set hlsearch
nmap <F8> :TagbarToggle<CR>
