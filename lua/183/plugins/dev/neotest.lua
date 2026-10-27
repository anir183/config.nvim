---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/nvim-neotest/neotest"
plugin.config = function()
    local map = FUNCS.map
    local nmap = function(...)
        map("n", ...)
    end

    local test_opts = QOPTS.get().test or {}
    local pack_specs = {}
    local adapters = {}

    -- install/load configured adapters.
    for _, conf in pairs(test_opts) do
        assert(
            type(conf.link) == "string" and conf.link ~= "",
            "neotest adapter requires a repository link"
        )

        pack_specs[#pack_specs + 1] = conf.link
    end

    if #pack_specs > 0 then
        vim.pack.add(pack_specs)
    end

    -- load and initialize adapters.
    for name, conf in pairs(test_opts) do
        adapters[#adapters + 1] = conf.adapter() or require(name)
    end

    local neotest = require("neotest")

    ---@diagnostic disable-next-line: missing-fields
    neotest.setup({
        adapters = adapters,
        discovery = {
            enabled = true,
            concurrent = 1,
        },
        running = {
            concurrent = true,
        },
        default_strategy = "integrated",
        ---@diagnostic disable-next-line: missing-fields
        floating = {
            border = vim.g.neovide and "solid" or "rounded",
        },
        output = {
            enabled = true,
            open_on_run = "short",
        },
        output_panel = {
            enabled = true,
            open = "botright split | resize 12",
        },
        ---@diagnostic disable-next-line: missing-fields
        summary = {
            enabled = true,
            animated = false,
            follow = true,
            expand_errors = true,
        },
        status = {
            enabled = true,
            signs = true,
            virtual_text = false,
        },
        diagnostic = {
            enabled = true,
            severity = vim.diagnostic.severity.ERROR,
        },
    })

    -- Run tests
    nmap("<leader>tn", function()
        neotest.run.run()
    end, {
        desc = "[plugins.neotest] run [n]earest test",
    })

    nmap("<leader>tf", function()
        neotest.run.run(vim.fn.expand("%"))
    end, {
        desc = "[plugins.neotest] run tests in current [f]ile",
    })

    nmap("<leader>tF", function()
        neotest.run.run(vim.fn.getcwd())
    end, {
        desc = "[plugins.neotest] run tests in project",
    })

    nmap("<leader>tr", function()
        neotest.run.run_last()
    end, {
        desc = "[plugins.neotest] [r]erun last test",
    })

    nmap("<leader>tS", function()
        neotest.run.stop()
    end, {
        desc = "[plugins.neotest] [S]top test run",
    })

    -- results and output
    nmap("<leader>ts", function()
        neotest.summary.toggle()
    end, {
        desc = "[plugins.neotest] toggle test [s]ummary",
    })

    nmap("<leader>to", function()
        neotest.output.open()
    end, {
        desc = "[plugins.neotest] show test [o]utput",
    })

    nmap("<leader>tO", function()
        neotest.output_panel.toggle()
    end, {
        desc = "[plugins.neotest] toggle output panel",
    })

    -- debugging (requires adapter dap support).
    nmap("<leader>td", function()
        ---@diagnostic disable-next-line: missing-fields
        neotest.run.run({ strategy = "dap" })
    end, {
        desc = "[plugins.neotest] [d]ebug nearest test",
    })

    -- action palette
    local function add(id, desc, action)
        PALETTE.add({
            id = "neotest." .. id,
            desc = desc,
            category = "neotest",
            action = action,
        })
    end

    add("run_nearest", "run nearest test", function()
        neotest.run.run()
    end)

    add("run_file", "run tests in current file", function()
        neotest.run.run(vim.fn.expand("%"))
    end)

    add("run_project", "run tests in project", function()
        neotest.run.run(vim.fn.getcwd())
    end)

    add("run_last", "rerun last test", function()
        neotest.run.run_last()
    end)

    add("stop", "stop test run", function()
        neotest.run.stop()
    end)

    add("summary", "toggle test summary", function()
        neotest.summary.toggle()
    end)

    add("output", "show test output", function()
        neotest.output.open()
    end)

    add(
        "output_panel",
        "toggle accumulated output panel",
        function()
            neotest.output_panel.toggle()
        end
    )

    add("debug_nearest", "debug nearest test", function()
        ---@diagnostic disable-next-line: missing-fields
        neotest.run.run({ strategy = "dap" })
    end)
end

return plugin
