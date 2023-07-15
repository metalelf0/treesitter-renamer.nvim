local M = {}

M.rename_text = function()
	local syntax_tree = vim.treesitter.get_parser(0):parse()[1]:root()

	if not syntax_tree then
		return "No syntax tree available"
	end

	local h1_node = M.search_header_into(syntax_tree, 1)
	local h1_text = ""
	if h1_node then
		h1_text = vim.treesitter.get_node_text(h1_node, 0):gsub("^%s+", "")
	end

	return h1_text
end

M.file_extension = function()
	return ".md"
end

M.search_header_into = function(node, heading_level)
	-- print("Traversing node " .. vim.inspect(node) .. " " .. node:type())
	if M.is_h1(node) then
		return node:named_child(1)
	end
	for i = 0, (node:named_child_count() - 1) do
		local result = M.search_header_into(node:named_child(i), heading_level)
		if result then
			return result
		end
	end
end

M.is_h1 = function(node)
	return node and node:type() == "atx_heading" and node:named_child(0):type() == "atx_h1_marker"
end

return M
