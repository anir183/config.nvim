--[[
--
-- nvim/lua/config-183/plugin/config/toolchains/rustacean.lua
--
-- rust toolset integration and setup
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "mrcjkb/rustaceanvim"
plugin.name = "rustacean"
plugin.dependencies = {
	"dap",
	"lspconfig",
	"treesitter",
	{
		"saecki/crates.nvim",
		name = "crates",
		tag = "stable",
		---@type crates.UserConfig
		opts = {
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
			completion = {
				crates = {
					enabled = true,
					max_results = 20,
					min_chars = 1,
				},
				blink = {
					use_custom_kind = true,
					kind_text = {
						version = "Version",
						feature = "Feature",
					},
					kind_highlight = {
						version = "BlinkCmpKindVersion",
						feature = "BlinkCmpKindFeature",
					},
					kind_icon = {
						version = " ",
						feature = " ",
					},
				},
			},
		},
		config = function(_, opts)
			local crates = require("crates")
			crates.setup(opts)

			FUNCS.mmap({ "v", "n" }, "<leader>RA", {
				["hide-ui"] = crates.hide,
				["show-ui"] = crates.show,
				["toggle-ui"] = crates.toggle,
				["update-data"] = crates.update,
				["reload-data"] = crates.reload,

				["upgrade-crate"] = function()
					-- delay the upgrade to avoid issues with the floating
					-- window closing before the command is executed
					vim.defer_fn(function()
						crates.upgrade_crate()
					end, 50)
				end,
				["upgrade-all-crates"] = crates.upgrade_all_crates,

				["update-crate"] = function()
					-- delay the update to avoid issues with the floating
					-- window closing before
					vim.defer_fn(function()
						crates.update_crate()
					end, 50)
				end,
				["update-all-crates"] = crates.update_all_crates,

				["expand-plain-crate-to-inline-table"] = crates.expand_plain_crate_to_inline_table,
				["extract-crate-into-table"] = crates.extract_crate_into_table,
				["use-git-source"] = crates.use_git_source,

				["open-homepage"] = function()
					-- delay the update to avoid issues with the floating
					-- window closing before
					vim.defer_fn(function()
						crates.open_homepage()
					end, 50)
				end,
				["open-repository"] = function()
					-- delay the update to avoid issues with the floating
					-- window closing before
					vim.defer_fn(function()
						crates.open_repository()
					end, 50)
				end,
				["open-documentation"] = function()
					-- delay the update to avoid issues with the floating
					-- window closing before
					vim.defer_fn(function()
						crates.open_documentation()
					end, 50)
				end,
				["open-crates-io"] = function()
					-- delay the update to avoid issues with the floating
					-- window closing before
					vim.defer_fn(function()
						crates.open_crates_io()
					end, 50)
				end,
				["open-lib-rs"] = function()
					-- delay the update to avoid issues with the floating
					-- window closing before
					vim.defer_fn(function()
						crates.open_lib_rs()
					end, 50)
				end,

				["show-popup"] = function()
					-- delay the update to avoid issues with the floating
					-- window closing before
					vim.defer_fn(function()
						crates.show_popup()
						crates.focus_popup()
					end, 50)
				end,
				["show-crate-popup"] = function()
					-- delay the update to avoid issues with the floating
					-- window closing before
					vim.defer_fn(function()
						crates.show_crate_popup()
						crates.focus_popup()
					end, 50)
				end,
				["show-versions-popup"] = function()
					-- delay the update to avoid issues with the floating
					-- window closing before
					vim.defer_fn(function()
						crates.show_versions_popup()
						crates.focus_popup()
					end, 50)
				end,
				["show-features-popup"] = function()
					-- delay the update to avoid issues with the floating
					-- window closing before
					vim.defer_fn(function()
						crates.show_features_popup()
						crates.focus_popup()
					end, 50)
				end,
				["show-dependencies-popup"] = function()
					-- delay the update to avoid issues with the floating
					-- window closing before
					vim.defer_fn(function()
						crates.show_dependencies_popup()
						crates.focus_popup()
					end, 50)
				end,
			}, "[plugin/crates]: crates actions")
		end,
	},
}
plugin.version = "^7"
plugin.lazy = false
plugin.config = function()
	FUNCS.mmap("n", "<leader>ra", {
		["analyzer-start"] = "RustAnalyzer start",
		["analyzer-stop"] = "RustAnalyzer stop",
		["analyzer-restart"] = "RustAnalyzer restart",
		["analyzer-enable-check-on-save"] = "RustAnalyzer config { checkOnSave = true }",
		["analyzer-disable-check-on-save"] = "RustAnalyzer config { checkOnSave = false }",

		["lsp-run"] = "RustLsp run",
		["lsp-runnables"] = "RustLsp runnables",
		["lsp-debug"] = "RustLsp debug",
		["lsp-debuggables"] = "RustLsp debuggables",
		["lsp-testables"] = "RustLsp testables",
		["lsp-related-tests"] = function()
			-- delay the move to avoid issues with the floating window closing
			-- before the command is executed
			vim.defer_fn(function()
				vim.cmd("RustLsp relatedTests")
			end, 100)
		end,
		["lsp-expand-macro"] = function()
			-- delay the move to avoid issues with the floating window closing
			-- before the command is executed
			vim.defer_fn(function()
				vim.cmd("RustLsp expandMacro")
			end, 100)
		end,
		["lsp-move-item-up"] = function()
			-- delay the move to avoid issues with the floating window closing
			-- before the command is executed
			vim.defer_fn(function()
				vim.cmd("RustLsp moveItem up")
			end, 100)
		end,
		["lsp-move-item-down"] = function()
			-- delay the move to avoid issues with the floating window closing
			-- before the command is executed
			vim.defer_fn(function()
				vim.cmd("RustLsp moveItem down")
			end, 100)
		end,
		["lsp-explain-error"] = function()
			-- delay the move to avoid issues with the floating window closing
			-- before the command is executed
			vim.defer_fn(function()
				vim.cmd("RustLsp explainError")
			end, 100)
		end,
		["lsp-render-diagnostic"] = function()
			-- delay the move to avoid issues with the floating window closing
			-- before the command is executed
			vim.defer_fn(function()
				vim.cmd("RustLsp renderDiagnostic")
			end, 100)
		end,
		["lsp-related-diagnostics"] = function()
			-- delay the move to avoid issues with the floating window closing
			-- before the command is executed
			vim.defer_fn(function()
				vim.cmd("RustLsp relatedDiagnostic")
			end, 100)
		end,
		["lsp-open-cargo"] = function()
			-- delay the move to avoid issues with the floating window closing
			-- before the command is executed
			vim.defer_fn(function()
				vim.cmd("RustLsp openCargo")
			end, 100)
		end,
		["lsp-open-docs"] = function()
			-- delay the move to avoid issues with the floating window closing
			-- before the command is executed
			vim.defer_fn(function()
				vim.cmd("RustLsp openDocs")
			end, 100)
		end,
		["lsp-parent-module"] = function()
			-- delay the move to avoid issues with the floating window closing
			-- before the command is executed
			vim.defer_fn(function()
				vim.cmd("RustLsp parentModule")
			end, 100)
		end,
		["lsp-workspace-types"] = function()
			vim.ui.input({
				prompt = "query: ",
			}, function(query)
				if not query or query == "" then
					query = "*"
				end

				-- delay the workspace symbol to avoid issues with the floating window closing
				-- before the command is executed
				vim.defer_fn(function()
					vim.cmd("RustLsp workspaceSymbol onlyTypes " .. query)
				end, 100)
			end)
		end,
		["lsp-workspace-symbols"] = function()
			vim.ui.input({
				prompt = "query: ",
			}, function(query)
				if not query or query == "" then
					query = "*"
				end

				-- delay the workspace symbol to avoid issues with the floating window closing
				-- before the command is executed
				vim.defer_fn(function()
					vim.cmd("RustLsp workspaceSymbol " .. query)
				end, 100)
			end)
		end,
		["lsp-join-lines"] = function()
			-- delay the join to avoid issues with the floating window closing
			-- before the command is executed
			vim.defer_fn(function()
				vim.cmd("RustLsp joinLines")
			end, 100)
		end,
		["lsp-ssr"] = function()
			-- delay the ssr to avoid issues with the floating window closing
			-- before the command is executed
			vim.defer_fn(function()
				vim.cmd("RustLsp ssr")
			end, 100)
		end,
		["lsp-rebuild-proc-macros"] = "RustLsp rebuildProcMacros",
		["lsp-syntax-tree"] = "RustLsp syntaxTree",
		["lsp-check-run"] = "RustLsp flyCheck run",
		["lsp-check-clear"] = "RustLsp flyCheck clear",
		["lsp-check-cancel"] = "RustLsp flyCheck cancel",
		["lsp-view-hir"] = "RustLsp view hir",
		["lsp-view-mir"] = "RustLsp view mir",
	}, "[plugin/rustacean]: rustacean actions")
end

return plugin
