--[[
--
-- nvim/lua/config-183/minimal/plugins.lua
--
-- bootstrap plugin manager and setup plugins
-- this module bootstraps the lazy.nvim plugin manager and configures different
-- plugins to be used
--
--]]

LOG.info("loading lazy.nvim plugin manager in minimal config")

---@class LazyOpts
--- options used when bootstrapping lazy.nvim plugin manager
LAZY = LAZY or {}

---@type string path to the directory to install lazy at
LAZY.path = LAZY.path or FUNCS.join_paths(VARS.path.data, "lazy", "lazy.nvim")
---@type string path where the lock file for installed plugins is stored
LAZY.lock_path = LAZY.lock_path
	or FUNCS.join_paths(VARS.path.state, "lazy-lock.json")
---@type string repository where the lazy.nvim pacakge is hosted
LAZY.repo = LAZY.repo or "https://github.com/folke/lazy.nvim.git"
---@type string[] installation command to pull down the remote repo
LAZY.install_cmd = LAZY.install_cmd
	or {
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		LAZY.repo,
		LAZY.path,
	}

---@class LazyPriorities
--- priority levels for controlling plugin load order
LAZY.priorities = {}
LAZY.priorities.highest = 200
LAZY.priorities.high = 100
LAZY.priorities.default = 50
LAZY.priorities.low = 25

LOG.info("setup lazy.nvim parameters")
LOG.debug(LAZY)

--[[ install lazy.nvim and add to runtime path ]]
if not (vim.uv or vim.loop).fs_stat(LAZY.path) then
	local cmd_out = vim.fn.system(LAZY.install_cmd)

	if vim.v.shell_error ~= 0 then
		LOG.error("failed to install lazy.nvim")
		LOG.debug(cmd_out)
		os.exit(1)
	end

	LOG.info("installed lazy.nvim successfully")
end
vim.opt.rtp:prepend(LAZY.path)
LOG.info("lazy.nvim added to rtp")
LOG.debug(vim.opt.rtp)

