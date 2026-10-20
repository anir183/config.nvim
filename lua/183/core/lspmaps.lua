local map = FUNCS.map
local nmap = function(...)
    map("n", ...)
end
local del = vim.keymap.del

-- editing
nmap(
    "<leader>rn",
    vim.lsp.buf.rename,
    { desc = "[lsp] [r]e[n]ame symbol" }
)

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
nmap(
    "gd",
    vim.lsp.buf.definition,
    { desc = "[lsp] [g]oto [d]efinition" }
)
nmap(
    "gD",
    vim.lsp.buf.declaration,
    { desc = "[lsp] [g]oto [D]eclaration" }
)
nmap(
    "gr",
    vim.lsp.buf.references,
    { desc = "[lsp] [g]oto [r]eferences" }
)
nmap(
    "gi",
    vim.lsp.buf.implementation,
    { desc = "[lsp] [g]oto [i]mplementation" }
)
nmap(
    "gy",
    vim.lsp.buf.type_definition,
    { desc = "[lsp] t[y]pe definition" }
)
nmap(
    "gai",
    vim.lsp.buf.incoming_calls,
    { desc = "[lsp] [i]ncoming calls" }
)
nmap(
    "gao",
    vim.lsp.buf.outgoing_calls,
    { desc = "[lsp] [o]utgoing calls" }
)

-- code actions
map(
    { "n", "v" },
    "<leader>a",
    vim.lsp.buf.code_action,
    { desc = "[lsp] code [a]ctions" }
)

-- formatting
map({ "n", "v" }, "<leader>fm", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "[lsp] [f]or[m]at file" })

-- diagnostics
del("n", "[d")
nmap("[d", function()
    vim.diagnostic.jump({ count = -1 })
end, { desc = "[lsp] previous [d]iagnostic" })
del("n", "]d")
nmap("]d", function()
    vim.diagnostic.jump({ count = 1 })
end, { desc = "[lsp] next [d]iagnostic" })
nmap(
    "<leader>BD",
    vim.diagnostic.setloclist,
    { desc = "[lsp] list [B]uffer [D]iagnostics in loclist" }
)
nmap(
    "<leader>WD",
    vim.diagnostic.setqflist,
    { desc = "[lsp] list [W]orkspace [D]iagnostics in qflist" }
)
