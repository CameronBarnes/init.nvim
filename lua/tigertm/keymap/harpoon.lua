local wk = require("which-key")

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

wk.register({
	["<leader>h"] = {
		name = "+Harpoon",
		a = {mark.add_file, "Add File"},
		e = {ui.toggle_quick_menu, "Quick Menu"},
	},
	["<C-]>"] = {ui.nav_next, "Harpoon Next"},
	["<C-i>"] = {function() ui.nav_file(1) end, "Harpoon 1"},
	["<C-o>"] = {function() ui.nav_file(2) end, "Harpoon 2"},
	["<C-p>"] = {function() ui.nav_file(3) end, "Harpoon 3"},
})
