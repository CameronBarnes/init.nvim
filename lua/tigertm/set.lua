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

vim.opt.tabstop = 4
--vim.opt.softtabstop = 4
--vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.smartindent = true

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
