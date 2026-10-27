---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = {
    src = "https://github.com/mrcjkb/rustaceanvim",
    version = vim.version.range("^9"),
}

plugin.config = function()
    ---@module "rustaceanvim"
    ---@type rustaceanvim.Opts
    vim.g.rustaceanvim = {
        dap = {
            autoload_configurations = true,
        },
    }

    ---@param id string
    ---@param desc string
    ---@param action string|fun()
    local function add(id, desc, action)
        PALETTE.add({
            id = "rust." .. id,
            desc = desc,
            category = "rust",
            action = action,
        })
    end

    --- run a rustlsp subcommand.
    ---@param command string|string[]
    local function rust_lsp(command)
        return function()
            vim.cmd.RustLsp(command)
        end
    end

    --- run a rustanalyzer subcommand.
    ---@param command string
    local function rust_analyzer(command)
        return function()
            vim.cmd.RustAnalyzer(command)
        end
    end

    -- analyzer lifecycle and runtime configuration.
    add(
        "analyzer.start",
        "Start rust-analyzer",
        rust_analyzer("start")
    )
    add(
        "analyzer.stop",
        "Stop rust-analyzer",
        rust_analyzer("stop")
    )
    add(
        "analyzer.restart",
        "Restart rust-analyzer",
        rust_analyzer("restart")
    )
    add(
        "analyzer.reload-settings",
        "Reload rust-analyzer settings",
        rust_analyzer("reloadSettings")
    )
    add(
        "analyzer.check-on-save.enable",
        "Enable check on save",
        rust_analyzer("config { checkOnSave = true }")
    )
    add(
        "analyzer.check-on-save.disable",
        "Disable check on save",
        rust_analyzer("config { checkOnSave = false }")
    )

    -- run, test, and debug targets.
    add("run", "Run target at cursor", rust_lsp("run"))
    add(
        "runnables",
        "Choose a runnable target",
        rust_lsp("runnables")
    )
    add("debug", "Debug target at cursor", rust_lsp("debug"))
    add(
        "debuggables",
        "Choose a debuggable target",
        rust_lsp("debuggables")
    )
    add("testables", "Choose Rust tests", rust_lsp("testables"))

    -- code actions and hover.
    add(
        "code-actions",
        "Show grouped Rust code actions",
        rust_lsp("codeAction")
    )
    add(
        "hover-actions",
        "Show Rust hover actions",
        rust_lsp({ "hover", "actions" })
    )
    add(
        "hover-range",
        "Show hover for expression range",
        rust_lsp({ "hover", "range" })
    )
    add(
        "explain-error",
        "Explain Rust diagnostic error",
        rust_lsp("explainError")
    )

    -- code navigation and refactoring.
    add(
        "related-tests",
        "Find related tests",
        rust_lsp("relatedTests")
    )
    add("expand-macro", "Expand macro", rust_lsp("expandMacro"))
    add(
        "move-item-up",
        "Move item up",
        rust_lsp({ "moveItem", "up" })
    )
    add(
        "move-item-down",
        "Move item down",
        rust_lsp({ "moveItem", "down" })
    )
    add(
        "parent-module",
        "Go to parent module",
        rust_lsp("parentModule")
    )
    add("open-cargo", "Open Cargo.toml", rust_lsp("openCargo"))
    add(
        "open-docs",
        "Open docs.rs documentation",
        rust_lsp("openDocs")
    )
    add("join-lines", "Join Rust lines", rust_lsp("joinLines"))
    add("ssr", "Structural search and replace", rust_lsp("ssr"))

    -- Workspace symbol search.
    add(
        "workspace-symbols",
        "Search workspace symbols",
        rust_lsp("workspaceSymbol")
    )
    add("workspace-types", "Search workspace types", function()
        vim.ui.input({ prompt = "Type query: " }, function(query)
            if query == nil then
                return
            end

            vim.cmd.RustLsp({
                "workspaceSymbol",
                "onlyTypes",
                query ~= "" and query or "*",
            })
        end)
    end)

    -- compiler and analysis tools.
    add(
        "rebuild-proc-macros",
        "Rebuild procedural macros",
        rust_lsp("rebuildProcMacros")
    )
    add(
        "syntax-tree",
        "Show Rust syntax tree",
        rust_lsp("syntaxTree")
    )
    add(
        "fly-check.run",
        "Run background cargo check",
        rust_lsp({ "flyCheck", "run" })
    )
    add(
        "fly-check.clear",
        "Clear background check diagnostics",
        rust_lsp({ "flyCheck", "clear" })
    )
    add(
        "fly-check.cancel",
        "Cancel background check",
        rust_lsp({ "flyCheck", "cancel" })
    )
    add("view-hir", "View HIR", rust_lsp({ "view", "hir" }))
    add("view-mir", "View MIR", rust_lsp({ "view", "mir" }))
    add("crate-graph", "Generate crate graph", function()
        vim.ui.input(
            { prompt = "Backend and output: " },
            function(value)
                if value == nil or value == "" then
                    return
                end

                local args =
                    vim.split(value, "%s+", { trimempty = true })
                vim.cmd.RustLsp(
                    vim.list_extend({ "crateGraph" }, args)
                )
            end
        )
    end)
end

return plugin
