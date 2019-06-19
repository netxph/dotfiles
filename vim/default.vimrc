source $VIMRUNTIME/mswin.vim
behave mswin

"plugins
"=======
call plug#begin('~\AppData\Local\nvim\plugged')

Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'mhinz/vim-grepper'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim', { 'on': 'VimFiler' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'w0rp/ale'
Plug 'OmniSharp/omnisharp-vim'
Plug 'roxma/vim-hug-neovim-rpc'

call plug#end()

"inits
"=====
let g:python3_host_prog='c:\programdata\anaconda3\python.exe'

"keyboard maps
"=============

let mapleader=","

nnoremap ; :
nnoremap <silent> <F4> :let @*=expand("%:p")<CR>

nmap <silent> <leader>ev :e C:/users/vitalism/Projects/dotfiles/vim/default.vimrc<CR>
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
set guifont=Consolas:h14
set termguicolors
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
set encoding=utf8

au BufNewFile,BufRead *.cake setlocal ft=cs
au BufNewFile,BufRead *.csx setlocal ft=cs
au FileType javascript setlocal sw=2 sts=2

set tags=.git/tags

set hidden
set diffopt+=iwhite
set diffexpr=""

set nowrap
autocmd FileType markdown setlocal wrap

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
set history=100
set undolevels=100
set nobackup
set noswapfile
set mouse=a
set autoread
set laststatus=2
set notagrelative
set hlsearch
set incsearch
set conceallevel=1
set noerrorbells
set scrolloff=1
set sidescrolloff=5
set showtabline=1
set clipboard=unnamed


"vim-solarized8
"==============
set background=dark
colorscheme solarized8_flat

"vim-airline
"===========
let g:airline_powerline_fonts=1
set laststatus=2

"vim-airline-themes
"==================
let g:airline_solarized_bg='dark'

"ctrl-p
"======
nnoremap <Leader>t :CtrlP<CR>
nnoremap <Leader>. :CtrlPTag<CR>

"vim-grepper
"===========
nnoremap <Leader>gp :Grepper<Space>-query<Space>
nnoremap <Leader>gb :Grepper<Space>-buffers<Space>-query<Space>-<Space>

"vim-filer
"=========
map ` :VimFiler -explorer<CR>
map ~ :VimFilerCurrentDir -explorer -find<CR>

let g:vimfiler_safe_mode_by_default = 0

"deoplete
"========
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"gutentags
"=========
let g:gutentags_cache_dir="./.git/"

"OmniSharp
"=========
let g:OmniSharp_selector_ui = 'ctrlp'
let g:OmniSharp_timeout = 10

set completeopt=longest,menuone,preview
set previewheight=5
"let g:ale_linters = { 'cs': ['OmniSharp'] }
let g:OmniSharp_highlight_types = 1

augroup omnisharp_commands
    autocmd!

    " When Syntastic is available but not ALE, automatic syntax check on events
    " (TextChanged requires Vim 7.4)
    " autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " Update the highlighting whenever leaving insert mode
    autocmd InsertLeave *.cs call OmniSharp#HighlightBuffer()

    " Alternatively, use a mapping to refresh highlighting for the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>th :OmniSharpHighlightTypes<CR>

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>
