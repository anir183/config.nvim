--[[
--
-- nvim/lua/config-183/plugin/config/essentials/harpoon.lua
--
-- quick file and buffer switcher
--
--]]

---@module "vim"
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
		"<leader>H",
		function()
			local harpoon = require("harpoon")
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end,
		desc = "[plugin/harpoon]: open [H]arpoon list",
	},
	{
		mode = "n",
		"<leader>h",
		function()
			require("harpoon"):list():add()
			vim.notify(
				"added file to harpoon list: " .. vim.fn.expand("%:t"),
				vim.log.levels.INFO
			)
		end,
		desc = "[plugin/harpoon]: add file to [H]arpoon list",
	},

	-- navigation
	{
		mode = "n",
		"<leader>1",
		function()
			require("harpoon"):list():select(1)
		end,
		desc = "[plugin/harpoon]: navigate to file [1]",
	},
	{
		mode = "n",
		"<leader>2",
		function()
			require("harpoon"):list():select(2)
		end,
		desc = "[plugin/harpoon]: navigate to file [2]",
	},
	{
		mode = "n",
		"<leader>3",
		function()
			require("harpoon"):list():select(3)
		end,
		desc = "[plugin/harpoon]: navigate to file [3]",
	},
	{
		mode = "n",
		"<leader>4",
		function()
			require("harpoon"):list():select(4)
		end,
		desc = "[plugin/harpoon]: navigate to file [4]",
	},
	{
		mode = "n",
		"<leader>5",
		function()
			require("harpoon"):list():select(5)
		end,
		desc = "[plugin/harpoon]: navigate to file [5]",
	},
	{
		mode = "n",
		"]h",
		function()
			require("harpoon"):list():next()
		end,
		desc = "[plugin/harpoon]: navigate to next file in list",
	},
	{
		mode = "n",
		"[h",
		function()
			require("harpoon"):list():prev()
		end,
		desc = "[plugin/harpoon]: navigate to previous file in list",
	},
}

return plugin
