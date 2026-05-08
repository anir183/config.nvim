--[[ github copilot auto complete ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "zbirenbaum/copilot.lua"
plugin.name = "copilot"
plugin.lazy = false
plugin.opts = {
	suggestion = {
		enabled = true,
		auto_trigger = false,
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
		auto_refresh = true,
		layout = {
			position = "right",
			ratio = 0.4,
		},
	},
	nes = {
		enabled = false,
	},
	filetypes = {
		bash = false,
		[""] = false,
		oil = false,
	},
}
plugin.config = function(_, opts)
	require("copilot").setup(opts)

	_G.FUNCS.mmap("<leader>oa", {
		["panel-accept"] = "copilot panel accept",
		["panel-jump-next"] = "copilot panel jump_next",
		["panel-jump-prev"] = "copilot panel jump_prev",
		["panel-open"] = "copilot panel open",
		["panel-close"] = "copilot panel close",
		["panel-toggle"] = "copilot panel toggle",
		["panel-refresh"] = "copilot panel refresh",
	}, {
		desc = "[plugin.copilot] c[O]pilot [A]ction menu",
	})
end
plugin.keys = {
	{
		mode = "n",
		"<leader>ot",
		"<CMD>Copilot toggle<CR>",
		desc = "[plugin.copilot] c[O]pilot [T]oggle",
	},
	{
		mode = "n",
		"<leader>og",
		"<CMD>Copilot suggestion toggle_auto_trigger<CR>",
		desc = "[plugin.copilot] c[O]pilot toggle auto tri[G]ger",
	},
	{
		mode = "n",
		"<leader>OT",
		"<CMD>Copilot panel toggle<CR>",
		desc = "[plugin.copilot] c[O]pilot panel [T]oggle",
	},
	{
		mode = "n",
		"<leader>or",
		"<CMD>Copilot panel refresh<CR>",
		desc = "[plugin.copilot] c[O]pilot panel [R]efresh",
	},
	{
		mode = "n",
		"<leader>oe",
		"<CMD>Copilot panel accept<CR>",
		desc = "[plugin.copilot] c[O]pilot panel [E]xecute",
	},
	{
		mode = "n",
		"]p",
		"<CMD>Copilot panel jump_next<CR>",
		desc = "[plugin.copilot] goto next copilot [P]anel listing",
	},
	{
		mode = "n",
		"[p",
		"<CMD>Copilot panel jump_prev<CR>",
		desc = "[plugin.copilot] goto prev copilot [P]anel listing",
	},
}

return plugin
