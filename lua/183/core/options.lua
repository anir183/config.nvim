--[[ setup neovim options using built-in funtionality like vim.o, vim.g, vim.cmd ]]

---@module "183.core.types"

---@type 183.core.types.Options
local M = {}
local o = vim.o

function M.set_colorscheme()
	vim.cmd.colorscheme(_G.CONSTS.default_colorscheme)

	local hl = vim.api.nvim_set_hl

	hl(0, "IncSearch", { bg = "#EDA792", fg = "#11111b", bold = true })

	-- make bg transparent
	hl(0, "Normal", { bg = "none" })

	-- make floating windows transparent
	hl(0, "NormalFloat", { bg = "none" })
	hl(0, "FloatBorder", { bg = "none" })

	-- make statusline transparent
	hl(0, "StatusLine", { bg = "none" })
	hl(0, "StatusLineNC", { bg = "none" })
	hl(0, "StatusLineTerm", { bg = "none" })
	hl(0, "StatusLineTermNC", { bg = "none" })

	-- make completion menu transparent
	hl(0, "Pmenu", { bg = "none" })
	hl(0, "PmenuSbar", { bg = "none" })
	hl(0, "PmenuThumb", { bg = "none" })

	_G.LOG.debug("setup colorscheme")
end

function M.set_signcolumn()
	o.number = true
	o.relativenumber = true
	o.signcolumn = "number"

	_G.LOG.debug("setup signcolumn")
end

function M.set_folding()
	o.foldmethod = "manual"
	o.foldtext = ""
	o.foldlevelstart = 1
	o.foldnestmax = 9
	o.foldcolumn = "auto:9"

	_G.LOG.debug("setup folding")
end

function M.set_indentation()
	o.expandtab = false -- dont expand tab character to spaces
	o.tabstop = 4 -- size of tab character in number of spaces
	o.shiftwidth = 0 -- size of each level of indentation (0 -> tabstop)
	o.softtabstop = -1 -- size of tab character in insert mode (-1 -> shiftwidth)
	o.autoindent = true -- copy current indentation for new line
	o.smartindent = true -- auto indent based on context

	_G.LOG.debug("setup indentation")
end

function M.set_editor_rendering()
	require('vim._core.ui2').enable()

	-- reduces time between typing-stop and CursorHold auto command which is
	-- used by many plugins to perform operations
	-- https://www.reddit.com/r/vim/comments/jqogan/how_does_a_lower_updatetime_lead_to_better/
	--
	-- NOTE: even though lower update times may improve user experience due to
	--        snappier reactivity... if swap file generation is enabled or
	--        heavy tasks are being performed in CursorHold, then may lead to
	--        performance issues
	o.updatetime = _G.CONF.update_time or 250

	-- text rendering
	o.wrap = false
	o.textwidth = 0
	o.scrolloff = 8

	-- different columns and indicator lines
	o.colorcolumn = "81"
	o.cursorline = true

	-- invisible characters
	o.list = true -- render invisible characters
	o.listchars = table.concat({
		"lead:∙",
		"leadmultispace:▎∙∙∙",
		"tab:▎ ",
		"trail:␣",
		"extends:‥",
		"precedes:‥",
	}, ",")

	_G.LOG.debug("setup editor rendering")
end

function M.set_editor_behaviour()
	-- splits / panes creation direction
	o.splitright = false -- WARN: keep false.. true breaks dap https://github.com/rcarriga/nvim-dap-ui/issues/424
	o.splitbelow = false -- WARN: keep false.. true breaks dap https://github.com/rcarriga/nvim-dap-ui/issues/424

	-- search and replace
	o.ignorecase = true -- ignore case while searching
	o.smartcase = true -- ignore case if search terms are in lowercase
	o.inccommand = "split" -- preview off screen search or substitution matches in a split window
	o.wrapscan = true -- wrap scan back to file top

	-- completion menu behaviour
	o.completeopt = table.concat({
		"fuzzy",
		"menu",
		"menuone",
		"noselect",
		"preview",
	}, ",")

	-- makes cursor jumping more consistent
	---@source https://www.reddit.com/r/neovim/comments/1cytkbq/comment/l7cqdmq
	o.jumpoptions = table.concat({
		"stack",
		"view",
	}, ",")

	-- terminal shell
	o.shell = _G.CONF.shell or o.shell

	_G.LOG.debug("setup behaviour")
end

function M.set_save_files()
	o.swapfile = false
	o.backup = false
	o.writebackup = false
	o.undofile = true

	_G.LOG.debug("setup save files")
end

return M
