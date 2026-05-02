--[[ common utility functions ]]

---@module "183.utils.types"

---@type 183.utils.types.Functions
local M = {}

function M.map(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, opts)
	_G.LOG.debug(
		"keymap set",
		{ mode = mode, lhs = lhs, rhs = rhs, opts = opts }
	)
end

function M.mmap(lhs, actions, opts)
	local choices = {}
	for choice, _ in ipairs(actions) do
		table.insert(choices, choice)
	end

	vim.keymap.set("n", lhs, function()
		vim.ui.select(choices, {
			prompt = "choose an action: ",
		}, function(choice)
			if not choice then
				return
			end

			local exec = actions[choice]
			local exec_type = type(exec)

			if exec_type ~= "function" and exec_type ~= "string" then
				return
			end

			if exec_type == "function" then
				exec()
				return
			end

			if exec_type == "string" then
				vim.cmd(exec)
				return
			end
		end)
	end, opts)

	_G.LOG.debug(
		"menu style keymap set",
		{ lhs = lhs, actions = actions, opts = opts }
	)
end

function M.feedkeys(keys, mode)
	mode = mode or "n"
	vim.api.nvim_feedkeys(vim.keycode(keys), mode, false)
	_G.LOG.debug("emulated keystrokes", { keys = keys, mode = mode })
end

function M.deep_loop_table(obj, callback, path)
	path = path or {}

	for key, value in pairs(obj) do
		if type(value) == "table" then
			table.insert(path, key)
			M.deep_loop_table(value, callback, path)
			goto continue
		end

		callback(path, key, value)

		::continue::
	end
end

function M.is_unix()
	return _G.CONSTS.path.separator == "/"
end

function M.is_windows()
	return _G.CONSTS.path.separator == "\\"
end

function M.join_path(...)
	return table.concat({ ... }, _G.CONSTS.path.separator)
end

function M.fmt_str(hl_grp, ...)
	return _G.CONSTS.strings.hl_fmt:format(hl_grp, ...)
end

function M.split_str(str, sep)
	sep = sep or " "

	local chunks = {}
	for field, s in string.gmatch(str, "([^" .. sep .. "]*)(" .. sep .. "?)") do
		table.insert(chunks, field)
		if s == "" then
			return chunks
		end
	end

	return chunks
end

function M.is_num(str)
	return str:match(_G.CONSTS.strings.pattern_num)
end

return M
