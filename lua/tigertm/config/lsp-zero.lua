local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"rust_analyzer",
	"eslint",
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

--CMP keymap setup
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<CR>'] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp' },
		{ name = 'buffer',  keyword_length = 3 },
		{ name = 'luasnip', keyword_length = 2 },
		{ name = 'crates' },
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

lsp.skip_server_setup({ 'rust_analyzer' })

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })

	local wk = require("which-key")
	local opts = { buffer = bufnr, remap = false }

	wk.add({
		{
			"K",
			function()
				local winid = require('ufo').peekFoldedLinesUnderCursor()
				if not winid then
					if client.name == "rust_analyzer" or client.name == "rust_analyzer-standalone" then -- Rust has additional features so we'll support that here
						vim.cmd.RustLsp { 'hover', 'actions' }                          -- We call it twice so that it focuses
						vim.cmd.RustLsp { 'hover', 'actions' }
					else
						vim.lsp.buf.hover()
					end
				end
			end,
			desc = "LSP Hover"
		},
		{ "<C-h>",     vim.lsp.buf.signature_help,                desc = "LSP Signature Help" },
		{ "[d",        function() vim.diagnostic.goto_next() end, desc = "Diagnostics Next" },
		{ "]d",        function() vim.diagnostic.goto_prev() end, desc = "Diagnostics Prev" },
		{ "<leader>d", vim.diagnostic.open_float,                 desc = "LSP Diagnostic" },
		{ "<leader>D", vim.lsp.buf.definition,                    desc = "LSP Definition" },
		{
			"<leader>a",
			function()
				if client.name == "rust_analyzer" or client.name == "rust_analyzer-standalone" then -- Rust has additional features so we'll support that here
					vim.cmd.RustLsp('codeAction')
				else
					vim.lsp.buf.code_action()
				end
			end,
			desc = "LSP Code Action"
		},
		{"<leader>v", group = "+LSP"},
		{"<leader>vS", vim.lsp.buf.workspace_symbol, desc = "Workspace Symbols"},
		{"<leader>vr", vim.lsp.buf.references, desc = "References"},
		{"<leader>vR", vim.lsp.buf.rename, desc = "Rename"},
	}, opts)

	-- Rust Specific keybinds here
	if client.name == "rust_analyzer" or client.name == "rust_analyzer-standalone" then
		local rt = require("rustaceanvim")
		wk.add({
			{ "<leader>x", rt.expand_macro.expand_macro,       desc = "Expand Macro" },
			{ "<leader>C", rt.open_cargo_toml.open_cargo_toml, desc = "Open Cargo Toml" },
			{ "<leader>R", rt.runnables.runnables,             desc = "Run Rust" },
			-- ["<C-d>"] = {rt.external_docs.open_external_docs(), "Rust Open External Docs"}, Doesnt appear to be working currently so I'm removing it
			-- ["<C-s>"] = {rt.ssr.ssr, "Rust Struct Search Replace"}, Honestly cant figure out what this is supposed to do, so I'm disabling it for now as well
		}, opts)
	end
end)

lsp.setup()
