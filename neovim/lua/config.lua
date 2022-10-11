-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
	ensure_installed = "all",
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true
	}
}

require('lualine').setup {
	options = { theme = 'gruvbox-material' }
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
	v = {
		name = "Configure",
		e = { "Open" },
		s = { "Apply" }
	}
}, { prefix = "<leader>" })

wk.setup()

require('hop').setup()

require('Comment').setup()

require('navigator').setup({
	lsp = {
		code_lens_action = {
			enable = false 
		},
		code_action = {
			virtual_text = false
		}
	}
})

vim.notify = function(msg, log_level, _opts)
	if msg:match("exit code") then
		return
	end
	if log_level == vim.log.levels.ERROR then
		vim.api.nvim_err_writeln(msg)
	else
		vim.api.nvim_echo({{msg}}, true, {})
	end
end

local w = vim.loop.new_fs_event()
local function on_change(err, fname, status)
	-- Do work...
	vim.api.nvim_command('checktime')
	-- Debounce: stop/start.
	w:stop()
	watch_file(fname)
end
function watch_file(fname)
	local fullpath = vim.api.nvim_call_function(
	'fnamemodify', {fname, ':p'})
	w:start(fullpath, {}, vim.schedule_wrap(function(...)
		on_change(...) end))
	end
	vim.api.nvim_command(
	"command! -nargs=1 Watch call luaeval('watch_file(_A)', expand('<args>'))")

require("todo-comments").setup({
	keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO", "REFACTOR" } },
    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
  },
})

local db = require('dashboard')
db.custom_header = {
[[                                        ▟▙              ]],
[[                                        ▝▘              ]],
[[ ██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖ ]],
[[ ██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██ ]],
[[ ██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██ ]],
[[ ██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██ ]],
[[ ▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀ ]],
[[                                                        ]],
[[                                                        ]]
}
db.custom_center = {
      {icon = '  ',
      desc = 'Find  File                              ',
      action = 'Telescope find_files',
      },
      {icon = '  ',
      desc = 'Find  word                              ',
      action = 'Telescope live_grep',
      }
    }

require("bufferline").setup()
