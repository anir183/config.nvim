--[[ improved ui and workflow for quickfix ]]

---@module "lazy"
---@module "bqf"

---@type LazySpec
local plugin = {}

plugin[1] = "kevinhwang91/nvim-bqf"
plugin.name = "bqf"
plugin.lazy = false
plugin.dependencies = "fzf"
---@type BqfConfig
plugin.opts = {
	---@diagnostic disable-next-line: missing-fields
	preview = {
		auto_preview = false,
		winblend = 0,
	},
}

return plugin
