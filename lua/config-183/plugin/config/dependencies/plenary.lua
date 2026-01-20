--[[
--
-- nvim/lua/config-183/plugin/config/dependencies/plenary.lua
--
-- utility lua functions used by other plugins
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "nvim-lua/plenary.nvim"
plugin.name = "plenary"
plugin.priority = LAZY.priorities.highest

return plugin
