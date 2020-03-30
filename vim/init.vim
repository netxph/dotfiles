"plugins
"=======

call plug#begin('~/.local/vim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'easymotion/vim-easymotion'
Plug 'valloric/youcompleteme'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'MaxMEllon/vim-jsx-pretty'

call plug#end()

"display
"=======

colorscheme base16-default-dark
set termguicolors
set ruler
set relativenumber
set number
set title
set visualbell
set autowriteall

"editor
"======

syntax enable
filetype plugin indent on
set encoding=utf-8

let mapleader=","

nnoremap ; :
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright
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

autocmd Filetype typescript set sw=2
autocmd Filetype typescript set ts=2
autocmd Filetype typescriptreact set sw=2
autocmd Filetype typescriptreact set ts=2

set tags=.git/tags

augroup Markdown
  autocmd!
  autocmd FileType markdown set wrap
augroup END

"vim-airline
"===========
let g:airline_powerline_fonts=0

"vim-airline-themes
"==================
let g:airline_solarized_bg='dark'

"gutentags
"=========
let g:gutentags_cache_dir="./.git/"

"ctrl-p
"======
nnoremap <Leader>t :CtrlP<CR>
nnoremap <Leader>. :CtrlPTag<CR>
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

"nerdtree
"========
nnoremap <Leader>` :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

"easymotion
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

"terminal
set splitright
set splitbelow
tnoremap <Esc> <C-\><C-n>
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>
