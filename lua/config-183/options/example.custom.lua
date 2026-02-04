--[[
--
-- the custom.lua file i use as of 04-feb-2026
--
--]]

---@module "config-183.options.defaults"
---@module "config-183.utils.functions"
---@module "blink"
---@module "blink-cmp"

local copilot_enabled = true

---@type DefaultOpts
local options = {}
options.lsps = {}
options.conform = {}
options.conform.ft_formatters = {}
options.lint = {}
options.lint.ft_linters = {}
options.dap = {}
options.dap.mason_dap = {}
options.extra_plugins = {}
options.plugin_overrides = {}
options.cmp_sources = {}
options.util_vars = {}

--[[ lsps ]]
options.lsps.bashls = {
	filetypes = { "sh", "zsh" },
	settings = {
		filetypes = { "sh", "zsh" },
	},
}
options.lsps.clangd = FUNCS.in_distrobox("dev-c") and {} or nil
if FUNCS.in_distrobox("dev-nodejs") then
	options.lsps.html = {}
	options.lsps.cssls = {}
	options.lsps.jsonls = {}
	options.lsps.emmet_language_server = {}
end

--[[ formatters ]]
options.conform.ft_formatters.lua = { "stylua" }
options.conform.ft_formatters.c = FUNCS.in_distrobox("dev-c")
		and { "clangd-format" }
	or nil
if FUNCS.in_distrobox("dev-nodejs") then
	options.conform.ft_formatters.html = { "prettier" }
	options.conform.ft_formatters.css = { "prettier" }
	options.conform.ft_formatters.typescript = { "prettier" }
	options.conform.ft_formatters.typescriptreact = { "prettier" }
	options.conform.ft_formatters.javascript = { "prettier" }
	options.conform.ft_formatters.javascriptreact = { "prettier" }
	options.conform.ft_formatters.json = { "prettier" }
	options.conform.ft_formatters.jsonc = { "prettier" }
else
	options.conform.ft_formatters.json = { "fixjson" }
	options.conform.ft_formatters.jsonc = { "fixjson" }
end

--[[ linters ]]
options.lint.ft_linters.json = { "jsonlint" }
options.lint.ft_linters.jsonc = { "jsonlint" }
if FUNCS.in_distrobox("dev-nodejs") then
	options.lint.ft_linters.typescript = { "eslint_d" }
	options.lint.ft_linters.javascript = { "eslint_d" }
	options.lint.ft_linters.typescriptreact = { "eslint_d" }
	options.lint.ft_linters.javascriptreact = { "eslint_d" }
end

--[[ debuggers ]]
options.dap.mason_dap.codelldb = FUNCS.in_distrobox("dev-c")

