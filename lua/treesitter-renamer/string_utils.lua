local M = {}

M.string_to_underscore = function(input)
	local normalized = input:gsub("[^%w_ ]", "")
	local output = normalized:gsub(" ", "_")
	output = normalized:gsub("(%l)(%u)", "%1_%2")
	output = output:gsub("^%u", function(c)
		return c:lower()
	end)
	output = output:lower()
	return output
end

return M
