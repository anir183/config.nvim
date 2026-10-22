---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/stevearc/quicker.nvim"
plugin.config = function()
    local quicker = require("quicker")

    quicker.setup({
        keys = {
            {
                ">",
                function()
                    quicker.expand({
                        before = 2,
                        after = 2,
                        add_to_existing = true,
                    })
                end,
                desc = "[plugins.quicker] expand quickfix context",
            },
            {
                "<",
                quicker.collapse,
                desc = "[plugins.quicker] collapse quickfix context",
            },
        },
    })

    FUNCS.map(
        "n",
        "<leader>ql",
        function()
            quicker.toggle({
                height = 10,
            })
        end,
        { desc = "[plugins.quicker] toggle [q]uick fix [l]ist" }
    )
    FUNCS.map("n", "<leader>ll", function()
        quicker.toggle({
            loclist = true,
            height = 10,
        })
    end, {
        desc = "[plugins.quicker] toggle [l]ocation [l]ist",
    })
end

return plugin
