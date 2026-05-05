--[[ editor colors and highlighting ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "navarasu/onedark.nvim"
plugin.name = "onedark"
plugin.priority = _G.CONSTS.lazy.priorities.highest
plugin.opts = {
	style = "dark",
	transparent = true,
	ending_tildes = true,
	highlights = {
		-- custom orange
		IncSearch = { bg = "#EDA792", fg = "#11111b", bold = true },

		-- make statusline transparent
		StatusLine = { bg = "none" },
		StatusLineNC = { bg = "none" },
		StatusLineTerm = { bg = "none" },
		StatusLineTermNC = { bg = "none" },

		-- make completion menu transparent
		Pmenu = { bg = "none" },
		PmenuSbar = { bg = "none" },
		PmenuThumb = { bg = "none" },

		-- make floating windows transparent
		NormalFloat = { bg = "none" },
		FloatBorder = { bg = "none" },

		-- but keep background for some
		LazyNormal = { fg = "$fg", bg = "$bg1" },
		MasonNormal = { fg = "$fg", bg = "$bg1" },
		TreesitterContext = { fg = "$fg", bg = "$bg1" },
	},
}
plugin.config = function(_, opts)
	require("onedark").setup(opts)
	require("onedark").load()
end

return plugin
