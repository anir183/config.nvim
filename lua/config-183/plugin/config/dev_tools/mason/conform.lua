--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/mason/conform.lua
--
-- bridge between conform and mason
--
--]]

-- WARN : archived
-- TODO : find replacement or remove

---@type LazySpec
local plugin = {}

plugin[1] = "zapling/mason-conform.nvim"
plugin.name = "mason-conform"
plugin.dependencies = {
	"mason",
	"conform",
}
plugin.opts = {}

return plugin
