--[[ hiding some sensitive patterns or tokens (just in case) ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "laytan/cloak.nvim"
plugin.name = "cloak"
plugin.lazy = false
plugin.opts = {
	cloak_character = "*",
	patterns = {},
}
plugin.keys = {
	{
		mode = "n",
		"<leader>tp",
		vim.cmd.CloakPreviewLine,
		desc = "[plugin.cloak] cloak curren[T] line [P]review",
	},
	{
		mode = "n",
		"<leader>ht",
		vim.cmd.CloakToggle,
		desc = "[plugin.cloak] cloak [H]iding [T]oggle",
	},
}

return plugin
