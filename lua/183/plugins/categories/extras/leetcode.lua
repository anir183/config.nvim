--[[ leetcode in neovim... hell yeah ]]

---@module "lazy"
---@module "leetcode"

---@type LazySpec
local plugin = {}

plugin[1] = "kawre/leetcode.nvim"
plugin.name = "leetcode"
plugin.dependencies = { "plenary", "nui" }
plugin.lazy = false
---@type lc.UserConfig
plugin.opts = {
	lang = "c",
	picker = "snacks-picker",
	storage = {
		home = _G.CONF.leetcode_path,
	},
}
plugin.config = function(_, opts)
	require("leetcode").setup(opts)

	_G.FUNCS.mmap("<leader>la", {
		["exit"] = function()
			vim.cmd("Leet exit")
		end,
		["console"] = function()
			vim.cmd("Leet console")
		end,
		["info"] = function()
			vim.cmd("Leet info")
		end,
		["tabs"] = function()
			vim.cmd("Leet tabs")
		end,
		["yank"] = function()
			vim.cmd("Leet yank")
		end,
		["lang"] = function()
			vim.cmd("Leet lang")
		end,
		["run"] = function()
			vim.cmd("Leet run")
		end,
		["test"] = function()
			vim.cmd("Leet test")
		end,
		["submit"] = function()
			vim.cmd("Leet submit")
		end,
		["random"] = function()
			vim.cmd("Leet random")
		end,
		["random-opts"] = function()
			vim.ui.input({
				prompt = "status=<status> difficulty=<difficulty> tags=<tags>: ",
			}, function(args)
				if not args or args == "" then
					return
				end

				vim.cmd("Leet random " .. args)
			end)
		end,
		["daily"] = function()
			vim.cmd("Leet daily")
		end,
		["list"] = function()
			vim.cmd("Leet list")
		end,
		["open"] = function()
			vim.cmd("Leet open")
		end,
		["restore"] = function()
			vim.cmd("Leet restore")
		end,
		["last-submit"] = function()
			vim.cmd("Leet last_submit")
		end,
		["reset"] = function()
			vim.cmd("Leet reset")
		end,
		["inject"] = function()
			vim.cmd("Leet inject")
		end,
		["fold"] = function()
			vim.cmd("Leet fold")
		end,
		["description"] = function()
			vim.cmd("Leet desc")
		end,
		["desc-stats"] = function()
			vim.cmd("Leet desc stats")
		end,
		["cookie-update"] = function()
			vim.cmd("Leet cookie update")
		end,
		["cookie-delete"] = function()
			vim.cmd("Leet cookie delete")
		end,
		["update"] = function()
			vim.cmd("Leet cache update")
		end,
	}, { desc = "[plugin.leetcode] leet code actions" })
end
plugin.keys = {
	{
		mode = "n",
		"<leader>lc",
		vim.cmd.Leet,
		desc = "[plugin.leetcode] open [L]eet[C]ode ui",
	},
}

return plugin
