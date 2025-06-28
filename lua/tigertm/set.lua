--vim.opt.guicursor = " "
vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 0

vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.cmd("filetype plugin indent on")

vim.opt.wrap = false

--vim.opt.swapfile = false
--vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- spell languages
vim.opt.spelllang = "en_ca,en_us"
vim.opt.spellsuggest = "best,9"

vim.cmd("autocmd FileType rust set colorcolumn=100")
vim.cmd("set noexpandtab") --I shouldnt need this here, but it doesnt seem to work if I dont have it

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		-- Real tab behavior
		if "rust" == vim.bo[args.buf].filetype then
			vim.opt_local.expandtab = true
			vim.opt_local.tabstop = 4
			vim.opt_local.shiftwidth = 4
			vim.opt_local.softtabstop = 4
		else
			vim.opt_local.expandtab = false
			vim.opt_local.tabstop = 4
			vim.opt_local.shiftwidth = 4
			vim.opt_local.softtabstop = 0
		end


		-- Strip conflicting indent logic
		vim.opt_local.smartindent = false
		vim.opt_local.cindent = false
		vim.opt_local.indentexpr = ""
		vim.opt_local.autoindent = true -- keep basic indent mirroring
	end
})
