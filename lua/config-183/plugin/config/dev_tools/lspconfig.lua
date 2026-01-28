--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/lspconfig.lua
--
-- handy configurations for different lsps
--
--]]

---@module "vim"
---@module "vim.api"
---@module "lazy"
---@module "config-183.utils"
---@module "config-183.utils.logging"
---@module "config-183.utils.variables"

---@type LazySpec
local plugin = {}

plugin[1] = "neovim/nvim-lspconfig"
plugin.name = "lspconfig"
plugin.dependencies = {
	"mason-lspconfig",
	"blink",
}

-- NOTE : i want to use default confiurations provided by nvim-lsconfig
--        along with possible overrides of my own
--
--        but setting things up like that seemed confusing:
--        - according to nvim-lspconfig vim.lsp.config automatically detects
--          confiurations stored in its lsp/ directory and "automatically finds
--          them and merges them with any local lsp/*.lua configs defined by you
--          or a plugin"
--        - it seems that using vim.lsp.config(name, conf) overrides this
--          detected config without merging
--        - i dont understand at what point nvim-lspconfig's configurations
--          are sources but i am guessing its after vim.lsp.enable is called
--        - i want to use this as the base config over which i will merge
--          blink.cmp capabilities and other config overrides from options file
--
--        i dont know if everything works truly correctly as i dont understand
--        the system too well
--
--        i also dont know if all of these steps are required or what exactly
--        they do, but if it works it works
--
--        https://github.com/neovim/nvim-lspconfig/blob/master/README.md

---@type table<string, boolean> store filetypes for which lsp has been attached
local lsp_attached_fts = {}
plugin.config = function()
	for name, conf in pairs(OPTS.lsps) do
		vim.lsp.enable(name)

		if (not conf) or (type(conf) ~= "table") then
			LOG.info("no options provided, using defaults for lsp: " .. name)
			LOG.debug(name, conf)

			conf = vim.lsp.config[name] or {}
		end

		--[[ base confiurations ]]
		-- hoping that nvim-lspconfig configurations are setup
		conf = vim.tbl_deep_extend(
			"force",
			vim.lsp.config[name] or {}, -- should have config from lsp/* folders
			conf
		)

		--[[ vim.lsp default capabilities ]]
		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			conf.capabilities -- dont lose overrides if any
		)

		--[[ set blink.cmp capabilities ]]
		conf.capabilities =
			require("blink.cmp").get_lsp_capabilities(capabilities)

		vim.lsp.config(name, conf)
		LOG.info("set up lsp: " .. name)
		LOG.debug(conf)

		if VARS.lsp_indexing_hack then
			vim.api.nvim_create_autocmd("LspAttach", {
				group = VARS.augrp.id,
				callback = function()
					if lsp_attached_fts[vim.bo.filetype] then
						return
					end

					vim.print(
						"LSP Attached\n\n"
							.. "Sometimes Workspace Indexing does not seem to start!\n"
							.. "This causes variable and definitions to not be recognised.\n"
							.. "However, a if a popup happens during LspAttach, the Indexing"
							.. " seems to work consistently.\n\n"
							.. "This is that popup. Why does this happen? IDK"
					)

					lsp_attached_fts[vim.bo.filetype] = true
				end,
			})
		end
	end
end

return plugin
