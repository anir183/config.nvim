--[[
-- nvim/lua/config-183/plugin/config/quality_of_life/oil_sidebar.lua
--
-- using oil.nvim in the sidebar
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "maelwalser/oil-bar.nvim"
plugin.name = "oil-sidebar"
plugin.dependencies = "oil"
plugin.opts = {}

return plugin
