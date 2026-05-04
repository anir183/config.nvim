--[[ quick file and buffer switcher ]]

---@module "lazy"
---@module "harpoon"

---@type LazySpec
local plugin = {}

plugin[1] = "ThePrimeagen/harpoon"
plugin.name = "harpoon"
plugin.branch = "harpoon2"
plugin.dependencies = "plenary"
plugin.lazy = false
---@type HarpoonPartialConfig
plugin.opts = {
	settings = {
		save_on_toggle = true,
		sync_on_ui_close = true,
	},
}
plugin.keys = {
	-- general
	{
		mode = "n",
		"<leader>HH",
		function()
			local harpoon = require("harpoon")
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end,
		desc = "[plugin.harpoon] open [H]arpoon list",
	},
	{
		mode = "n",
		"<leader>hh",
		function()
			require("harpoon"):list():add()
			vim.notify(
				"added file to harpoon list: " .. vim.fn.expand("%:t"),
				vim.log.levels.INFO
			)
		end,
		desc = "[plugin.harpoon] add file to [H]arpoon list",
	},

	-- navigation
	{
		mode = "n",
		"<C-1>",
		function()
			require("harpoon"):list():select(1)
		end,
		desc = "[plugin.harpoon] navigate to file [1]",
	},
	{
		mode = "n",
		"<C-2>",
		function()
			require("harpoon"):list():select(2)
		end,
		desc = "[plugin.harpoon] navigate to file [2]",
	},
	{
		mode = "n",
		"<C-3>",
		function()
			require("harpoon"):list():select(3)
		end,
		desc = "[plugin.harpoon] navigate to file [3]",
	},
	{
		mode = "n",
		"<C-4>",
		function()
			require("harpoon"):list():select(4)
		end,
		desc = "[plugin.harpoon] navigate to file [4]",
	},
	{
		mode = "n",
		"<C-5>",
		function()
			require("harpoon"):list():select(5)
		end,
		desc = "[plugin.harpoon] navigate to file [5]",
	},
	{
		mode = "n",
		"]h",
		function()
			require("harpoon"):list():next()
		end,
		desc = "[plugin.harpoon] navigate to next file in list",
	},
	{
		mode = "n",
		"[h",
		function()
			require("harpoon"):list():prev()
		end,
		desc = "[plugin.harpoon] navigate to previous file in list",
	},
}

return plugin
