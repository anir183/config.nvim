--[[
--
-- nvim/lua/config-183/plugin/spec.lua
--
--]]

---@module "table"
---@module "vim"
---@module "config-183.utils"
---@module "config-183.utils.logging"
---@module "config-183.options"
---@module "config-183.options.defaults"
---@module "config-183.plugin"
---@module "config-183.plugin.init"

---@class ConfigSpec
LAZY.spec = {}

if OPTS.test_plugins then
	LOG.info("test plugins found")
	LOG.debug(OPTS.test_plugins)
	return OPTS.test_plugins
end

LOG.info("generating lazy.nvim plugin spec")
LAZY.spec = {
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
	guess_indent = require(
		"config-183.plugin.config.quality_of_life.guess_indent"
	),
	lazy_git = require("config-183.plugin.config.quality_of_life.lazy_git"),
	lsp_saga = require("config-183.plugin.config.quality_of_life.lsp_saga"),
	oil = require("config-183.plugin.config.quality_of_life.oil"),
	oil_sidebar = require(
		"config-183.plugin.config.quality_of_life.oil_sidebar"
	),
	tiny_inline_diagnostics = require(
		"config-183.plugin.config.quality_of_life.tiny_inline_diagnostics"
	),
	todo_comments = require(
		"config-183.plugin.config.quality_of_life.todo_comments"
	),
	trouble = require("config-183.plugin.config.quality_of_life.trouble"),
	undotree = require("config-183.plugin.config.quality_of_life.undotree"),

	--[[ development tools ]]
	lspconfig = require("config-183.plugin.config.dev_tools.lspconfig"),
	blink = require("config-183.plugin.config.dev_tools.completion.blink"),
	blink_copilot = require(
		"config-183.plugin.config.dev_tools.completion.copilot"
	),
	frienly_snippets = require(
		"config-183.plugin.config.dev_tools.completion.friendly_snippets"
	),
	lazydev = require("config-183.plugin.config.dev_tools.completion.lazydev"),
	lua_snip = require(
		"config-183.plugin.config.dev_tools.completion.lua_snip"
	),
	signature = require(
		"config-183.plugin.config.dev_tools.completion.signature"
	),
	conform = require("config-183.plugin.config.dev_tools.formatting"),
	lint = require("config-183.plugin.config.dev_tools.linting"),
	dap = require("config-183.plugin.config.dev_tools.dap.dap"),
	dap_ui = require("config-183.plugin.config.dev_tools.dap.ui"),
	virtual_text = require(
		"config-183.plugin.config.dev_tools.dap.virtual_text"
	),
	mason = require("config-183.plugin.config.dev_tools.mason.mason"),
	mason_conform = require("config-183.plugin.config.dev_tools.mason.conform"),
	mason_dap = require("config-183.plugin.config.dev_tools.mason.dap"),
	mason_lint = require("config-183.plugin.config.dev_tools.mason.lint"),
	mason_lspconfig = require(
		"config-183.plugin.config.dev_tools.mason.lspconfig"
	),

	--[[ ai ]]
	copilot = require("config-183.plugin.config.ai.copilot"),
	copilot_lsp = require("config-183.plugin.config.ai.copilot_lsp"),
	opencode = require("config-183.plugin.config.ai.opencode"),
}
LOG.info("lazy.nvim plugin specs generated and loaded")

LAZY.spec = vim.tbl_deep_extend("force", LAZY.spec, OPTS.plugin_overrides)
LOG.info("merging spec overrides from options")
LOG.debug(LAZY.spec)

local spec = {}
for name, plugin in pairs(LAZY.spec) do
	name = plugin.name or name
	plugin.name = name
	table.insert(spec, plugin)
	LOG.info("added plugin to spec: " .. name)
	LOG.debug(plugin)
end
LOG.info("cleaned spec for lazy.nvim")
LOG.debug(spec)

LAZY.spec.extra_from_opts = OPTS.extra_plugins

for _, plugin in ipairs(OPTS.extra_plugins) do
	table.insert(spec, plugin)
	LOG.info("added extra plugin to spec: " .. plugin.name or plugin[1])
	LOG.debug(plugin)
end

return spec
