--[[
--
-- nvim/lua/config-183/plugin/config/ai/copilot_lsp.lua
--
-- lsp intergration with copilot and nes
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "copilotlsp-nvim/copilot-lsp"
plugin.name = "copilot-lsp"
plugin.cond = OPTS.ai.copilot ~= "off"

return plugin
