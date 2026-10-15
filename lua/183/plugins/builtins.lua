vim.cmd.packadd("nvim.undotree")
FUNCS.map(
    "n",
    "<leader>u",
    vim.cmd.Undotree,
    { desc = "[plugin.builtins] open [u]ndotree" }
)
