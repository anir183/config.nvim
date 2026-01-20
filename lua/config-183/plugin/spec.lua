--[[
--
-- nvim/lua/config-183/plugin/spec.lua
--
--]]

---@class ConfigSpec
local spec = {}

LOG.info("generating lazy.nvim plugin spec")
spec = {
	--[[ dependencies ]]
	plenary = require("config-183.plugin.config.dependencies.plenary"),
	nio = require("config-183.plugin.config.dependencies.nio"),
	nui = require("config-183.plugin.config.dependencies.nui"),
	devicons = require("config-183.plugin.config.dependencies.devicons"),

	--[[ aesthetics ]]
	theme = require("config-183.plugin.config.aesthetic.theme"),
	fidget = require("config-183.plugin.config.aesthetic.fidget"),
	netrw_plus = require("config-183.plugin.config.aesthetic.netrw_plus"),
}
LOG.info("lazy.nvim plugin specs generated and loaded")

return spec
