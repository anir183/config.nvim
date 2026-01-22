--[[
--
-- nvim/lua/config-183/plugin/config/quality_of_life/lsp_saga.lua
--
-- utilites and visual upgrades for lsp actions
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "nvimdev/lspsaga.nvim"
plugin.name = "lspsaga"
plugin.dependencies = { "treesitter", "devicons" }
plugin.opts = {}
plugin.config = function(_, opts)
	require("lspsaga").setup(opts)

	FUNCS.nmap("<leader>TT", "<CMD>Lspsaga term_toggle<CR>", "[plugin/lspsaga]: [T]oggle floating [T]erminal")
	FUNCS.set_lsp_keymaps = function()
		LOG.info("setting lspsaga keymaps current lsp-attached buffer")

		FUNCS.nmap("<leader>rn", "<CMD>Lspsaga rename<CR>", "[plugin/lspsaga]: [R]e[N]ame symbol", { buffer = 0 })
		FUNCS.nmap("<leader>RN", "<CMD>Lspsaga project_replace<CR>", "[plugin/lspsaga]: project wide [R]eplace", { buffer = 0 })
		FUNCS.nmap("<leader>ic", "<CMD>Lspsaga incoming_calls<CR>", "[plugin/lspsaga]: [I]ncoming [C]alls", { buffer = 0 })
		FUNCS.nmap("<leader>oc", "<CMD>Lspsaga outgoing_calls<CR>", "[plugin/lspsaga]: [O]outgoing [C]alls", { buffer = 0 })
		FUNCS.nmap("<leader>ds", "<CMD>Lspsaga outline<CR>", "[plugin/lspsaga]: [D]ocument [S]ymbol", { buffer = 0 })
		FUNCS.nmap("<leader>ol", "<CMD>Lspsaga outline<CR>", "[plugin/lspsaga]: [O]ut[L]ine", { buffer = 0 })
		FUNCS.map({ "n", "x" }, "<leader>ca", "<CMD>Lspsaga code_action<CR>", "[plugin/lspsaga]: open [C]ode [A]ctions", { buffer = 0 })
		FUNCS.nmap("gD", vim.lsp.buf.declaration, "[base/lsp]: [G]oto [D]eclaration", { buffer = 0 })
		FUNCS.nmap("gd", "<CMD>Lspsaga goto_definition<CR>", "[plugin/lspsaga]: [G]oto [D]efinition", { buffer = 0 })
		FUNCS.nmap("gT", "<CMD>Lspsaga goto_type_definition<CR>", "[plugin/lspsaga]: [G]oto [T]ype definition", { buffer = 0 })
		FUNCS.nmap("<leader>gd", "<CMD>Lspsaga peek_definition<CR>", "[plugin/lspsaga]: [G]oto [D]efinition", { buffer = 0 })
		FUNCS.nmap("<leader>gT", "<CMD>Lspsaga peek_type_definition<CR>", "[plugin/lspsaga]: [G]oto [T]ype definition", { buffer = 0 })
		FUNCS.nmap("gr", "<CMD>Lspsaga finder ref<CR>", "[plugin/lspsaga]: [G]et [R]eferences", { buffer = 0 })
		FUNCS.nmap("gi", "<CMD>Lspsaga finder imp<CR>", "[plugin/lspsaga]: [G]et [I]mplementation", { buffer = 0 })
		FUNCS.nmap("gF", "<CMD>Lspsaga finder<CR>", "[plugin/lspsaga]: [F]inder", { buffer = 0 })
		FUNCS.nmap("]d", "<CMD>Lspsaga diagnostic_jump_next<CR>", "[plugin/lspsaga]: next [D]iagnostic", { buffer = 0 })
		FUNCS.nmap("[d", "<CMD>Lspsaga diagnostic_jump_prev<CR>", "[plugin/lspsaga]: prev [D]iagnostic", { buffer = 0 })
		FUNCS.nmap("K", "<CMD>Lspsaga hover_doc<CR>", "[plugin/lspsaga]: hover doc", { buffer = 0 })
		FUNCS.nmap("<leader>K", "<CMD>Lspsaga hover_doc ++keep<CR>", "[plugin/lspsaga]: persistent hover doc", { buffer = 0 })
		FUNCS.nmap("<C-s>", vim.lsp.buf.signature_help, "[base]: toggle lsp signature window", { buffer = 0 })

		LOG.info("lspsaga keymaps setup and loaded")
	end
end

return plugin
