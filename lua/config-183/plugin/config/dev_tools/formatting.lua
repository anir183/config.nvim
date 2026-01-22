--[[
--
-- nvim/lua/config-183/plugin/config/dev_tools/xxxxxxxx.lua
--
-- file formatting engine
--
--]]

---@type LazySpec
local plugin = {}

plugin[1] = "stevearc/conform.nvim"
plugin.name = "conform"
plugin.dependencies = "mason"
plugin.lazy = false
---@type conform.setupOpts
plugin.opts = {
	formatters_by_ft = OPTS.conform.ft_formatters,
	formatters = OPTS.conform.custom_formatters,
}

---@param silent? boolean silent formatting
---@param try_num? integer the number of tries performed to format a file
---@return nil
--- ---
--- try to format a file 3 times in case of error before giving up
local function format(silent, try_num)
	silent = silent or false

	if not try_num or try_num < 1 then
		try_num = 0
		if not silent then
			vim.notify("Starting Format!", vim.log.levels.INFO)
			LOG.info("silent format requested")
		else
			LOG.info("format requested")
		end
	else
		LOG.info("format trial " .. try_num)
	end

	local curr_filt_path = vim.fn.expand("%:p")

	--[[ try to format the file ]]
	local success, result = pcall(require("conform").format, {
		async = true,
		quiet = true,
	}, function(err, edited_file)
		--[[ formatting successful ]]
		if not err then
			if edited_file then
				if not silent then
					vim.notify("Formatted File!", vim.log.levels.INFO)
				end
				LOG.info("file was changed")
				vim.cmd("silent! w" .. curr_filt_path)
			else
				if not silent then
					vim.notify(
						"File is already Correctly Formatted!",
						vim.log.levels.INFO
					)
				end
				LOG.info("file already formatted.. no changes")
			end

		--[[ formatting unsuccessful, retry unless exceeded try limit ]]
		else
			if try_num <= 3 then
				LOG.info("retrying format")
				format(silent, try_num + 1)
			elseif not silent then
				vim.notify(
					"Could not Format File!\n" .. err,
					vim.log.levels.WARN
				)
			end
		end
	end)

	if not success then
		if not silent then
			vim.notify(
				"Could not Format File after 3 tries!",
				vim.log.levels.ERROR
			)
		end
		LOG.info("could not format file even after 3 tries")
	else
		LOG.info("formatted file")
	end
	LOG.debug(curr_filt_path, result)
end

plugin.config = function(_, opts)
	local conform = require("conform")

	conform.setup(opts)

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = VARS.augrp.id,
		callback = function()
			format(true)
		end,
	})
end
plugin.keys = {
	{
		mode = { "n", "v" },
		"<leader>fm",
		format,
		desc = "[plugin/conform]: [F]or[M]at file or selections",
	},
}

return plugin
