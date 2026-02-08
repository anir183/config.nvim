--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/completion/lazydev.lua
--
-- copilot completion for blink via copilot.lua
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "folke/lazydev.nvim"
plugin.name = "lazydev"
---@module "lazydev"
---@type lazydev.Config
plugin.opts = {
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ "nvim-dap-ui" },
	},
	integrations = {
		blink = true,
	},
}

return plugin
