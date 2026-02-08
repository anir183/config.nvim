--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/completion/copilot.lua
--
-- copilot completion for blink via copilot.lua
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "fang2hou/blink-copilot"
plugin.name = "blink-copilot"
plugin.dependencies = "copilot"
plugin.cond = OPTS.ai.copilot == "cmp"

return plugin
