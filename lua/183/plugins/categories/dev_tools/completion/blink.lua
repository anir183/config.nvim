--[[ auto completion engine ]]

---@module "lazy"
---@module "blink"

---@type LazySpec
local plugin = {}
plugin[1] = "saghen/blink.cmp"
plugin.name = "blink"
plugin.main = "blink.cmp"
plugin.version = "1.*"
plugin.lazy = false
---@type blink.cmp.Config
plugin.opts = {
	keymap = {
		preset = "none",
	},
	completion = {
		list = {
			selection = {
				preselect = false,
				auto_insert = true,
			},
		},
		menu = {
			direction_priority = { "n", "s" },
			border = "rounded",
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind", gap = 1 },
					{ "source_name" },
				},
			},
		},
	},
	--snippets = {
	--	preset = "luasnip",
	--},
	sources = {
		default = {
			"lsp",
			"buffer",
			"snippets",
			"path",
		},
	},
}
plugin.keys = {
	-- show menu
	{
		mode = { "i", "s" },
		"<C-Space>",
		function()
			if not require("blink.cmp").is_visible() then
				require("blink.cmp").show()
			else
				_G.FUNCS.feedkeys("<C-Space>")
			end
		end,
		desc = "[plugin.blink] show completion menu",
	},

	-- hide or cancel completion menu
	{
		mode = { "i", "s" },
		"<C-c>",
		function()
			if require("blink.cmp").is_visible() then
				require("blink.cmp").hide()
			else
				_G.FUNCS.feedkeys("<C-c>")
			end
		end,
		desc = "[plugin.blink] hide completion menu",
	},
	{
		mode = { "i", "s" },
		"<C-x>",
		function()
			if require("blink.cmp").is_visible() then
				require("blink.cmp").cancel()
			else
				_G.FUNCS.feedkeys("<C-x>")
			end
		end,
		desc = "[plugin.blink] cancel completion and hide",
	},

	-- navigate completion menu
	{
		mode = { "i", "s" },
		"<TAB>",
		function()
			local blink = require("blink.cmp")
			if blink.is_visible() then
				blink.select_next()
				return
			end

			if not blink.snippet_forward() then
				_G.FUNCS.feedkeys("<TAB>")
			end
		end,
		desc = "[plugin.blink] next item in completion menu",
	},
	{
		mode = { "i", "s" },
		"<S-TAB>",
		function()
			local blink = require("blink.cmp")
			if blink.is_visible() then
				blink.select_prev()
				return
			end

			if not blink.snippet_backward() then
				_G.FUNCS.feedkeys("<S-TAB>")
			end
		end,
		desc = "[plugin.blink] prev item in completion menu",
	},

	-- accept completion
	{
		mode = { "i", "s" },
		"<CR>",
		function()
			if not require("blink.cmp").accept() then
				_G.FUNCS.feedkeys("<CR>")
			end
		end,
		desc = "[plugin.blink] accept completion suggestion",
	},

	-- documentation window ]]
	{
		mode = { "i", "s" },
		"<C-k>",
		function()
			local blink = require("blink.cmp")
			if blink.is_documentation_visible() then
				blink.hide_documentation()
			elseif blink.is_visible() then
				blink.show_documentation()
			else
				_G.FUNCS.feedkeys("<C-k>")
			end
		end,
		desc = "[plugin.blink] toggle documentation window",
	},
	{
		mode = { "i", "s" },
		"<C-d>",
		function()
			if not require("blink.cmp").scroll_documentation_down(1) then
				_G.FUNCS.feedkeys("<C-d>")
			end
		end,
		desc = "[plugin.blink] scroll down docs window",
	},
	{
		mode = { "i", "s" },
		"<C-u>",
		function()
			if not require("blink.cmp").scroll_documentation_up(1) then
				_G.FUNCS.feedkeys("<C-u>")
			end
		end,
		desc = "[plugin.blink] scroll up docs window",
	},
}

return plugin
