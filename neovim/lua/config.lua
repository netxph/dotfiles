-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  sync_install = false,
  highlight = {
	  enable = true,
	  additional_vim_regex_highlighting = true
  }
}

-- lualine
require('lualine').setup {
	options = {
		theme = 'gruvbox-material'
	}
}

local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },
  sources = {
    { name = 'nvim_lsp' },
  }
}

require'lspconfig'.omnisharp.setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
  cmd = { "omnisharp", "--languageserver" , "--hostPID", tostring(pid) },
}

local wk = require('which-key')

wk.register({
  p = {
    name = "Open",
  },
}, { prefix = "<leader>" })

wk.register({
  g = {
    name = "Goto",
	r = { "References" },
	d = { "Definition" }
  },
  f = {
    name = "Find",
	g = { "Grep" },
	b = { "Buffers" },
	h = { "Help" }
  },
}, { prefix = "<leader>" })

wk.setup()

require('hop').setup()

require('Comment').setup()

require('navigator').setup()
