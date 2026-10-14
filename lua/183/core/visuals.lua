vim.opt.messagesopt:append("pager:<CR>")
require("vim._core.ui2").enable()

-- borders
vim.o.winborder = "none"
vim.o.pumborder = "none"

-- diagnostic icons
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN] = "󰀪",
            [vim.diagnostic.severity.INFO] = "󰋼",
            [vim.diagnostic.severity.HINT] = "󰌵",
        },
    },
    float = {
        max_width = 90,
        max_height = 15,
    },
})

-- colors and transparency
vim.cmd.colorscheme("catppuccin")
local hl = vim.api.nvim_set_hl

hl(0, "Normal", { bg = "none" })

hl(0, "StatusLine", { bg = "none" })
hl(0, "StatusLineNC", { bg = "none" })
hl(0, "StatusLineTerm", { bg = "none" })
hl(0, "StatusLineTermNC", { bg = "none" })
