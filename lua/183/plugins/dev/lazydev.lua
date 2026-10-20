---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/folke/lazydev.nvim"
plugin.config = function()
    local config_dir = vim.fn.stdpath("config")

    require("lazydev").setup({
        enabled = function(root_dir)
            return vim.fs.normalize(root_dir)
                == vim.fs.normalize(config_dir)
        end,
        library = {
            {
                path = "${3rd}/luv/library",
                words = { "vim%.uv" },
            },
            { "nvim-dap-ui" },
        },
    })
end

return plugin
