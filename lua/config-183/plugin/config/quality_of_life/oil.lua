--[[
--
-- nvim/lua/config-183/plugin/config/quality_of_life/oil.lua
--
-- file explorer with a editable buffer
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "stevearc/oil.nvim"
plugin.name = "oil"
plugin.dependencies = "devicons"
plugin.lazy = false
---@type oil.SetupOpts
plugin.opts = {
	default_file_explorer = true,
	skip_confirm_for_simple_edits = true,
	prompt_save_on_select_new_entry = false,
	view_options = {
		show_hidden = true,
	},
}
plugin.keys = {
	{
		mode = "n",
		"<leader>E",
		vim.cmd.Oil,
		desc = "[plugin/oil]: open the oil file [E]xplorer",
	},
}

return plugin
