---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/brianhuster/live-preview.nvim"
plugin.config = function()
    require("livepreview.config").set()

    PALETTE.add({
        id = "livepreview.start",
        desc = "start live preview",
        category = "livepreview",
        action = function()
            vim.cmd("LivePreview start")
        end,
    })

    PALETTE.add({
        id = "livepreview.close",
        desc = "close live preview",
        category = "livepreview",
        action = function()
            vim.cmd("LivePreview close")
        end,
    })

    PALETTE.add({
        id = "livepreview.pick",
        desc = "pick file to preview",
        category = "livepreview",
        action = function()
            vim.cmd("LivePreview pick")
        end,
    })
end

return plugin
