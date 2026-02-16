--[[
--
-- nvim/lua/config-183/plugin/config/aesthetic/theme.lua
--
-- editor colors and highlighting
--
--]]

---@module "vim"
---@module "lazy"
---@module "catppuccin"

---@type LazySpec
local plugin = {}

plugin[1] = "catppuccin/nvim"
plugin.name = "catppuccin"
plugin.priority = LAZY.priorities.highest
---@type CatppuccinOptions
plugin.opts = {
	flavour = "mocha",
	transparent_background = true,
	float = {
		transparent = true,
		solid = false,
	},
	show_end_of_buffer = true,
}
plugin.config = function(_, opts)
	require("catppuccin").setup(opts)

	vim.cmd.colorscheme("catppuccin")
	vim.api.nvim_set_hl(0, "IncSearch", { bg = "#EBA0AC", fg = "#11111b", bold = true })
end

return plugin
