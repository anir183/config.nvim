local map = FUNCS.map
local nmap = function(...)
    map("n", ...)
end

-- editing
nmap("<leader>rn", vim.lsp.buf.rename, { desc = "[lsp] [r]e[n]ame symbol" })

-- documentation and information
nmap("K", function()
    vim.lsp.buf.hover({
        max_width = 80,
        max_height = 20,
    })
end, { desc = "[lsp] hover documentation" })
map(
    { "n", "i", "s" },
    "<C-s>",
    vim.lsp.buf.signature_help,
    { desc = "[lsp] [s]ignature help" }
)
nmap("<leader>li", function()
    vim.cmd("checkhealth vim.lsp")
end, { desc = "[lsp] [l]sp [i]nformation" })

-- navigation
nmap("gd", vim.lsp.buf.definition, { desc = "[lsp] [g]oto [d]efinition" })
nmap("gD", vim.lsp.buf.declaration, { desc = "[lsp] [g]oto [D]eclaration" })
nmap("gi", vim.lsp.buf.implementation, { desc = "[lsp] [g]oto [i]mplementation" })
nmap("gr", vim.lsp.buf.references, { desc = "[lsp] [g]oto [r]eferences" })

-- code actions
map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, { desc = "[lsp] code [a]ctions" })

-- formatting
map({ "n", "v" }, "<leader>fm", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "[lsp] [f]or[m]at file" })

-- lists and symbols
nmap("<leader>ic", vim.lsp.buf.incoming_calls, { desc = "[lsp] [i]ncoming [c]alls" })
nmap("<leader>oc", vim.lsp.buf.outgoing_calls, { desc = "[lsp] [o]outgoing [c]alls" })
nmap("<leader>sy", vim.lsp.buf.document_symbol, { desc = "[lsp] document [s][y]mbols" })
nmap("<leader>st", function()
    vim.lsp.buf.typehierarchy("subtypes")
end, { desc = "[lsp] [s]ub [t]ypes" })
nmap("<leader>ST", function()
    vim.lsp.buf.typehierarchy("supertypes")
end, { desc = "[lsp] [S]uper [T]ypes" })
nmap("<leader>ws", function()
    vim.lsp.buf.workspace_symbol("")
end, { desc = "[lsp] [w]orkspace [s]ymbols" })
nmap("<leader>WS", function()
    vim.ui.input({
        prompt = "workspace symbols filter query: ",
    }, function(query)
        if not query then
            return
        end

        vim.lsp.buf.workspace_symbol(query)
    end)
end, { desc = "[lsp] [W]orkspace [S]ymbols with query" })

-- diagnostics
nmap("[d", function()
    vim.diagnostic.jump({ count = -1 })
end, { desc = "[lsp] previous [d]iagnostic", force = true })
nmap("]d", function()
    vim.diagnostic.jump({ count = 1 })
end, { desc = "[lsp] next [d]iagnostic", force = true })
nmap(
    "<leader>wd",
    vim.lsp.buf.workspace_diagnostics,
    { desc = "[lsp] load [w]orkspace [d]iagnostics" }
)
nmap(
    "<leader>ld",
    vim.diagnostic.setloclist,
    { desc = "[lsp] [l]ist buffer [d]iagnostics in loclist" }
)
nmap(
    "<leader>LD",
    vim.diagnostic.setqflist,
    { desc = "[lsp] [L]ist all [D]iagnostics in qflist" }
)

-- workspace folders
nmap(
    "<leader>wa",
    vim.lsp.buf.add_workspace_folder,
    { desc = "[lsp] [w]orkspace [a]dd folder" }
)
nmap("<leader>wr", function()
    vim.ui.select(vim.lsp.buf.list_workspace_folders(), {
        prompt = "choose workspace folder to remove: ",
    }, function(folder)
        if not folder then
            return
        end

        vim.lsp.buf.remove_workspace_folder(folder)
    end)
end, { desc = "[lsp] lsp [w]orkspace [r]emove folder" })
