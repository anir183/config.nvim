---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo =
    "https://github.com/nvim-flutter/flutter-tools.nvim"
plugin.config = function()
    local flutter = require("flutter-tools")
    flutter.setup({
        debugger = {
            enabled = true,
        },
        flutter_lookup_cmd = "mise where flutter",
        fvm = false,
        ui = {
            border = vim.g.neovide and "solid" or "rounded",
        },
    })

    require("luasnip").filetype_extend("dart", { "flutter" })

    -- action palette
    local function add(id, desc, action)
        PALETTE.add({
            id = "flutter." .. id,
            desc = desc,
            category = "flutter",
            action = action,
        })
    end

    -- application
    add("run", "run Flutter application", vim.cmd.FlutterRun)
    add(
        "debug",
        "run Flutter application with debugger",
        vim.cmd.FlutterDebug
    )
    add("quit", "stop Flutter application", vim.cmd.FlutterQuit)
    add(
        "attach",
        "attach to running Flutter application",
        vim.cmd.FlutterAttach
    )
    add(
        "detach",
        "detach from Flutter application",
        vim.cmd.FlutterDetach
    )

    -- hot reload / restart
    add(
        "reload",
        "hot reload Flutter application",
        vim.cmd.FlutterReload
    )
    add(
        "restart",
        "hot restart Flutter application",
        vim.cmd.FlutterRestart
    )

    -- devices and emulators
    add(
        "devices",
        "list available Flutter devices",
        vim.cmd.FlutterDevices
    )
    add(
        "emulators",
        "list and manage Flutter emulators",
        vim.cmd.FlutterEmulators
    )

    -- outline
    add(
        "outline_toggle",
        "toggle Flutter widget outline",
        vim.cmd.FlutterOutlineToggle
    )
    add(
        "outline_open",
        "open Flutter widget outline",
        vim.cmd.FlutterOutlineOpen
    )

    -- development tools
    add(
        "dev_tools",
        "open Flutter DevTools",
        vim.cmd.FlutterDevTools
    )
    add(
        "dev_tools_activate",
        "activate Flutter DevTools",
        vim.cmd.FlutterDevToolsActivate
    )
    add(
        "copy_profiler_url",
        "copy Flutter profiler URL",
        vim.cmd.FlutterCopyProfilerUrl
    )

    -- language server and analysis
    add(
        "lsp_restart",
        "restart Flutter language server",
        vim.cmd.FlutterLspRestart
    )
    add(
        "reanalyze",
        "reanalyze Flutter project",
        vim.cmd.FlutterReanalyze
    )
    add("rename", "rename Flutter symbol", vim.cmd.FlutterRename)

    -- logs
    add(
        "log_clear",
        "clear Flutter logs",
        vim.cmd.FlutterLogClear
    )
    add(
        "log_toggle",
        "toggle Flutter log panel",
        vim.cmd.FlutterLogToggle
    )

    -- utilities
    add(
        "super",
        "show Flutter superclass methods",
        vim.cmd.FlutterSuper
    )
end

return plugin
