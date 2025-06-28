local wk = require("which-key")

wk.add({
	{
		"<leader>e",
		function()
			vim.cmd("NvimTreeToggle")
		end,
		desc = "Toggle File Tree"
	}
})
