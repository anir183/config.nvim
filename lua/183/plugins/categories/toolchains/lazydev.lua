--[[ setup lua_ls for neovim configurations ]]

---@module "lazy"
---@module "lazydev"

---@type LazySpec
local plugin = {}

plugin[1] = "folke/lazydev.nvim"
plugin.name = "lazydev"
---@module "lazydev"
---@type lazydev.Config
plugin.opts = {
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ "nvim-dap-ui" },
	},
	integrations = {
		blink = true,
	},
}

return plugin
