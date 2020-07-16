"plugins
"=======

call plug#begin('~/.config/nvim/plugged')

Plug 'haishanh/night-owl.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"appearance
"==========

colorscheme night-owl
let g:lightline = { 'colorscheme': 'nightowl' }

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
syntax on
filetype plugin indent on
set encoding=utf-8

runtime mswin.vim

let mapleader=','

nnoremap ; :
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>t :FZF<CR>
nmap <silent> <leader>g :GFiles<CR>
nmap <silent> <leader>b :Buffers<CR>
nmap <silent> <leader>f :Rg! 

inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"


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

"python
"======

au BufNewFile,BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4

let g:ale_python_flake8_executable = 'python3'
let g:ale_linters = {'python': ['pylint', 'flake8', 'yapf']}
let g:coc_global_extensions=[ 'coc-omnisharp' ]
