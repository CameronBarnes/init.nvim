local wk = require("which-key")

wk.register({
	["<leader>e"] = {function ()
	   vim.cmd("NvimTreeToggle")
	end, "Toggle File Tree"}
})
