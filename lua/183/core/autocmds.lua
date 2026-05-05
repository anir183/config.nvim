--[[ some event-based setup using auto commands ]]

---@module "183.core.types"

---@type table<string, 183.core.types.AutoCommand>
local M = {}

M["highlight on yank"] = {
	events = "TextYankPost",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 75,
		})
	end,
}

M["disable color column in some filtypes"] = {
	events = "FileType",
	patterns = { "netrw", "help" },
	callback = function()
		vim.opt_local.colorcolumn = "0"
		vim.opt_local.statuscolumn = "%s"
		vim.opt_local.statusline = nil
	end,
}

M["disable numbers in netrw"] = {
	events = {
		"WinEnter",
		"FocusGained",
		"BufReadPre",
		"FileReadPre",
	},
	patterns = "netrw",
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
}

M["make view to retain folds"] = {
	events = {
		"BufWritePre",
		"BufWinLeave",
		"BufLeave",
	},
	command = "silent! mkview",
}

M["load view to load previous folds"] = {
	events = "BufWinEnter",
	command = "silent! loadview",
}

M["delete item from quick fix list"] = {
	events = "FileType",
	patterns = "qf",
	callback = function()
		---@source https://stackoverflow.com/a/77181885

		_G.FUNCS.map("n", "dd", function()
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
		end, { desc = "[core.qflist] [D]elete item", buf = 0 })
	end,
}

return M
