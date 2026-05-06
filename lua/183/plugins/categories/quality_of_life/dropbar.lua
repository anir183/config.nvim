--[[ breadcrumbs for code context and some navigation ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "Bekaboo/dropbar.nvim"
plugin.name = "dropbar"
plugin.lazy = false
plugin.keys = {
	{
		mode = "n",
		"<leader>;",
		function()
			require("dropbar.api").pick()
		end,
		desc = "[plugin.dropbar] pick symbols in winbar",
	},
	{
		mode = "n",
		"[;",
		function()
			require("dropbar.api").goto_context_start()
		end,
		desc = "[plugin.dropbar] go to start of current context",
	},
	{
		mode = "n",
		"];",
		function()
			require("dropbar.api").select_next_context()
		end,
		desc = "[plugin.dropbar] select next context",
	},
}

return plugin
