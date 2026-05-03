--[[ core config module and setup ]]

---@module "183.core.types"

---@type 183.core.types.Module
local M = {}

function M.init_options()
	local options = require("183.core.options")

	options.set_colorscheme()
	options.set_signcolumn()
	options.set_folding()
	options.set_indentation()
	options.set_editor_rendering()
	options.set_save_files()

	_G.LOG.debug("setup core options")
end

function M.init_keymaps()
	local keymaps = require("183.core.keymaps")

	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	for desc, map in pairs(keymaps) do
		map.opts = map.opts or {}
		map.opts.desc = "[core." .. (map.category or "misc") .. "] " .. desc

		_G.FUNCS.map(map.mode or "n", map.lhs, map.rhs, map.opts)
	end

	_G.LOG.debug("setup core keymaps")
end

function M.init_lsp_keymaps()
	local keymaps = require("183.core.lsp_keymaps")

	vim.api.nvim_create_autocmd("LspAttach", {
		group = _G.CONSTS.augrp.id,
		callback = function(args)
			for desc, map in pairs(keymaps) do
				local opts = {} ---@type vim.keymap.set.Opts
				opts.buf = args.buf
				opts.desc = "[core.lsp] " .. desc

				_G.FUNCS.map(map.mode or "n", map.lhs, map.rhs, opts)
			end
		end,
	})

	_G.LOG.debug("setup lsp keymaps for current buffer")
end

function M.init_auto_commands()
	local autocmds = require("183.core.autocmds")

	for desc, autocmd in pairs(autocmds) do
		vim.api.nvim_create_autocmd(autocmd.events, {
			group = _G.CONSTS.augrp.id,
			pattern = autocmd.patterns,
			command = autocmd.command,
			callback = autocmd.callback,
			desc = "[core] " .. desc,
		})
	end

	_G.LOG.debug("setup core auto commands", autocmds)
end

return M
