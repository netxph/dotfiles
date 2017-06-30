source $VIMRUNTIME/mswin.vim
behave mswin

let g:python3_host_prog='c:\Python36\'
let g:python_host_prog='c:\Python27\'

"plugins
"=======

call plug#begin('~\AppData\Local\nvim\plugged')

Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neco-syntax'

call plug#end()

"keyboard maps
"=============

let mapleader=","

nnoremap ; :

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"display
"=======

colorscheme base16-default-dark 
set background=dark
set ruler
set relativenumber
set number
set title
set noerrorbells
set visualbell
set autowriteall

"editing
"=======

syntax enable
filetype plugin indent on

set hidden
set diffopt+=iwhite
set diffexpr=""
set nowrap
set tabstop=4
set backspace=indent,eol,start
set smartindent
set autoindent
set copyindent
set shiftwidth=4
set expandtab
set shiftround
set showmatch
set ignorecase
set smartcase
set smarttab
set history=1000
set undolevels=1000
set nobackup
set noswapfile
set mouse=a
set autoread
set laststatus=2
