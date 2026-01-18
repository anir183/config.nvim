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

LOG.info("loading editable options")

OPTS = require("config-183.options.defaults")
if pcall(require, "config-183.options.custom") then
	OPTS = vim.tbl_deep_extend(
		"force",
		OPTS,
		require("config-183.options.custom") or {}
	)
	LOG.info("found and using custom options")
	LOG.debug(require("config-183.options.custom"))
end

VARS = vim.tbl_deep_extend(
	"force",
	VARS or {},
	OPTS.util_vars or {}
)
LOG.info("merged editable options into global variables")
LOG.debug(OPTS.util_vars or {})

LOG.opts = vim.tbl_deep_extend(
	"force",
	LOG.opts or {},
	OPTS.log_opts or {}
)
LOG.info("merged editable options into logging library options")
LOG.debug(OPTS.log_opts or {})
if OPTS.log_opts and (OPTS.log_opts.file_path or OPTS.log_opts.file_action) then
	LOG.perform_file_action()
	LOG.info("regenerated log file after updating log options")
end

LOG.info("editable options loaded")
