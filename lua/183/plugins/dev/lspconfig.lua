---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/neovim/nvim-lspconfig"
plugin.config = function()
    for name, conf in pairs(QOPTS.get().lsps) do
        vim.lsp.config[name] = vim.tbl_deep_extend("force", vim.lsp.config[name], conf)
        vim.lsp.enable(name)
    end
end

return plugin
