--[[
--
-- nvim/lua/config-183/plugin/config/quality_of_life/tiny_inline_diagnostics.lua
--
-- quick inline diagnostics with more information
--
--]]

---@module "vim"
---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "rachartier/tiny-inline-diagnostic.nvim"
plugin.name = "tiny-inline-diagnostic"
plugin.lazy = false
plugin.opts = {
	preset = "classic",
	transparent_bg = true,
	options = {
		show_code = false,
		show_source = {
			enabled = true,
		},
		add_messages = {
			display_count = true,
		},
		multilines = {
			enabled = true,
		},
		show_all_diags_on_cursorline = true,
		show_diags_only_under_cursor = true,
		override_open_float = true,
		experimental = {
			-- Make diagnostics not mirror across windows containing the same buffer
			-- See: https://github.com/rachartier/tiny-inline-diagnostic.nvim/issues/127
			use_window_local_extmarks = true,
		},
	},
	blend = {
		factor = 0.22,
	},
}
plugin.config = function(_, opts)
	require("tiny-inline-diagnostic").setup(opts)
	vim.diagnostic.config({ virtual_text = false }) -- disable neovim's default virtual text diagnostics
end
plugin.keys = {
	{
		mode = "n",
		"<leader>ti",
		"<CMD>TinyInlineDiag toggle<CR>",
		desc = "[plugin/tiny-inline-diagnostic]: [T]oggle [I]nline dagnostics",
	},
}

return plugin
