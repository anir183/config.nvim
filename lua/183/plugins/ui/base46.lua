local plugin = {}

plugin.repo = "https://github.com/AvengeMedia/base46"
plugin.config = function()
    require("base46").setup({
        transparency = true,
    })

    local ok = pcall(vim.cmd.colorscheme, "dms")

    if not ok then
        vim.cmd.colorscheme("base46-catppuccin")
    elseif vim.g.neovide then
        vim.api.nvim_set_hl(0, "Normal", {
            bg = "#151311",
        })
    end

    local incsearch = vim.api.nvim_get_hl(0, {
        name = "IncSearch",
        link = false,
    })

    vim.api.nvim_set_hl(0, "StlineMode", {
        fg = incsearch.fg,
        bg = incsearch.bg,
        bold = true,
    })
end

return plugin
