local o = vim.o

-- ui
o.number = true
o.relativenumber = true
o.signcolumn = "number"
o.cursorline = true
o.laststatus = 3

-- editing
o.expandtab = true -- expand tab character to spaces
o.tabstop = 4 -- size of tab character in number of spaces
o.shiftwidth = 0 -- size of each level of indentation (0 -> tabstop)
o.softtabstop = -1 -- size of tab character in insert mode (-1 -> shiftwidth)
o.autoindent = true -- copy current indentation for new line
o.smartindent = false -- dont auto indent based on context

-- folding
o.foldmethod = "manual"
o.foldtext = ""
o.foldlevelstart = 1
o.foldnestmax = 9
o.foldcolumn = "auto:9"

-- display
o.wrap = false
o.textwidth = 0
o.scrolloff = 8
o.sidescrolloff = 8
o.colorcolumn = "91"

-- search
o.ignorecase = true
o.smartcase = true
o.inccommand = "split"
o.wrapscan = true

-- completion
o.completeopt = "fuzzy,menu,menuone,noselect,preview"
o.pumheight = 12
o.pummaxwidth = 80

-- splits
-- WARN: keep splitright and splitbelow false, or dap breaks
--       https://github.com/rcarriga/nvim-dap-ui/issues/424
o.splitright = false
o.splitbelow = false
o.splitkeep = "screen"

-- persistence
o.undofile = true
o.undolevels = 10000

-- responsiveness
o.updatetime = 250 -- https://www.reddit.com/r/vim/comments/jqogan/how_does_a_lower_updatetime_lead_to_better
o.timeoutlen = 500

-- navigation
o.jumpoptions = "stack,view" -- https://www.reddit.com/r/neovim/comments/1cytkbq/comment/l7cqdmq

-- invisible characters
o.list = true
o.listchars = table.concat({
    "leadmultispace:│   ",
    "leadtab:╎  ",

    "tab:>  ",
    "trail:␣",

    "extends:‥",
    "precedes:‥",
}, ",")

-- disable netrw
vim.g.loaded_netrwPlugin = 1
