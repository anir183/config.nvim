---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/laytan/cloak.nvim"
plugin.config = function()
    require("cloak").setup({
        cloak_character = "*",
        patterns = QOPTS.get().cloak,
    })

    FUNCS.map(
        "n",
        "<leader>lp",
        vim.cmd.CloakPreviewLine,
        {
            desc = "[plugins.cloak] cloak current [l]ine [p]review",
        }
    )
    FUNCS.map(
        "n",
        "<leader>ht",
        vim.cmd.CloakToggle,
        { desc = "[plugins.cloak] cloak [h]iding [t]oggle" }
    )

    PALETTE.add({
        id = "cloak.preview",
        desc = "preview current cloaked line",
        category = "cloak",
        action = vim.cmd.CloakPreviewLine,
    })
    PALETTE.add({
        id = "cloak.toggle",
        desc = "toggle cloaking in current line",
        category = "cloak",
        action = vim.cmd.CloakToggle,
    })
    PALETTE.add({
        id = "cloak.enable",
        desc = "enable cloak",
        category = "cloak",
        action = vim.cmd.CloakEnable,
    })
    PALETTE.add({
        id = "cloak.disable",
        desc = "disable cloak",
        category = "cloak",
        action = vim.cmd.CloakDisable,
    })
end

return plugin
