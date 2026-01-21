--[[
--
-- nvim/lua/config-183/plugin/config/quality_of_life/cloak.lua
--
-- hiding some sensitive patterns or tokens (just in case)
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "laytan/cloak.nvim"
plugin.name = "cloak"
plugin.lazy = false
plugin.opts = {
	cloak_character = "*",
	patterns = OPTS.cloak_patterns,
}
plugin.keys = {
	{
		mode = "n",
		"<leader>ct",
		vim.cmd.CloakPreviewLine,
		desc = "[plugin/cloak]: [C]loak curren[T] line preview",
	},
	{
		mode = "n",
		"<leader>CT",
		vim.cmd.CloakToggle,
		desc = "[plugin/cloak]: [C]loak hiding [T]oggle",
	},
}

return plugin
