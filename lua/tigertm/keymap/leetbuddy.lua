local wk = require("which-key")

wk.register({
	["<leader>l"] = {
		name = "+LeetBuddy",
		L = {function ()
			require("leetbuddy").setup({ language = "rs" }) -- initialize LeetBuddy and set the default problem language to Rust
		end, "Load LeetBuddy"},
		l = {function() vim.cmd("LBQuestions") end, "List Questions"},
		q = {function() vim.cmd("LBQuestion") end, "View Question"},
		R = {function() vim.cmd("LBReset") end, "Reset Code"},
		t = {function() vim.cmd("LBTest") end, "Run Code"},
		S = {function() vim.cmd("LBSubmit") end, "Submit Code"},
	}
})
