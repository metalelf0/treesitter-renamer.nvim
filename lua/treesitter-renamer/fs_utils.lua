local M = {}

-- kindly taken from echanovski/mini.nvim - thanks!
M.rename_loaded_buffer = function(buf_id, from, to)
	if not (vim.api.nvim_buf_is_loaded(buf_id) and vim.bo[buf_id].buftype == "") then
		return
	end
	-- Make sure buffer name is normalized (same as `from` and `to`)
	local cur_name = M.fs_normalize_path(vim.api.nvim_buf_get_name(buf_id))

	-- Use `gsub('^' ...)` to also take into account directory renames
	local new_name = cur_name:gsub("^" .. vim.pesc(from), to)
	if cur_name == new_name then
		return
	end
	vim.api.nvim_buf_set_name(buf_id, new_name)

	-- Force write to avoid the 'overwrite existing file' error message on write
	-- for normal files
	vim.api.nvim_buf_call(buf_id, function()
		vim.cmd("silent! write! | edit")
	end)
end

-- kindly taken from echanovski/mini.nvim - thanks!
M.fs_normalize_path = function(path)
	-- Use only forward slashes (for proper work on Windows)
	-- Don't use trailing slashes for proper 'get_parent' (account for plain '/')
	local res = path:gsub("\\", "/"):gsub("/+", "/"):gsub("(.)/$", "%1")
	return res
end

return M
