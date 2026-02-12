--[[
--
-- nvim/lua/config-183/plugin/config/toolchains/flutter_tools.lua
--
-- flutter toolset integration and setup
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "nvim-flutter/flutter-tools.nvim"
plugin.name = "flutter-tools"
plugin.dependencies = "plenary"
plugin.cond = OPTS.toolchain.flutter
---@module "flutter-tools"
---@type flutter.Config
plugin.opts = {
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
}
plugin.config = function(_, opts)
	require("flutter-tools").setup(opts)
	require("luasnip").filetype_extend("dart", { "flutter" })

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
end

return plugin