---@type table<string, LazySpec>
local spec = {
	mason = {
		"williamboman/mason.nvim",
		name = "mason",
		opts = {},
		lazy = false,
		keys = {
			{
				mode = "n",
				"<leader>mn",
				function()
					vim.cmd.Mason()
				end,
				desc = "[plugin/mason]: open [M]aso[N] window",
			},
		},
	},
	mason_lspconfig = {
		"williamboman/mason-lspconfig.nvim",
		name = "mason-lspconfig",
		dependencies = {
			"mason",
			"lspconfig",
		},
		opts = {
			automatic_installation = true,
		},
		config = function(_, opts)
			local ensure_installed = {}

			for lsp, _ in pairs(OPTS.lsps) do
				table.insert(ensure_installed, lsp)
			end

			require("mason-lspconfig").setup(vim.tbl_deep_extend("force", {
				ensure_installed = ensure_installed,
			}, opts))
		end,
	},
	blink = {
		"saghen/blink.cmp",
		name = "blink",
		main = "blink.cmp",
		version = "1.*",
		dependencies = "lazydev",
		opts = {
			keymap = {
				preset = "none",
			},
			completion = {
				list = {
					selection = {
						preselect = false,
						auto_insert = true,
					},
				},
			},
			sources = {
				default = {
					"lazydev",
					"lsp",
					"path",
					"snippets",
					"buffer",
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100, -- top priority
					},
				},
			},
		},
		config = function(_, opts)
			local blink = require("blink.cmp")

			blink.setup(opts)

			-- keypress emulation
			local feedkeys = function(keys)
				FUNCS.feedkeys(keys, "ni")
			end

			-- show menu
			FUNCS.map({ "i", "s" }, "<C-Space>", function()
				if not blink.is_visible() then
					blink.show()
				else
					feedkeys("<C-Space>")
				end
			end, "[plugin/blink]: show completion menu")

			-- hide or cancel completion menu
			FUNCS.map({ "i", "s" }, "<C-c>", function()
				if blink.is_visible() then
					blink.hide()
				else
					feedkeys("<C-c>")
				end
			end, "[plugin/blink]: hide completion menu")
			FUNCS.map({ "i", "s" }, "<C-x>", function()
				if blink.is_visible() then
					blink.cancel()
				else
					feedkeys("<C-x>")
				end
			end, "[plugin/blink]: cancel completion and hide")

			-- navigate completion menu
			FUNCS.map({ "i", "s" }, "<TAB>", function()
				if blink.is_visible() then
					blink.select_next()
					return
				end

				if not blink.snippet_forward() then
					feedkeys("<TAB>")
				end
			end, "[plugin/blink]: next item in completion menu")
			FUNCS.map({ "i", "s" }, "<S-TAB>", function()
				if blink.is_visible() then
					blink.select_prev()
					return
				end

				if not blink.snippet_backward() then
					feedkeys("<S-TAB>")
				end
			end, "[plugin/blink]: prev item in completion menu")

			-- accept completion
			FUNCS.map({ "i", "s" }, "<CR>", function()
				if not blink.accept() then
					feedkeys("<CR>")
				end
			end, "[plugin/blink]: accept completion suggestion")

			-- documentation window
			FUNCS.map({ "i", "s" }, "<C-k>", function()
				if blink.is_documentation_visible() then
					blink.hide_documentation()
				elseif blink.is_visible() then
					blink.show_documentation()
				else
					feedkeys("<C-k>")
				end
			end, "[plugin/blink]: toggle documentation window")
			FUNCS.map({ "i", "s" }, "<C-d>", function()
				if not blink.scroll_documentation_down(1) then
					feedkeys("<C-d>")
				end
			end, "[plugin/blink]: scroll down docs window")
			FUNCS.map({ "i", "s" }, "<C-u>", function()
				if not blink.scroll_documentation_up(1) then
					feedkeys("<C-u>")
				end
			end, "[plugin/blink]: scroll up docs window")
		end,
	},
	lazydev = {
		"folke/lazydev.nvim",
		name = "lazydev",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
			integrations = {
				blink = true,
			},
		},
	},
	lspconfig = {
		"neovim/nvim-lspconfig",
		name = "lspconfig",
		dependencies = {
			"mason-lspconfig",
			"blink",
		},
		config = function()
			for name, opts in pairs(OPTS.lsps) do
				if not opts then
					goto continue
				end

				local capabilities = vim.tbl_deep_extend(
					"force",
					vim.lsp.protocol.make_client_capabilities(),
					opts.capabilities or {}
				)

				local glc = require("blink.cmp").get_lsp_capabilities
				opts.capabilities = glc(capabilities)

				vim.lsp.enable(name)
				vim.lsp.config(name, opts)

				LOG.info("setup lsp: " .. name)
				LOG.debug("lsp opts", opts)

				::continue::
			end

			--[[ lsp keymaps ]]
			vim.api.nvim_create_autocmd("LspAttach", {
				group = VARS.augrp.id,
				callback = function()
					if FUNCS.set_lsp_keymaps then
						LOG.info("using custom lsp keymap handler")
						FUNCS.set_lsp_keymaps()
						return
					end

					LOG.info("setting lsp keymaps current lsp-attached buffer")

					FUNCS.nmap(
						"<leader>rn",
						vim.lsp.buf.rename,
						"[base/lsp]: [R]e[N]ame symbol",
						{ buffer = 0 }
					)
					FUNCS.nmap(
						"<leader>ic",
						vim.lsp.buf.incoming_calls,
						"[base/lsp]: [I]ncoming [C]alls",
						{ buffer = 0 }
					)
					FUNCS.nmap(
						"<leader>oc",
						vim.lsp.buf.outgoing_calls,
						"[base/lsp]: [O]outgoing [C]alls",
						{ buffer = 0 }
					)
					FUNCS.nmap(
						"<leader>ds",
						vim.lsp.buf.document_symbol,
						"[base/lsp]: [D]ocument [S]ymbol",
						{ buffer = 0 }
					)
					FUNCS.map(
						{ "n", "x" },
						"<leader>ca",
						vim.lsp.buf.code_action,
						"[base/lsp]: open [C]ode [A]ctions",
						{ buffer = 0 }
					)
					FUNCS.nmap(
						"gD",
						vim.lsp.buf.declaration,
						"[base/lsp]: [G]oto [D]eclaration",
						{ buffer = 0 }
					)
					FUNCS.nmap(
						"gd",
						vim.lsp.buf.definition,
						"[base/lsp]: [G]oto [D]efinition",
						{ buffer = 0 }
					)
					FUNCS.nmap(
						"gr",
						vim.lsp.buf.references,
						"[base/lsp]: [G]et [R]eferences",
						{ buffer = 0 }
					)
					FUNCS.nmap(
						"gi",
						vim.lsp.buf.implementation,
						"[base/lsp]: [G]et [I]mplementation",
						{ buffer = 0 }
					)
					FUNCS.nmap(
						"<C-s>",
						vim.lsp.buf.signature_help,
						"[base]: toggle lsp signature window",
						{ buffer = 0 }
					)

					LOG.info("lsp keymaps setup and loaded")
				end,
			})
		end,
	},
}

--[[ setup and initate lazy ]]
local _spec = {}
for name, plugin in pairs(spec) do
	name = plugin.name or name
	plugin.name = name
	table.insert(_spec, plugin)
	LOG.info("added plugin to spec: " .. name)
	LOG.debug(plugin)
end
require("lazy").setup({
	spec = OPTS.test_plugins and OPTS.test_plugins or {
		vim.tbl_deep_extend("force", _spec, OPTS.plugin_overrides or {}),
		OPTS.extra_plugins,
	},
	lockfile = LAZY.lock_path,
	defaults = {
		lazy = false,
		priority = LAZY.priorities.default,
	},
	rocks = {
		enabled = false,
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
})

FUNCS.nmap("<leader>lz", "<CMD>Lazy<CR>", "[plugin/lazy]: open lazy")

LOG.info("lazy.nvim setup and loaded in minimal config")
