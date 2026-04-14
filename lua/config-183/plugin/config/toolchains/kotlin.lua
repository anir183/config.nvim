--[[
--
-- nvim/lua/config-183/plugin/config/toolchains/kotlin.lua
--
-- kotlin toolset integration and setup
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "AlexandrosAlexiou/kotlin.nvim"
plugin.name = "kotlin"
plugin.dependencies = {
	"mason",
	"mason-lspconfig",
	"oil",
	"trouble",
}
plugin.cond = OPTS.toolchain.kotlin
plugin.opts = {
	jre_path = nil, -- use bundled jre (recommended)
	jdk_for_symbol_resolution = nil, -- auto-detect from project
	jvm_args = {
		"-Xmx4g", -- increase max heap (useful for large projects)
	},
}

return plugin
