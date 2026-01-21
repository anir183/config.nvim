--[[
--
-- nvim/lua/config-183/plugin/init.lua
--
-- bootstrap plugin manager and setup plugins
-- this module bootstraps the lazy.nvim plugin manager and configures different
-- plugins to be used
--
--]]

LOG.info("loading lazy.nvim plugin manager")

---@class LazyOpts
--- options used when bootstrapping lazy.nvim plugin manager
LAZY = LAZY or {}

---@type string path to the directory to install lazy at
LAZY.path =LAZY.path or FUNCS.join_paths(
	VARS.path.data,
	"lazy",
	"lazy.nvim"
)
---@type string path where the lock file for installed plugins is stored
LAZY.lock_path = LAZY.lock_path or FUNCS.join_paths(
	VARS.path.state,
	"lazy-lock.json"
)
---@type string repository where the lazy.nvim pacakge is hosted
LAZY.repo = LAZY.repo or "https://github.com/folke/lazy.nvim.git"
---@type string[] installation command to pull down the remote repo
LAZY.install_cmd = LAZY.install_cmd or {
	"git",
	"clone",
	"--filter=blob:none",
	"--branch=stable",
	LAZY.repo,
	LAZY.path
}

---@class LazyPriorities
--- priority levels for controlling plugin load order
LAZY.priorities = {}
LAZY.priorities.highest = 200
LAZY.priorities.high = 100
LAZY.priorities.default = 50
LAZY.priorities.low = 25

LOG.info("setup lazy.nvim parameters")
LOG.debug(LAZY)

--[[ install lazy.nvim and add to runtime path ]]
if not (vim.uv or vim.loop).fs_stat(LAZY.path) then
	local cmd_out = vim.fn.system(LAZY.install_cmd)

	if vim.v.shell_error ~= 0 then
		LOG.error("failed to install lazy.nvim")
		LOG.debug(cmd_out)
		os.exit(1)
	end

	LOG.info("installed lazy.nvim successfully")
end
vim.opt.rtp:prepend(LAZY.path)
LOG.info("lazy.nvim added to rtp")
LOG.debug(vim.opt.rtp)

--[[ setup and initate lazy ]]
local spec = {}
for name, plugin in pairs(vim.tbl_deep_extend("force", require("config-183.plugin.spec"), OPTS.plugin_overrides)) do
	name = plugin.name or name
	plugin.name = name
	table.insert(spec, plugin)
	LOG.info("added plugin to spec: " .. name)
	LOG.debug(plugin)
end
require("lazy").setup({
	spec = {
		spec,
		OPTS.extra_plugins,
	},
	lockfile = LAZY.lock_path,
	defaults = {
		lazy = false,
		priority = LAZY.priorities.default,
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

FUNCS.nmap("<leader>lz", "<CMD>Lazy<CR>", "[plugin/lazy]: open lazy")

LOG.info("lazy.nvim setup and loaded")
