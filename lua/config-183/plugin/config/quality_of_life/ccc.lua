--[[
--
-- nvim/lua/config-183/plugin/config/quality_of_life/ccc.lua
--
-- color picker
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "uga-rosa/ccc.nvim"
plugin.name = "color-picker"
plugin.lazy = false
---@type ccc.Options.P
plugin.opts = {}
plugin.keys = {
	{
		mode = "n",
		"<leader>cp",
		vim.cmd.CccPick,
		desc = "[plugin/color-picker]: open [C]olor [P]icker",
	},
	{
		mode = "n",
		"<leader>ch",
		vim.cmd.CccHighlighterToggle,
		desc = "[plugin/color-picker]: toggle [C]olor [H]ighlighting",
	},
	{
		mode = "n",
		"<leader>cv",
		vim.cmd.CccConvert,
		desc = "[plugin/color-picker]: [C]on[V]ert color",
	},
}

return plugin
