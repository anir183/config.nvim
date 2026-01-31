--[[
--
-- the custom.lua file i use as of 29-jan-2025
--
--]]

---@type DefaultOpts
local options = {}

options.lsps = {
	bashls = {
		filetypes = { "sh", "zsh" },
		settings = {
			filetypes = { "sh", "zsh" },
		},
	},
}

options.extra_plugins = {
	{
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
	},
	{
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
	},
	{
		"pmizio/typescript-tools.nvim",
		name = "typescript-tools",
		dependencies = "plenary",
		cond = FUNCS.in_distrobox("dev-nodejs"),
		opts = {},
	},
	{
		"ray-x/go.nvim",
		name = "gopher",
		main = "go",
		dependencies = {
			"treesitter",
			"lspconfig",
		},
		cond = FUNCS.in_distrobox("dev-golang"),
		opts = {},
	},
	{
		"copilotlsp-nvim/copilot-lsp",
		name = "copilot-lsp",
	},
	{
		"zbirenbaum/copilot.lua",
		name = "copilot",
		dependencies = "copilot-lsp",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
	},
	{
		"giuxtaposition/blink-cmp-copilot",
		name = "blink-copilot",
		dependencies = "copilot",
	},
}

options.plugin_overrides = {
	blink = {
		dependencies = {
			"lazydev",
			"blink-copilot",
		},
	},
}

options.conform = {}
options.conform.ft_formatters = {
	lua = { "stylua" },
}

options.cmp_sources = {
	default = {
		"lazydev",
		"lsp",
		"path",
		"snippets",
		"copilot",
		"buffer",
	},
	providers = {
		lazydev = {
			name = "LazyDev",
			module = "lazydev.integrations.blink",
			score_offset = 100, -- top priority
		},
		copilot = {
			name = "copilot",
			module = "blink-cmp-copilot",
			score_offset = 100,
			async = true,
		},
	},
}

options.util_vars = {}
options.util_vars.lsp_indexing_hack = { "lua_ls" }
options.log_opts = {}

return options
