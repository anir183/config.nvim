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
		"<leader>ct",
		vim.cmd.CloakPreviewLine,
		desc = "[plugin.cloak] [C]loak curren[T] line preview",
	},
	{
		mode = "n",
		"<leader>CT",
		vim.cmd.CloakToggle,
		desc = "[plugin.cloak] [C]loak hiding [T]oggle",
	},
}

return plugin
