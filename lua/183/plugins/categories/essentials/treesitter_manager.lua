--[[ install and manager treesitter parsers ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "romus204/tree-sitter-manager.nvim"
plugin.name = "tree-sitter-manager"
plugin.lazy = false
plugin.opts = {
	auto_install = true,
	highlight = true,
	languages = _G.CONF.additional_parsers,
}
plugin.keys = {
	{
		mode = "n",
		"<leader>tm",
		"<CMD>TSManager<CR>",
		desc = "[plugin.tsmanager] [T]ree-sitter [M]anager interface",
	},
}

return plugin
