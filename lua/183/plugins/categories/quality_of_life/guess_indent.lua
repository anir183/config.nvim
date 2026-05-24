--[[ setup buffer indentation based on file content ]]

---@module "lazy"
---@module "guess-indent"

---@type LazySpec
local plugin = {}

plugin[1] = "nmac427/guess-indent.nvim"
plugin.name = "guess-indent"
plugin.lazy = false
---@type GuessIndentConfig
plugin.opts = {
	auto_cmd = true,
}
plugin.config = function(_, opts)
	local guess = require("guess-indent")
	guess.setup(opts)

	-- made to work after the following aucmd
	-- https://github.com/NMAC427/guess-indent.nvim/blob/84a4987ff36798c2fc1169cbaff67960aed9776f/lua/guess-indent/init.lua#L30
	vim.api.nvim_create_autocmd({
		"BufReadPost",
		"BufWritePost",
		"BufNewFile",
	}, {
		group = CONSTS.augrp.id,
		desc = "set leadmultispace after guess does its job",
		callback = function(_)
			vim.defer_fn(function()
				vim.opt_local.listchars:remove("leadmultispace")
				vim.opt_local.listchars:append({
					leadmultispace = "▎" .. ("∙"):rep(vim.bo.tabstop - 1),
				})
			end, 300)
		end,
	})
end
plugin.keys = {
	{
		mode = "n",
		"<leader>ai",
		function()
			vim.cmd.GuessIndent()
			vim.opt_local.listchars:remove("leadmultispace")
			vim.opt_local.listchars:append({
				leadmultispace = "▎" .. ("∙"):rep(vim.bo.tabstop - 1),
			})
		end,
		desc = "[plugin.guess-indent] [A]uto guess [I]ndentation",
	},
}

return plugin
