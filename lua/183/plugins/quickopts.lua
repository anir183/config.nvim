_G.QOPTS = {}

---@module "nvim-treesitter"
---@class 183.TreesitterParser
---@field install_info InstallInfo
---@field filetypes string|string[]|nil

---@class 183.Options
---@field plugins table<string, 183.PluginSpec>
---@field parsers table<string, 183.TreesitterParser>

local opt_template = {
    "---@type 183.Options",
    "local M = {}",
    "",
    "-- plugins",
    "M.plugins = {}",
    "",
    "-- treesitter parsers",
    "M.parsers = {}",
    "",
    "return M",
}

---@return string
local function ensure_file()
    local opts_path = FUNCS.join_path(vim.fn.stdpath("state"), "183", "options.lua")

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

    vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
        relative = "editor",
        width = width,
        height = height,
        col = (ui.width - width) / 2,
        row = (ui.height - height) / 2,
        focusable = true,
        border = "none",
    })

    vim.cmd.edit(opts_path)
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
