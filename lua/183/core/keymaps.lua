--[[ map or remap functionality that is already built-in to neovim ]]

---@module "183.core.types"

---@type table<string, 183.core.types.Keymap>
local M = {}

-- misc
M["open [M]e[S]sages history"] = {
	lhs = "<leader>ms",
	rhs = "<CMD>messages<CR>",
}

-- move text
-- WARN : using "<CMD>" instead of ":" breaks these keymaps
M["move current line up"] = {
	category = "move-text",
	lhs = "<C-j>",
	rhs = "v:m '>+1<CR>gv=<ESC>",
}
M["move current line down"] = {
	category = "move-text",
	lhs = "<C-k>",
	rhs = "v:m '<-2<CR>gv=<ESC>",
}
M["move selection up"] = {
	mode = "v",
	category = "move-text",
	lhs = "<C-j>",
	rhs = ":m '>+1<CR>gv=<ESC>gv",
}
M["move selection down"] = {
	mode = "v",
	category = "move-text",
	lhs = "<C-k>",
	rhs = ":m '<-2<CR>gv=<ESC>gv",
}

-- center cursor while jumping around to keep it stationary
M["dont move the cursor when joining next line"] = {
	category = "stationary-cursor",
	lhs = "J",
	rhs = "mzJ`z",
}
M["keep cursor centered when scrolling down"] = {
	category = "stationary-cursor",
	lhs = "<C-d>",
	rhs = "<C-d>zz",
}
M["keep cursor centered when jumping to next result"] = {
	category = "stationary-cursor",
	lhs = "n",
	rhs = "nzzzv",
}
M["keep cursor centered when jumping to prev result"] = {
	category = "stationary-cursor",
	lhs = "N",
	rhs = "Nzzzv",
}

-- system clipboard
M["[P]aste from system clipboard"] = {
	category = "clipboard",
	lhs = "<leader>P",
	rhs = "\"+p",
}
M["[P]aste from system clipboard without copying"] = {
	mode = "x",
	category = "clipboard",
	lhs = "<leader>P",
	rhs = "\"_d\"+p",
}
M["[Y]ank to system clipboard"] = {
	mode = { "n", "v" },
	category = "clipboard",
	lhs = "<leader>y",
	rhs = "\"+y",
}
M["[Y]ank till end of line to system clipboard"] = {
	category = "clipboard",
	lhs = "<leader>Y",
	rhs = "\"+Y",
}

-- no-copy versions of delete, paste and change keymaps
M["[P]aste over selection without copying"] = {
	mode = "x",
	category = "no-copy",
	lhs = "<leader>p",
	rhs = "\"_dP",
}
M["[P]aste over selection without copying"] = {
	mode = "x",
	category = "no-copy",
	lhs = "<leader>p",
	rhs = "\"_dP",
}
M["[D]elete without copying"] = {
	mode = { "n", "v" },
	category = "no-copy",
	lhs = "<leader>d",
	rhs = "\"_d",
}
M["[D]elete till end of line without copying"] = {
	category = "no-copy",
	lhs = "<leader>D",
	rhs = "\"_D",
}
M["[C]hange without copying"] = {
	mode = { "n", "v" },
	category = "no-copy",
	lhs = "<leader>c",
	rhs = "\"_c",
}
M["[C]hange till end of line without copying"] = {
	mode = { "n", "v" },
	category = "no-copy",
	lhs = "<leader>C",
	rhs = "\"_C",
}

-- splits resizing
M["increase window width"] = {
	category = "resizing",
	lhs = "<C-.>",
	rhs = "<CMD>wincmd ><CR>",
}
M["decrease window width"] = {
	category = "resizing",
	lhs = "<C-,>",
	rhs = "<CMD>wincmd <<CR>",
}
M["increase window height"] = {
	category = "resizing",
	lhs = "<C-S-.>",
	rhs = "<CMD>wincmd +<CR>",
}
M["decrease window height"] = {
	category = "resizing",
	lhs = "<C-S-,>",
	rhs = "<CMD>wincmd -<CR>",
}

