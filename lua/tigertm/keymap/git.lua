local wk = require("which-key")

wk.add({
	{
		"<leader>G",
		function()
			vim.cmd("LazyGit")
		end,
		desc = "LazyGit"
	}
})
