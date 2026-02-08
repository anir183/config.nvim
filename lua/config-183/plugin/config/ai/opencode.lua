--[[
--
-- nvim/lua/config-183/plugin/config/ai/opencode.lua
--
-- opencode integration in neovim
--
--]]

---@module "lazy"

---@type LazySpec
local plugin = {}

plugin[1] = "nickjvandyke/opencode.nvim"
plugin.name = "opencode"
plugin.cond = OPTS.ai.opencode
plugin.dependencies = "snacks"
plugin.lazy = false
plugin.config = function()
	-- Required for `opts.events.reload`.
	vim.o.autoread = true
end
plugin.keys = {
	{
		mode = { "n", "x" },
		"<M-f>",
		function()
			require("opencode").ask("@this: ", { submit = true })
		end,
		desc = "[plugin/opencode]: ask opencode",
	},
	{
		mode = { "n", "x" },
		"<S-M-f>",
		function()
			require("opencode").select()
		end,
		desc = "[plugin/opencode]: execute opencode action",
	},
	{
		mode = { "n", "t" },
		"<leader>od",
		function()
			require("opencode").toggle()
		end,
		desc = "[plugin/opencode]: toggle [O]penco[D]e",
	},
	{
		mode = { "n", "x" },
		"go",
		function()
			return require("opencode").operator("@this ")
		end,
		desc = "[plugin/opencode]: add range to [O]pencode",
		expr = true,
	},
	{
		mode = "n",
		"goo",
		function()
			return require("opencode").operator("@this ") .. "_"
		end,
		desc = "[plugin/opencode]: add line to [O]pencode",
		expr = true,
	},
	{
		mode = "n",
		"<S-C-u>",
		function()
			require("opencode").command("session.half.page.up")
		end,
		desc = "[plugin/opencode]: scroll opencode [U]p",
	},
	{
		mode = "n",
		"<S-C-d>",
		function()
			require("opencode").command("session.half.page.down")
		end,
		desc = "[plugin/opencode]: scroll opencode [D]own",
	},
}

return plugin
