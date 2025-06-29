require('gitsigns').setup {
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local wk = require("which-key")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map('n', ']c', function()
			if vim.wo.diff then return ']c' end
			vim.schedule(function() gs.next_hunk() end)
			return '<Ignore>'
		end, { expr = true })

		map('n', '[c', function()
			if vim.wo.diff then return '[c' end
			vim.schedule(function() gs.prev_hunk() end)
			return '<Ignore>'
		end, { expr = true })

		wk.add({
			{ "<leader>g",  group = "+Git" },
			{ "<leader>gB", function() gs.blame_line { full = true } end, desc = "Blame Line FULL" },
			{ "<leader>gD", function() gs.diffthis('~') end,              desc = "Diff ~" },
			{ "<leader>gR", gs.reset_buffer,                              desc = "Reset Buffer" },
			{ "<leader>gS", gs.stage_buffer,                              desc = "Stage Buffer" },
			{ "<leader>gb", gs.toggle_current_line_blame,                 desc = "Toggle Blame Line" },
			{ "<leader>gd", gs.diffthis,                                  desc = "Diff this" },
			{ "<leader>gp", gs.preview_hunk,                              desc = "Preview Hunk" },
			{ "<leader>gr", gs.reset_hunk,                                desc = "Reset Hunk" },
			{ "<leader>gs", gs.stage_hunk,                                desc = "Stage Hunk" },
			{ "<leader>gu", gs.undo_stage_hunk,                           desc = "Undo Stage Hunk" },
		}, { buffer = bufnr })

		-- Actions
		map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
		map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)

		-- Text object
		map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
	end
}

vim.cmd("autocmd BufEnter * :lua require('lazygit.utils').project_root_dir()")
