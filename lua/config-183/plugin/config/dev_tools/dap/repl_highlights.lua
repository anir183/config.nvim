--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/dap/repl_highlights.lua
--
-- highlighting in the dap ui repl window
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "LiadOz/nvim-dap-repl-highlights"
plugin.name = "dap-repl-highlights"
plugin.dependencies = {
	"dap",
	"treesitter",
}

return plugin
