local M = {}

M.dig = function(table, ...)
	local value = table
	for _, key in ipairs({ ... }) do
		if type(value) == "table" and value[key] ~= nil then
			value = value[key]
		else
			return nil
		end
	end
	return value
end

return M
