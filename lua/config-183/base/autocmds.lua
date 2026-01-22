--[[
--
-- nvim/lua/config-183/base/autocmds.lua
--
-- some event based setup in auto commands
--
--]]

local aucmd = vim.api.nvim_create_autocmd
local augrp = VARS.augrp.id

--[[ disable color column in netrw and help pages ]]
aucmd("FileType", {
	group = augrp,
	pattern = { "netrw", "help" },
	callback = function()
		vim.opt_local.colorcolumn = "0"
		vim.opt_local.statuscolumn = "%s"
		vim.opt_local.statusline = nil
	end,
})

--[[ momentarily highlight yanked text ]]
aucmd("TextYankPost", {
	group = augrp,
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 50,
		})
	end,
})

--[[ disable number column when in netrw ]]
aucmd({
	"WinEnter",
	"FocusGained",
	"BufReadPre",
	"FileReadPre",
}, {
	group = augrp,
	pattern = { "netrw" },
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
})

--[[ make and load views to retain folds ]]
aucmd({
	"BufWritePre",
	"BufWinLeave",
	"BufLeave",
}, {
	group = augrp,
	command = "silent! mkview",
})
aucmd("BufWinEnter", {
	group = augrp,
	command = "silent! loadview",
})

--[ execute when config is loaded ]]
aucmd("VimEnter", {
	group = augrp,
	callback = OPTS.after,
})
