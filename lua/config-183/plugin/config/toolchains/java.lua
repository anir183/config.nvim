--[[
--
-- nvim/lua/config-183/plugin/config/toolchains/java.lua
--
-- java toolset integration and setup
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "nvim-java/nvim-java"
plugin.name = "java"
plugin.dependencies = {
	"dap",
	"lspconfig",
	"nui",
}
plugin.cond = OPTS.toolchain.java
plugin.opts = {}
plugin.config = function(_, opts)
	require("nvim-java").setup(opts)

	vim.lsp.enable("jdtls")
end

return plugin
