local wk = require("which-key")

wk.add({
	{ "<leader>l",  group = "+LeetBuddy" },
	{ "<leader>lL", function() require("leetbuddy").setup({ language = "rs" }) end, desc = "Load LeetBudy" },
	{ "<leader>ll", function() vim.cmd("LBQuestions") end,                          desc = "List Questions" },
	{ "<leader>lq", function() vim.cmd("LBQuestion") end,                           desc = "View Question" },
	{ "<leader>lR", function() vim.cmd("LBReset") end,                              desc = "Reset Code" },
	{ "<leader>lt", function() vim.cmd("LBTest") end,                               desc = "Test Code" },
	{ "<leader>lS", function() vim.cmd("LBSubmit") end,                             desc = "Submit Code" },
})
