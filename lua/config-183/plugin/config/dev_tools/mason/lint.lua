--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/mason/lint.lua
--
-- bridge between nvim-lint and mason
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "rshkarin/mason-nvim-lint"
plugin.name = "mason-lint"
plugin.dependencies = {
	"mason",
	"lint",
}
---@type MasonNvimLintSettings
plugin.opts = {
	automatic_installation = true,
}

return plugin
