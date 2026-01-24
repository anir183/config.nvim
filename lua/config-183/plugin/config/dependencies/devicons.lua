--[[
--
-- nvim/lua/config-183/plugin/config/dependencies/devicons.lua
--
-- several symbols and icons that can be used in other plugins
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "nvim-tree/nvim-web-devicons"
plugin.name = "devicons"
plugin.priority = LAZY.priorities.high

return plugin
