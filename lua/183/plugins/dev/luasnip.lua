---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = {
    src = "https://github.com/L3MON4D3/LuaSnip",
    version = vim.version.range("2.*"),
    data = {
        hook = function(_, ev)
            local result = vim.system(
                { "make", "install_jsregexp" },
                { cwd = ev.data.path, text = true }
            ):wait()
            vim.notify(vim.inspect(result))
        end,
    },
}
plugin.config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
end

return plugin
