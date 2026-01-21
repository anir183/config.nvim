--[[
--
-- nvim/lua/config-183/plugin/config/aesthetic/fidget.lua
--
-- lsp progress visualizer and vim.notify handler
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "j-hui/fidget.nvim"
plugin.name = "fidget"
plugin.lazy = false
plugin.opts = {
	notification = {
		override_vim_notify = true,
		view = {
			group_separator_hl = "Normal",
		},
		window = {
			normal_hl = "Normal",
			winblend = 0,
			y_padding = 2,
		},
	},
}
plugin.keys = {
	{
		mode = "n",
		"<leader>nh",
		"<CMD>Fidget history<CR>",
		desc = "[plugin/fidget]: open [N]otification [H]istory",
	},
	{
		mode = "n",
		"<leader>nc",
		"<CMD>Fidget clear<CR>",
		desc = "[plugin/fidget]: [N]otifications [C]leared",
	},
}

return plugin
