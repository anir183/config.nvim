--[[ track context of cursor position ]]

---@module "lazy"
---@module "treesitter-context"

---@type LazySpec
local plugin = {}

plugin[1] = "nvim-treesitter/nvim-treesitter-context"
plugin.name = "treesitter-context"
plugin.lazy = false
---@type TSContext.UserConfig
plugin.opts = {
	multiwindow = true,
}
plugin.keys = {
	{
		mode = "n",
		"<leader>tc",
		"<CMD>TSContext toggle<CR>",
		desc = "[plugin.treesitter-context] toggle [T]reesitter [C]ontext",
	},
}

return plugin
