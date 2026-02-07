--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/completion/lua_snip.lua
--
-- snippets engine
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "L3MON4D3/LuaSnip"
plugin.name = "lua-snip"
plugin.main = "luasnip"
plugin.version = "v2.*"
plugin.build = "make install_jsregexp"
plugin.dependencies = "friendly-snippets"
plugin.config = function()
	require("luasnip.loaders.from_vscode").lazy_load()
end

return plugin
