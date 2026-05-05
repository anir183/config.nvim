--[[ merge and clean plugin spec for lazy.nvim manager ]]

---@module "183.plugins.types"

---@type 183.plugins.types.Spec
local M = {}

M.category_opts = nil

function M.get_base_spec()
	local opts = M.category_opts
	local base = {} ---@type 183.plugins.types.BaseSpec

	if not opts or opts.aesthetics then
		base.onedark = require("183.plugins.categories.aesthetics.onedark")
		base.fidget = require("183.plugins.categories.aesthetics.fidget")
	end

	if not opts or opts.dependencies then
		base.devicons = require("183.plugins.categories.dependencies.devicons")
		base.plenary = require("183.plugins.categories.dependencies.plenary")
	end

	if not opts or opts.dev_tools then
		base.blink =
			require("183.plugins.categories.dev_tools.completion.blink")
		base.conform = require("183.plugins.categories.dev_tools.conform")
		base.friendly_snippets = require(
			"183.plugins.categories.dev_tools.completion.friendly_snippets"
		)
		base.lint = require("183.plugins.categories.dev_tools.lint")
		base.lsp_signature =
			require("183.plugins.categories.dev_tools.lsp_signature")
		base.lspconfig = require("183.plugins.categories.dev_tools.lspconfig")
		base.lua_snip =
			require("183.plugins.categories.dev_tools.completion.luasnip")

		base.mason = require("183.plugins.categories.dev_tools.mason")
	end

	if not opts or opts.essentials then
		base.oil = require("183.plugins.categories.essentials.oil")
		base.snacks = require("183.plugins.categories.essentials.snacks")
		base.treesitter_manager =
			require("183.plugins.categories.essentials.treesitter_manager")
		base.undotree = require("183.plugins.categories.essentials.undotree")
	end

	if not opts or opts.quality_of_life then
		base.ccc = require("183.plugins.categories.quality_of_life.ccc")
		base.cloak = require("183.plugins.categories.quality_of_life.cloak")
		base.comment = require("183.plugins.categories.quality_of_life.comment")
		base.git_signs =
			require("183.plugins.categories.quality_of_life.git_signs")
		base.harpoon = require("183.plugins.categories.quality_of_life.harpoon")
		base.sleuth = require("183.plugins.categories.quality_of_life.sleuth")
		base.tiny_inline_diagnostics = require(
			"183.plugins.categories.quality_of_life.tiny_inline_diagnostics"
		)
		base.todo_comments =
			require("183.plugins.categories.quality_of_life.todo_comments")
	end

	if not opts or opts.toolchains then
		base.lazydev = require("183.plugins.categories.toolchains.lazydev")
	end

	return base
end

function M.get_lazy_spec()
	-- testing environment for plugins by disabling other plugins
	if
		type(_G.CONF.plugins.minimal_testing) == "table"
		and #_G.CONF.plugins.minimal_testing > 0
	then
		return _G.CONF.plugins.minimal_testing
	end

	---@module "lazy"
	---@type LazySpec[]
	local spec = {}
	local base = M.get_base_spec()

	-- merge overrides
	base = vim.tbl_deep_extend(
		"force",
		base,
		type(_G.CONF.plugins.overrides) == "table" and _G.CONF.plugins.overrides
			or {}
	)

	-- convert to lazy spec
	---@param name string
	---@param plugin LazySpec
	for name, plugin in pairs(base) do
		name = plugin.name or name
		plugin.name = name

		table.insert(spec, plugin)
	end

	-- add additional specs
	if
		type(_G.CONF.plugins.additional) == "table"
		and #_G.CONF.plugins.additional > 0
	then
		---@diagnostic disable-next-line: param-type-mismatch
		for _, plugin in pairs(_G.CONF.plugins.additional) do
			table.insert(spec, plugin)
		end
	end

	return spec
end

return M
