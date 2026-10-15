PALETTE.add({
    id = "session.select",
    desc = "select session",
    category = "session",
    keymap = "<leader>qq",
    action = function()
        SESS.select()
    end,
})

PALETTE.add({
    id = "session.save",
    desc = "save session",
    category = "session",
    keymap = "<leader>qw",
    action = function()
        if SESS.save() then
            vim.notify("session saved")
        end
    end,
})
