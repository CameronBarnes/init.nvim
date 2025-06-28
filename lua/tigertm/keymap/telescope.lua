local wk = require("which-key")

local t = require("telescope.builtin")

wk.add({
	{ "<leader>f",  group = "+Telescope / Find" },
	{ "<leader>ff", t.find_files,                desc = "Find Files" },
	{ "<leader>fg", t.grep_string,               desc = "File Grep String" },
	{ "<leader>fl", t.live_grep,                 desc = "File Live Grep" },
	{ "<leader>fG", t.git_files,                 desc = "Git Files" },
	{ "<leader>fb", t.buffers,                   desc = "Buffers" },
	{ "<leader>fc", t.commands,                  desc = "Commands" },
	{ "<leader>fh", t.help_tags,                 desc = "Help Tags" },
	{ "<leader>fm", t.man_pages,                 desc = "Man Pages" },
	{ "<leader>fq", t.quickfix,                  desc = "Quickfix" },
	{ "<leader>fC", t.current_buffer_fuzzy_find, desc = "Current Buffer FzF" },
	{ "<leader>fp", t.builtin,                   desc = "List all builtin pickers" }
})
