--[[
--
-- nvim/lua/config-183/plugin/config/aesthetic/theme.lua
--
-- editor colors and highlighting
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "catppuccin/nvim"
plugin.name = "catppuccin"
plugin.priority = LAZY.priorities.highest
plugin.opts = {
	flavour = "frappe",
	transparent_background = true,
	float = {
		transparent = true,
	},
	show_end_of_buffer = true,
}
plugin.config = function(_, opts)
	require("catppuccin").setup(opts)

	vim.cmd.colorscheme("catppuccin")
	vim.api.nvim_set_hl(
		0,
		"IncSearch",
		{ bg = "#ea999c", fg = "#232634" }
	)
end

return plugin
