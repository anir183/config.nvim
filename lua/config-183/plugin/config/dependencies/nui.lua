--[[
--
-- nvim/lua/config-183/plugin/config/dependencies/nui.lua
--
-- ui components library
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "MunifTanjim/nui.nvim"
plugin.name = "nui"
plugin.priority = LAZY.priorities.high

return plugin
