local wk = require("which-key")

-- Previous had a keybinding here for the default nvim file browser,
-- but we're not using that because we're using nvim-tree instead

wk.add({
	{ "<leader>V",  group = "+Vim" },
	{ "<leader>Vt", function() vim.cmd(":set noet|retab!") end, desc = "Switch from Spaces to Tabs" },
})
