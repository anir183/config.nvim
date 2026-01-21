--[[
--
-- nvim/lua/config-183/plugin/config/aesthetic/netrw_plus.lua
--
-- icons and beautification for netrw explorer
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "prichrd/netrw.nvim"
plugin.name = "netrw-plus"
plugin.dependencies = "devicons"
---@type Config
plugin.opts = {
	use_devicons = true,
}

return plugin
