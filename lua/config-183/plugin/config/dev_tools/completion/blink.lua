--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/completion/blink.lua
--
-- auto completion engine
--
--]]

---@module "lazy"
---@module "blink"
---@module "blink-cmp"
---@module "config-183.utils"
---@module "config-183.utils.functions"

---@type LazySpec
local plugin = {}

plugin[1] = "saghen/blink.cmp"
plugin.name = "blink"
plugin.main = "blink.cmp"
plugin.version = "1.*"
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
			border = "rounded",
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind", gap = 1 },
					{ "source_name" }
				},
			},
		},
	},
	sources = OPTS.cmp_sources,
}
plugin.config = function(_, opts)
	local blink = require("blink.cmp")
	blink.setup(opts)

	--[[ keymaps ]]
	local map = FUNCS.map
	local feedkeys = FUNCS.feedkeys

	--[[ show menu ]]
	map({ "i", "s" }, "<C-Space>", function()
		if not blink.is_visible() then
			blink.show()
		else
			feedkeys("<C-Space>")
		end
	end, "[plugin/blink]: show completion menu")

	--[[ hide or cancel completion menu ]]
	map({ "i", "s" }, "<C-c>", function()
		if blink.is_visible() then
			blink.hide()
		else
			feedkeys("<C-c>")
		end
	end, "[plugin/blink]: hide completion menu")
	map({ "i", "s" }, "<C-x>", function()
		if blink.is_visible() then
			blink.cancel()
		else
			feedkeys("<C-x>")
		end
	end, "[plugin/blink]: cancel completion and hide")

	--[[ navigate completion menu ]]
	map({ "i", "s" }, "<TAB>", function()
		if blink.is_visible() then
			blink.select_next()
			return
		end

		if not blink.snippet_forward() then
			feedkeys("<TAB>")
		end
	end, "[plugin/blink]: next item in completion menu")
	map({ "i", "s" }, "<S-TAB>", function()
		if blink.is_visible() then
			blink.select_prev()
			return
		end

		if not blink.snippet_backward() then
			feedkeys("<S-TAB>")
		end
	end, "[plugin/blink]: prev item in completion menu")

	--[[ accept completion ]]
	map({ "i", "s" }, "<CR>", function()
		if not blink.accept() then
			feedkeys("<CR>")
		end
	end, "[plugin/blink]: accept completion suggestion")

	--[[ documentation window ]]
	map({ "i", "s" }, "<C-k>", function()
		if blink.is_documentation_visible() then
			blink.hide_documentation()
		elseif blink.is_visible() then
			blink.show_documentation()
		else
			feedkeys("<C-k>")
		end
	end, "[plugin/blink]: toggle documentation window")
	map({ "i", "s" }, "<C-d>", function()
		if not blink.scroll_documentation_down(1) then
			feedkeys("<C-d>")
		end
	end, "[plugin/blink]: scroll down docs window")
	map({ "i", "s" }, "<C-u>", function()
		if not blink.scroll_documentation_up(1) then
			feedkeys("<C-u>")
		end
	end, "[plugin/blink]: scroll up docs window")
end

return plugin
