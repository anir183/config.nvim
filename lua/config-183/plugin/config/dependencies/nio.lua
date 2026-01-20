--[[
--
-- nvim/lua/config-183/plugin/config/dependencies/nio.lua
--
-- async io
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "nvim-neotest/nvim-nio"
plugin.name = "nio"
plugin.priority = LAZY.priorities.high

return plugin
