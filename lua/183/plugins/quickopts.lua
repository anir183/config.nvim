_G.QOPTS = {}

---@module "nvim-treesitter"
---@class 183.TreesitterParser
---@field install_info InstallInfo
---@field filetypes string|string[]|nil

---@class 183.CloakRule
---@field file_pattern string|string[]
---@field cloak_pattern string|string[]
---@field replace string|string[]|nil

---@module "dap"
---@module "conform"
---@module "lint"
---@class 183.Options
---@field plugins table<string, 183.PluginSpec>
---@field lsps table<string, vim.lsp.Config|nil>
---@field formatters table<string, conform.FiletypeFormatter>
---@field custom_formatters table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
---@field linters table<string, string[]>
---@field custom_linters table<string, fun(): lint.Linter|lint.Linter>
---@field dap table<string, { adapter: dap.Adapter | fun( callback: fun(adapter: dap.Adapter), config: dap.Configuration, parent?: dap.Session), configs: dap.Configuration[] }>
---@field filetypes vim.filetype.add.filetypes[]
---@field parsers table<string, 183.TreesitterParser>
---@field cloak 183.CloakRule[]

local opt_template = {
    "---@type 183.Options",
    "---@diagnostic disable-next-line: missing-fields",
    "local M = {}",
    "",
    "-- plugins",
    "M.plugins = {}",
    "",
    "-- lsp server config",
    "M.lsps = {}",
    "",
    "-- :h conform-formatters",
    "-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md",
    "M.formatters = {}",
    "M.custom_formatters = {}",
    "",
    "-- https://github.com/mfussenegger/nvim-lint#available-linters",
    "M.linters = {}",
    "M.custom_linters = {}",
    "",
    "-- dap configuration",
    "M.dap = {}",
    "",
    "-- additional filetypes",
    "M.filetypes = {}",
    "",
    "-- treesitter parsers",
    "M.parsers = {}",
    "",
    "-- visual obfuscation",
    "M.cloak = {",
    "   {",
    "       file_pattern = { \".env\", \".env.*\" },",
    "       cloak_pattern = { \"=.+\" },",
    "       replace = nil,",
    "   },",
    "}",
    "",
    "return M",
}

---@return string
local function ensure_file()
    local opts_path = FUNCS.join_path(
        vim.fn.stdpath("config"),
        "lua",
        "opts183.lua"
    )

    if vim.fn.filereadable(opts_path) == 1 then
        return opts_path
    end

    local parent = vim.fn.fnamemodify(opts_path, ":h")
    vim.fn.mkdir(parent, "p")
    vim.fn.writefile(opt_template, opts_path)

    return opts_path
end

function QOPTS.open()
    local opts_path = ensure_file()
    local ui = vim.api.nvim_list_uis()[1]
    local width = math.floor((ui.width * 0.7) + 0.5)
    local height = math.floor((ui.height * 0.75) + 0.5)

    vim.api.nvim_open_win(
        vim.api.nvim_create_buf(false, true),
        true,
        {
            relative = "editor",
            width = width,
            height = height,
            col = (ui.width - width) / 2,
            row = (ui.height - height) / 2,
            focusable = true,
            border = "none",
        }
    )

    vim.cmd.edit(opts_path)
    vim.defer_fn(function()
        FUNCS.map("n", "q", "<cmd>wq<cr>")
    end, 10)
end

function QOPTS.load()
    local opts = dofile(ensure_file())
    QOPTS._options = type(opts) == "table" and opts or {}
end

---@return 183.Options
function QOPTS.get()
    if QOPTS._options then
        return QOPTS._options
    end

    QOPTS.load()
    return QOPTS._options
end

QOPTS.load()

PALETTE.add({
    id = "plugins.quick_opts",
    desc = "open quick options in buffer",
    category = "plugins",
    action = QOPTS.open,
})

FUNCS.map("n", "<leader>op", QOPTS.open, {
    desc = "[plugins.quickopts] open quick options in floating buffer",
})
