local nmap = function(...)
    FUNCS.map("n", ...)
end

-- sessions
nmap("<leader>qq", SESS.select, {
    desc = "[session] select and load session",
})
nmap("<leader>QQ", function()
    SESS.load({ last = true })
end, {
    desc = "[session] load last session",
})
nmap("<leader>qc", SESS.load, {
    desc = "[session] load session for [c]wd",
})
nmap("<leader>qw", function()
    if SESS.save() then
        vim.notify("session saved")
    end
end, {
    desc = "[session] [w]rite current session",
})
nmap("<leader>qd", SESS.delete, {
    desc = "[session] [d]elete saved session",
})
nmap("<leader>qs", SESS.stop, {
    desc = "[session] [s]top saving sessions",
})

-- palette
nmap("<C-S-p>", PALETTE.open, {
    desc = "[palette] open command palette",
})
nmap("<leader>pc", PALETTE.categories, {
    desc = "[palette] open categorized command palette",
})
