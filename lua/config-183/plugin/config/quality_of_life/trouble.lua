--[[
--
-- nvim/lua/config-183/plugin/config/quality_of_life/trouble.lua
--
-- pretty list for diagnostics, lsp info, quick fix and location lists
--
--]]

---@module "lazy"
---@module "config-183.utils"
---@module "config-183.utils.logging"

---@type LazySpec
local plugin = {}

plugin[1] = "folke/trouble.nvim"
plugin.name = "trouble"
plugin.lazy = false
---@type trouble.Config
plugin.opts = {}
plugin.keys = {
	{
		"<leader>td",
		"<CMD>Trouble diagnostics toggle<CR>",
		desc = "[plugin/trouble]: [T]rouble [D]iagnostics",
	},
	{
		"<leader>tb",
		"<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
		desc = "[plugin/trouble]: [T]rouble [B]uffer diagnostics",
	},
	{
		"<leader>ty",
		"<CMD>Trouble symbols toggle focus=false win.position=left<CR>",
		desc = "[plugin/trouble]: [T]rouble s[Y]mbols",
	},
	{
		"<leader>tl",
		"<CMD>Trouble lsp toggle focus=false win.position=left<CR>",
		desc = "[plugin/trouble]: [T]rouble [L]sp information",
	},
	{
		"<leader>l",
		"<CMD>Trouble loclist toggle<CR>",
		desc = "[plugin/trouble]: trouble [L]ocation list",
	},
	{
		"<leader>q",
		"<CMD>Trouble qflist toggle<CR>",
		desc = "[plugin/trouble]: trouble [Q]uick fix list",
	},
	{
		"[q",
		function()
			if require("trouble").is_open() then
				---@diagnostic disable-next-line: missing-fields, missing-parameter
				require("trouble").prev({ skip_groups = true, jump = true })
			else
				local ok, err = pcall(vim.cmd.cprev)
				if not ok then
					LOG.error("error while navigating trouble quickfix")
					LOG.debug(err)
				end
			end
		end,
		desc = "Previous Trouble/Quickfix Item",
	},
	{
		"]q",
		function()
			if require("trouble").is_open() then
				---@diagnostic disable-next-line: missing-fields, missing-parameter
				require("trouble").next({ skip_groups = true, jump = true })
			else
				local ok, err = pcall(vim.cmd.cnext)
				if not ok then
					LOG.error("error while navigating trouble quickfix")
					LOG.debug(err)
				end
			end
		end,
		desc = "Next Trouble/Quickfix Item",
	},
}

return plugin
