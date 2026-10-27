---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields

local plugin = {}
plugin.repo = "https://github.com/mfussenegger/nvim-dap"
plugin.config = function()
    local dap = require("dap")
    local map = FUNCS.map
    local nmap = function(...)
        map("n", ...)
    end

    -- register dap clients
    local dacs = QOPTS.get().dap
    for name, dac in pairs(dacs or {}) do
        dap.adapters[name] = dac.adapter or {}
        for lang, configs in pairs(dac.configs or {}) do
            dap.configurations[lang] = configs
        end
    end

    -- signs and theme-aware highlights
    vim.api.nvim_set_hl(0, "DapStoppedCustom", {
        link = "DiagnosticOk",
    })
    vim.api.nvim_set_hl(0, "DapBreakpointCustom", {
        link = "DiagnosticError",
    })

    vim.fn.sign_define("DapStopped", {
        text = "▶ ",
        texthl = "DapStoppedCustom",
        linehl = "",
        numhl = "",
    })
    vim.fn.sign_define("DapBreakpoint", {
        text = "ඞ ",
        texthl = "DapBreakpointCustom",
        linehl = "",
        numhl = "",
    })

    -- debugger controls: function keys
    nmap("<F5>", dap.continue, {
        desc = "[plugins.dap] continue / start debugging",
    })
    nmap("<S-F5>", dap.terminate, {
        desc = "[plugins.dap] terminate session",
    })
    nmap("<F6>", dap.pause, {
        desc = "[plugins.dap] pause execution",
    })
    nmap("<F9>", dap.step_back, {
        desc = "[plugins.dap] step back",
    })
    nmap("<F10>", dap.step_out, {
        desc = "[plugins.dap] step out",
    })
    nmap("<F11>", dap.step_over, {
        desc = "[plugins.dap] step over",
    })
    nmap("<F12>", dap.step_into, {
        desc = "[plugins.dap] step into",
    })

    -- breakpoints
    nmap("<leader>bb", dap.toggle_breakpoint, {
        desc = "[plugins.dap] toggle [b]reakpoint",
    })
    nmap("<leader>BB", dap.clear_breakpoints, {
        desc = "[plugins.dap] [b]reakpoints clear",
    })
    nmap("<leader>bl", function()
        dap.list_breakpoints(true)
    end, {
        desc = "[plugins.dap] [b]reakpoints [l]ist",
    })

    -- running
    nmap("<leader>rr", dap.run_last, {
        desc = "[plugins.dap] [r]e-run last configuration",
    })
    nmap("<leader>rl", function()
        vim.ui.input({ prompt = "line number: " }, function(line)
            if not line or not FUNCS.str_is_num(line) then
                return
            end

            dap.goto_(tonumber(line))
        end)
    end, {
        desc = "[plugins.dap] [r]un to [l]ine",
    })
    nmap("<leader>rc", dap.run_to_cursor, {
        desc = "[plugins.dap] [r]un to [c]ursor",
    })
    nmap("<leader>RC", dap.reverse_continue, {
        desc = "[plugins.dap] [R]everse [C]ontinue",
    })

    -- repl
    nmap("<leader>rt", dap.repl.toggle, {
        desc = "[plugins.dap] [r]epl [t]oggle",
    })
    nmap("<leader>re", function()
        vim.ui.input(
            { prompt = "evaluate in repl: " },
            function(expression)
                if expression and expression ~= "" then
                    dap.repl.execute(expression)
                end
            end
        )
    end, {
        desc = "[plugins.dap] execute [r]epl [e]xpression",
    })

    -- action palette
    local function add(id, desc, action)
        PALETTE.add({
            id = "dap." .. id,
            desc = desc,
            category = "dap",
            action = action,
        })
    end

    -- execution
    add("continue", "continue / start debugging", dap.continue)
    add(
        "run_last",
        "rerun last debug configuration",
        dap.run_last
    )
    add("restart", "restart debug session", dap.restart)
    add("terminate", "terminate debug session", dap.terminate)
    add("disconnect", "disconnect debug session", dap.disconnect)
    add("pause", "pause execution", dap.pause)
    add("step_over", "step over", dap.step_over)
    add("step_into", "step into", dap.step_into)
    add("step_out", "step out", dap.step_out)
    add("step_back", "step back (if supported)", dap.step_back)
    add(
        "reverse_continue",
        "reverse continue (if supported)",
        dap.reverse_continue
    )
    add("run_to_cursor", "run to cursor", dap.run_to_cursor)

    -- breakpoints
    add(
        "toggle_breakpoint",
        "toggle breakpoint",
        dap.toggle_breakpoint
    )
    add("set_breakpoint", "set breakpoint", dap.set_breakpoint)
    add(
        "clear_breakpoints",
        "clear all breakpoints",
        dap.clear_breakpoints
    )
    add("list_breakpoints", "list breakpoints", function()
        dap.list_breakpoints(true)
    end)

    -- stack frames
    add("up", "move up stack frame", dap.up)
    add("down", "move down stack frame", dap.down)
    add("focus_frame", "focus current frame", dap.focus_frame)
    add(
        "restart_frame",
        "restart current frame",
        dap.restart_frame
    )
    add("goto", "jump to line", function()
        vim.ui.input({ prompt = "Line number: " }, function(line)
            if line and line:match("^%d+$") then
                dap.goto_(tonumber(line))
            end
        end)
    end)

    -- repl
    add("repl_toggle", "toggle REPL", dap.repl.toggle)
    add("repl_open", "open REPL", dap.repl.open)
    add("repl_close", "close REPL", dap.repl.close)
    add("repl_execute", "execute REPL expression", function()
        vim.ui.input(
            { prompt = "Evaluate in REPL: " },
            function(expression)
                if expression and expression ~= "" then
                    dap.repl.execute(expression)
                end
            end
        )
    end)

    -- session inspection
    add("session", "inspect current session", function()
        vim.print(dap.session())
    end)
    add("sessions", "inspect all sessions", function()
        vim.print(dap.sessions())
    end)
    add("status", "show debugger status", function()
        vim.notify(dap.status(), vim.log.levels.INFO)
    end)
    add("set_log_level", "set debugger log level", function()
        vim.ui.select({
            "TRACE",
            "DEBUG",
            "INFO",
            "WARN",
            "ERROR",
        }, {
            prompt = "dap log level:",
        }, function(level)
            if level then
                dap.set_log_level(level)
            end
        end)
    end)
end

return plugin
