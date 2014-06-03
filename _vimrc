set nocompatible

execute pathogen#infect('/home/netxph/Projects/vim/{}')

source $VIMRUNTIME/mswin.vim
behave mswin

" windows only
" set guifont=Consolas:h10:cANSI

au BufRead,BufNewFile *.cshtml setfiletype html

if &t_Co >= 256 || has("gui_running")
   colorscheme vividchalk
endif

if &t_Co > 2 || has("gui_running")
   " switch syntax highlighting on, when the terminal has colors
   syntax on
endif

let mapleader=","

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>f :CtrlP<CR>

nnoremap ; :
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
nnoremap <C-l> :nohl<CR><C-l>
nnoremap <A-[> :bprevious<CR>
nnoremap <A-]> :bnext<CR>

nnoremap j gj
nnoremap k gk

" settings
set hidden

set nowrap
set nowrap
set ruler
set tabstop=4
set backspace=indent,eol,start

set smartindent
set autoindent
set copyindent
set number
set shiftwidth=4
set expandtab
set shiftround
set showmatch
set ignorecase
set smartcase

set smarttab

set hlsearch
set incsearch

set history=1000
set undolevels=1000
set title
set noerrorbells

set guioptions-=T
set nobackup
set noswapfile

set pastetoggle=<F2>
set mouse=a

filetype plugin indent on

"CTRLP + Ag
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif
