--[[ embedded code lsp ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "jmbuhr/otter.nvim"
plugin.name = "otter"
plugin.lazy = false
plugin.opts = {}
plugin.config = function(_, opts)
	local otter = require("otter")
	otter.setup(opts)

	-- https://mise.jdx.dev/mise-cookbook/neovim.html#enable-lsp-for-embedded-lang-in-run-commands
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = { "toml" },
		group = vim.api.nvim_create_augroup("EmbedToml", {}),
		callback = function()
			otter.activate()
		end,
	})
end
plugin.keys = {
	{
		mode = "n",
		"<leader>oe",
		function() require("otter").activate() end,
		desc = "[plugin.otter] activate [O]tt[E]r for current buffer",
	},
}

return plugin
