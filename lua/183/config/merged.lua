--[[ merge and consolidate config options into one table ]]

---@type 183.config.types.ConfigSpec
local M = nil

-- start with defaults
M = require("183.config.defaults")
M.config_state = "default"

-- try to merge customs
if
	pcall(require, "183.config.custom")
	and type(require("183.config.custom")) == "table"
then
	M = vim.tbl_deep_extend("force", M, require("183.config.custom"))
	M.config_state = "default+custom"
end

-- try to merge some env vars
if _G.CONSTS.env_keys then
	local env = vim.env
	local state = M.config_state == "default" and "default+env"
		or "default+custom+env"

	if env[_G.CONSTS.env_keys.mode] then
		M.mode = env[_G.CONSTS.env_keys.mode]
		M.config_state = state
	end

	M.shell = M.shell or vim.env["SHELL"]
	if env[_G.CONSTS.env_keys.shell] then
		M.shell = env[_G.CONSTS.env_keys.shell]
		M.config_state = state
	end
end

return M
