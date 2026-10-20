---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/uga-rosa/ccc.nvim"
plugin.config = function()
    require("ccc").setup({
        win_opts = {
            border = "solid",
        },
    })

    PALETTE.add({
        id = "ccc.picker",
        desc = "open color picker",
        category = "ccc",
        action = vim.cmd.CccPick,
    })
    PALETTE.add({
        id = "ccc.highlights",
        desc = "toggle color highlights",
        category = "ccc",
        action = vim.cmd.CccHighlighterToggle,
    })
    PALETTE.add({
        id = "ccc.convert",
        desc = "convert colors",
        category = "ccc",
        action = vim.cmd.CccConvert,
    })
end

return plugin
