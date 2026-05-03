--[[ custom config and functionality from neovim api ]]

---@module "183.custom.types"

---@type 183.custom.types.Module
local M = {}

function M.init_netrw()
	_G.NETRW = require("183.custom.netrw")
	vim.g.netrw_winsize = 17 -- netrw sidebar width

	_G.NETRW.create_commands()
	_G.NETRW.create_keymaps()
end

function M.init_statusline()
	_G.STLINE = require("183.custom.statusline")
	_G.STLINE.set_arrangement()

	vim.o.showmode = false -- dont show current mode name in command line (handled by statusline)
	vim.o.ruler = false -- dont show line and col number (handled by statusline)
end

function M.init_commands()
	local commands = require("183.custom.commands")

	for desc, command in pairs(commands) do
		command.opts = command.opts or {}
		command.opts.desc = "[custom] " .. desc

		vim.api.nvim_create_user_command(
			_G.CONSTS.strings.cmd_prefix .. command.name,
			command.cmd,
			command.opts
		)
	end

	_G.LOG.debug("setup custom commands")
end

return M
