--[[ file formatting engine ]]

---@module "lazy"
---@module "conform"

---@type LazySpec
local plugin = {}

plugin[1] = "stevearc/conform.nvim"
plugin.name = "conform"
plugin.lazy = false
---@type conform.setupOpts
plugin.opts = {
	formatters_by_ft = _G.CONF.dev_tools.ft_formatters,
	formatters = _G.CONF.dev_tools.custom_formatters,
}
plugin.keys = {
	-- TODO: idk why but the format keymap set in core/lsp_keymaps does not
	--        get remapped by this one...
	--        figure it out
	{
		mode = { "n", "v" },
		"<leader>fm",
		function()
			local curr_file = vim.fn.expand("%:p")

			-- try to format the file
			require("conform").format({
				async = true,
			}, function(err)
				if not err then
					vim.print("formatted " .. curr_file)
				else
					vim.print(err)
				end
			end)
		end,
		desc = "[plugin.conform] [F]or[M]at file or selections",
	},
}

return plugin
