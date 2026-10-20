---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/Bekaboo/dropbar.nvim"
plugin.config = function()
    require("dropbar").setup({
        bar = {
            sources = function(buf, _)
                local sources = require("dropbar.sources")
                local utils = require("dropbar.utils")

                if vim.bo[buf].ft == "markdown" then
                    return {
                        sources.path,
                        sources.markdown,
                    }
                end

                if vim.bo[buf].buftype == "terminal" then
                    return { sources.terminal }
                end

                return {
                    utils.source.fallback({
                        sources.lsp,
                        sources.treesitter,
                        sources.path,
                    }),
                }
            end,
        },
    })

    -- dropbar kind highlights
    local links = {
        Class = "Type",
        Interface = "Type",
        Struct = "Type",
        Type = "Type",
        TypeParameter = "Type",

        Function = "Function",
        Method = "Function",
        Constructor = "Special",

        Variable = "Identifier",
        Identifier = "Identifier",
        Field = "Identifier",
        Property = "Identifier",
        Parameter = "Identifier",

        Constant = "Constant",
        Enum = "Type",
        EnumMember = "Constant",

        Module = "Include",
        Namespace = "Include",
        Package = "Include",

        Keyword = "Keyword",
        Operator = "Operator",
        String = "String",
        Number = "Number",
        Boolean = "Boolean",
        Array = "Delimiter",
        Object = "Structure",
        File = "Directory",
        Folder = "Directory",
    }

    for _, name in
        ipairs(vim.fn.getcompletion("DropBarKind", "highlight"))
    do
        if name:match("NC$") then
            vim.api.nvim_set_hl(0, name, { link = "Comment" })
        end
    end

    for _, name in
        ipairs(
            vim.fn.getcompletion("DropBarIconKind", "highlight")
        )
    do
        if name:match("NC$") then
            vim.api.nvim_set_hl(0, name, { link = "Comment" })
        end
    end

    for kind, target in pairs(links) do
        vim.api.nvim_set_hl(0, "DropBarKind" .. kind, {
            link = target,
            default = true,
        })
    end

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
        {
            desc = "[plugins.dropbar] go to start of current context",
        }
    )
    FUNCS.map(
        "n",
        "];",
        dropbar_api.select_next_context,
        { desc = "[plugins.dropbar] select next context" }
    )
end

return plugin
