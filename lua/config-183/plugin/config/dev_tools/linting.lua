--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/linting.lua
--
-- linting engine
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "mfussenegger/nvim-lint"
plugin.name = "lint"
plugin.dependencies = "mason"
plugin.lazy = false
plugin.config = function()
	local lint = require("lint")

	lint.linters_by_ft = OPTS.lint.ft_linters
	lint.linters = OPTS.lint.available_linters

	vim.api.nvim_create_autocmd({
		"BufEnter",
		"BufWritePre",
		"InsertLeave",
	}, {
		group = VARS.augrp.id,
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
		desc = "[plugin/nvim-lint]: perform [L]i[N]ting on current file",
	},
}

return plugin
