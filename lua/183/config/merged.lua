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

	if env[_G.CONSTS.env_keys.logging_opts.logs_dir_parent] then
		M.logging_opts.logs_dir_parent =
			env[_G.CONSTS.env_keys.logging_opts.logs_dir_parent]
		M.config_state = state
	end

	if env[_G.CONSTS.env_keys.logging_opts.output.notify] then
		M.logging_opts.output.notify =
			env[_G.CONSTS.env_keys.logging_opts.output.notify]
		M.config_state = state
	end

	if env[_G.CONSTS.env_keys.logging_opts.output.print] then
		M.logging_opts.output.print =
			env[_G.CONSTS.env_keys.logging_opts.output.print]
		M.config_state = state
	end

	if env[_G.CONSTS.env_keys.logging_opts.output.vim_print] then
		M.logging_opts.output.vim_print =
			env[_G.CONSTS.env_keys.logging_opts.output.vim_print]
		M.config_state = state
	end

	if env[_G.CONSTS.env_keys.logging_opts.output.file] then
		M.logging_opts.output.file =
			env[_G.CONSTS.env_keys.logging_opts.output.file]
		M.config_state = state
	end
end

return M
