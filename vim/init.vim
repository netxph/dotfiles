"plugins
"=======

call plug#begin('~/.config/nvim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'airblade/vim-rooter'
Plug 'justinmk/vim-sneak'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-startify'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'b3nj5m1n/kommentary'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

"appearance
"==========

colorscheme gruvbox
highlight Normal guibg=none

set background=dark
set termguicolors
set ruler
set relativenumber
set number
set title
set visualbell
set autowriteall

"mappings
"========

command! -nargs=0 Prettier :CocCommand prettier.formatFile

let mapleader=','
nnoremap ; :

nmap <silent> <leader>ve :e $MYVIMRC<CR>
nmap <silent> <leader>vs :so $MYVIMRC<CR>
nmap <silent> <leader>t :NvimTreeToggle<CR>
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>r <Plug>(coc-references)
nmap <silent> <leader>j <Plug>(coc-implementation)
nmap <silent> <leader>. <Plug>(coc-codeaction)
xmap <silent> <leader>. <Plug>(coc-codeaction)
nmap <silent> <leader>= :Prettier<CR>
nmap <silent> <leader>p <Cmd>Telescope find_files<CR>
nmap <silent> <leader>b <Cmd>Telescope buffers<CR>

"editor
"======

runtime mswin.vim
syntax enable

set encoding=utf-8
set fileencoding=utf-8
set pumheight=10
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
set nowritebackup
set noswapfile
set mouse=a
set autoread
set laststatus=2
set notagrelative
set hlsearch
set incsearch
set scrolloff=8
set colorcolumn=80
set signcolumn=yes
set cmdheight=2
set clipboard=unnamedplus
set t_Co=256
set cursorline
set updatetime=300
set timeoutlen=500
set formatoptions-=cro
set showtabline=2
set noshowmode

"fzf
"===

let g:fzf_preview_window = []
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

"coc
"===

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

let g:coc_global_extensions = ['coc-json', 'coc-omnisharp', 'coc-prettier', 'coc-tsserver', 'coc-eslint']

"netrw
"=====

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

"lightline
"=========

let g:lightline = {
  \   'colorscheme': 'gruvbox',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head'
  \   },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
  \ }

let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': '' 
  \}

let g:lightline#bufferline#show_number=2
let g:lightline#bufferline#enable_devicons=1
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline#bufferline#clickable = 1
let g:lightline.component_raw = {'buffers': 1}


"nvim-tree-lua
"=============

let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ }

"coc
"===

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


"treesitter
"==========

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c_sharp", "json", "jsonc", "python", "html", "typescript" }, 
  highlight = {
    enable = true,
  },
}
EOF

"which_key"
"==========

call which_key#register(',', "g:which_key_map")

" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey ','<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual ','<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

let g:which_key_map['t'] = 'explorer' 
let g:which_key_map['d'] = 'goto definition'
let g:which_key_map['r'] = 'find references'
let g:which_key_map['j'] = 'goto implementation'
let g:which_key_map['='] = 'format'
let g:which_key_map['p'] = 'find files'
let g:which_key_map['b'] = 'buffers'
let g:which_key_map['.'] = 'code action'

let g:which_key_map['v'] = {
    \ 'name': '+vimrc',
    \ 'e': 'edit',
    \ 's': 'source'
    \}

let g:which_key_map['_'] = {'name': 'which_key_ignore' }

"sneak"
"=======
let g:sneak#label = 1

"startify"
"=========

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m > NUL')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard > NUL')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

let s:startify_ascii_header = [
 \ '                                        ▟▙            ',
 \ '                                        ▝▘            ',
 \ '██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
 \ '██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
 \ '██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
 \ '██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
 \ '▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
 \ '',
 \]
let g:startify_custom_header = map(s:startify_ascii_header +
        \ startify#fortune#quote(), '"   ".v:val')

"neovide
"=======

let g:neovide_cursor_vfx_mode = 'pixiedust'
set guifont=Hack\ NF:h16
