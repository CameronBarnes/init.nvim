local wk = require("which-key")

local t = require("telescope.builtin")

wk.register({
    ["<leader>f"] = {
        name = "+Telescope / Find",
        f = {t.find_files, "Find Files"},
        g = {t.grep_string, "File Grep String"},
        l = {t.live_grep, "File Live Grep"},
        G = {t.git_files, "Git Files"},
        b = {t.buffers, "Buffers"},
        c = {t.commands, "Commands"},
        h = {t.help_tags, "Help Tags"},
        m = {t.man_pages, "Man Pages"},
        q = {t.quickfix, "Quickfix"},
        C = {t.current_buffer_fuzzy_find, "Current Buffer FzF"},
        p = {t.builtin, "List all builtin pickers"}
    }
})
