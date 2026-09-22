--[[ my own configuration as of 2026-Sept-22]]

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

M.leetcode_path = "/home/anir183/workspace/sandbox/leetcode"

return M
