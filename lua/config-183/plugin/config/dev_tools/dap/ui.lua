--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/dap/ui.lua
--
-- ui window for dap
--
--]]

---@module "vim"
---@module "vim.ui"
---@module "lazy"
---@module "dapui"

---@type LazySpec
local plugin = {}

plugin[1] = "rcarriga/nvim-dap-ui"
plugin.name = "dap-ui"
plugin.dependencies = {
	"dap",
	"nio",
	"dap-virtual-text",
}
plugin.lazy = false
---@type dapui.Config
---@diagnostic disable-next-line: missing-fields
plugin.opts = {}
plugin.config = function(_, opts)
	local dap = require("dap")
	local dapui = require("dapui")

	dapui.setup(opts)

	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end
end
plugin.keys = {
	{
		mode = "n",
		"<leader>tu",
		function()
			require("dapui").toggle()
		end,
		desc = "[plugin/dapui]: [T]oggle dap [U]i",
	},
	{
		mode = "n",
		"<leader>ru",
		function()
			require("dapui").open({ reset = true })
		end,
		desc = "[plugin/dapui]: [R]oggle dap ui",
	},
	{
		mode = "n",
		"<leader>va",
		"<CMD>lua require(\"dapui\").eval()<CR>",
		desc = "[plugin/dapui]: dapui e[V][A]l expression under cursor",
	},
	{
		mode = "n",
		"<leader>VA",
		function()
			vim.ui.input({
				prompt = "expression: ",
			}, function(expression)
				if not expression then
					return
				end

				require("dapui").eval(expression)
			end)
		end,
		desc = "[plugin/dapui]: dapui e[V][A]l expression under cursor",
	},
	{
		mode = "v",
		"<leader>va",
		"<CMD>lua require(\"dapui\").eval()<CR>",
		desc = "[plugin/dapui]: [D]apui e[V]al selected expression",
	},
	{
		mode = "n",
		"<leader>fe",
		function()
			---@diagnostic disable-next-line: missing-parameter
			require("dapui").float_element()
		end,
		desc = "[plugin/dapui]: [D]apui e[V]al selected expression",
	},
}

return plugin
