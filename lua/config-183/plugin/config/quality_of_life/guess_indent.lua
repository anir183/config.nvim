--[[
--
-- nvim/lua/config-183/plugin/config/quality_of_life/guess_indent.lua
--
-- setup buffer indentation based on file content
--
--]]

---@module "vim"
---@module "lazy"
---@module "config-183.utils"
---@module "config-183.utils.logging"
---@module "config-183.utils.variables"
---@module "config-183.utils.functions"

---@type LazySpec
local plugin = {}

plugin[1] = "nmac427/guess-indent.nvim"
plugin.name = "guess-indent"
plugin.lazy = false
---@type GuessIndentConfig
plugin.opts = {
	auto_cmd = false,
}
plugin.config = function(_, opts)
	require("guess-indent").setup(opts)

	vim.api.nvim_create_user_command(
		VARS.strings.cmd_prefix .. "AutoSetIndent",
		function()
			local ft = vim.bo.filetype
			local ftstates = {
				help = false,
				netrw = false,
				oil = false,
				tutor = false,
				nofile = false,
				terminal = false,
				prompt = false,
				harpoon = false,
				fidget = false,
				undotree = false,
				["blink-cmp-menu"] = false,
				["blink-cmp-documentation"] = false,
				snacks_layout_box = false,
				snacks_picker_input = false,
				snacks_terminal = false,
				snacks_picker_list = false,
				snacks_picker_preview = false,
				snacks_input = false,
				oil_preview = false,
				conf = false,
				rc = false,
				text = false,
				trouble = false,
				sagafinder = false,
				sagaoutline = false,
				beacon = false,
				mason = false,
				lazy = false,
				lazygit = false,
				diff = false,
				man = false,
			}

			if ft == "" or ftstates[ft] == false then
				return
			end

			require("guess-indent").set_from_buffer(nil, true, true)
			vim.opt_local.shiftwidth = 0 -- size of each level of indentation (0 -> tabstop)
			vim.opt_local.softtabstop = -1 -- size of tab character in insert mode (-1 -> shiftwidth)
			vim.opt_local.listchars:remove("leadmultispace")
			vim.opt_local.listchars:append({
				leadmultispace = "▎"
					---@diagnostic disable-next-line: undefined-field
					.. ("∙"):rep(vim.opt_local.tabstop._value - 1),
			})
			LOG.info(
				"set indentation: "
					---@diagnostic disable-next-line: undefined-field
					.. (vim.opt_local.expandtab._value and "spaces" or "tabs")
					.. ":"
					---@diagnostic disable-next-line: undefined-field
					.. vim.opt_local.tabstop._value
			)
			LOG.debug(
				---@diagnostic disable-next-line: undefined-field
				(vim.opt_local.expandtab._value and "spaces" or "tabs")
					.. ":"
					---@diagnostic disable-next-line: undefined-field
					.. vim.opt_local.tabstop._value,
				vim.fn.expand("%:p")
			)
		end,
		{ desc = "[plugin/guess-indent]: auto set indent" }
	)

	FUNCS.auto_set_indents = function()
		vim.cmd(VARS.strings.cmd_prefix .. "AutoSetIndent")
	end
	LOG.info("created global auto indent function")
	LOG.debug(FUNCS)

	vim.api.nvim_create_autocmd("BufEnter", {
		group = VARS.augrp.id,
		command = VARS.strings.cmd_prefix .. "AutoSetIndent",
	})
end

return plugin
