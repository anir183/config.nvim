--[[
--
-- nvim/lua/config-183/plugin/config/xxxxxxxx/xxxxxxxx.lua
--
-- xxxxxxxx
--
--]]

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
