source $VIMRUNTIME/mswin.vim
behave mswin

call plug#begin('~\AppData\Local\nvim\plugged')
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
call plug#end()

"keyboard maps
"=============

let mapleader=","

nnoremap ; :
nnoremap <silent> <F4> :let @*=expand("%:p")<CR>

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


"window
"======

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

"display
"=======

colorscheme base16-default-dark 
set guifont=Fira\ Code\ Retina:h15:cANSI
set background=dark
set ruler
set relativenumber
set number
set title
set noerrorbells
set visualbell
set autowriteall
set guioptions=

"editing
"=======

syntax enable
filetype plugin indent on
set encoding=utf-8

au BufNewFile,BufRead *.cake setlocal ft=cs
au BufNewFile,BufRead *.csx setlocal ft=cs
au FileType javascript setlocal sw=2 sts=2

set tags=.git/tags

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
set notagrelative
set hlsearch
set incsearch

"gutentags
"=========
let g:gutentags_cache_dir="./.git/"

"vim-grepper
"===========
nnoremap <Leader>gp :Grepper<Space>-query<Space>
nnoremap <Leader>gb :Grepper<Space>-buffers<Space>-query<Space>-<Space>

"ctrl-p
"======
nnoremap <Leader>t :CtrlP<CR>
nnoremap <Leader>. :CtrlPTag<CR>

"vim-airline
"===========
let g:airline_powerline_fonts=1

"vim-airline-themes
"==================
let g:airline_solarized_bg='dark'

"vim-markdown
let g:vim_markdown_folding_disabled = 1
