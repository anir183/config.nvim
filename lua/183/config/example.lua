--[[ my own configuration as of 2026-June-01]]

---@module "183.config.types"

---@type 183.config.types.ConfigSpec
local M = {}

M.shell = "fish"

M.plugins = {}
M.plugins.additional = {}
M.plugins.overrides = {}
M.plugins.minimal_testing = {}

M.dev_tools = {}
M.dev_tools.lsps = {
	fish_lsp = {},
	clangd = {},
	basedpyright = {},
	svelte = {},
	tailwindcss = {},
	emmet_language_server = {},
	css_variables = {},
	csskit = {},
	-- cssls = {},
	cssmodules_ls = {},
	html = {},
}
-- :h conform-formatters or https://github.com/mfussenegger/nvim-lint#available-linters
M.dev_tools.ft_formatters = {
	lua = { "stylua" },
	css = { "prettier" },
	html = { "htmlbeautifier", "prettier" },
	c = { "clang-format" },
	svelte = { "prettier" },
	fish = { "fish_indent" },
	typescript = { "prettier" },
	javascript = { "prettier" },
	javascriptreact = { "prettier" },
	typescriptreact = { "prettier" },
	json = { "fixjson", "jq", "prettier" },
	jsonc = { "fixjson", "jq", "prettier" },
	python = { "isort", "ruff_fix", "ruff_format" },
}
-- https://github.com/mfussenegger/nvim-lint#available-linters
M.dev_tools.ft_linters = {
	python = { "ruff" },
	json = { "jsonlint" },
	html = { "htmlhint" },
}
-- https://github.com/jay-babu/mason-nvim-dap.nvim#advanced-customization
M.dev_tools.dap_handlers = {
	python = function()
		--[[ empty config as handled by nvim-dap-python ]]
	end,
}
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
	"$distrobox",
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
		_G.STLINE.components.distrobox = function()
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

M.leetcode_path = "/home/anir183/projects/comp_sci/leet"

return M
