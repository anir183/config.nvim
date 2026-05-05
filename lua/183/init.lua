--[[ bootstrap configuration modules ]]

-- initialize utilities
_G.CONSTS = require("183.utils.constants")
_G.CONF = require("183.config.merged")
_G.LOG = require("183.utils.logging")
_G.FUNCS = require("183.utils.functions")

LOG.setup_log_file()

_G.LOG.info("loaded utilities and config options")
_G.LOG.debug(
	{ consts = _G.CONSTS },
	{ config = _G.CONF },
	{ log = _G.LOG },
	{ funcs = _G.FUNCS }
)

-- config surrounding functions
_G.LOG.debug("running before config function")
_G.CONF.run_before_config()
vim.api.nvim_create_autocmd("VimEnter", {
	group = _G.CONSTS.augrp.id,
	callback = function()
		_G.LOG.debug("running after config function")
		_G.CONF.run_after_config()
	end,
})

local mode = _G.CONF.mode

-- minimal
if mode == "minimal" or mode == "minimal-plugin" or mode == "minimal-dev" then
	local core = require("183.core.init")
	core.init_options()
	core.init_keymaps()
	core.init_lsp_keymaps()

	require("183.custom.init").init_netrw()

	if mode == "minimal-plugin" then
		_G.LAZY = require("183.plugins.init")

		_G.LAZY.check_and_install()
		_G.LAZY.spec.category_opts = {
			dependencies = true,
			essentials = true,

			dev_tools = false,
			aesthetics = false,
			quality_of_life = false,
			toolchains = false,
		}
		_G.LAZY.init()
	end

	if mode == "minimal-dev" then
		_G.LAZY = require("183.plugins.init")

		_G.LAZY.check_and_install()
		_G.LAZY.spec.category_opts = {
			dependencies = true,
			essentials = true,
			dev_tools = true,
			toolchains = true,

			aesthetics = false,
			quality_of_life = false,
		}
		_G.LAZY.init()
	end

	return
end

-- normal
local core = require("183.core.init")
core.init_options()
core.init_keymaps()
core.init_lsp_keymaps()
core.init_auto_commands()

local custom = require("183.custom.init")
custom.init_netrw()
custom.init_statusline()
custom.init_commands()
custom.init_keymaps()

-- plugin
if mode ~= "no-plugin" then
	_G.LAZY = require("183.plugins.init")

	_G.LAZY.check_and_install()
	_G.LAZY.init()
end
