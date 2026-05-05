--[[ highlighting for special comment tags ]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "folke/todo-comments.nvim"
plugin.name = "todo-comments"
plugin.dependencies = "plenary"
plugin.lazy = false
plugin.opts = {}
plugin.config = function(_, opts)
	require("todo-comments").setup(opts)
	vim.defer_fn(function()
		local local_find = {
			ALL = function()
				require("todo-comments.search").setloclist({
					cwd = vim.fn.expand("%"),
				})
			end,
		}
		local global_find = {
			ALL = function()
				require("todo-comments.search").setqflist()
			end,
		}

		for keyword, _ in
			pairs(require("todo-comments.config").options.keywords)
		do
			local_find[keyword] = function()
				require("todo-comments.search").setloclist({
					keywords = keyword,
					cwd = vim.fn.expand("%"),
				})
			end
			global_find[keyword] = function()
				require("todo-comments.search").setqflist({ keywords = keyword })
			end
		end

		_G.FUNCS.mmap("<leader>td", local_find, {
			desc = "[plugin.todo-comments] list [T]o[D]o comments",
		})
		_G.FUNCS.mmap("<leader>TD", global_find, {
			desc = "[plugin.todo-comments] list [T]o[D]o comments",
		})
	end, 10)
end
plugin.keys = {
	{
		mode = "n",
		"]t",
		function()
			require("todo-comments").jump_next()
		end,
		desc = "[plugin.todo-comments] jump to next todo comment",
	},
	{
		mode = "n",
		"[t",
		function()
			require("todo-comments").jump_prev()
		end,
		desc = "[plugin.todo-comments] jump to previous todo comment",
	},
}

return plugin
