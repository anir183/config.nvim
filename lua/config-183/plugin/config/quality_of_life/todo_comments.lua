--[[
--
-- nvim/lua/config-183/plugin/config/quality_of_life/todo_comments.lua
--
-- highlighting for special comment tags
--
--]]

---@module "lazy"

-- BUG : commands like TodoQuickFix or Trouble todo only show NOTE comments

---@type LazySpec
local plugin = {}

plugin[1] = "folke/todo-comments.nvim"
plugin.name = "todo-comments"
plugin.dependencies = "plenary"
plugin.lazy = false
plugin.opts = {}
plugin.keys = {
	{
		mode = "n",
		"]t",
		function()
			require("todo-comments").jump_next()
		end,
		desc = "[plugin/todo-comments]: jump to next todo comment",
	},
	{
		mode = "n",
		"[t",
		function()
			require("todo-comments").jump_prev()
		end,
		desc = "[plugin/todo-comments]: jump to previous todo comment",
	},
}

return plugin
