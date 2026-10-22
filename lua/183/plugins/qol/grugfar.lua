---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/MagicDuck/grug-far.nvim"
plugin.config = function()
    local grug_far = require("grug-far")
    local map = FUNCS.map
    local nmap = function(...)
        map("n", ...)
    end

    grug_far.setup({
        -- keep the ui focused on the search/replace workflow.
        debounceMs = 300,
        minSearchChars = 2,
        maxSearchMatches = 2000,
    })

    -- project-wide search and replace.
    nmap("<leader>sr", function()
        grug_far.open()
    end, { desc = "[plugins.grugfar] [s]earch and [r]eplace" })

    -- search for the word under the cursor.
    nmap("<leader>sR", function()
        grug_far.open({
            prefills = {
                search = vim.fn.expand("<cword>"),
            },
        })
    end, { desc = "[plugins.grugfar] [s]earch and [r]eplace word under cursor" })

    -- search using the current visual selection.
    map("x", "<leader>sr", function()
        grug_far.with_visual_selection()
    end, { desc = "[plugins.grugfar] [s]earch and [r]eplace selected text" })

    -- restrict search and replacement to the current file.
    nmap("<leader>sf", function()
        grug_far.open({
            prefills = {
                paths = vim.fn.expand("%"),
            },
        })
    end, { desc = "[plugins.grugfar] [s]earch and replace in [f]ile" })

    -- restrict the operation to a visual range.
    map({ "n", "x" }, "<leader>sv", function()
        grug_far.open({
            visualSelectionUsage = "operate-within-range",
        })
    end, { desc = "[plugins.grugfar] [s]earch within [v]isual range" })

    -- action palette.
    local function add(id, desc, action)
        PALETTE.add({
            id = "grug-far." .. id,
            desc = desc,
            category = "grug-far",
            action = action,
        })
    end

    add("open", "search and replace across project", function()
        grug_far.open()
    end)

    add("word", "replace word under cursor across project", function()
        grug_far.open({
            prefills = {
                search = vim.fn.expand("<cword>"),
            },
        })
    end)

    add("search", "search using last search pattern", function()
        grug_far.open({
            prefills = {
                search = vim.fn.getreg("/"),
            },
        })
    end)

    add("file", "search and replace in current file", function()
        grug_far.open({
            prefills = {
                paths = vim.fn.expand("%"),
            },
        })
    end)

    add("directory", "search and replace in current directory", function()
        grug_far.open({
            prefills = {
                paths = vim.fn.expand("%:p:h"),
            },
        })
    end)

    add("selection", "search selected text", function()
        grug_far.with_visual_selection()
    end)
end

return plugin
