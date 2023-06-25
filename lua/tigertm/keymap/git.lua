local wk = require("which-key")

wk.register({
	["<leader>G"] = {function ()
	   vim.cmd("LazyGit")
	end, "LazyGit"}
})
