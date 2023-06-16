local wk = require("which-key")

wk.register({
	["<leader>v"] = {
		name = "+VIM",
		e = {vim.cmd.Ex, "Browse Files"}
	}
})
