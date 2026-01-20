--[[
--
-- nvim/lua/config-183/minimal/keymaps.lua
--
-- keymaps or remaps for functionality that is already built-in to neovim
--
--]]

local map = FUNCS.map
local nmap = FUNCS.nmap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

LOG.info("setting base keymaps")

--[[ messages and logs ]]
nmap("<leader>ms", "<CMD>messages<CR>", "[base]: open [M]essage[S] window")

--[[ moving text ]]
-- WARN : using "<CMD>" instead of ":" breaks these commands
nmap("<C-j>", "v:m '>+1<CR>gv=<ESC>", "[base]: move the current line up")
nmap("<C-k>", "v:m '<-2<CR>gv=<ESC>", "[base]: move the current line down")
map("v", "<C-j>", "m: '>+1<CR>gv=<ESC>gv", "[base]: move selection up")
map("v", "<C-k>", "m: '<-2<CR>gv=<ESC>gv", "[base]: move selection down")

--[[ stationary or centered cursor while jumping, etc ]]
nmap("J", "mzJ`z", "[base]: dont move the cursor when joining next line")
nmap("<C-d>", "<C-d>zz", "[base]: keep cursor centerd when scrolling down")
nmap("<C-u>", "<C-u>zz", "[base]: keep cursor centerd when scrolling up")
nmap("n", "nzzzv", "[base]: centered cursor when going to next search result")
nmap("N", "Nzzzv", "[base]: centered cursor when going to prev search result")

--[[ modification or extensions of existing keymaps ]]
map({ "n", "v" }, "x", "\"_x", "[base]: remove without copying")
map("x", "<leader>p", "\"_dP", "[base]: [P]aste over selection without copying")
nmap("<leader>P", "\"+p", "[base]: [P]aste from system clipboard")
map("x", "<leader>P", "\"_d\"+P", "[base]: [P]aste from system clipboard over selection without copying")
map({ "n", "v" }, "<leader>y", "\"+y", "[base]: [Y]ank to system clipboard")
nmap("<leader>Y", "\"+Y", "[base]: [Y]ank till end of line to system clipboard")
map({ "n", "v" }, "<leader>d", "\"_d", "[base]: [D]elete without copying")
nmap("<leader>D", "\"_D", "[base]: [D]elete till end of line without copying")
map({ "n", "v" }, "<leader>c", "\"_c", "[base]: delete and edit without copying")
nmap("<leader>C", "\"_C", "[base]: delete till eol and edit without copying")
