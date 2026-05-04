--[[ installation and management of dev tools ]]

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

