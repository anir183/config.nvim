--[[ improved ui and workflow for quickfix ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "stevearc/quicker.nvim"
plugin.name = "quicker"
plugin.lazy = false
plugin.opts = {
	keys = {
		{
			">",
			function()
				require("quicker").expand({
					before = 2,
					after = 2,
					add_to_existing = true,
				})
			end,
			desc = "[plugin.quicker] expand quickfix context",
		},
		{
			"<",
			function()
				require("quicker").collapse()
			end,
			desc = "[plugin.quicker] collapse quickfix context",
		},
	},
}
plugin.keys = {
	{
		mode = "n",
		"<leader>ql",
		function() require("quicker").toggle() end,
		desc = "[plugin.quicker] toggle [Q]uick fix [L]ist",
	},
	{
		mode = "n",
		"<leader>QL",
		function() require("quicker").toggle() end,
		desc = "[plugin.quicker] toggle [Q]uick fix [L]ist",
	},
	{
		mode = "n",
		"<leader>ll",
		function()
			require("quicker").toggle({ loclist = true })
		end,
		desc = "[plugin.quicker] toggle [Q]uick fix [L]ist",
	},
	{
		mode = "n",
		"<leader>LL",
		function()
			require("quicker").toggle({ loclist = true })
		end,
		desc = "[plugin.quicker] toggle [Q]uick fix [L]ist",
	},
}

return plugin
