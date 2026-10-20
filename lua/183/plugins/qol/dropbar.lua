---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/Bekaboo/dropbar.nvim"
plugin.config = function()
    local dropbar_api = require("dropbar.api")

    FUNCS.map(
        "n",
        "<leader>;",
        dropbar_api.pick,
        { desc = "[plugins.dropbar] pick symbols in winbar" }
    )
    FUNCS.map(
        "n",
        "[;",
        dropbar_api.goto_context_start,
        { desc = "[plugins.dropbar] go to start of current context" }
    )
    FUNCS.map(
        "n",
        "];",
        dropbar_api.select_next_context,
        { desc = "[plugins.dropbar] select next context" }
    )
end

return plugin
