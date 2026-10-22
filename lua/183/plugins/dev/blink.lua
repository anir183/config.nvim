---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
}
plugin.config = function()
    local blink = require("blink.cmp")
    local feedkeys = FUNCS.feedkeys
    local map = FUNCS.map

    blink.setup({
        keymap = {
            preset = "none",
        },
        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = true,
                },
            },
            menu = {
                draw = {
                    columns = {
                        {
                            "label",
                            "label_description",
                            gap = 1,
                        },
                        { "kind_icon", "kind", gap = 1 },
                        { "source_name" },
                    },
                },
            },
        },
        snippets = {
            preset = "luasnip",
        },
        sources = {
            default = {
                "lsp",
                "buffer",
                "snippets",
                "path",
            },
            per_filetype = {
                lua = { inherit_defaults = true, "lazydev" },
            },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },
    })

    -- show menu
    map({ "i", "s" }, "<C-Space>", function()
        if not blink.is_visible() then
            blink.show()
        else
            feedkeys("<C-Space>")
        end
    end, { desc = "[plugins.blink] show completion menu" })

    -- hide or cancel completion menu
    map({ "i", "s" }, "<C-c>", function()
        if blink.is_visible() then
            blink.hide()
        else
            feedkeys("<C-c>")
        end
    end, { desc = "[plugins.blink] hide completion menu" })

    map({ "i", "s" }, "<C-x>", function()
        if blink.is_visible() then
            blink.cancel()
        else
            feedkeys("<C-x>")
        end
    end, {
        desc = "[plugins.blink] cancel completion and hide",
    })

    -- navigate completion menu
    vim.keymap.del({ "i", "s" }, "<Tab>")
    vim.keymap.del({ "i", "s" }, "<S-Tab>")
    map(
        { "i", "s" },
        "<Tab>",
        function()
            if blink.is_visible() then
                blink.select_next()
                return
            end

            if not blink.snippet_forward() then
                feedkeys("<Tab>")
            end
        end,
        { desc = "[plugins.blink] next item in completion menu" }
    )
    map(
        { "i", "s" },
        "<S-Tab>",
        function()
            if blink.is_visible() then
                blink.select_prev()
                return
            end

            if not blink.snippet_backward() then
                feedkeys("<S-Tab>")
            end
        end,
        { desc = "[plugins.blink] prev item in completion menu" }
    )

    -- accept completion
    map(
        { "i", "s" },
        "<CR>",
        function()
            if not blink.accept() then
                feedkeys("<CR>")
            end
        end,
        { desc = "[plugins.blink] accept completion suggestion" }
    )

    -- documentation window
    map(
        { "i", "s" },
        "<C-k>",
        function()
            if blink.is_documentation_visible() then
                blink.hide_documentation()
            elseif blink.is_visible() then
                blink.show_documentation()
            else
                feedkeys("<C-k>")
            end
        end,
        { desc = "[plugins.blink] toggle documentation window" }
    )
    map({ "i", "s" }, "<C-d>", function()
        if not blink.scroll_documentation_down(1) then
            feedkeys("<C-d>")
        end
    end, { desc = "[plugins.blink] scroll down docs window" })
    map({ "i", "s" }, "<C-u>", function()
        if not blink.scroll_documentation_up(1) then
            feedkeys("<C-u>")
        end
    end, { desc = "[plugins.blink] scroll up docs window" })
end

return plugin
