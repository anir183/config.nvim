--[[
--
-- nvim/lua/config-183/plugin/config/toolchains/gopher.lua
--
-- go lang toolset integration and setup
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "ray-x/go.nvim"
plugin.name = "gopher"
plugin.main = "go"
plugin.dependencies = {
	"treesitter",
	"lspconfig",
}
plugin.cond = OPTS.toolchain.gopher
plugin.opts = {}

return plugin
