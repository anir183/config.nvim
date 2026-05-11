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
	auto_cmd = false,
}
plugin.config = function(_, opts)
	local guess = require("guess-indent")
	guess.setup(opts)

	---@source https://github.com/NMAC427/guess-indent.nvim/blob/84a4987ff36798c2fc1169cbaff67960aed9776f/lua/guess-indent/init.lua#L30
	local augroup = vim.api.nvim_create_augroup("GuessIndent", { clear = true })
	vim.api.nvim_create_autocmd("BufReadPost", {
		group = augroup,
		desc = "guesss indentation when loading a file",
		callback = function(args)
			---@diagnostic disable-next-line: param-type-mismatch
			guess.set_from_buffer(args.buf, true, true)
			vim.opt_local.listchars:remove("leadmultispace")
			vim.opt_local.listchars:append({
				leadmultispace = "▎" .. ("∙"):rep(vim.bo.tabstop - 1),
			})
		end,
	})
	vim.api.nvim_create_autocmd("BufNewFile", {
		group = augroup,
		desc = "guess indentation when saving a new file",
		callback = function(args)
			vim.api.nvim_create_autocmd("BufWritePost", {
				buffer = args.buf,
				once = true,
				group = augroup,
				callback = function(wargs)
					---@diagnostic disable-next-line: param-type-mismatch
					guess.set_from_buffer(wargs.buf, true, true)
					vim.opt_local.listchars:remove("leadmultispace")
					vim.opt_local.listchars:append({
						leadmultispace = "▎" .. ("∙"):rep(vim.bo.tabstop - 1),
					})
				end,
			})
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
