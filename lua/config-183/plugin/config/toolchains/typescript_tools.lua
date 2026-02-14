--[[
--
-- nvim/lua/config-183/plugin/config/toolchains/typescript_tools.lua
--
-- typescript and javascript toolset integration and setup
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "pmizio/typescript-tools.nvim"
plugin.name = "typescript-tools"
plugin.dependencies = "plenary"
plugin.cond = OPTS.toolchain.typescript
plugin.opts = {}
plugin.config = function(_, opts)
	require("typescript-tools").setup(opts)

	FUNCS.mmap("n", "<leader>ta", {
		["organize-imports"] = vim.cmd.TSToolsOrganizeImports,
		["sort-imports"] = vim.cmd.TSToolsSortImports,
		["remove-unused-imports"] = vim.cmd.TSToolsRemoveUnusedImports,
		["remove-unused"] = vim.cmd.TSToolsRemoveUnused,
		["add-missing-imports"] = vim.cmd.TSToolsAddMissingImports,
		["fix-all"] = vim.cmd.TSToolsFixAll,
		["go-to-source-definition"] = vim.cmd.TSToolsGoToSourceDefinition,
		["rename-file"] = vim.cmd.TSToolsRenameFile,
		["file-references"] = vim.cmd.TSToolsFileReferences,
	}, "[plugin/flutter-tools]: flutter tools actions")
end

return plugin
