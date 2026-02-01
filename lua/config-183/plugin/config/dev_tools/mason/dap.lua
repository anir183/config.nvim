--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/mason/dap.lua
--
-- bridge between dap and mason
--
--]]

---@module "vim
---@module "lazy"
---@module "config-183.utils"
---@module "config-183.utils.logging"
---@module "config-183.options"
---@module "config-183.options.defaults"

---@type LazySpec
local plugin = {}

plugin[1] = "jay-babu/mason-nvim-dap.nvim"
plugin.name = "mason-dap"
plugin.dependencies = {
	"mason",
	"dap",
}
plugin.config = function()
	local mason_dap = require("mason-nvim-dap")

	-- variables be used in the mason-dap setup function
	local ensure_installed = {}
	local handlers = {
		function(config)
			mason_dap.default_setup(config)
		end,
	}

	-- populate the variables from settings data
	for name, handler in pairs(OPTS.dap.mason_dap) do
		table.insert(ensure_installed, name)

		if handler and type(handler) == "function" then
			handlers[name] = handler
			LOG.info("mason dap handler setup: " .. name)
			LOG.debug(handler)
		end
	end

	-- setup mason_dap
	mason_dap.setup({
		ensure_installed = ensure_installed,
		handlers = handlers,
		automatic_installation = true,
	})

	-- defer config of all daps to give mason-nvim-dap time to setup
	vim.defer_fn(function()
		local dap = require("dap")

		for name, adapter in pairs(OPTS.dap.adapters) do
			if adapter then
				dap.adapters[name] = adapter
				LOG.info("setup adapter definition for: " .. name)
				LOG.debug(adapter)
			end
		end
		for name, config in pairs(OPTS.dap.configuration) do
			if config then
				dap.configurations[name] = config
				LOG.info("setup adapter configuration for: " .. name)
				LOG.debug(config)
			end
		end
	end, 2000)
end

return plugin
