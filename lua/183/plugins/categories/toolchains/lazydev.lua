--[[ setup lua_ls for neovim configurations ]]

---@module "lazy"
---@module "lazydev"

---@type LazySpec[]
local plugin = { {}, {} }

plugin[1][1] = "folke/lazydev.nvim"
plugin[1].name = "lazydev"
---@module "lazydev"
---@type lazydev.Config
plugin[1].opts = {
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ "nvim-dap-ui" },
	},
	integrations = {
		blink = true,
	},
}
plugin[1].config = function(_, opts)
	require("lazydev").setup(opts)
	vim.lsp.enable("lua_ls")
end

-- add blink.cmp source
plugin[2][1] = "saghen/blink.cmp"
plugin[2].opts = {
	sources = {
		per_filetype = {
			lua = { inherit_defaults = true, "lazydev" },
		},
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
		},
	},
}

return plugin
