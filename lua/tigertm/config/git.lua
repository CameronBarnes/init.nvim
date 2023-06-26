require('gitsigns').setup{
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
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

	wk.register({
		["<leader>g"] = {
			name = "+Git",
			s = {gs.stage_hunk, "Stage Hunk"},
			r = {gs.reset_hunk, "Reset Hunk"},
			S = {gs.stage_buffer, "Stage Buffer"},
			u = {gs.undo_stage_hunk, "Undo Stage Hunk"},
			R = {gs.reset_buffer, "Reset Buffer"},
			p = {gs.preview_hunk, "Preview Hunk"},
			B = {function() gs.blame_line{full=true} end, "Blame Line FULL"},
			b = {gs.toggle_current_line_blame, "Toggle Blame Line"},
			d = {gs.diffthis, "Diff this"},
			D = {function() gs.diffthis('~') end, "Diff ~"},
		}
	}, {buffer = bufnr})

    -- Actions
    map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

vim.cmd("autocmd BufEnter * :lua require('lazygit.utils').project_root_dir()")
