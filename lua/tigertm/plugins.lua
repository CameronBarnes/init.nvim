local utils = require("tigertm.config.utils")
local plugins = {
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		'stevearc/dressing.nvim',
  		opts = {},
	},
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {}
	},
	{ "catppuccin/nvim", name = "catppuccin" },
	{"ThePrimeagen/harpoon"},
	{"mbbill/undotree"},
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
          -- LSP Support
          {'neovim/nvim-lspconfig'},             -- Required
          {                                      -- Optional
            'williamboman/mason.nvim',
            build = function()
              pcall(vim.cmd, 'MasonUpdate')
            end,
          },
          {'williamboman/mason-lspconfig.nvim'}, -- Optional

          -- Autocompletion
          {'hrsh7th/nvim-cmp'},     -- Required
          {'hrsh7th/cmp-nvim-lsp'}, -- Required
          {'L3MON4D3/LuaSnip'},     -- Required
        }
    },
    {"mfussenegger/nvim-dap"},
    {"rcarriga/nvim-dap-ui", dependencies = {{"mfussenegger/nvim-dap"}}},
    {
        "simrat39/rust-tools.nvim",
        ft = { "rust" },
        opts = function()
          local adapter
          local success, package = pcall(function() return require("mason-registry").get_package "codelldb" end)
          if success then
            local package_path = package:get_install_path()
            local codelldb_path = package_path .. "/codelldb"
            local liblldb_path = package_path .. "/extension/lldb/lib/liblldb"
            local this_os = vim.loop.os_uname().sysname

            -- The path in windows is different
            if this_os:find "Windows" then
              codelldb_path = package_path .. "\\extension\\adapter\\codelldb.exe"
              liblldb_path = package_path .. "\\extension\\lldb\\bin\\liblldb.dll"
            else
              -- The liblldb extension is .so for linux and .dylib for macOS
              liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
            end
            adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
          else
            adapter = require("rust-tools.dap").get_codelldb_adapter()
          end

          return {
              server = utils.extend_tbl(utils.config("rust_analyzer"), { settings = { ["rust-analyzer"] = {fmtOnSave = {enable = true}, procMacro = {enable = true}, checkOnSave = { enable = true, command = "clippy", }, cargo = { allFeatures = true, },} }}),
              dap = { adapter = adapter }
          }
        end,
        dependencies = {{"jay-babu/mason-nvim-dap.nvim"}},
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            {"kyazdani42/nvim-web-devicons", opt = true}
        }
    },
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },
    {
        "saecki/crates.nvim",
        config = function ()
            require("crates").setup()
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            --"nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {
				renderer = {indent_markers = {
					enable = true
				}},
				disable_netrw = true,
				hijack_netrw = true,
				filters = { custom = { "^.git$", "Cargo.lock" } }
			}
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "User AstroFile",
        opts = {
            buftype_exclude = {
                "nofile",
                "terminal",
            },
            filetype_exclude = {
                "help",
                "startify",
                "aerial",
                "alpha",
                "dashboard",
                "lazy",
                "neogitstatus",
                "NvimTree",
                "neo-tree",
                "Trouble",
            },
            context_patterns = {
                "class",
                "return",
                "function",
                "method",
                "^if",
                "^while",
                "jsx_element",
                "^for",
                "^object",
                "^table",
                "block",
                "arguments",
                "if_statement",
                "else_clause",
                "jsx_element",
                "jsx_self_closing_element",
                "try_statement",
                "catch_clause",
                "import_statement",
                "operation_type",
            },
            show_trailing_blankline_indent = false,
            use_treesitter = true,
            char = "▏",
            context_char = "▏",
            show_current_context = true,
        },
    },
    { "folke/neodev.nvim", opts = {} },
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
            { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
        },
        opts = function()
            local commentstring_avail, commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
            return commentstring_avail and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        cmd = { "ToggleTerm", "TermExec" },
        opts = {
            size = 10,
            on_create = function()
                vim.opt.foldcolumn = "0"
                vim.opt.signcolumn = "no"
            end,
            open_mapping = [[<F7>]],
            shading_factor = 2,
            direction = "float",
            float_opts = {
                border = "curved",
                highlights = { border = "Normal", background = "Normal" },
            },
        },
    },
    {
        "stevearc/aerial.nvim",
        opts = {
            attach_mode = "global",
            backends = { "lsp", "treesitter", "markdown", "man" },
            layout = { min_width = 28 },
            show_guides = true,
            filter_kind = false,
            guides = {
                mid_item = "├ ",
                last_item = "└ ",
                nested_top = "│ ",
                whitespace = "  ",
            },
            keymaps = {
                ["[y"] = "actions.prev",
                ["]y"] = "actions.next",
                ["[Y"] = "actions.prev_up",
                ["]Y"] = "actions.next_up",
                ["{"] = false,
                ["}"] = false,
                ["[["] = false,
                ["]]"] = false,
            },
        },
    },
	{ "tenxsoydev/tabs-vs-spaces.nvim", config = true },
	{
		"Dhanus3133/LeetBuddy.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("leetbuddy").setup({})
		end,
		keys = {
			{ "<leader>lq", "<cmd>LBQuestions<cr>", desc = "List Questions" },
			{ "<leader>ll", "<cmd>LBQuestion<cr>", desc = "View Question" },
			{ "<leader>lr", "<cmd>LBReset<cr>", desc = "Reset Code" },
			{ "<leader>lt", "<cmd>LBTest<cr>", desc = "Run Code" },
			{ "<leader>ls", "<cmd>LBSubmit<cr>", desc = "Submit Code" },
		},
	},
}
return plugins
