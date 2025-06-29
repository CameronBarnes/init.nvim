local wk = require("which-key")

vim.g.copilot_no_tab_map = false

wk.add({
	{ "<leader>C",  group = "+Copilot" },
	{ "<leader>Cs", function() vim.cmd("Copilot setup") end, desc = "Setup" },
	{"<leader>Cp", function() vim.cmd("CopilotChatPrompts") end, desc = "List Prompts"},
	{"<leader>Cc", function() vim.cmd("CopilotChatToggle") end, desc = "Toggle Chat Window"},
})
