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

lsp.on_attach(function(client, bufnr)

	lsp.default_keymaps({buffer = bufnr})

	local wk = require("which-key")
	local opts = {buffer = bufnr, remap = false}

	wk.register({
		K = {function ()
			local winid = require('ufo').peekFoldedLinesUnderCursor()
			if not winid then
				if client.name == "rust_analyzer" or client.name == "rust_analyzer-standalone" then -- Rust has additional features so we'll support that here
					require("rust-tools").hover_actions.hover_actions() -- We call it twice so that it focuses
					require("rust-tools").hover_actions.hover_actions()
				else
					vim.lsp.buf.hover()
				end
			end
		end, "LSP Hover"},
		["<C-h>"] = {vim.lsp.buf.signature_help, "LSP Signature Help"},
		["<leader>"] = {
			D = {vim.lsp.buf.definition, "LSP Definition"},
			d = {vim.diagnostic.open_float, "LSP Diagnostics"},
			a = {function ()
				if client.name == "rust_analyzer" or client.name == "rust_analyzer-standalone" then -- Rust has additional features so we'll support that here
					require("rust-tools").code_action_group.code_action_group()
				else
					vim.lsp.buf.code_action()
				end
			end, "LSP Code Action"},
			["v"] = {
				name = "+LSP",
				S = {vim.lsp.buf.workspace_symbol, "Workspace Symbols"},
				r = {vim.lsp.buf.references, "References"},
				R = {vim.lsp.buf.rename, "Rename"},
				["<C-r>"] = {function() require("rust-tools").standalone.start_standalone_client() end, "Rust Standalone Client"},
			}
		},
		["[d"] = {function() vim.diagnostic.goto_next() end, "Diagnostics Next"},
		["]d"] = {function() vim.diagnostic.goto_prev() end, "Diagnostics Prev"},
	}, opts)

	-- Rust Specific keybinds here
	if client.name == "rust_analyzer" or client.name == "rust_analyzer-standalone" then
		local rt = require("rust-tools")
		wk.register({
			["<leader>"] = {
				x = {rt.expand_macro.expand_macro, "Expand Macro"},
				-- ["<C-d>"] = {rt.external_docs.open_external_docs(), "Rust Open External Docs"}, Doesnt appear to be working currently so I'm removing it
				C = {rt.open_cargo_toml.open_cargo_toml, "Open Cargo Toml"},
				-- ["<C-s>"] = {rt.ssr.ssr, "Rust Struct Search Replace"}, Honestly cant figure out what this is supposed to do, so I'm disabling it for now as well
				R = {rt.runnables.runnables, "Rust Run"},
			}
		}, opts)
	end

end)

lsp.setup()
