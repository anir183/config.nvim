local aucmd = vim.api.nvim_create_autocmd
local augrp = vim.api.nvim_create_augroup("au183", {
    clear = true,
})

aucmd("TextYankPost", {
    group = augrp,
    callback = function()
        vim.hl.hl_op({
            timeout = 75,
        })
    end,
    desc = "[core] highlight on yank",
})

aucmd({
    "BufWritePre",
    "BufWinLeave",
    "BufLeave",
}, {
    group = augrp,
    command = "silent! mkview",
    desc = "[core] make view to retain folds",
})

aucmd("BufWinEnter", {
    group = augrp,
    command = "silent! loadview",
    desc = "[core] load view to retain previous folds",
})

aucmd("FileType", {
    group = augrp,
    pattern = "qf",
    callback = function()
        ---@source https://stackoverflow.com/a/77181885

        vim.keymap.set("n", "dd", function()
            local curr_qf_idx = vim.fn.line(".")
            local qf_items = vim.fn.getqflist()

            -- return if there are no items to remove
            if #qf_items == 0 then
                return
            end

            -- remove the item from the quickfix list
            table.remove(qf_items, curr_qf_idx)
            vim.fn.setqflist(qf_items, "r")

            -- reopen quickfix window to refresh the list
            vim.cmd("copen")

            -- if not at the end of the list, stay at the same index, otherwise, go one up.
            local new_idx = curr_qf_idx < #qf_items and curr_qf_idx
                or math.max(curr_qf_idx - 1, 1)

            -- set the cursor position directly in the quickfix window
            local winid = vim.fn.win_getid() -- get the window id of the quickfix window
            vim.api.nvim_win_set_cursor(winid, { new_idx, 0 })
        end, { desc = "[d]elete item", buf = 0 })
    end,
    desc = "[core] delete item from quick fix list",
})
