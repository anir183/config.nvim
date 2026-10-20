---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/ray-x/lsp_signature.nvim"
plugin.config = function()
    local signature = require("lsp_signature")
    signature.setup({
        floating_window = false,
        doc_lines = 0,
        hint_prefix = {
            above = "↙ ",
            current = "🡨 ",
            below = "↖ ",
        },
        handler_opts = {
            border = "solid",
        },
    })

    vim.keymap.del({ "n", "i", "s" }, "<C-s>")
    FUNCS.map({ "n", "i", "s" }, "<C-s>", function()
        require("lsp_signature").toggle_float_win()
    end, { desc = "[plugin.lsp_signature] toggle signature widow" })
end

return plugin
