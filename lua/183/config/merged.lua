--[[ merge and consolidate config options into one table ]]

---@type 183.config.types.ConfigSpec
local M = nil

-- start with defaults
M = require("183.config.defaults")

-- try to merge customs
if
	pcall(require, "183.config.custom")
	and type(require("183.config.custom")) == "table"
then
	M = vim.tbl_deep_extend("force", M, require("183.config.custom"))
end

-- try to merge some env vars
local env = vim.env

if _G.CONSTS.env_keys and env[_G.CONSTS.env_keys.mode] then
	M.mode = env[_G.CONSTS.env_keys.mode]
end

M.shell = M.shell or vim.env["SHELL"]
if _G.CONSTS.env_keys and env[_G.CONSTS.env_keys.shell] then
	M.shell = env[_G.CONSTS.env_keys.shell]
end

-- try to merge vim globals
if vim.g and vim.g.MODE_183 then
	M.mode = vim.g.MODE_183
end

if vim.g and vim.g.SHELL_183 then
	M.mode = vim.g.SHELL_183
end

return M
