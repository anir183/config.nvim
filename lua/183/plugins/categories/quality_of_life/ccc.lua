--[[ color picker ]]

---@module "lazy"
---@module "ccc"

---@type LazySpec
local plugin = {}

plugin[1] = "uga-rosa/ccc.nvim"
plugin.name = "color-picker"
plugin.lazy = false
---@type ccc.Options.P
plugin.opts = {}
plugin.keys = {
	{
		mode = "n",
		"<leader>ol",
		vim.cmd.CccPick,
		desc = "[plugin.color-picker] open c[OL]or picker",
	},
	{
		mode = "n",
		"<leader>hl",
		vim.cmd.CccHighlighterToggle,
		desc = "[plugin.color-picker] toggle color [H]igh[L]ighting",
	},
	{
		mode = "n",
		"<leader>vc",
		vim.cmd.CccConvert,
		desc = "[plugin.color-picker] con[V]ert [C]olor",
	},
}

return plugin
