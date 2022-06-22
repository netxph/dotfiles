vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use {
		'ray-x/navigator.lua', 
		requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}
	}

	use 'wbthomason/packer.nvim'
	use 'gruvbox-community/gruvbox'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'folke/which-key.nvim'
	use 'phaazon/hop.nvim'
	use 'numToStr/Comment.nvim'
	use 'glepnir/dashboard-nvim'
end)
