--[[ setup buffer indentation based on file content ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "nmac427/guess-indent.nvim"
plugin.name = "guess-indent"
plugin.lazy = false
plugin.opts = {}
plugin.keys = {
	{
		mode = "n",
		"<leader>ai",
		"<CMD>GuessIndent<CR>",
		desc = "[plugin.guess-indent] [A]uto guess [I]ndentation",
	},
}

return plugin
