---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/neovim/nvim-lspconfig"
plugin.config = function()
    for name, conf in pairs(QOPTS.get().lsps) do
        vim.lsp.config[name] = vim.tbl_deep_extend("force", vim.lsp.config[name], conf)
        vim.lsp.enable(name)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)

            if client and client:supports_method("textDocument/inlayHint", ev.buf) then
                vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
            end
        end,
    })
end

return plugin
