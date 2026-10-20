---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/rcarriga/nvim-dap-ui"

-- Add nvim-neotest/nvim-nio to your vim.pack specs if it
-- is not already installed by your plugin configuration.
plugin.config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local map = FUNCS.map

    ---@diagnostic disable-next-line: missing-fields
    dapui.setup({
        floating = {
            border = "rounded",
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
    })

    -- Open on session start; close when the session ends.
    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end

    -- UI controls
    local nmap = function(...)
        map("n", ...)
    end

    nmap("<leader>ut", dapui.toggle, {
        desc = "[plugins.dapui] dap [u]i [t]oggle",
    })

    -- evaluations
    nmap("<leader>=", dapui.eval, {
        desc = "[plugins.dapui] evaluate value",
    })
    map("v", "<leader>=", dapui.eval, {
        desc = "[plugins.dapui] evaluate selection value",
    })
    nmap("<leader>=e", function()
        vim.ui.input(
            { prompt = "expression: " },
            function(expression)
                if expression and expression ~= "" then
                    dapui.eval(expression)
                end
            end
        )
    end, {
        desc = "[plugins.dapui] evaluate entered [e]xpression",
    })

    -- action palette
    local function add(id, desc, action)
        PALETTE.add({
            id = "dapui." .. id,
            desc = desc,
            category = "dapui",
            action = action,
        })
    end

    add("toggle", "toggle dap ui", dapui.toggle)
    add("open", "open dap ui", dapui.open)
    add("open_reset", "open / reset dap ui layout", function()
        dapui.open({ reset = true })
    end)
    add("close", "close dap ui", dapui.close)

    add(
        "eval_cursor",
        "evaluate expression under cursor",
        dapui.eval
    )
    add(
        "eval_expression",
        "evaluate entered expression",
        function()
            vim.ui.input(
                { prompt = "expression: " },
                function(expression)
                    if expression and expression ~= "" then
                        dapui.eval(expression)
                    end
                end
            )
        end
    )

    add("float_element", "float dap ui element", function()
        vim.ui.select({
            "scopes",
            "watches",
            "stacks",
            "breakpoints",
            "repl",
            "console",
        }, {
            prompt = "dap ui element:",
        }, function(choice)
            if choice then
                ---@diagnostic disable-next-line: missing-fields
                dapui.float_element(choice, { enter = true })
            end
        end)
    end)
end

return plugin
