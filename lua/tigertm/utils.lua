local M = {}

function M.concat_list_from_dir(config_path, require_path)

	local path = vim.fn.stdpath("config") .. config_path

	local list = {}

	local handle = vim.loop.fs_scandir(path)
	while true do
		local item, _ = vim.loop.fs_scandir_next(handle)
		if not item then break end
		_ = item
		item = item:match('(.+)%.lua$')
		if not item then goto continue end
		if item:match('init') then
			goto continue
		end
		vim.list_extend(list, require(require_path .. item))
		::continue::
	end

	return list

end

function M.require_all_in_dir(config_path, require_path)

	local path = vim.fn.stdpath("config") .. config_path

	local handle = vim.loop.fs_scandir(path)
	while true do
		local item, _ = vim.loop.fs_scandir_next(handle)
		if not item then break end
		_ = item
		item = item:match('(.+)%.lua$')
		if not item then goto continue end
		if item:match('init') then
			goto continue
		end
		pcall(require, require_path .. item)
		::continue::
	end

end

return M
