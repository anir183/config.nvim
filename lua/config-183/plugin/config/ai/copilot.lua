--[[
--
-- nvim/lua/config-183/plugin/config/ai/copilot.lua
--
-- copilot integration
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "zbirenbaum/copilot.lua"
plugin.name = "copilot"
plugin.dependencies = "copilot-lsp"
plugin.cond = OPTS.ai.copilot ~= "off"
plugin.lazy = false
plugin.opts = {
	suggestion = {
		enabled = OPTS.ai.copilot == "vtext",
		auto_trigger = OPTS.ai.copilot == "vtext",
		keymap = {
			accept = "<M-l>",
			accept_line = "<M-k>",
			accept_word = "<M-j>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
			toggle_auto_trigger = false,
		},
	},
	panel = {
		enabled = true,
		layout = {
			position = "right",
			ratio = 0.4,
		},
	},
	filetypes = {
		bash = false,
		[""] = false,
		oil = false,
	},
}
plugin.config = function(_, opts)
	require("copilot").setup(opts)

	FUNCS.mmap("n", "<leader>co", {
		["panel-accept"] = "Copilot panel accept",
		["panel-jump-next"] = "Copilot panel jump_next",
		["panel-jump-prev"] = "Copilot panel jump_prev",
		["panel-open"] = "Copilot panel open",
		["panel-close"] = "Copilot panel close",
		["panel-toggle"] = "Copilot panel toggle",
		["panel-refresh"] = "Copilot panel refresh",
	}, "[plugin/copilot]: copilot action menu")
end
plugin.keys = {
	{
		mode = "n",
		"<leader>co",
		"<CMD>Copilot toggle<CR>",
		desc = "[plugin/copilot]: toggle [C][O]pilot",
	},
	{
		mode = "n",
		"<leader>cn",
		"<CMD>Copilot panel toggle<CR>",
		desc = "[plugin/copilot]: toggle [C]opilot pa[N]el",
	},
	{
		mode = "n",
		"<leader>CN",
		"<CMD>Copilot panel refresh<CR>",
		desc = "[plugin/copilot]: refresh [C]opilot pa[N]el",
	},
	{
		mode = "n",
		"<leader>CN",
		"<CMD>Copilot panel refresh<CR>",
		desc = "[plugin/copilot]: refresh [C]opilot pa[N]el",
	},
	{
		mode = "n",
		"<leader>ce",
		"<CMD>Copilot panel accept<CR>",
		desc = "[plugin/copilot]: [C]opilot panel [E]xecute",
	},
	{
		mode = "n",
		"]p",
		"<CMD>Copilot panel jump_next<CR>",
		desc = "[plugin/copilot]: goto next copilot [P]anel listing",
	},
	{
		mode = "n",
		"[p",
		"<CMD>Copilot panel jump_prev<CR>",
		desc = "[plugin/copilot]: goto prev copilot [P]anel listing",
	},
}

return plugin
