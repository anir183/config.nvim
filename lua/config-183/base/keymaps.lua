--[[
--
-- nvim/lua/config-183/base/keymaps.lua
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
if VARS.os == "unix" then
	local cmd = "!"
		.. FUNCS.join_paths(
			VARS.path.config,
			"lua",
			"config-183",
			"base",
			"logvim.sh"
		)
	nmap(
		"<leader>lv",
		"<CMD>" .. cmd .. "<CR>",
		"[base]: execute [L]og[V]im command"
	)
	nmap(
		"<leader>lt",
		"<CMD>" .. cmd .. " trace<CR>",
		"[base]: execute [L]ogvim [T]race command"
	)
	nmap(
		"<leader>ld",
		"<CMD>" .. cmd .. " debug<CR>",
		"[base]: execute [L]ogvim [D]ebug command"
	)
	nmap(
		"<leader>li",
		"<CMD>" .. cmd .. " info<CR>",
		"[base]: execute [L]ogvim [I]nfo command"
	)
	nmap(
		"<leader>lw",
		"<CMD>" .. cmd .. " warn<CR>",
		"[base]: execute [L]ogvim [W]arn command"
	)
	nmap(
		"<leader>le",
		"<CMD>" .. cmd .. " error<CR>",
		"[base]: execute [L]ogvim [E]rror command"
	)
	nmap(
		"<leader>lnt",
		"<CMD>" .. cmd .. " notrace<CR>",
		"[base]: execute [L]ogvim [N]o [T]race command"
	)
	nmap(
		"<leader>lnd",
		"<CMD>" .. cmd .. " nodebug<CR>",
		"[base]: execute [L]ogvim [N]o [D]ebug command"
	)
	nmap(
		"<leader>lni",
		"<CMD>" .. cmd .. " noinfo<CR>",
		"[base]: execute [L]ogvim [N]o [I]nfo command"
	)
	nmap(
		"<leader>lnw",
		"<CMD>" .. cmd .. " nowarn<CR>",
		"[base]: execute [L]ogvim [N]o [W]arn command"
	)
	nmap(
		"<leader>lne",
		"<CMD>" .. cmd .. " noerror<CR>",
		"[base]: execute [L]ogvim [N]o [E]rror command"
	)
	nmap(
		"<leader>l1",
		"<CMD>" .. cmd .. " one<CR>",
		"[base]: execute [L]og[V]im level [1] command"
	)
	nmap(
		"<leader>l2",
		"<CMD>" .. cmd .. " two<CR>",
		"[base]: execute [L]og[V]im level [2] command"
	)
	nmap(
		"<leader>l3",
		"<CMD>" .. cmd .. " three<CR>",
		"[base]: execute [L]og[V]im level [3] command"
	)
	nmap(
		"<leader>l4",
		"<CMD>" .. cmd .. " four<CR>",
		"[base]: execute [L]og[V]im level [4] command"
	)
end

--[[ moving text ]]
-- WARN : using "<CMD>" instead of ":" breaks these commands
nmap("<C-j>", "v:m '>+1<CR>gv=<ESC>", "[base]: move the current line up")
nmap("<C-k>", "v:m '<-2<CR>gv=<ESC>", "[base]: move the current line down")
map("v", "<C-j>", ":m '>+1<CR>gv=<ESC>gv", "[base]: move selection up")
map("v", "<C-k>", ":m '<-2<CR>gv=<ESC>gv", "[base]: move selection down")

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
map(
	"x",
	"<leader>P",
	"\"_d\"+P",
	"[base]: [P]aste from system clipboard over selection without copying"
)
map({ "n", "v" }, "<leader>y", "\"+y", "[base]: [Y]ank to system clipboard")
nmap("<leader>Y", "\"+Y", "[base]: [Y]ank till end of line to system clipboard")
map({ "n", "v" }, "<leader>d", "\"_d", "[base]: [D]elete without copying")
nmap("<leader>D", "\"_D", "[base]: [D]elete till end of line without copying")
map(
	{ "n", "v" },
	"<leader>c",
	"\"_c",
	"[base]: delete and edit without copying"
)
nmap("<leader>C", "\"_C", "[base]: delete till eol and edit without copying")

--[[ split resizing ]]
nmap("(", function()
	vim.cmd.wincmd("<")
end, "[base]: increase window width")
nmap(")", function()
	vim.cmd.wincmd(">")
end, "[base]: decrease window width")
nmap("+", function()
	vim.cmd.wincmd("+")
end, "[base]: increase window height")
nmap("-", function()
	vim.cmd.wincmd("-")
end, "[base]: decrease window height")

--[[ quick fix list ]]
nmap("<leader>q", vim.cmd.copen, "[base]: open the [Q]uick fix list")
nmap("<leader>Q", vim.cmd.ccl, "[base]: close the [Q]uick fix list")
nmap("]q", vim.cmd.cnext, "[base]: walk forward in [Q]uick fix list")
nmap("[q", vim.cmd.cprev, "[base]: walk backward in [Q]uick fix list")

--[[ location list ]]
nmap("<leader>l", vim.cmd.lopen, "[base]: open the [L]ocation fix list")
nmap("<leader>L", vim.cmd.lcl, "[base]: close the [L]ocation fix list")
nmap("]l", vim.cmd.lnext, "[base]: walk forward in [L]ocation fix list")
nmap("[l", vim.cmd.lprev, "[base]: walk backward in [L]ocation fix list")

--[[ lsp keymaps ]]
vim.api.nvim_create_autocmd("LspAttach", {
	group = VARS.augrp.id,
	callback = function()
		if FUNCS.set_lsp_keymaps then
			LOG.info("using custom lsp keymap handler")
			FUNCS.set_lsp_keymaps()
			return
		end

		LOG.info("setting lsp keymaps current lsp-attached buffer")

		nmap(
			"<leader>rn",
			vim.lsp.buf.rename,
			"[base/lsp]: [R]e[N]ame symbol",
			{ buffer = 0 }
		)
		nmap(
			"<leader>ic",
			vim.lsp.buf.incoming_calls,
			"[base/lsp]: [I]ncoming [C]alls",
			{ buffer = 0 }
		)
		nmap(
			"<leader>oc",
			vim.lsp.buf.outgoing_calls,
			"[base/lsp]: [O]outgoing [C]alls",
			{ buffer = 0 }
		)
		nmap(
			"<leader>ds",
			vim.lsp.buf.document_symbol,
			"[base/lsp]: [D]ocument [S]ymbol",
			{ buffer = 0 }
		)
		map(
			{ "n", "x" },
			"<leader>ca",
			vim.lsp.buf.code_action,
			"[base/lsp]: open [C]ode [A]ctions",
			{ buffer = 0 }
		)
		nmap(
			"gD",
			vim.lsp.buf.declaration,
			"[base/lsp]: [G]oto [D]eclaration",
			{ buffer = 0 }
		)
		nmap(
			"gd",
			vim.lsp.buf.definition,
			"[base/lsp]: [G]oto [D]efinition",
			{ buffer = 0 }
		)
		nmap(
			"gr",
			vim.lsp.buf.references,
			"[base/lsp]: [G]et [R]eferences",
			{ buffer = 0 }
		)
		nmap(
			"gi",
			vim.lsp.buf.implementation,
			"[base/lsp]: [G]et [I]mplementation",
			{ buffer = 0 }
		)
		nmap(
			"<C-s>",
			vim.lsp.buf.signature_help,
			"[base]: toggle lsp signature window",
			{ buffer = 0 }
		)

		LOG.info("lsp keymaps setup and loaded")
	end,
})

LOG.info("base keymaps setup and loaded")
