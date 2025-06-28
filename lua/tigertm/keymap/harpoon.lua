local wk = require("which-key")

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

wk.add({
	{ "<leader>h",  group = "+Harpoon" },
	{ "<leader>ha", mark.add_file,                 desc = "Add File" },
	{ "<leader>he", ui.toggle_quick_menu,          desc = "Quick Menu" },
	{ "<C-]>",      ui.nav_next,                   desc = "Harpoon Next" },
	{ "<C-i>",      function() ui.nav_file(1) end, desc = "Harpoon 1" },
	{ "<C-o>",      function() ui.nav_file(2) end, desc = "Harpoon 2" },
	{ "<C-p>",      function() ui.nav_file(3) end, desc = "Harpoon 3" },
})
