local ufo = require("ufo")
local wk = require("which-key")

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- This function allows us to have a display that shows how many lines are hidden in a fold
local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

local fileType = {
	git = "",
}

ufo.setup({
	fold_virt_text_handler = handler,
    provider_selector = function(bufnr, filetype, buftype)
        return fileType[fileType] or {'treesitter', 'indent'}
    end
})

wk.register({
	["z"] = {
		R = {ufo.openAllFolds, "Open All Folds"},
		r = {ufo.openFoldsExceptKinds, "Open All Folds Except Kinds"},
		M = {ufo.closeAllFolds, "Close All Folds"},
		m = {ufo.closeFoldsWith, "Close All Folds With 0"},
	}
})
