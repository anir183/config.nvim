--[[ bridge between dap and mason ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "jay-babu/mason-nvim-dap.nvim"
plugin.name = "mason-dap"
plugin.main = "mason-nvim-dap"
plugin.dependencies = {
	"mason",
	"dap",
}
plugin.opts = {
	handlers = _G.CONF.dev_tools.dap_handlers,
	automatic_installation = true,
}

return plugin
