--[[ editor colors and highlighting ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "AvengeMedia/base46"
plugin.name = "base64"
plugin.priority = _G.CONSTS.lazy.priorities.highest
plugin.lazy = false
plugin.opts = {
	transparency = true,
}
plugin.config = function(_, opts)
	require("base46").setup(opts)
	vim.cmd.colorscheme("dms")
end

return plugin