--[[ additional plugins ]]
options.extra_plugins[1] = {
	"copilotlsp-nvim/copilot-lsp",
	name = "copilot-lsp",
	cond = copilot_enabled,
}
options.extra_plugins[2] = {
	"zbirenbaum/copilot.lua",
	name = "copilot",
	dependencies = "copilot-lsp",
	cond = copilot_enabled,
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
		filetypes = {
			bash = false,
			[""] = false,
			oil = false,
		},
	},
}
options.extra_plugins[3] = {
	"fang2hou/blink-copilot",
	name = "blink-copilot",
	dependencies = "copilot",
	cond = copilot_enabled,
}
options.extra_plugins[4] = {
	"folke/lazydev.nvim",
	name = "lazydev",
	---@module "lazydev"
	---@type lazydev.Config
	opts = {
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			{ "nvim-dap-ui" },
		},
		integrations = {
			blink = true,
		},
	},
}
options.extra_plugins[5] = {
	"nvim-flutter/flutter-tools.nvim",
	name = "flutter-tools",
	dependencies = "plenary",
	cond = FUNCS.in_distrobox("dev-flutter"),
	---@module "flutter-tools"
	---@type flutter.Config
	opts = {
		debugger = {
			enabled = true,
		},
		flutter_path = vim.env.HOME and FUNCS.join_paths(
			vim.env.HOME,
			"fvm",
			"default",
			"bin",
			"flutter"
		) or nil,
		fvm = true,
	},
	config = function(_, opts)
		require("flutter-tools").setup(opts)
		vim.print(FUNCS.join_paths(vim.env.HOME, "fvm", "default", "bin"))

		FUNCS.mmap("n", "<leader>fa", {
			["run"] = vim.cmd.FlutterRun,
			["debug"] = vim.cmd.FlutterDebug,
			["devices"] = vim.cmd.FlutterDevices,
			["emulators"] = vim.cmd.FlutterEmulators,
			["reload"] = vim.cmd.FlutterReload,
			["restart"] = vim.cmd.FlutterRestart,
			["quit"] = vim.cmd.FlutterQuit,
			["attach"] = vim.cmd.FlutterAttach,
			["detach"] = vim.cmd.FlutterDetach,
			["outline-toggle"] = vim.cmd.FlutterOutlineToggle,
			["outline-open"] = vim.cmd.FlutterOutlineOpen,
			["dev-tools"] = vim.cmd.FlutterDevTools,
			["dev-tools-activate"] = vim.cmd.FlutterDevToolsActivate,
			["copy-profiler-url"] = vim.cmd.FlutterCopyProfilerUrl,
			["lsp-restart"] = vim.cmd.FlutterLspRestart,
			["super"] = vim.cmd.FlutterSuper,
			["re-analyze"] = vim.cmd.FlutterReanalyze,
			["rename"] = vim.cmd.FlutterRename,
			["log-clear"] = vim.cmd.FlutterLogClear,
			["log-toggle"] = vim.cmd.FlutterLogToggle,
		}, "[plugin/flutter-tools]: flutter tools actions")
	end,
}
options.extra_plugins[6] = {
	"pmizio/typescript-tools.nvim",
	name = "typescript-tools",
	dependencies = "plenary",
	cond = FUNCS.in_distrobox("dev-nodejs"),
	opts = {},
	config = function(_, opts)
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
	end,
}
options.extra_plugins[7] = {
	"ray-x/go.nvim",
	name = "gopher",
	main = "go",
	dependencies = {
		"treesitter",
		"lspconfig",
	},
	cond = FUNCS.in_distrobox("dev-golang"),
	opts = {},
}

--[[ config plugins override ]]
options.plugin_overrides.blink = {
	dependencies = copilot_enabled and {
		"lazydev",
		"blink-copilot",
	} or { "lazydev" },
}

--[[ completion sources ]]
if copilot_enabled then
	options.cmp_sources.default = {
		"lazydev",
		"lsp",
		"path",
		"snippets",
		"copilot",
		"buffer",
	}
	options.cmp_sources.providers = {
		lazydev = {
			name = "LazyDev",
			module = "lazydev.integrations.blink",
			score_offset = 100, -- top priority
		},
		copilot = {
			name = "copilot",
			module = "blink-copilot",
			score_offset = 90, -- close to top priority
			async = true,
		},
	}
else
	options.cmp_sources.default = {
		"lazydev",
		"lsp",
		"path",
		"snippets",
		"buffer",
	}
	options.cmp_sources.providers = {
		lazydev = {
			name = "LazyDev",
			module = "lazydev.integrations.blink",
			score_offset = 100, -- top priority
		},
	}
end

--[[ run after config ]]
options.after = function()
	STLINE.components.dbox = function()
		if FUNCS.in_distrobox() then
			return FUNCS.hl_fmt_str(
				"Function",
				"  " .. vim.env.CONTAINER_ID .. " "
			)
		else
			return ""
		end
	end
	STLINE.arrangement = {
		-- left
		"$logo",
		"$mode",
		"$dbox",
		"$diagnostics",
		"  ",
		"%r",
		"%w",
		"%h",
		"%m",

		"%=", -- break

		-- right
		"$gitinfo",
		" ",
		"$filename",
		" ",
		"$indent",
		" ",
		"$position",
	}
	STLINE.set_arrangment()
end

--[[ utility variables ]]
options.util_vars.lsp_indexing_hack = { "lua_ls" }

return options
