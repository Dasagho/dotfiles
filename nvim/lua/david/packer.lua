-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	use { "catppuccin/nvim", as = "catppuccin" }
	use {
	  	'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
	  	requires = { {'nvim-lua/plenary.nvim'} }
	}
	use { 'nvim-treesitter/nvim-treesitter', { run = ":TSUpdate" } }
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'L3MON4D3/LuaSnip'},
		}
	}
	use "sindrets/diffview.nvim"
	use 'nvim-tree/nvim-web-devicons'
	-- install without yarn or npm
	use({
	    "iamcco/markdown-preview.nvim",
	    run = function() vim.fn["mkdp#util#install"]() end,
	})
	use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
	use({ "esensar/nvim-dev-container" })
end)
