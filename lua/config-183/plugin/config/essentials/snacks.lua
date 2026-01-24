--[[
--
-- nvim/lua/config-183/plugin/config/essentials/snacks.lua
--
-- fuzzy finder, picker and some other cool utilities
--
--]]

---@module "vim"
---@module "lazy"
---@module "snacks"
---@module "config-183.utils"
---@module "config-183.utils.functions"

---@type LazySpec
local plugin = {}

plugin[1] = "folke/snacks.nvim"
plugin.name = "snacks"
plugin.dependencies = "devicons"
plugin.priority = LAZY.priorities.high
plugin.lazy = false
plugin.init = function()
	vim.g.snacks_animate = false
end
---@type snacks.Config
plugin.opts = {
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	explorer = { enabled = false },
	image = { enabled = false },
	indent = { enabled = false },
	input = { enabled = true },
	notifier = { enabled = false },
	picker = {
		enabled = true,
		win = {
			input = {
				keys = {
					["<C-p>"] = {
						"toggle_preview",
						mode = { "i", "n" },
					},
				},
			},
			list = {
				keys = {
					["<C-p>"] = "toggle_preview",
				},
			},
		},
		main = {
			current = true,
		},
	},
	quickfile = { enabled = true },
	scope = { enabled = false },
	scroll = { enabled = false },
	statuscolumn = { enabled = false },
	words = {
		enabled = false,
		debounce = 0,
	},
	terminal = {
		start_insert = false,
		auto_insert = false,
		auto_close = true,
	},
	zen = {
		toggles = {
			dim = false,
		},
	},
}
plugin.config = function(_, opts)
	local snacks = require("snacks")
	snacks.setup(opts)

	-- invoke lsp action on file rename via oil.nvim
	vim.api.nvim_create_autocmd("User", {
		group = VARS.augrp.id,
		pattern = "OilActionsPost",
		callback = function(event)
			if event.data.actions.type == "move" then
				snacks.rename.on_rename_file(
					event.data.actions.src_url,
					event.data.actions.dest_url
				)
			end
		end,
	})

	-- snacks actions menu
	FUNCS.mmap("n", "<leader>sa", {
		["dim-enable"] = snacks.dim.enable,
		["dim-disable"] = snacks.dim.disable,
		["git-blame"] = snacks.git.blame_line,
		["git-browse"] = snacks.gitbrowse.open,
		["lazy-git"] = snacks.lazygit.open,
		["rename-file"] = snacks.rename.rename_file,
		["scratch-toggle"] = function()
			snacks.scratch()
		end,
		["scratch-select"] = snacks.scratch.select,
		["word-enable"] = snacks.words.enable,
		["word-disable"] = snacks.words.disable,
		["word-clear"] = snacks.words.clear,
		["word-jump"] = snacks.words.jump,
		["zen"] = function()
			snacks.zen()
		end,
		["zen-zoom"] = snacks.zen.zoom,
		["explorer"] = function()
			snacks.explorer()
		end,
		["smart"] = snacks.picker.smart,
		["find-buffers"] = snacks.picker.buffers,
		["find-config"] = function()
			snacks.picker.files({ cwd = vim.fn.stdpath("config") })
		end,
		["find-projects"] = snacks.picker.projects,
		["grep-buffers"] = snacks.picker.grep_buffers,
		["git-files"] = snacks.picker.git_files,
		["git-branches"] = snacks.picker.git_branches,
		["git-log"] = snacks.picker.git_log,
		["git-logline"] = snacks.picker.git_log_line,
		["git-status"] = snacks.picker.git_status,
		["git-stash"] = snacks.picker.git_stash,
		["git-diff"] = snacks.picker.git_diff,
		["git-logfile"] = snacks.picker.git_log_file,
		["search-registers"] = snacks.picker.registers,
		["search-autocmds"] = snacks.picker.autocmds,
		["search-commands"] = snacks.picker.commands,
		["search-diagnostics"] = snacks.picker.diagnostics,
		["search-diag-buff"] = snacks.picker.diagnostics_buffer,
		["search-highlights"] = snacks.picker.highlights,
		["search-keymaps"] = snacks.picker.keymaps,
		["search-undo"] = snacks.picker.undo,
		["search-man"] = snacks.picker.man,
		["search-lazy"] = snacks.picker.lazy,
	}, "[plugin/snacks]: choose from [S]nacks [A]ctions")
