local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"rust_analyzer",
	"eslint",
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

--CMP keymap setup
local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
    {name = 'crates'},
  }
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})

lsp.skip_server_setup({'rust_analyzer'})

lsp.on_attach(function(_, bufnr)

	lsp.default_keymaps({buffer = bufnr})

	local wk = require("which-key")

	wk.register({
		K = {vim.lsp.buf.hover, "LSP Hover"},
		["<C-h>"] = {vim.lsp.buf.signature_help, "LSP Signature Help"},
		["<leader>"] = {
			D = {vim.lsp.buf.definition, "LSP Definition"},
			d = {vim.diagnostic.open_float, "LSP Diagnostics"},
			a = {vim.lsp.buf.code_action, "LSP Code Action"},
			["v"] = {
				name = "+LSP",
				S = {vim.lsp.buf.workspace_symbol, "Workspace Symbols"},
				r = {vim.lsp.buf.references, "References"},
				R = {vim.lsp.buf.rename, "Rename"},
			}
		}
	}, {buffer = bufnr, remap = false})

	vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)

end)

lsp.setup()
