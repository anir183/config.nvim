---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    data = { hook = "TSUpdate" },
}
plugin.config = function()
    local treesitter = require("nvim-treesitter")
    local parsers = require("nvim-treesitter.parsers")
    local options = QOPTS.get()

    treesitter.setup()

    vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
            for lang, parser in pairs(options.parsers or {}) do
                ---@diagnostic disable-next-line: missing-fields
                parsers[lang] = {
                    install_info = parser.install_info,
                }

                if parser.filetypes then
                    vim.treesitter.language.register(lang, parser.filetypes)
                end
            end
        end,
    })

    local installing = {}

    local function start(buf, lang)
        if not vim.api.nvim_buf_is_valid(buf) then
            return
        end

        if vim.treesitter.language.add(lang) then
            vim.treesitter.start(buf, lang)
        end
    end

    vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
            local buf = args.buf
            local filetype = vim.bo[buf].filetype
            local lang = vim.treesitter.language.get_lang(filetype)

            if not lang then
                return
            end

            -- parser is already available.
            if vim.treesitter.language.add(lang) then
                vim.treesitter.start(buf, lang)
                return
            end

            -- unknown to nvim-treesitter.
            if not vim.tbl_contains(treesitter.get_available(), lang) then
                return
            end

            -- installation already in progress.
            if installing[lang] then
                return
            end

            installing[lang] = true

            treesitter.install(lang):await(function(err, success)
                installing[lang] = nil

                if err or not success then
                    vim.notify(
                        err or ("could not install parser for " .. lang)
                    )
                    return
                end

                start(buf, lang)
            end)
        end,
    })
end

return plugin
