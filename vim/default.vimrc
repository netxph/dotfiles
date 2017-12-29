source $VIMRUNTIME/mswin.vim
behave mswin

let g:python3_host_prog='c:\python3\'
let g:python_host_prog='c:\python\'
let g:ruby_host_prog='c:\ruby\bin\neovim-ruby-host'

"plugins
"=======

call plug#begin('~\AppData\Local\nvim\plugged')

Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'mileszs/ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline-themes'
Plug 'pangloss/vim-javascript'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
Plug 'plasticboy/vim-markdown'
Plug 'pprovost/vim-ps1'

call plug#end()

"keyboard maps
"=============

let mapleader=","

nnoremap ; :
nnoremap <silent> <F4> :let @*=expand("%:p")<CR>

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

au BufNewFile,BufRead *.cake setlocal ft=cs
au BufNewFile,BufRead *.csx setlocal ft=cs

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

"Ack/CtrlP
"=========

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag -l -i --nocolor -g "" %s'
  let g:ctrlp_use_caching = 1
  let g:ackprg = 'ag --vimgrep'
  let g:ctrlp_switch_buffer = 0
endif 

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

nmap <silent> <leader>f :CtrlP<CR>
nmap <silent> <leader>. :CtrlPTag<CR>



