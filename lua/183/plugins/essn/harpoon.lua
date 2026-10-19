---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = {
    src = "https://github.com/ThePrimeagen/harpoon",
    version = "harpoon2",
}
plugin.config = function()
    local harpoon = require("harpoon")
    local nmap = function(...)
        FUNCS.map("n", ...)
    end

    harpoon:setup({
        settings = {
            save_on_toggle = true,
            sync_on_ui_close = true,
        },
    })

    -- general
    nmap("<C-S-h>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list(), {
            border = vim.g.neovide and "solid" or "rounded",
        })
    end, { desc = "[plugins.harpoon] open [H]arpoon list" })
    nmap("<C-S-l>", function()
        harpoon:list():add()
        vim.notify(
            "added file to harpoon list: " .. vim.fn.expand("%:t"),
            vim.log.levels.INFO
        )
    end, { desc = "[plugins.harpoon] add file to [h]arpoon list" })

    -- navigation
    nmap("<C-1>", function()
        harpoon:list():select(1)
    end, { desc = "[plugins.harpoon] navigate to file [1]" })
    nmap("<C-2>", function()
        harpoon:list():select(2)
    end, { desc = "[plugins.harpoon] navigate to file [2]" })
    nmap("<C-3>", function()
        harpoon:list():select(3)
    end, { desc = "[plugins.harpoon] navigate to file [3]" })
    nmap("<C-4>", function()
        harpoon:list():select(4)
    end, { desc = "[plugins.harpoon] navigate to file [4]" })
    nmap("<C-5>", function()
        harpoon:list():select(5)
    end, { desc = "[plugins.harpoon] navigate to file [5]" })
    nmap("]h", function()
        harpoon:list():next()
    end, { desc = "[plugins.harpoon] navigate to next file in list" })
    nmap("[h", function()
        harpoon:list():prev()
    end, { desc = "[plugins.harpoon] navigate to previous file in list" })

    -- actions
    PALETTE.add({
        id = "harpoon.menu",
        desc = "open the harpoon list menu",
        category = "harpoon",
        action = function()
            harpoon.ui:toggle_quick_menu(harpoon:list(), {
                border = vim.g.neovide and "solid" or "rounded",
            })
        end,
    })
    PALETTE.add({
        id = "harpoon.add",
        desc = "add current file to harpoon menu",
        category = "harpoon",
        action = function()
            harpoon:list():add()
            vim.notify(
                "added file to harpoon list: " .. vim.fn.expand("%:t"),
                vim.log.levels.INFO
            )
        end,
    })
end

return plugin
