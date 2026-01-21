--[[
--
-- nvim/lua/config-183/plugin/config/quality_of_life/lazy_git.lua
--
-- lazygit intergration inside of neovim
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "kdheepak/lazygit.nvim"
plugin.name = "lazygit"
plugin.dependencies = "plenary"
plugin.lazy = false
plugin.init = function()
	vim.g.lazygit_floating_window_scaling_factor = 0.95 -- scaling factor for floating window
end
plugin.config = function()
	FUNCS.mmap(
		"n",
		"<leader>la",
		{
			["config"] = function()
				vim.cmd("LazyGitConfig")
			end,
			["open-file-root"] = function()
				vim.cmd("LazyGitCurrentFile")
			end,
			["project-commits"] = function()
				vim.cmd("LazyGitFilter")
			end,
			["buffer-commits"] = function()
				vim.cmd("LazyGitFilterCurrentFile")
			end,
			["log"] = function()
				vim.cmd("LazyGitLog")
			end,
		},
		"[plugin/lazygit]: open [L]azy git [A]ctions menu"
	)
end
plugin.keys = {
	{
		mode = "n",
		"<leader>lg",
		"<CMD>LazyGit<CR>",
		desc = "[plugin/lazygit]: open [L]azy [G]it",
	},
}

return plugin
