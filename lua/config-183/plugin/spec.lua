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

	--[[ essentials ]]
	snacks = require("config-183.plugin.config.essentials.snacks"),
	treesitter = require("config-183.plugin.config.essentials.treesitter"),
	harpoon = require("config-183.plugin.config.essentials.harpoon"),

	--[[ quality of life ]]
	ccc = require("config-183.plugin.config.quality_of_life.ccc"),
	cloak = require("config-183.plugin.config.quality_of_life.cloak"),
	comment = require("config-183.plugin.config.quality_of_life.comment"),
	git_signs = require("config-183.plugin.config.quality_of_life.git_signs"),
	guess_indent = require("config-183.plugin.config.quality_of_life.guess_indent"),
	lazy_git = require("config-183.plugin.config.quality_of_life.lazy_git"),
	lsp_saga = require("config-183.plugin.config.quality_of_life.lsp_saga"),
	oil = require("config-183.plugin.config.quality_of_life.oil"),
	oil_sidebar = require("config-183.plugin.config.quality_of_life.oil_sidebar"),
	tiny_inline_diagnostics = require("config-183.plugin.config.quality_of_life.tiny_inline_diagnostics"),
	todo_comments = require("config-183.plugin.config.quality_of_life.todo_comments"),
	trouble = require("config-183.plugin.config.quality_of_life.trouble"),
	undotree = require("config-183.plugin.config.quality_of_life.undotree"),

	--[[ development tools ]]
	blink = require("config-183.plugin.config.dev_tools.completion.blink"),
	mason = require("config-183.plugin.config.dev_tools.mason.mason"),
}
LOG.info("lazy.nvim plugin specs generated and loaded")

return spec
