---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/nmac427/guess-indent.nvim"
plugin.config = function()
    local guess = require("guess-indent")
    guess.setup({
        auto_cmd = true,
    })

    -- made to work after the following aucmd
    -- https://github.com/NMAC427/guess-indent.nvim/blob/84a4987ff36798c2fc1169cbaff67960aed9776f/lua/guess-indent/init.lua#L30
    vim.api.nvim_create_autocmd({
        "BufReadPost",
        "BufWritePost",
        "BufNewFile",
    }, {
        desc = "set leadmultispace after guess does its job",
        callback = function(_)
            vim.defer_fn(function()
                vim.opt_local.listchars:remove("leadmultispace")
                ---@diagnostic disable-next-line: param-type-mismatch
                vim.opt_local.listchars:append({
                    leadmultispace = "│" .. (" "):rep(vim.bo.tabstop - 1),
                })
            end, 300)
        end,
    })

    FUNCS.map("n", "<leader>IN", function()
        vim.cmd.GuessIndent()
        vim.opt_local.listchars:remove("leadmultispace")
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.opt_local.listchars:append({
            leadmultispace = "│" .. (" "):rep(vim.bo.tabstop - 1),
        })
    end, { desc = "[plugins.guess-indent] auto guess [IN]dentation" })

    PALETTE.add({
        id = "guessindent.guess",
        desc = "auto resolve indentation style",
        category = "guessindent",
        action = function()
            vim.cmd.GuessIndent()
            vim.opt_local.listchars:remove("leadmultispace")
            ---@diagnostic disable-next-line: param-type-mismatch
            vim.opt_local.listchars:append({
                leadmultispace = "│" .. (" "):rep(vim.bo.tabstop - 1),
            })
        end,
    })
end

return plugin
