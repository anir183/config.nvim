--[[
--
-- nvim/lua/config-183/plugin/config/quality_of_life/undotree.lua
--
-- navigable undo history tree
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "mbbill/undotree"
plugin.name = "undotree"
plugin.lazy = false
plugin.init = function()
	vim.g.undotree_WindowLayout = 2
	vim.g.undotree_SplitWidth = 40
	vim.g.undotree_SetFocusWhenToggle = 1
end
plugin.keys = {
	{
		mode = "n",
		"<leader>u",
		function()
			vim.cmd.UndotreeToggle()
		end,
		desc = "[plugin/undotree]: toggle [U]ndo history tree",
	},
}

return plugin
