---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/j-hui/fidget.nvim"
plugin.config = function()
    require("fidget").setup({
        notification = {
            override_vim_notify = true,
            view = {
                group_separator_hl = "Normal",
            },
            window = {
                normal_hl = "Normal",
                winblend = 0,
                y_padding = 2,
            },
        },
    })

    FUNCS.map(
        "n",
        "<leader>nh",
        "<CMD>Fidget history<CR>",
        {
            desc = "[plugin.fidget] open [N]otification [H]istory",
        }
    )
    FUNCS.map(
        "n",
        "<leader>nc",
        "<CMD>Fidget clear<CR>",
        { desc = "[plugin.fidget] [N]otifications [C]leared" }
    )
end

return plugin
