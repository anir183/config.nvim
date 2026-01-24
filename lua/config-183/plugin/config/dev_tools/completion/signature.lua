--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/completion/signature.lua
--
-- lsp signature help virtual text and window
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "ray-x/lsp_signature.nvim"
plugin.name = "lsp-signature"
plugin.lazy = false
plugin.opts = {
	floating_window = false,
	floating_window_off_x = 2,
	floating_window_off_y = 1,
	doc_lines = 0,
	hint_prefix = {
		above = "🡯 ",
		current = "🡨 ",
		below = "🡬 ",
	},
	handler_opts = {
		border = "none",
	},
	-- WARN : broken
	--        https://github.com/ray-x/lsp_signature.nvim/issues/367
	-- select_signature_key = "<M-n>",
}
plugin.keys = {
	{
		mode = { "i", "s" },
		"<C-s>",
		function()
			require("lsp_signature").toggle_float_win()
		end,
		desc = "[plugin/lsp_signature]: toggle signature widow",
	},
}

return plugin
