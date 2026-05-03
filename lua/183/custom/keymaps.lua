--[[ keymaps for custom functionality ]]

---@module "183.custom.types"

---@type table<string, 183.custom.types.Keymap>
local M = {}

M["toggle [R]elative [L]ine numbers"] = {
	category = "toggles",
	lhs = "<leader>rl",
	rhs = function()
		vim.o.relativenumber = not vim.o.relativenumber
	end,
}

M["toggle fold column"] = {
	category = "toggles",
	lhs = "zt",
	rhs = function()
		vim.o.foldcolumn = vim.o.foldcolumn == "0" and "auto:9" or "0"
	end,
}

M["toggle cu[R]sor [C]entering"] = {
	category = "toggles",
	lhs = "<leader>rc",
	rhs = function()
		vim.o.scrolloff = 999 - vim.o.scrolloff
	end,
}

M["edit [OP]tions"] = {
	category = "commands",
	lhs = "<leader>op",
	rhs = "<CMD>" .. _G.CONSTS.strings.cmd_prefix .. "EditOptions<CR>",
}

M["change [IN]dentation"] = {
	category = "commands",
	lhs = "<leader>in",
	rhs = "<CMD>" .. _G.CONSTS.strings.cmd_prefix .. "ChangeIndent<CR>",
}

M["change colo[R] column [P]osition"] = {
	category = "change-opts",
	lhs = "<leader>rp",
	rhs = function()
		vim.ui.input({
			prompt = "color column position: ",
		}, function(col_pos)
			if not col_pos or not _G.FUNCS.is_num(col_pos) then
				return
			end

			vim.o.colorcolumn = col_pos
		end)
	end,
}

M["change [F]ile[T]ype of current buffer"] = {
	category = "change-opts",
	lhs = "<leader>ft",
	rhs = function()
		vim.ui.input({
			prompt = "new file type: ",
		}, function(filetype)
			if not filetype or filetype == "" then
				return
			end

			vim.bo.filetype = filetype
		end)
	end,
}

M["check [P]ath to current [F]ile"] = {
	category = "info",
	lhs = "<leader>pf",
	rhs = function()
		vim.print(vim.fn.expand("%:p"))
	end,
}

return M
