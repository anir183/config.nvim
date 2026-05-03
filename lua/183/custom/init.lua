--[[ custom config and functionality from neovim api ]]

---@module "183.custom.types"

---@type 183.custom.types.Module
local M = {}

function M.init_netrw()
	vim.g.netrw_winsize = 17 -- netrw sidebar width

	_G.NETRW = require("183.custom.netrw")

	_G.NETRW.create_commands()
	_G.NETRW.create_keymaps()
end

return M
