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
	require("183.custom.git_info").setup()

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
end

function M.init_keymaps()
	local keymaps = require("183.custom.keymaps")

	for desc, map in pairs(keymaps) do
		map.opts = map.opts or {}
		map.opts.desc = "[custom." .. (map.category or "misc") .. "] " .. desc

		_G.FUNCS.map(map.mode or "n", map.lhs, map.rhs, map.opts)
	end
end

return M