end
plugin.keys = {
	-- search, find and picker keymaps
	{
		mode = "n",
		"<leader>/",
		function()
			require("snacks").picker.lines()
		end,
		desc = "[plugin/snacks]: search in buffer",
	},
	{
		mode = "n",
		"<leader>?",
		function()
			require("snacks").picker.search_history()
		end,
		desc = "[plugin/snacks]: search history",
	},
	{
		mode = { "n", "x" },
		"<leader>*",
		function()
			require("snacks").picker.grep_word()
		end,
		desc = "[plugin/snacks]: grep word under cursor",
	},
	{
		mode = "n",
		"<leader>::",
		function()
			require("snacks").picker.command_history()
		end,
		desc = "[plugin/snacks]: command history",
	},
	{
		mode = "n",
		"<leader>ff",
		function()
			require("snacks").picker.files()
		end,
		desc = "[plugin/snacks]: [F]ind [F]iles",
	},
	{
		mode = "n",
		"<leader>fF",
		function()
			if vim.bo.filetype == "oil" then
				require("snacks").picker.files({
					cwd = vim.fn.expand("%:h"):sub(7, -1),
				})
			end
			require("snacks").picker.files({
				cwd = vim.fn.expand("%:p:h"),
			})
		end,
		desc = "[plugin/snacks]: [F]ind [F]iles in current directory",
	},
	{
		mode = "n",
		"<leader>FF",
		function()
			require("snacks").picker.files({
				hidden = true,
				ignored = true,
			})
		end,
		desc = "[plugin/snacks]: [F]ind [F]iles hidden and ignored incl",
	},
	{
		mode = "n",
		"<leader>FI",
		function()
			require("snacks").picker.files({
				ignored = true,
			})
		end,
		desc = "[plugin/snacks]: [F]ind [F]iles ignored incl",
	},
	{
		mode = "n",
		"<leader>FH",
		function()
			require("snacks").picker.files({
				hidden = true,
			})
		end,
		desc = "[plugin/snacks]: [F]ind [F]iles hidden incl",
	},
	{
		mode = "n",
		"<leader>fc",
		function()
			require("snacks").picker.files({
				cwd = vim.fn.stdpath("config"),
			})
		end,
		desc = "[plugin/snacks]: [F]ind files in [C]onfig directory",
	},
	{
		mode = "n",
		"<leader>fr",
		function()
			require("snacks").picker.recent()
		end,
		desc = "[plugin/snacks]: [F]ind [R]ecently visited files",
	},
	{
		mode = "n",
		"<leader>fk",
		function()
			require("snacks").picker.keymaps()
		end,
		desc = "[plugin/snacks]: [F]ind [K]eymaps",
	},
	{
		mode = "n",
		"<leader>gg",
		function()
			require("snacks").picker.grep({
				cwd = vim.fn.getcwd(),
			})
		end,
		desc = "[plugin/snacks]: [G]lobal [G]rep",
	},
	{
		mode = "n",
		"<leader>GG",
		function()
			if vim.bo.filetype == "oil" then
				-- WARN : idk why but directly using require("snacks").picker.grep or
				--        vim.cmd to open grep picker fails to run
				local cwd = vim.fn.expand("%:p:h"):sub(7, -1)
				FUNCS.feedkeys(
					":lua require(\"snacks\").picker.grep({ cwd = \""
						.. cwd
						.. "\" })<CR><C-l>"
				)
			end

			require("snacks").picker.grep({
				cwd = vim.fn.expand("%:h"),
			})
		end,
		desc = "[plugin/snacks]: [G]lobal [G]rep",
	},
	{
		mode = "n",
		"<leader>fh",
		function()
			require("snacks").picker.help()
		end,
		desc = "[plugin/snacks]: [F]ind in [H]elp pages",
	},
	{
		mode = "n",
		"<leader>fq",
		function()
			require("snacks").picker.qflist()
		end,
		desc = "[plugin/snacks]: [F]ind in [Q]uick fix list",
	},
	{
		mode = "n",
		"<leader>fl",
		function()
			require("snacks").picker.loclist()
		end,
		desc = "[plugin/snacks]: [F]ind in [L]ocation list",
	},

	-- words keymaps
	{
		mode = "n",
		"<leader>wo",

		function()
			require("snacks").words.enable()
		end,
		desc = "[plugin/snacks]: enable [WO]rds",
	},
	{
		mode = "n",
		"<leader>WO",
		function()
			require("snacks").words.disable()
		end,
		desc = "[plugin/snacks]: disable [WO]rds",
	},
	{
		mode = "n",
		"<C-l>",
		function()
			vim.cmd("mode")
			vim.cmd("redraw!")
			vim.cmd("nohlsearch")
			require("snacks").words.clear()
		end,
		desc = "[plugin/snacks]: clear words and also clear screen",
	},
	{
		mode = "n",
		"]w",
		function()
			require("snacks").words.jump(vim.v.count1, true)
		end,
		desc = "[plugin/snacks]: jump to next word reference",
	},
	{
		mode = "n",
		"[w",
		function()
			require("snacks").words.jump(-vim.v.count1, true)
		end,
		desc = "[plugin/snacks]: jump to previous word references",
	},

	-- terminal keymaps
	{
		mode = "n",
		"<leader>tt",
		function()
			require("snacks").terminal.toggle()
		end,
		desc = "[plugin/snacks]: [T]oggle [T]erminal window",
	},
	{
		mode = "n",
		"<leader>to",
		function()
			require("snacks").terminal.open()
		end,
		desc = "[plugin/snacks]: [O]pen a [T]erminal window",
	},

	-- zen mode keymaps
	{
		mode = "n",
		"<leader>zt",
		function()
			require("snacks").zen.zen()
		end,
		desc = "[plugin/snacks]: [Z]en mode [T]oggle",
	},
	{
		mode = "n",
		"<leader>zz",
		function()
			require("snacks").zen.zoom()
		end,
		desc = "[plugin/snacks]: toggle [Z]en in [Z]oom mode",
	},
}

return plugin
