--[[ utility lua functions used by other plugins ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "nvim-lua/plenary.nvim"
plugin.name = "plenary"
plugin.priority = _G.CONSTS.lazy.priorities.highest

return plugin
