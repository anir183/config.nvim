--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/mason/lspconfig.lua
--
-- bridge between nvim lspconfig and mason
--
--]]

---@module "table"
---@module "lazy"
---@module "config-183.options"
---@module "config-183.options.defaults"

---@type LazySpec
local plugin = {}

plugin[1] = "williamboman/mason-lspconfig.nvim"
plugin.name = "mason-lspconfig"
plugin.dependencies = {
	"mason",
	"lspconfig",
}

---@type string[]
local lsp_list = {}
for name, _ in pairs(OPTS.lsps) do
	table.insert(lsp_list, name)
end
---@type MasonLspconfigSettings
plugin.opts = {
	automatic_enable = false,
	ensure_installed = lsp_list,
}

return plugin
