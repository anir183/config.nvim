---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/williamboman/mason.nvim"
plugin.config = function()
    require("mason").setup({
        ui = {
            icons = {
                package_installed = "󰌵",
                package_pending = "▶",
                package_uninstalled = "󰅚",
            },
        },
        log_level = vim.log.levels.DEBUG,
    })

    FUNCS.map(
        "n",
        "<leader>mn",
        vim.cmd.Mason,
        { desc = "[plugins.mason] open [m]aso[n] window" }
    )

    PALETTE.add({
        id = "mason.open",
        desc = "open mason tool manager window",
        category = "mason",
        action = vim.cmd.Mason,
    })
end

return plugin
