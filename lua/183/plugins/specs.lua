---@alias Hooks "install"|"update"|"delete"

---@class 183.PluginSpec
---@field repo string|vim.pack.Spec|{ data?: { hook: Hooks|fun(kind: Hooks): nil } }
---@field cond? boolean|fun(): boolean
---@field priority? integer
---@field config? function

---@type table<string, 183.PluginSpec>
local M = {
    -- dependencies
    devicons = { repo = "https://github.com/nvim-tree/nvim-web-devicons" },
    plenary = { repo = "https://github.com/nvim-lua/plenary.nvim" },
    nui = { repo = "https://github.com/MunifTanjim/nui.nvim" },

    -- ui
    base46 = require("183.plugins.ui.base46"),
    fidget = require("183.plugins.ui.fidget"),

    -- essentials
    treesitter = require("183.plugins.essn.treesitter"),
}

return M
