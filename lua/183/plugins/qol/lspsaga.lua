---@type 183.PluginSpec
---@diagnostic disable-next-line: missing-fields
local plugin = {}

plugin.repo = "https://github.com/nvimdev/lspsaga.nvim"
plugin.config = function()
    local map = FUNCS.map
    local nmap = function(...)
        map("n", ...)
    end
    local del = vim.keymap.del

    -- NOTE: temporary fix until lspsaga resolves the issues
    --       https://github.com/nvimdev/lspsaga.nvim/issues/1565
    ---@param bufnr integer
    ---@param position lsp.Position
    ---@param position_encoding "utf-16"|"utf-32"|"utf-8"
    ---@return integer byte_col
    vim.lsp.util._get_line_byte_from_position = function(
        bufnr,
        position,
        position_encoding
    )
        return vim.pos.lsp(bufnr, position, position_encoding).col
    end

    require("lspsaga").setup({
        hover = {
            max_width = 0.5,
            max_height = 0.3,
        },
        symbol_in_winbar = {
            enable = false,
        },
        lightbulb = {
            virtual_text = true,
            sign = false,
        },
        beacon = {
            enable = false,
        },
        ui = {
            border = vim.g.neovide and "solid" or "rounded",
        },
    })

    -- rename and replace
    del("n", "<leader>rn")
    nmap(
        "<leader>rn",
        "<CMD>Lspsaga rename<CR>",
        { desc = "[plugins.lspsaga]: [r]e[n]ame symbol" }
    )

    -- code actions
    del({ "n", "v" }, "<leader>a")
    map(
        { "n", "x" },
        "<leader>a",
        "<CMD>Lspsaga code_action<CR>",
        { desc = "[plugins.lspsaga]: open code [a]ctions" }
    )

    -- navigation
    del("n", "gd")
    del("n", "gy")
    del("n", "gai")
    del("n", "gao")
    nmap(
        "gai",
        "<CMD>Lspsaga incoming_calls<CR>",
        { desc = "[plugins.lspsaga]: [i]ncoming calls" }
    )
    nmap(
        "gao",
        "<CMD>Lspsaga outgoing_calls<CR>",
        { desc = "[plugins.lspsaga]: [o]outgoing calls" }
    )
    -- nmap(
    --     "<leader>sy",
    --     "<CMD>Lspsaga outline<CR>",
    --     { desc = "[plugins.lspsaga]: document [S][Y]mbol" }
    -- )
    -- nmap(
    --     "<leader>ol",
    --     "<CMD>Lspsaga outline<CR>",
    --     { desc = "[plugins.lspsaga]: [O]ut[L]ine" }
    -- )
    nmap(
        "gd",
        "<CMD>Lspsaga goto_definition<CR>",
        { desc = "[plugins.lspsaga]: [g]oto [d]efinition" }
    )
    nmap(
        "gy",
        "<CMD>Lspsaga goto_type_definition<CR>",
        { desc = "[plugins.lspsaga]: [g]oto t[y]pe definition" }
    )
    nmap(
        "gp",
        "<CMD>Lspsaga peek_definition<CR>",
        { desc = "[plugins.lspsaga]: [g]o [p]eek definition" }
    )
    nmap("gP", "<CMD>Lspsaga peek_type_definition<CR>", {
        desc = "[plugins.lspsaga]: [g]o [P]eek type definition",
    })

    -- finders
    del("n", "gr")
    del("n", "gi")
    nmap(
        "gr",
        "<CMD>Lspsaga finder ref<CR>",
        { desc = "[plugins.lspsaga]: [g]et [r]eferences" }
    )
    nmap(
        "gi",
        "<CMD>Lspsaga finder imp<CR>",
        { desc = "[plugins.lspsaga]: [g]et [i]mplementation" }
    )
    nmap(
        "gF",
        "<CMD>Lspsaga finder<CR>",
        { desc = "[plugins.lspsaga]: [F]inder" }
    )

    -- diagnostics
    del("n", "[d")
    del("n", "]d")
    nmap(
        "]d",
        "<CMD>Lspsaga diagnostic_jump_next<CR>",
        { desc = "[plugins.lspsaga]: next [d]iagnostic" }
    )
    nmap(
        "[d",
        "<CMD>Lspsaga diagnostic_jump_prev<CR>",
        { desc = "[plugins.lspsaga]: prev [d]iagnostic" }
    )
    nmap("<leader>bd", "<CMD>Lspsaga show_buf_diagnostics<CR>", {
        desc = "[plugins.lspsaga] show [b]uffer [d]iagnostics in loclist",
    })
    nmap(
        "<leader>wd",
        "<CMD>Lspsaga show_workspace_diagnostics<CR>",
        {
            desc = "[plugins.lspsaga] show [workspace] [D]iagnostics in qflist",
        }
    )
    nmap(
        { "<C-S-w><C-S-d>", "<C-S-w>D", "<C-w>D" },
        "<CMD>Lspsaga show_line_diagnostics<CR>",
        { desc = "[plugins.lspsaga] show line diagnostics" }
    )

    -- information
    del("n", "K")
    nmap(
        "K",
        "<CMD>Lspsaga hover_doc<CR>",
        { desc = "[plugins.lspsaga]: hover doc" }
    )
    nmap(
        "<leader>K",
        "<CMD>Lspsaga hover_doc ++keep<CR>",
        { desc = "[plugins.lspsaga]: persistent hover doc" }
    )

    -- actions
    PALETTE.add({
        id = "lspsaga.outline",
        desc = "symbol outlines in buffer",
        category = "lspsaga",
        action = "Lspsaga outline",
    })
    PALETTE.add({
        id = "lspsaga.subtypes",
        desc = "list all subtypes of symbol",
        category = "lspsaga",
        action = "Lspsaga subtypes",
    })
    PALETTE.add({
        id = "lspsaga.supertypes",
        desc = "list all supertypes of symbol",
        category = "lspsaga",
        action = "Lspsaga subtypes",
    })
end

return plugin
