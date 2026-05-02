--[[ default configuration values ]]

---@module "183.config.types"

---@type 183.config.types.ConfigSpec
local M = {}

-- misc general options
M.config_state = "default"
M.mode = "normal"
M.shell = nil
M.additional_fts = {}

-- some special functions
M.run_before_config = function() end
M.run_after_config = function() end

-- plugins related options
M.plugins = {}
M.plugins.additional = {}
M.plugins.overrides = {}
M.plugins.minimal_testing = {}

-- devtools related options
M.dev_tools = {}
M.dev_tools.lsps = {}
M.dev_tools.ft_formatters = {}
M.dev_tools.ft_linters = {}
M.dev_tools.dap_handlers = {}
M.dev_tools.custom_formatters = {}
M.dev_tools.custom_linters = {}

-- statusline related options
M.statusline = {}
M.statusline.bg_hl = { bg = "none" }
M.statusline.mode_labels = {
	n = "  normal  ",
	niI = "  insert [normal]  ",
	niR = "  replace [normal]  ",
	nt = "  terminal [normal]  ",
	i = "  insert  ",
	R = "  replace  ",
	v = "  visual  ",
	V = "  visual [line]  ",
	[""] = "  visual [block]  ",
	c = "  command  ",
	["!"] = "  command [external]  ",
	t = "  terminal  ",
}
M.statusline.arrangement = {
	-- left
	"$logo",
	"$mode",
	"$diagnostics",
	" ",
	"%r",
	"%w",
	"%h",
	"%m",

	"%=", -- break

	-- right
	"$gitinfo",
	" ",
	"$filename",
	" ",
	"$indent",
	" ",
	"$position",
}

-- logging related options
M.logging_opts = {}

M.logging_opts.logs_dir_parent = _G.CONSTS.path.state
M.logging_opts.display_after_ready = true

M.logging_opts.output = {}
M.logging_opts.output.notify = vim.log.levels.WARN
M.logging_opts.output.print = vim.log.levels.OFF
M.logging_opts.output.vim_print = vim.log.levels.OFF
M.logging_opts.output.file = vim.log.levels.INFO

return M
