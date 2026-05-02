--[[ core config module and setup ]]

---@module "183.core.types"

---@type 183.core.types.Module
local M = {}

function M.init_options()
	local options = require("183.core.options")

	options.set_colorscheme()
	options.set_signcolumn()
	options.set_folding()
	options.set_indentation()
	options.set_editor_rendering()
	options.set_save_files()

	_G.LOG.debug("setup core options")
end

return M
