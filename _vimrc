set nocompatible

execute pathogen#infect('d:/users/vitalim/projects/git/vim/{}')

source $VIMRUNTIME/mswin.vim
behave mswin

" Windows
set guifont=Consolas:h11:cANSI
au GUIEnter * simalt ~x

au BufRead,BufNewFile *.cshtml setfiletype html
au BufRead,BufNewFile *.xaml setfiletype xml

" if &t_Co >= 256 || has("gui_running")
   " autocmd GUIEnter * set vb t_vb=
   " colorscheme vividchalk
" endif
"
syntax enable
colorscheme solarized
set background=dark

if !has('gui_running')
endif


if &t_Co > 2 || has("gui_running")
   " switch syntax highlighting on, when the terminal has colors
   autocmd GUIEnter * set vb t_vb=
   syntax on
endif

autocmd BufNewFile,BufReadPost *.md set filetype=markdown

let mapleader=","

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>f :CtrlP<CR>
nmap <silent> <leader>. :CtrlPTag<CR>
nmap <silent> <leader>e :NERDTree<CR>
nmap <silent> <leader>t :TagbarToggle<CR>
nmap <silent> <leader>wd :update<CR>:e ++ff=unix<CR>:setlocal ff=dos<CR>:w<CR>
nmap <silent> <leader>wu :update<CR>:e ++ff=dos<CR>:setlocal ff=unix<CR>:w<CR>
nmap <silent> <leader>wc :1,1000bd<CR>
nmap <silent> <leader>q :cope<CR>
nmap <silent> <leader>qq :ccl<CR>

nnoremap ; :
nnoremap <C-S-B> :Make!<CR>
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
nnoremap <C-l> :nohl<CR><C-l>
nnoremap <A-[> :bprevious<CR>
nnoremap <A-]> :bnext<CR>
nnoremap <silent> <F4> :let @*=expand("%:p")<CR>
nnoremap <Leader>vs :cabbrev vsedit :!"c:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe" /edit "%"<CR>

nnoremap j gj
nnoremap k gk

nnoremap <Leader>q" ciw""<Esc>P
nnoremap <Leader>q' ciw''<Esc>P
nnoremap <Leader>qd daW"=substitute(@@,"'\\\|\"","","g")<CR>P

nmap <silent> <leader>pp :colorscheme mayansmoke<CR>:TOhtml<CR>:w! print.html<CR>:bd!<CR>:colorscheme solarized<CR>:set background=dark<CR>:!start /B print.html<CR>

" settings
setlocal ff=dos
set hidden

set diffopt+=iwhite
set diffexpr=""

set nowrap
set nowrap
set ruler
set tabstop=4
set backspace=indent,eol,start
set relativenumber

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
set guioptions-=m
set guioptions-=l
set guioptions-=r
set guioptions-=b
set nobackup
set noswapfile

set pastetoggle=<F2>
set mouse=a
set autoread
set laststatus=2

set visualbell
set autowriteall

set errorformat=\ %#%f(%l\\\,%c):\ %m
set makeprg=msbuild\ /nologo\ /v:q\ /property:GenerateFullPaths=true\ /clp:ErrorsOnly\ /m:4
"set makeprg=msbuild\ /nologo\ /v:q\ /property:GenerateFullPaths=true

filetype plugin indent on 
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_user_command = 'ag %s -l -i --nocolor -g "" --ignore=*.xml'
let g:ctrlp_match_window = 'min:4,max:10,results:30'

let html_number_lines = 0
let html_no_pre = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"autocmd BufWritePost *.cs
      "\ if filereadable('tags') |
      "\     call system('ctags -a '.expand('%')) |
      "\ endif

