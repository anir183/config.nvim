--[[
--
-- nvim/lua/config-183/utils/logging.lua
--
-- logging functions for ease of debugging
--
--]]

---@module "os"
---@module "table"
---@module "debug"
---@module "vim"
---@module "config-183.utils"
---@module "config-183.utils.functions"
---@module "config-183.utils.variables"

---@class LogLib
--- logging library used throughout the configuration
_G.LOG = {}

---@class LogOpts
--- options used in the logging library
_G.LOG.opts = {}
---@type vim.log.levels minimum level of log statements to notify
_G.LOG.opts.notify_level = vim.log.levels.WARN
---@type vim.log.levels minimum level of log statements to write to file
_G.LOG.opts.file_level = vim.log.levels.TRACE
---@type "notify" | "file" | "both" output stream of the log statements
_G.LOG.opts.out_stream = "both"
---@type "delete" | "rename" | "keep" what to do with the log file when opening neovim
_G.LOG.opts.file_action = "delete"
---@type string path where the log file should be stored
_G.LOG.opts.file_path = FUNCS.join_paths(VARS.path.state, "config-183.log")
---@param level vim.log.levels log level to get the label for
---@return string? label the label for the log level
_G.LOG.opts.label = function(level)
	local labels = {
		"trace",
		"debug",
		"info",
		"warn",
		"error",
		"off",
	}
	return labels[level + 1]
end
---@type boolean logs generated during vim config loading will be notified after config completion to prevent intereference with config
_G.LOG.opts.notify_after_vim_enter = true

---[[ dont interfere with vim loading with notifications ]]
local is_vim_entered = not LOG.opts.notify_after_vim_enter
---@type { msg: string, lvl: vim.log.levels }[]
local notify_backlog = {}
if LOG.opts.notify_after_vim_enter then
	vim.api.nvim_create_autocmd("VimEnter", {
		group = VARS.augrp.id,
		callback = function()
			for _, entry in ipairs(notify_backlog) do
				vim.notify(entry.msg, entry.lvl)
			end
			is_vim_entered = true
		end,
	})
end

---@param level vim.log.levels log level of the provided data or message
---@param ... any data or information to log
---@return nil
--- ---
--- log a statement to some outut stream and handle formatting (all based on options)
_G.LOG.print = function(level, ...)
	local timestamp = os.date("[%Y-%m-%d %H-%M-%S] ")
	local label = "[" .. LOG.opts.label(level) .. "] "

	local out = ""
	for index, item in ipairs({ ... }) do
		out = out .. (index == 1 and "" or "\n") .. vim.inspect(item)
	end

	--[[ handle neovim notifications ]]
	if level >= LOG.opts.notify_level then
		--[[ if out_stream is "file" indicates its neither "notify" nor "both" ]]
		if LOG.opts.out_stream == "file" then
			return
		end

		if is_vim_entered then
			vim.notify(timestamp .. label, level)
			vim.notify(out, level)
		else
			table.insert(
				notify_backlog,
				{ msg = timestamp .. label, lvl = level }
			)
			table.insert(notify_backlog, { msg = out, lvl = level })
		end
	end

	--[[ handle file logging ]]
	if level >= LOG.opts.file_level then
		--[[ if out_stream is "notify" indicates its neither "file" nor "both" ]]
		if LOG.opts.out_stream == "notify" then
			return
		end

		for _, chunk in ipairs(FUNCS.split_str(out, "\n")) do
			FUNCS.write_to_file(
				LOG.opts.file_path,
				timestamp .. label .. chunk .. "\n"
			)
		end
	end
end

---@param order integer? order of the function in the stack to trace
--- ---
--- print the file and line number where a function is called
_G.LOG.trace = function(order)
	order = order or 2
	local debug_info = debug.getinfo(order)

	LOG.print(
		vim.log.levels.TRACE,
		"line " .. debug_info.currentline .. " @ " .. debug_info.short_src
	)
end

---@param ... any debug data
--- ---
--- print some data or information for debugging
_G.LOG.debug = function(...)
	LOG.trace(3)
	LOG.print(vim.log.levels.DEBUG, ...)
end

---@param message string statement or event information
--- ---
--- print some kind of informational statement
_G.LOG.info = function(message)
	LOG.trace(3)
	LOG.print(vim.log.levels.INFO, message)
end

---@param message string warning message
--- ---
--- print a warning message
_G.LOG.warn = function(message)
	LOG.trace(3)
	LOG.print(vim.log.levels.WARN, message)
end

---@param message string error message
--- ---
--- print a error message
_G.LOG.error = function(message)
	LOG.trace(3)
	LOG.print(vim.log.levels.ERROR, message)
end

---@return nil
--- ---
--- perform file action on config execution
_G.LOG.perform_file_action = function()
	--[[ perform log file action ]]
	if LOG.opts.file_action ~= "keep" then
		if LOG.opts.out_stream == "notify" then
			goto skip
		end

		local success, err
		if LOG.opts.file_action == "delete" then
			success, err = os.remove(LOG.opts.file_path)
		elseif LOG.opts.file_action == "rename" then
			success, err = os.rename(
				LOG.opts.file_path,
				FUNCS.join_paths(
					VARS.path.state,
					"config-183-" .. os.date("%Y-%m-%d-%H-%M-%S") .. ".log"
				)
			)
		end

		if success then
			LOG.info("empty log file initiated")
		else
			LOG.warn("could not initiate empty log file")
			LOG.debug(err)
		end

		::skip::
	end
end

_G.LOG.perform_file_action()

_G.LOG.info("logging library loaded")

_G.LOG.info("global variables should already be loaded")
_G.LOG.debug(VARS)

_G.LOG.info("global functions should already be loaded")
_G.LOG.debug(FUNCS)
