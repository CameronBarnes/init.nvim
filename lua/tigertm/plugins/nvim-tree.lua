local plugins = {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		config = function()
			require("nvim-tree").setup {
				renderer = {indent_markers = {
					enable = true
				}},
				disable_netrw = true,
				hijack_netrw = true,
				filters = { custom = { "^.git$", "Cargo.lock" } }
			}
		end,
	},
}
return plugins
