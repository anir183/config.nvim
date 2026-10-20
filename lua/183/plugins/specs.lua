---@class 183.PluginSpec
---@field repo string|vim.pack.Spec|{ data?: { hook: string|fun(kind: "install"|"update"|"delete"): nil } }
---@field cond? boolean|fun(): boolean
---@field priority? integer
---@field config? function

---@param opts 183.PluginSpec
---@param num? integer
---@return 183.PluginSpec
local function pr(opts, num)
    opts = vim.tbl_deep_extend("keep", opts, { priority = num or 0 })
    return opts
end

---@type table<string, 183.PluginSpec>
local M = {
    -- dependencies
    devicons = pr({ repo = "https://github.com/nvim-tree/nvim-web-devicons" }, 50),
    plenary = pr({ repo = "https://github.com/nvim-lua/plenary.nvim" }, 50),
    nui = pr({ repo = "https://github.com/MunifTanjim/nui.nvim" }, 50),
    nio = pr({ repo = "https://github.com/nvim-neotest/nvim-nio" }, 50),

    -- ui
    base46 = pr(require("183.plugins.ui.base46"), 100),
    fidget = require("183.plugins.ui.fidget"),

    -- essentials
    treesitter = pr(require("183.plugins.essn.treesitter"), 25),
    snacks = pr(require("183.plugins.essn.snacks"), 25),
    quicker = require("183.plugins.essn.quicker"),
    harpoon = require("183.plugins.essn.harpoon"),

    -- dev tools
    lspconfig = pr(require("183.plugins.dev.lspconfig"), 25),
    lazydev = pr(require("183.plugins.dev.lazydev"), 4),
    friendly_snips = pr({ repo = "https://github.com/rafamadriz/friendly-snippets" }, 3),
    luasnip = pr(require("183.plugins.dev.luasnip"), 2),
    blink = pr(require("183.plugins.dev.blink"), 1),
    mason = require("183.plugins.dev.mason"),
    conform = require("183.plugins.dev.conform"),
    lint = require("183.plugins.dev.lint"),

    -- debugging
    dap = pr(require("183.plugins.debug.dap"), 1),
    dapui = require("183.plugins.debug.dapui"),
    dapvtext = require("183.plugins.debug.virtualtext"),

    -- quality of life
    cloak = require("183.plugins.qol.cloak"),
    colorpicker = require("183.plugins.qol.colorpicker"),
    comment = require("183.plugins.qol.comment"),
    dropbar = require("183.plugins.qol.dropbar"),
    todo = pr(require("183.plugins.qol.todo"), 26),
    guessindent = require("183.plugins.qol.guessindent"),
    lspsaga = require("183.plugins.qol.lspsaga"),
    lspsign = require("183.plugins.qol.lspsign"),

    -- stacks
    flutter = require("183.plugins.stacks.flutter"),
}

return M
