local M = {}

local markdown = require("treesitter-renamer.languages.markdown")
local fs_utils = require("treesitter-renamer.fs_utils")
local string_utils = require("treesitter-renamer.string_utils")
local map_helpers = require("treesitter-renamer.helpers.map")

local langs = {
	markdown = markdown,
}

M.setup = function(opts)
	M.set_keymaps(opts)
end

M.treesitter_rename = function()
	local current_language = vim.bo.filetype
	local language_handler = langs[current_language]
	local new_file_name = language_handler.rename_text() .. language_handler.file_extension()
	M.rename_current_file_with_tpope_eunuch(new_file_name)
	-- local new_file_path = fs_utils.fs_normalize_path(vim.fn.expand("%:p:h") .. "/" .. new_file_name)
	-- local cur_file_path = fs_utils.fs_normalize_path(vim.fn.expand("%:p"))
	-- fs_utils.rename_loaded_buffer(vim.api.nvim_get_current_buf(), cur_file_path, new_file_path)
end

M.set_keymaps = function(opts)
	local rename_file = map_helpers.dig(opts, "bindings", "rename_file") or "<leader>rr"
	vim.keymap.set("n", rename_file, M.treesitter_rename, { desc = "Rename current file" })
end

M.rename_current_file_with_tpope_eunuch = function(new_name)
	local command = "Rename " .. new_name
	vim.api.nvim_command(command)
end

return M
