--[[
--
-- nvim/lua/config-183/plugin/config/quality_of_life/comment.lua
--
-- auto comment toggling
--
--]]

---@module "vim"
---@module "lazy"
---@module "Comment"

---@type LazySpec
local plugin = {}

plugin[1] = "numToStr/Comment.nvim"
plugin.name = "comment"
plugin.main = "Comment"
plugin.lazy = false
---@type CommentConfig
---@diagnostic disable-next-line: missing-fields
plugin.opts = {
	mappings = {
		basic = false,
		extra = false,
	},
}
plugin.keys = {
	-- comment leaders
	{
		mode = "n",
		"<C-c>",
		"<PLUG>(comment_toggle_linewise)",
		desc = "[plugin/comment]: linewise commenting leader",
	},
	{
		mode = "n",
		"<C-x>",
		"<PLUG>(comment_toggle_blockwise)",
		desc = "[plugin/comment]: blockwise commenting leader",
	},

	-- single line or count comment
	{
		mode = "n",
		"<C-c><C-c>",
		function()
			if vim.api.nvim_get_vvar("count") == 0 then
				return "<PLUG>(comment_toggle_linewise_current)"
			else
				return "<PLUG>(comment_toggle_linewise_count)"
			end
		end,
		expr = true,
		desc = "[plugin/comment]: comment current line",
	},
	{
		mode = "n",
		"<C-x><C-x>",
		function()
			if vim.api.nvim_get_vvar("count") == 0 then
				return "<PLUG>(comment_toggle_blockwise_current)"
			else
				return "<PLUG>(comment_toggle_blockwise_count)"
			end
		end,
		expr = true,
		desc = "[plugin/comment]: block-comment current line",
	},

	-- visual mode comment
	{
		mode = "x",
		"<C-c><C-c>",
		-- NOTE: "<PLUG>(comment_toggle_linewise_visual)" did not work
		--       https://github.com/numToStr/Comment.nvim/blob/e30b7f2008e52442154b66f7c519bfd2f1e32acb/plugin/Comment.lua#L134
		"<ESC><CMD>lua require(\"Comment.api\").locked(\"toggle.linewise\")(vim.fn.visualmode())<CR>gv",
		desc = "[plugin/comment]: comment current selection",
	},
	{
		mode = "x",
		"<C-x><C-x>",
		-- NOTE: "<PLUG>(comment_toggle_blockwise_visual)" did not work
		--       https://github.com/numToStr/Comment.nvim/blob/e30b7f2008e52442154b66f7c519bfd2f1e32acb/plugin/Comment.lua#L140
		"<ESC><CMD>lua require(\"Comment.api\").locked(\"toggle.blockwise\")(vim.fn.visualmode())<CR>gv",
		desc = "[plugin/comment]: block-comment current selection",
	},
}

return plugin
