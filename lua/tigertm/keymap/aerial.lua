local wk = require("which-key")

wk.register({
    ["<leader>S"] = {function ()
        vim.cmd("AerialToggle!")
    end, "AerialToggle"}
})
