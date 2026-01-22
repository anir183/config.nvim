--[[
--
-- nvim/lua/config-183/minimal/options.lua
--
-- setup neovim options via built-in defualt functionality like vim.g, vim.o,
-- vim.cmd, etc
--
--]]

LOG.info("setting minimal options")

local opt = vim.o

--[[ theme and colors ]]
vim.cmd.colorscheme("retrobox")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- transparent bg

--[[ sign column ]]
opt.number = true
opt.relativenumber = true
opt.signcolumn = "number" -- show signs by replacing numbers instead of creating another column

--[[ text formatting and indentation ]]
opt.wrap = false
opt.textwidth = 0
opt.expandtab = false -- dont expand tab character to spaces
opt.tabstop = 4 -- size of tab character in number of spaces
opt.shiftwidth = 0 -- size of each level of indentation (0 -> tabstop)
opt.softtabstop = -1 -- size of tab character in insert mode (-1 -> shiftwidth)
opt.autoindent = true -- copy current indentation for new line
opt.smartindent = true -- auto indent based on context

--[[ editor interface and utility visuals ]]
opt.updatetime = 250
opt.scrolloff = 8
opt.colorcolumn = "81"
opt.cursorline = true
opt.ruler = false -- dont show line and col number (handled by statusline)

--[[ tools and behaviour ]]
opt.ignorecase = true -- ignore case while searching
opt.smartcase = true -- ignore case if search terms are in lowercase
opt.completeopt = table.concat({ -- completion menu behaviour
	"fuzzy",
	"menu",
	"menuone",
	"noselect",
	"preview",
}, ",")

--[[ backup, recovery and history]]
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true

LOG.info("minimal options loaded")
