--[[ debug adapter for python ]]

---@module "lazy"

---@type LazySpec[]
local plugin = { {}, {} }

plugin[1][1] = "mfussenegger/nvim-dap-python"
plugin[1].name = "python-dap"
plugin[1].config = function()
	require("dap-python").setup("uv")
end

-- make sure mason-nvim-dap doesnt interfere
plugin[2][1] = "jay-babu/mason-nvim-dap.nvim"
plugin[2].opts = {
	handlers = {
		python = function()
			--[[ empty config as handled by nvim-dap-python ]]
		end,
	},
}

return plugin
