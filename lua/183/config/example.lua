--[[ my own configuration as of 2026-May-08]]

---@module "183.config.types"

---@type 183.config.types.ConfigSpec
local M = {}

M.shell = "fish"

M.plugins = {}
M.plugins.additional = {}
M.plugins.overrides = {}
M.plugins.minimal_testing = {}

M.dev_tools = {}
M.dev_tools.lsps = {}
-- :h conform-formatters or https://github.com/mfussenegger/nvim-lint#available-linters
M.dev_tools.ft_formatters = {
	lua = { "stylua" },
}
-- https://github.com/mfussenegger/nvim-lint#available-linters
M.dev_tools.ft_linters = {}
-- https://github.com/jay-babu/mason-nvim-dap.nvim#advanced-customization
M.dev_tools.dap_handlers = {}
M.dev_tools.custom_formatters = {}
M.dev_tools.custom_linters = {}

M.cloak_patterns = {}

M.additional_fts = {
	{
		extension = {
			env = "dotenv",
		},
		filename = {
			[".env"] = "dotenv",
		},
		pattern = {
			["%.env%.[%w_.-]+"] = "dotenv",
			["%.env"] = "dotenv",
			["%.env%..+"] = "dotenv",
		},
	},
	{
		extension = {
			license = "",
		},
		filename = {
			["license"] = "license",
			["LICENSE"] = "license",
		},
	},
}

M.additional_parsers = {}

M.statusline = {}
M.statusline.arrangement = {
	-- left
	"$logo",
	"$mode",
	"$diagnostics",
	" ",
	"$dbox",
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

---@type fun(container_id?: string): boolean
local function in_distrobox(container_id)
	if not vim.env.container then
		return false
	end

	if not vim.env.CONTAINER_ID then
		return false
	end

	if not vim.env.DISTROBOX_ENTER_PATH then
		return false
	end

	if not container_id then
		return true
	end

	return container_id == vim.env.CONTAINER_ID
end

function M.run_after_config()
	if _G.STLINE then
		_G.STLINE.components.dbox = function()
			if in_distrobox() then
				return _G.FUNCS.fmt_str(
					"Function",
					"  " .. vim.env.CONTAINER_ID .. " "
				)
			else
				return ""
			end
		end
	end
end

return M
