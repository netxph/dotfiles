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

	use {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	use {
		'ray-x/navigator.lua', 
	 	requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}
	}

	use {
		'akinsho/bufferline.nvim',
		requires = { 'kyazdani42/nvim-web-devicons' }
 	}

	use {
		'nvim-neo-tree/neo-tree.nvim',
		branch = "v2.x",
		requires = { 
		'nvim-lua/plenary.nvim',
		'kyazdani42/nvim-web-devicons',
		'MunifTanjim/nui.nvim',
    }
  }

	use 'lewis6991/gitsigns.nvim'
	use 'wbthomason/packer.nvim'
	use 'ellisonleao/gruvbox.nvim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'folke/which-key.nvim'
	use 'phaazon/hop.nvim'
	use 'numToStr/Comment.nvim'
	use 'glepnir/dashboard-nvim'
end)
