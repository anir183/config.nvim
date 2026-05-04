--[[ linting engine ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "mfussenegger/nvim-lint"
plugin.name = "lint"
plugin.lazy = false
plugin.config = function()
	local lint = require("lint")

	---@diagnostic disable-next-line: assign-type-mismatch
	lint.linters_by_ft = _G.CONF.dev_tools.ft_linters
	for name, linter in pairs(_G.CONF.dev_tools.custom_linters) do
		lint.linters[name] = linter
	end

	vim.api.nvim_create_autocmd({
		"BufEnter",
		"BufWritePre",
		"InsertLeave",
	}, {
		group = _G.CONSTS.augrp.id,
		callback = function()
			lint.try_lint()
		end,
	})
end
plugin.keys = {
	{
		mode = "n",
		"<leader>ln",
		function()
			require("lint").try_lint()
		end,
		desc = "[plugin.nvim-lint] perform [L]i[N]ting on current file",
	},
}

return plugin
