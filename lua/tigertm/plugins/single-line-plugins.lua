local plugins = {
	{ "ThePrimeagen/harpoon" },
	{ "mbbill/undotree" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ 'echasnovski/mini.nvim', version = false },
	{ "folke/neodev.nvim", opts = {} },
	{ 'stevearc/dressing.nvim',opts = {} },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.1', dependencies = { 'nvim-lua/plenary.nvim' } },
	{ 'akinsho/bufferline.nvim', version = "*", dependencies = {"kyazdani42/nvim-web-devicons", opt = true} },
	{ "nvim-lualine/lualine.nvim", dependencies = {"kyazdani42/nvim-web-devicons", opt = true} },
	{ "saecki/crates.nvim",	config = function () require("crates").setup() end },
	{ "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end },
	{ "kevinhwang91/nvim-ufo", dependencies = {"kevinhwang91/promise-async"} },
}
return plugins
