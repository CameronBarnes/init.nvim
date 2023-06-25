local npairs = require'nvim-autopairs'
local Rule   = require'nvim-autopairs.rule'
local cond = require('nvim-autopairs.conds')

npairs.add_rule(Rule("<", ">"):with_pair(cond.not_after_regex("\\ ")))
