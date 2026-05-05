--[[ vim plugin for fzf integration ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "junegunn/fzf"
plugin.name = "fzf"
plugin.priority = _G.CONSTS.lazy.priorities.highest
plugin.build = ":call fzf#install()"

return plugin
