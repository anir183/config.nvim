--[[ async io ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "nvim-neotest/nvim-nio"
plugin.name = "nio"
plugin.priority = _G.CONSTS.lazy.priorities.high

return plugin
