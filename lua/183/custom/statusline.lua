_G.STLINE = {}

local hl = FUNCS.str_fmt

local modes = {
    n = "normal",
    no = "op-pending",
    i = "insert",
    ic = "insert",
    v = "visual",
    V = "v-line",
    ["\22"] = "v-block",
    s = "select",
    S = "s-line",
    ["\19"] = "s-block",
    R = "replace",
    c = "command",
    r = "prompt",
    ["!"] = "shell",
    t = "terminal",
}

local incsearch = vim.api.nvim_get_hl(0, {
    name = "IncSearch",
    link = false,
})

vim.api.nvim_set_hl(0, "StlineMode", {
    fg = incsearch.fg,
    bg = incsearch.bg,
    bold = true,
})

---@return string
function STLINE.mode()
    local mode = vim.api.nvim_get_mode().mode
    local name = modes[mode] or modes[mode:sub(1, 1)]

    return hl("StlineMode", "  " .. name .. "  ")
end

---@return string
function STLINE.diagnostics()
    local counts = vim.diagnostic.count(0)
    local parts = {}

    for severity, group in pairs({
        [vim.diagnostic.severity.ERROR] = "DiagnosticError",
        [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
        [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
        [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    }) do
        local count = counts[severity] or 0
        if count > 0 then
            parts[#parts + 1] = hl(group, count)
        end
    end

    return table.concat(parts, " ")
end

---@return string
function STLINE.lsp()
    local names = {}

    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        names[#names + 1] = client.name
    end

    return #names > 0 and hl("Directory", table.concat(names, ", ")) or ""
end

---@return string
function STLINE.filetype()
    return vim.bo.filetype ~= "" and hl("Type", vim.bo.filetype) or ""
end

---@return string
function STLINE.arrange()
    return table.concat({
        -- left
        " ",
        "%{%v:lua.STLINE.mode()%}",
        "  ",
        "%{%v:lua.STLINE.lsp()%}",
        "  ",
        "%r",
        "%w",
        "%h",
        "%m",

        "%=",
        -- center
        "%f",

        "%=",
        -- right
        "%{%v:lua.STLINE.diagnostics()%}",
        "  ",
        "%{%v:lua.STLINE.filetype()%}",
        "  ",
        "%02l:%02c",
        " ~ ",
        "%2p%%",
        " "
    })
end
vim.opt.statusline = STLINE.arrange()
