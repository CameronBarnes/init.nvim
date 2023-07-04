local wk = require("which-key")

-- Previous had a keybinding here for the default nvim file browser,
-- but we're not using that because we're using nvim-tree instead

wk.register({
	["<leader>V"] = {
		name = "+Vim",
		t = {vim.cmd(":set noet|retab!"), "Switch From Spaces to Tabs"}, -- For some reason this isnt working, I dont know why
	}
})
