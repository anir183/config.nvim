--[[ map lsp functionality that is already built-in to neovim ]]

---@module "183.core.types"

---@type table<string, 183.core.types.LspKeymap>
local M = {}

-- editing
M["[R]e[N]ame symbol"] = {
	lhs = "<leader>rn",
	rhs = vim.lsp.buf.rename,
}

-- documentation
M["hover documentation"] = {
	lhs = "K",
	rhs = vim.lsp.buf.hover,
}
M["signature help"] = {
	mode = { "n", "i", "s" },
	lhs = "<C-S-s>",
	rhs = vim.lsp.buf.signature_help,
}

-- navigation
M["[G]oto [D]efinition"] = {
	lhs = "gd",
	rhs = vim.lsp.buf.definition,
}
M["[G]oto [D]eclaration"] = {
	lhs = "gD",
	rhs = vim.lsp.buf.declaration,
}
M["[G]oto [I]mplementation"] = {
	lhs = "gi",
	rhs = vim.lsp.buf.implementation,
}
M["[G]oto [R]eferences"] = {
	lhs = "gr",
	rhs = vim.lsp.buf.references,
}
M["[G]oto [T]ype Definition"] = {
	lhs = "gt",
	rhs = vim.lsp.buf.type_definition,
}

-- code actions
M["code [A][C]tions"] = {
	mode = { "n", "v" },
	lhs = "<leader>ac",
	rhs = vim.lsp.buf.code_action,
}

-- formatting
-- TODO : idk why but the format keymap set in plugin/conform is not able to
--        remap this one...
--        hence using capital FM
M["[F]or[M]at file"] = {
	mode = { "n", "v" },
	lhs = "<leader>FM",
	rhs = function()
		vim.lsp.buf.format({ async = true })
	end,
}

-- lists and symbols
M["[I]ncoming [C]alls"] = {
	lhs = "<leader>ic",
	rhs = vim.lsp.buf.incoming_calls,
}
M["[O]outgoing [C]alls"] = {
	lhs = "<leader>oc",
	rhs = vim.lsp.buf.outgoing_calls,
}
M["document [S][Y]mbols"] = {
	lhs = "<leader>sy",
	rhs = vim.lsp.buf.document_symbol,
}
M["[S]ub [T]ypes"] = {
	lhs = "<leader>st",
	rhs = function()
		vim.lsp.buf.typehierarchy("subtypes")
	end,
}
M["[S]uper [T]ypes"] = {
	lhs = "<leader>ST",
	rhs = function()
		vim.lsp.buf.typehierarchy("supertypes")
	end,
}
M["[W]orkspace [S]ymbols"] = {
	lhs = "<leader>ws",
	rhs = vim.lsp.buf.workspace_symbol,
}
M["[W]orkspace [S]ymbols with query"] = {
	lhs = "<leader>WS",
	rhs = function()
		vim.ui.input({
			prompt = "workspace symbols filter query: ",
		}, function(query)
			if not query then
				return
			end

			vim.lsp.buf.workspace_symbol(query)
		end)
	end,
}

-- diagnostics
M["previous diagnostic"] = {
	lhs = "[d",
	rhs = function()
		vim.diagnostic.jump({ count = -1 })
	end,
}
M["next diagnostic"] = {
	lhs = "]d",
	rhs = function()
		vim.diagnostic.jump({ count = 1 })
	end,
}
M["load [W]orkspace [D]iagnostics"] = {
	lhs = "<leader>wd",
	rhs = vim.lsp.buf.workspace_diagnostics,
}
M["[L]ist buffer [D]iagnostics in loclist"] = {
	lhs = "<leader>ld",
	rhs = vim.diagnostic.setloclist,
}
M["[L]ist all [D]iagnostics in qflist"] = {
	lhs = "<leader>LD",
	rhs = vim.diagnostic.setqflist,
}

-- workspace folders
M["lsp [W]orkspace [A]dd folder"] = {
	lhs = "<leader>wa",
	rhs = vim.lsp.buf.add_workspace_folder,
}
M["lsp [W]orkspace [R]emove folder"] = {
	lhs = "<leader>wr",
	rhs = function()
		vim.ui.select(vim.lsp.buf.list_workspace_folders(), {
			prompt = "choose workspace folder to remove: ",
		}, function(folder)
			if not folder then
				return
			end

			vim.lsp.buf.remove_workspace_folder(folder)
		end)
	end,
}

return M
