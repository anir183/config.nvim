--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/dap/virtual_text.lua
--
-- live debug statements in editor as virtual text
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "theHamsta/nvim-dap-virtual-text"
plugin.name = "dap-virtual-text"
plugin.dependencies = "dap"
---@type nvim_dap_virtual_text_options
plugin.opts = {
	-- hides sensitive tokens... just in case
	display_callback = function(variable)
		local name = string.lower(variable.name)
		local value = string.lower(variable.name)

		if
			name:match("secret")
			or name:match("api")
			or value:match("secret")
			or value:match("api")
		then
			return " ******"
		end

		if #variable.value > 15 then
			return " " .. string.sub(variable.value, 1, 15) .. "... "
		end

		return " " .. variable.value
	end,
}

return plugin
