local o = vim.o
local wo = vim.wo
local bo = vim.bo

o.background = 'dark'
vim.cmd([[colorscheme gruvbox]])

o.termguicolors = true
o.ruler = true
o.title = true
o.visualbell = true
o.autowriteall = true
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'
o.pumheight = 10
o.splitbelow = true
o.splitright = true
o.hidden = true
o.diffexpr = ""
o.backspace = [[indent,eol,start]]
o.shiftround = true
o.showmatch = true
o.ignorecase = true
o.smartcase = true
o.smarttab = true
o.history = 1000
o.undolevels = 1000
o.backup = false
o.writebackup = false
o.swapfile = false
o.mouse = 'a'
o.autoread = true
o.laststatus = 2
o.tagrelative = false
o.hlsearch = true
o.incsearch = true
o.scrolloff = 8
o.cmdheight = 2
o.clipboard = 'unnamedplus'
o.updatetime = 300
o.showtabline = 2
o.showmode = false
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4

wo.wrap = false
wo.number = true
wo.relativenumber = true
wo.colorcolumn = '80'
wo.signcolumn = 'yes'
wo.cursorline = true

bo.smartindent = true
bo.autoindent = true
bo.copyindent = true
bo.expandtab = true
bo.formatoptions = 'tqnj'



vim.opt.diffopt = vim.opt.diffopt + "iwhite"
