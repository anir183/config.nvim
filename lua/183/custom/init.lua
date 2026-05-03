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

return M