-- utility lists
M["open [T]a[B]s list"] = {
	category = "lists",
	lhs = "<leader>tb",
	rhs = vim.cmd.tabs,
}
M["open [B]u[F]fers list"] = {
	category = "lists",
	lhs = "<leader>bf",
	rhs = vim.cmd.buffers,
}
M["open [J]um[P]s list"] = {
	category = "lists",
	lhs = "<leader>jp",
	rhs = vim.cmd.jumps,
}
M["open [M]ar[K]s list"] = {
	category = "lists",
	lhs = "<leader>mk",
	rhs = vim.cmd.marks,
}

-- buffer navigation
M["previous buffer"] = {
	category = "buffers",
	lhs = "[b",
	rhs = vim.cmd.bprev,
}
M["next buffer"] = {
	category = "buffers",
	lhs = "]b",
	rhs = vim.cmd.bnext,
}

-- quick fix list
M["open [Q]uick fix [L]ist"] = {
	category = "qflist",
	lhs = "<leader>ql",
	rhs = vim.cmd.copen,
}
M["close [Q]uick fix [L]ist"] = {
	category = "qflist",
	lhs = "<leader>QL",
	rhs = vim.cmd.ccl,
}
M["[Q]uick fix list [H]istory"] = {
	category = "qflist",
	lhs = "<leader>qh",
	rhs = vim.cmd.chistory,
}
M["[Q]uick fix list [C]lear"] = {
	category = "qflist",
	lhs = "<leader>qc",
	rhs = vim.cmd("cexpr []"),
}
M["jump to next [Q]uick fix list item"] = {
	category = "qflist",
	lhs = "]q",
	rhs = vim.cmd.cnext,
}
M["jump to previous [Q]uick fix list item"] = {
	category = "qflist",
	lhs = "[q",
	rhs = vim.cmd.cprev,
}
M["jump to last [Q]uick fix list item"] = {
	category = "qflist",
	lhs = "]Q",
	rhs = vim.cmd.clast,
}
M["jump to first [Q]uick fix list item"] = {
	category = "qflist",
	lhs = "[Q",
	rhs = vim.cmd.cfirst,
}
M["jump to newer [Q]uick fix list"] = {
	category = "loclist",
	lhs = "<leader>]q",
	rhs = vim.cmd.lnewer,
}
M["jump to older [Q]uick fix list"] = {
	category = "loclist",
	lhs = "<leader>[q",
	rhs = vim.cmd.lolder,
}

-- location list
M["open [L]ocation [L]ist"] = {
	category = "loclist",
	lhs = "<leader>ll",
	rhs = vim.cmd.lopen,
}
M["close [L]ocation [L]ist"] = {
	category = "loclist",
	lhs = "<leader>LL",
	rhs = vim.cmd.lcl,
}
M["[L]ocation list [H]istory"] = {
	category = "qflist",
	lhs = "<leader>lh",
	rhs = vim.cmd.lhistory,
}
M["[L]ocation list [C]lear"] = {
	category = "qflist",
	lhs = "<leader>lc",
	rhs = vim.cmd("lexpr []"),
}
M["jump to next [L]ocation list item"] = {
	category = "loclist",
	lhs = "]l",
	rhs = vim.cmd.lnext,
}
M["jump to previous [L]ocation list item"] = {
	category = "loclist",
	lhs = "[l",
	rhs = vim.cmd.lprev,
}
M["jump to last [L]ocation list item"] = {
	category = "loclist",
	lhs = "]L",
	rhs = vim.cmd.llast,
}
M["jump to first [L]ocation list item"] = {
	category = "loclist",
	lhs = "[L",
	rhs = vim.cmd.lfirst,
}
M["jump to newer [L]ocation list"] = {
	category = "loclist",
	lhs = "<leader>]l",
	rhs = vim.cmd.lnewer,
}
M["jump to older [L]ocation list"] = {
	category = "loclist",
	lhs = "<leader>[l",
	rhs = vim.cmd.lolder,
}

-- save and quit
M["[Q]uit buffer"] = {
	lhs = "<leader>qq",
	rhs = "<CMD>bd<CR>",
}
M["[Q]uit window"] = {
	lhs = "<leader>QQ",
	rhs = "<CMD>q<CR>",
}
M["[W]rite file"] = {
	lhs = "<leader>ww",
	rhs = "<CMD>w<CR>",
}
M["[W]rite and [Q]uit"] = {
	lhs = "<leader>wq",
	rhs = "<CMD>wq<CR>",
}

return M
