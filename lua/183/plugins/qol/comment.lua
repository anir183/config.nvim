---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/numToStr/Comment.nvim"
plugin.config = function()
    local map = FUNCS.map
    local nmap = function(...)
        map("n", ...)
    end

    ---@diagnostic disable-next-line: missing-fields
    require("Comment").setup({
        mappings = {
            basic = false,
            extra = false,
        },
    })

    -- comment leaders
    nmap(
        "<C-/>",
        "<PLUG>(comment_toggle_linewise)",
        { desc = "[plugins.comment] linewise commenting leader" }
    )
    nmap(
        "<C-?>",
        "<PLUG>(comment_toggle_blockwise)",
        {
            desc = "[plugins.comment] blockwise commenting leader",
        }
    )

    -- single line or count comment in normal mode
    nmap("<C-/><C-/>", function()
        if vim.api.nvim_get_vvar("count") == 0 then
            return "<PLUG>(comment_toggle_linewise_current)"
        else
            return "<PLUG>(comment_toggle_linewise_count)"
        end
    end, {
        desc = "[plugins.comment] comment current line normal mode",
        expr = true,
    })
    nmap("<C-?><C-?>", function()
        if vim.api.nvim_get_vvar("count") == 0 then
            return "<PLUG>(comment_toggle_blockwise_current)"
        else
            return "<PLUG>(comment_toggle_blockwise_count)"
        end
    end, {
        desc = "[plugins.comment] block-comment current line normal mode",
        expr = true,
    })

    -- single line or count comment in insert mode
    map("i", "<C-/><C-/>", function()
        return "<ESC><PLUG>(comment_toggle_linewise_current)<ESC>a"
    end, {
        desc = "[plugins.comment] comment current line insert mode",
        expr = true,
    })
    map("i", "<C-?><C-?>", function()
        return "<ESC><PLUG>(comment_toggle_blockwise_current)<ESC>a"
    end, {
        desc = "[plugins.comment] block-comment current line insert mode",
        expr = true,
    })

    -- visual mode comment
    map(
        "x",
        "<C-/>",
        -- NOTE: "<PLUG>(comment_toggle_linewise_visual)" did not work
        --       https://github.com/numToStr/Comment.nvim/blob/e30b7f2008e52442154b66f7c519bfd2f1e32acb/plugins.comment.lua#L134
        "<ESC><CMD>lua require(\"Comment.api\").locked(\"toggle.linewise\")(vim.fn.visualmode())<CR>gv",
        { desc = "[plugins.comment] comment current selection" }
    )
    map(
        "x",
        "<C-?>",
        -- NOTE: "<PLUG>(comment_toggle_blockwise_visual)" did not work
        --       https://github.com/numToStr/Comment.nvim/blob/e30b7f2008e52442154b66f7c519bfd2f1e32acb/plugins.comment.lua#L140
        "<ESC><CMD>lua require(\"Comment.api\").locked(\"toggle.blockwise\")(vim.fn.visualmode())<CR>gv",
        {
            desc = "[plugins.comment] block-comment current selection",
        }
    )
end

return plugin
