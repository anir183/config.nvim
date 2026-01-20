--[[
--
-- nvim/lua/config-183/custom/keymaps.lua
--
-- keymaps to new custom functionality built using neovim functions
--
--]]

local nmap = FUNCS.nmap

--[[ toggle relative line number ]]
nmap("<leader>rl", function()
	vim.o.relativenumber = not vim.o.relativenumber
end, "[custom]: toggle [R]elative [L]ine numbers")

--[[ toggle fold column ]]
nmap("zt", function()
	local fc = vim.o.foldcolumn
	vim.opt.foldcolumn = fc == "0" and "auto:9" or "0"
end, "[custom]: toggle fold column")

--[[ edit options in a popup ]]
nmap(
	"<leader>op",
	"<CMD>" .. VARS.strings.cmd_prefix .. "EditOptions<CR>",
	"[custom]: edit configuration [O][P]tions"
)

--[[ change color column ]]
nmap("<leader>cl", function()
	vim.ui.input({
		prompt = "color column position: ",
	}, function(col_pos)
		if not col_pos or not FUNCS.str_isnum(col_pos) then
			return
		end

		vim.o.colorcolumn = col_pos
	end)
end, "[custom]: change the [C]olor co[L]umn position")

--[[ change indentation style ]]
nmap(
	"<leader>in",
	"<CMD>" .. VARS.strings.cmd_prefix .. "ChangeIndent<CR>",
	"[custom]: change [I][N]dentatin style"
)

--[[ toggle cursor movement ]]
nmap("<leader>lc", function()
	vim.o.scrolloff = 999 - vim.o.scrolloff
end, "[custom]: togg[L]e between moving text or moving [C]ursor")

--[[ substitute a string either as standalone or substring ]]
nmap(
	"<leader>sb",
	"<CMD>" .. VARS.strings.cmd_prefix .. "SubstituteWord<CR>",
	"[custom]: [S]u[B]stitute a string as standalone or substring"
)
