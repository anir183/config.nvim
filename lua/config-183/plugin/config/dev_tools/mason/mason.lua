--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/mason/mason.lua
--
-- installation and management of dev tools
--
--]]

---@module "vim"
---@module "lazy"
---@module "mason"

---@type LazySpec
local plugin = {}

plugin[1] = "williamboman/mason.nvim"
plugin.name = "mason"
plugin.lazy = false
---@type MasonSettings
plugin.opts = {}
plugin.keys = {
	{
		mode = "n",
		"<leader>mn",
		vim.cmd.Mason,
		desc = "[plugin/mason]: open [M]aso[N] window",
	},
}

return plugin
