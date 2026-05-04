--[[ handy configurations for different lsps ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "neovim/nvim-lspconfig"
plugin.name = "lspconfig"
plugin.config = function()
	-- NOTE : vim autoloads the lsp setup provided in the lua/ directory of the
	--        plugin (added to rtp by lazy)

	-- inject custom config and enable
	for name, conf in pairs(_G.CONF.dev_tools.lsps) do
		vim.lsp.config[name] = conf
		vim.lsp.enable(name)
	end
end

return plugin
