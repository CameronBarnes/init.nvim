vim.deprecate = function() end

local M = require("tigertm.utils")

M.require_all_in_dir("/lua/tigertm/config/", "tigertm.config.")
M.require_all_in_dir("/lua/tigertm/keymap/", "tigertm.keymap.")

require("tigertm.colour")
require("tigertm.set")
