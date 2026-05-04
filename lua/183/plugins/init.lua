--[[ setup plugin manager and install plugins ]]

---@module "183.plugins.types"

---@type 183.plugins.types.Module
local M = {}

M.install_cmd = {
	"git",
	"clone",
	"--filter=blob:none",
	"--branch=stable",
	_G.CONSTS.lazy.repo_url,
	_G.CONSTS.lazy.install_path,
}

M.category_opts = nil

function M.check_and_install()
	if not (vim.uv or vim.loop).fs_stat(_G.CONSTS.lazy.install_path) then
		local cmd_out = vim.fn.system(M.install_cmd)

		if vim.v.shell_error ~= 0 then
			LOG.error("failed to install lazy.nvim")
			LOG.debug(cmd_out)
			os.exit(1)
		end

		LOG.info("installed lazy.nvim successfully")
	end
end

function M.get_base_spec()
	local opts = M.category_opts
	local base = {} ---@type 183.plugins.types.BaseSpec

	if not opts or opts.aesthetics then
		base.onedark = require("183.plugins.categories.aesthetics.onedark")
	end

	if not opts or opts.dependencies then
		base.devicons = require("183.plugins.categories.dependencies.devicons")
		base.plenary = require("183.plugins.categories.dependencies.plenary")
	end

	if not opts or opts.dev_tools then
		base.lspconfig = require("183.plugins.categories.dev_tools.lspconfig")
	end

	if not opts or opts.essentials then
		base.snacks = require("183.plugins.categories.essentials.snacks")
		base.treesitter_manager =
			require("183.plugins.categories.essentials.treesitter_manager")
	end

	if not opts or opts.quality_of_life then
		base.harpoon = require("183.plugins.categories.quality_of_life.harpoon")
	end

	if not opts or opts.toolchains then
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

function M.init()
	vim.opt.rtp:prepend(_G.CONSTS.lazy.install_path)

	require("lazy").setup({
		spec = M.get_lazy_spec(),
		lockfile = _G.CONSTS.lazy.lock_file_path,
		defaults = {
			lazy = false,
			priority = _G.CONSTS.lazy.priorities.default,
		},
		rocks = {
			enabled = false,
		},
		checker = {
			enabled = true,
			notify = false,
		},
		change_detection = {
			enabled = true,
			notify = false,
		},
	})

	_G.FUNCS.map(
		"n",
		"<leader>lz",
		"<CMD>Lazy<CR>",
		{ desc = "[plugin.lazy] open [L]a[Z]y" }
	)
end

return M
