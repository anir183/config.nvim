vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode("<space>")

local map = FUNCS.map
local nmap = function(...)
    map("n", ...)
end
local del = vim.keymap.del

-- move text
-- WARN: using "<CMD>" instead of ":" breaks these keymaps
nmap(
    "<C-j>",
    "v:m '>+1<CR>gv=<ESC>",
    { desc = "[core] move current line down" }
)
nmap(
    "<C-k>",
    "v:m '<-2<CR>gv=<ESC>",
    { desc = "[core] move current line up" }
)
map(
    "v",
    "<C-j>",
    ":m '>+1<CR>gv=<ESC>gv",
    { desc = "[core] move selection down" }
)
map(
    "v",
    "<C-k>",
    ":m '<-2<CR>gv=<ESC>gv",
    { desc = "[core] move selection up" }
)

-- center cursor while jumping around to keep it stationary
nmap(
    "J",
    "mzJ`z",
    {
        desc = "[core] dont move the cursor when joining next line",
    }
)
nmap(
    "<C-d>",
    "<C-d>zz",
    { desc = "[core] keep cursor centered when scrolling down" }
)
nmap("n", "nzzzv", {
    desc = "[core] keep cursor centered when jumping to next result",
})
nmap("N", "Nzzzv", {
    desc = "[core] keep cursor centered when jumping to prev result",
})

-- system clipboard
map("i", "<C-S-v>", function()
    vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
end, { desc = "[core] paste from system clipboard" })
map(
    "i",
    "<C-S-v>",
    "<esc>\"+pa",
    { desc = "[core] [p]aste from system clipboard" }
)
nmap(
    "<leader>p",
    "\"+p",
    { desc = "[core] [p]aste from system clipboard" }
)
nmap(
    "<leader>P",
    "\"+P",
    { desc = "[core] [P]aste from system clipboard before" }
)
map(
    { "n", "v" },
    "<leader>y",
    "\"+y",
    { desc = "[core] [y]ank to system clipboard" }
)
nmap(
    -- WARN: "+Y copies whole line instead of current character till end
    --        also _ instead of _g also includes newline
    "<leader>Y",
    "vg_\"+y",
    {
        desc = "[core] [Y]ank till end of line to system clipboard",
    }
)

-- no-copy versions of delete, paste and change keymaps
map(
    "x",
    "<leader>p",
    "\"_dP",
    { desc = "[core] [p]aste over selection without copying" }
)
map(
    { "n", "v" },
    "<leader>d",
    "\"_d",
    { desc = "[core] [d]elete without copying" }
)
nmap(
    "<leader>D",
    "\"_D",
    { desc = "[core] [D]elete till end of line without copying" }
)
map(
    { "n", "v" },
    "<leader>c",
    "\"_c",
    { desc = "[core] [c]hange without copying" }
)
map(
    { "n", "v" },
    "<leader>C",
    "\"_C",
    { desc = "[core] [C]hange till end of line without copying" }
)

-- splits resizing
nmap(
    "<C-.>",
    "<CMD>wincmd ><CR>",
    { desc = "[core] increase window width" }
)
nmap(
    "<C-,>",
    "<CMD>wincmd <<CR>",
    { desc = "[core] decrease window width" }
)
nmap(
    "<C-S-.>",
    "<CMD>wincmd +<CR>",
    { desc = "[core] increase window height" }
)
nmap(
    "<C-S-,>",
    "<CMD>wincmd -<CR>",
    { desc = "[core] decrease window height" }
)

-- buffer navigation
del("n", "[b")
del("n", "]b")
nmap("]b", vim.cmd.bnext, { desc = "[core] next [b]uffer" })
nmap("[b", vim.cmd.bprev, { desc = "[core] previous [b]uffer" })

-- quick fix list
del("n", "]q")
del("n", "[q")
del("n", "]Q")
del("n", "[Q")
nmap(
    "]q",
    vim.cmd.cnext,
    { desc = "[core] jump to next [q]uick fix list item" }
)
nmap(
    "[q",
    vim.cmd.cprev,
    { desc = "[core] jump to previous [q]uick fix list item" }
)
nmap(
    "]Q",
    vim.cmd.cnewer,
    { desc = "[core] jump to newer [Q]uick fix list" }
)
nmap(
    "[Q",
    vim.cmd.colder,
    { desc = "[core] jump to older [Q]uick fix list" }
)

-- location list
del("n", "]l")
del("n", "[l")
del("n", "]L")
del("n", "[L")
nmap(
    "]l",
    vim.cmd.lnext,
    { desc = "[core] jump to next [l]ocation list item" }
)
nmap(
    "[l",
    vim.cmd.lprev,
    { desc = "[core] jump to previous [l]ocation list item" }
)
nmap(
    "]L",
    vim.cmd.lnewer,
    { desc = "[core] jump to newer [L]ocation list" }
)
nmap(
    "[L",
    vim.cmd.lolder,
    { desc = "[core] jump to older [L]ocation list" }
)
