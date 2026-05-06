--[[ default configuration values ]]

---@module "183.config.types"

---@type 183.config.types.ConfigSpec
local M = {}

-- misc general options
M.mode = "normal"
M.shell = nil
M.update_time = 500
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
M.dev_tools.ft_formatters = {} --- :h conform-formatters or https://github.com/mfussenegger/nvim-lint#available-linters
M.dev_tools.ft_linters = {} --- https://github.com/mfussenegger/nvim-lint#available-linters
M.dev_tools.dap_handlers = {} --- https://github.com/jay-babu/mason-nvim-dap.nvim#advanced-customization
M.dev_tools.custom_formatters = {}
M.dev_tools.custom_linters = {}

-- obsfurcation patterns
M.cloak_patterns = {}

-- treesitter parsers
M.additional_parsers = {}

-- statusline related options
M.statusline = {}
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
	"   ",
	"$filename",
	"   ",
	"$indent",
	"   ",
	"$position",
}

return M
