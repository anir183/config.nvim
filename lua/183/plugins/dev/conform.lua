---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/stevearc/conform.nvim"
plugin.config = function()
    local conform = require("conform")
    local opts = QOPTS.get()

    conform.setup({
        formatters_by_ft = opts.formatters,
        formatters = opts.custom_formatters,
    })

    vim.keymap.del({ "n", "v" }, "<leader>fm")
    FUNCS.map({ "n", "v" }, "<leader>fm", function()
        conform.format({
            async = true,
        }, function(err, modify)
            if not err and modify then
                vim.notify("formatted: " .. vim.fn.expand("%:t"))
            elseif not err and not modify then
                vim.notify("format ok: " .. vim.fn.expand("%:t"))
            else
                vim.notify(err or "error while formatting", vim.log.levels.ERROR)
            end
        end)
    end, { desc = "[plugin.conform] [f]or[m]at file or selections" })
end

return plugin
