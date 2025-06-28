local wk = require("which-key")

wk.add({
	{
		"<leader>S",
		function()
			vim.cmd("AerialToggle!")
		end,
		desc = "AerialToggle"
	}
})
