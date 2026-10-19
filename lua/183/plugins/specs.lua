---@class 183.PluginSpec
---@field repo string|vim.pack.Spec|{ data?: { hook: string|fun(kind: "install"|"update"|"delete"): nil } }
---@field cond? boolean|fun(): boolean
---@field priority? integer
---@field config? function

---@type table<string, 183.PluginSpec>
local M = {
    -- dependencies
    devicons = { repo = "https://github.com/nvim-tree/nvim-web-devicons", priority = 50 },
    plenary = { repo = "https://github.com/nvim-lua/plenary.nvim", priority = 50 },
    nui = { repo = "https://github.com/MunifTanjim/nui.nvim", priority = 50 },

    -- ui
    base46 = require("183.plugins.ui.base46"),
    fidget = require("183.plugins.ui.fidget"),

    -- essentials
    treesitter = require("183.plugins.essn.treesitter"),
    snacks = require("183.plugins.essn.snacks"),
    harpoon = require("183.plugins.essn.harpoon"),
}

return M
