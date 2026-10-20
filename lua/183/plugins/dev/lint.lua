---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/mfussenegger/nvim-lint"
plugin.config = function()
    local lint = require("lint")
    local opts = QOPTS.get()

    ---@diagnostic disable-next-line: assign-type-mismatch
    lint.linters_by_ft = opts.linters
    for name, linter in pairs(opts.custom_linters) do
        lint.linters[name] = linter
    end

    vim.api.nvim_create_autocmd({
        "BufEnter",
        "BufWritePre",
        "InsertLeave",
    }, {
        callback = function()
            pcall(lint.try_lint, {})
        end,
    })

    FUNCS.map("n", "<leader>ln", lint.try_lint, {
        desc = "[plugins.nvim-lint] perform [l]i[n]ting on current file",
    })
end

return plugin
