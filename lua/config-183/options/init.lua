--[[
--
-- nvim/lua/config-183/options/init.lua
--
-- bootstrap quick options
-- this module bootstraps and merges quick editable options into the global
-- options variable to be used in the config
-- this allows setting options in a single file on-the-go without needing to
-- dive into the whole config project
--
--]]

---@module "vim"
---@module "config-183.utils"
---@module "config-183.utils.logging"
---@module "config-183.options"
---@module "config-183.options.defaults"
---@module "config-183.options.custom"
---@module "config-183.custom"
---@module "config-183.custom.statusline"
---@module "config-183.plugin"
---@module "config-183.plugin.init"

LOG.info("loading editable options")

_G.OPTS = require("config-183.options.defaults")
if pcall(require, "config-183.options.custom") then
	OPTS = vim.tbl_deep_extend(
		"force",
		OPTS,
		require("config-183.options.custom") or {}
	)
	vim.api.nvim_create_autocmd("VimEnter", {
		group = VARS.augrp.id,
		callback = function()
			vim.notify("using custom options", vim.log.levels.INFO)
		end,
	})
	LOG.info("found and using custom options")
	LOG.debug(require("config-183.options.custom"))
else
	LOG.info("using default options as no custom options found")
end

VARS = vim.tbl_deep_extend("force", VARS or {}, OPTS.util_vars or {})
LOG.info("merged editable options into global variables")
LOG.debug(OPTS.util_vars or {})

LOG.opts = vim.tbl_deep_extend("force", LOG.opts or {}, OPTS.log_opts or {})
LOG.info("merged editable options into logging library options")
LOG.debug(OPTS.log_opts or {})
if OPTS.log_opts and OPTS.log_opts.file_dir then
	LOG.init()
	LOG.info("reinitialised logging files")
end

_G.STLINE = vim.tbl_deep_extend("force", STLINE or {}, OPTS.stline_otps or {})
LOG.info("merged editable options into statusline options")
LOG.debug(OPTS.stline_otps or {})

_G.LAZY = vim.tbl_deep_extend("force", LAZY or {}, OPTS.lazy_opts or {})
LOG.info("merged editable options into lazy.nvim bootstrapping options")
LOG.debug(OPTS.lazy_opts or {})

if vim.g.MODE then
	OPTS.mode = vim.g.MODE
	LOG.info("found vim.g.MODE variable, will use this as mode")
end

LOG.info("editable options loaded")
