---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/folke/todo-comments.nvim"
plugin.config = function()
    local todo = require("todo-comments")
    todo.setup()

    local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    local warn = vim.api.nvim_get_hl(0, { name = "TodoFgWarn", link = false })

    if normal.bg and warn.fg then
        vim.api.nvim_set_hl(0, "TodoBgWarn", {
            fg = normal.bg,
            bg = warn.fg,
            bold = true,
        })
    end

    FUNCS.map(
        "n",
        "]c",
        todo.jump_next,
        { desc = "[plugins.todo-comments]: jump to next todo [c]omment" }
    )
    FUNCS.map(
        "n",
        "[c",
        todo.jump_prev,
        { desc = "[plugins.todo-comments]: jump to previous todo [c]omment" }
    )

    PALETTE.add({
        id = "todo.loclist",
        desc = "list todo comments in location list",
        category = "todo",
        action = "TodoLocList",
    })
    PALETTE.add({
        id = "todo.qflist",
        desc = "list todo comments in quick fix list",
        category = "todo",
        action = "TodoQuickFix",
    })
end

return plugin
