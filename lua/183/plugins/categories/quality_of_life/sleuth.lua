--[[ setup buffer indentation based on project files content ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "tpope/vim-sleuth"
plugin.name = "sleuth"
plugin.lazy = false
plugin.keys = {
	{
		mode = "n",
		"<leader>ai",
		"<CMD>Sleuth<CR>",
		desc = "[plugin.sleuth] [A]uto guess [I]ndentation",
	},
}

return plugin
