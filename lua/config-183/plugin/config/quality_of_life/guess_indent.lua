--[[
--
-- nvim/lua/config-183/plugin/config/quality_of_life/guess_indent.lua
--
-- setup buffer indentation based on file content
--
--]]

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
				snacks_layout_box = false,
				snacks_picker_input = false,
				snacks_terminal = false,
				snacks_picker_list = false,
				snacks_picker_preview = false,
				snacks_input = false,
			}

			if ft == "" or ftstates[ft] == false then
				return
			end

			vim.cmd.GuessIndent()
			vim.opt_local.listchars:remove("leadmultispace")
			vim.opt_local.listchars:append({
				leadmultispace = "▎"
					.. ("∙"):rep(vim.opt_local.tabstop._value - 1),
			})
			---@diagnostic disable-next-line: undefined-field
			LOG.info("set indentation: " .. (vim.opt_local.expandtab._value and "spaces" or "tabs") .. ":" .. vim.opt_local.tabstop._value)
			---@diagnostic disable-next-line: undefined-field
			LOG.debug((vim.opt_local.expandtab._value and "spaces" or "tabs") .. ":" .. vim.opt_local.tabstop._value, vim.fn.expand("%:p"))
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
