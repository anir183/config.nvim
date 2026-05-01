--[[ write and live-display logs ]]

---@module "183.utils.types"

---@type 183.utils.types.Logging
local M = {}

M.runtime_vars = {}

-- log file and file operations related variables
M.runtime_vars.log_file = nil
M.runtime_vars.log_file_path = nil
M.runtime_vars.log_file_ready = false
M.runtime_vars.failed_write_tries = 0

-- printing logs while vim config is running can interrupt configuration flow
-- store logs and display them all at once when vim config is loaded
M.runtime_vars.display_ready = not _G.CONF.logging_opts.display_after_ready
M.runtime_vars.display_backlog = {}

function M.setup_log_file()
	if _G.CONF.logging_opts.output.file == vim.log.levels.OFF then
		M.runtime_vars.log_file_ready = false
		return
	end

	-- close file before exiting vim
	vim.api.nvim_create_autocmd("VimLeave", {
		group = _G.CONSTS.augrp.id,
		callback = function()
			if M.runtime_vars.log_file then
				M.runtime_vars.log_file:close()
			end
		end,
	})

	local log_files_dir = _G.CONF.logging_opts.logs_dir_parent
		.. _G.CONSTS.path.separator
		.. _G.CONSTS.log.dir_name

	-- check and create directory
	-- "p" flag also created intermediate directories
	if vim.fn.isdirectory(log_files_dir) == 0 then
		if vim.fn.mkdir(log_files_dir, "p") == 0 then
			-- failed to create directory
			_G.LOG.warn("could not create log directory")
			_G.LOG.debug({ log_files_dir = log_files_dir })
			M.runtime_vars.log_file_ready = false
			return
		end
	end

	-- create file
	local err = nil
	M.runtime_vars.log_file_path = log_files_dir
		.. _G.CONSTS.path.separator
		.. os.date("%Y-%m-%d-%H-%M-%S")
		.. ".log"
	M.runtime_vars.log_file, err = io.open(M.runtime_vars.log_file_path, "a+")

	-- file creation or opening failed
	if err or not M.runtime_vars.log_file then
		_G.LOG.warn("could open log file for writing")
		_G.LOG.debug({ log_file_open_err = err })
		M.runtime_vars.log_file_ready = false
		return
	end

	LOG.info("log file created for session")
	M.runtime_vars.log_file_ready = true
end

function M.print(reqd_level, data)
	if not M.runtime_vars.display_ready then
		table.insert(
			M.runtime_vars.display_backlog,
			{ reqd_level = reqd_level, data = data }
		)
		return
	end

	-- parse data into printable output
	local label = "[" .. _G.CONSTS.log.labels[reqd_level + 1] .. "] " -- vim log levels are 0 indexed
	local out = vim.inspect(data)

	-- notify output method
	if _G.CONF.logging_opts.output.notify <= reqd_level then
		vim.notify(label, reqd_level)
		vim.notify(out, reqd_level)
	end

	-- print output method
	if _G.CONF.logging_opts.output.print <= reqd_level then
		print(label .. out)
	end

	-- vim.print output method
	if _G.CONF.logging_opts.output.vim_print <= reqd_level then
		vim.print(label .. out)
	end

	-- file output method
	if
		_G.CONF.logging_opts.output.file <= reqd_level
		and M.runtime_vars.log_file_ready
	then
		-- should be impossible as setup_log_file() and log_file_ready handles
		-- this case
		if not M.runtime_vars.log_file then
			-- just a sanity check
			M.runtime_vars.log_file_ready = false
			return
		end

		local timestamp = "[" .. os.date("%H:%M:%S") .. "] "

		while true do
			if
				M.runtime_vars.failed_write_tries
				>= _G.CONSTS.log.max_failed_write_tries
			then
				_G.LOG.warn("could not write to log file after multiple tries")
				break
			end

			local ok, err =
				M.runtime_vars.log_file:write(timestamp .. label .. out .. "\n")

			if err or not ok then
				_G.LOG.warn("could not write to log file")
				_G.LOG.debug({ log_file_write_err = err })
				M.runtime_vars.failed_write_tries = M.runtime_vars.failed_write_tries
					+ 1
			else
				M.runtime_vars.log_file:flush()
				break
			end
		end
	end
end

function M.trace(f)
	f = f or 2
	local debug_info = debug.getinfo(f)

	M.print(
		vim.log.levels.TRACE,
		{ "line " .. debug_info.currentline .. " @ " .. debug_info.short_src }
	)
end

function M.debug(...)
	M.trace(3)
	M.print(vim.log.levels.DEBUG, { ... })
end

function M.info(...)
	M.trace(3)
	M.print(vim.log.levels.INFO, { ... })
end

function M.warn(...)
	M.trace(3)
	M.print(vim.log.levels.WARN, { ... })
end

function M.error(...)
	M.trace(3)
	M.print(vim.log.levels.ERROR, { ... })
end

-- clear log display backlog on vim enter
vim.api.nvim_create_autocmd("VimEnter", {
	group = _G.CONSTS.augrp.id,
	callback = function()
		M.runtime_vars.display_ready = true
		for _, log_data in ipairs(M.runtime_vars.display_backlog) do
			M.print(log_data.reqd_level, log_data.data)
		end
		M.runtime_vars.display_backlog = {}
	end,
})

return M
