--[[
--
-- nvim/lua/config-183/utils/functions.lua
--
-- useful functions that can be used in the config and are made globally
-- available
--
--]]

---@class UtilFuncs
--- handy utility functions made to be globally available
FUNCS = {}

---@param mode string | string[] mode(s) where the keyma can be used
---@param lhs string actual keystokes to map
---@param rhs string | function command or callback to run when keymap triggers
---@param desc? string description of what the keymap does
---@param opts? vim.keymap.set.Opts extra options for the keymaps
---@return nil
--- ---
--- map a keystoke to a function or command in provided mode(s)
FUNCS.map = function(mode, lhs, rhs, desc, opts)
	opts = opts or {}
	opts.desc = desc

	vim.keymap.set(mode, lhs, rhs, opts)
end

---@param lhs string actual keystokes to map
---@param rhs string | function command or callback to run when keymap triggers
---@param desc? string description of what the keymap does
---@param opts? vim.keymap.set.Opts extra options for the keymaps
---@return nil
--- ---
--- map a keystoke to a function or command in normal mode
FUNCS.nmap = function(lhs, rhs, desc, opts)
	FUNCS.map("n", lhs, rhs, desc, opts)
end

---@param mode string | string[] mode(s) where the keyma can be used
---@param lhs string actual keystokes to map
---@param actions table<string, function | string> list of actions and the command or callback to run on selection
---@param desc? string description of what the keymap does
---@param opts? vim.keymap.set.Opts extra options for the keymaps
---@return nil
--- ---
--- map a keystoke to a open a menu and perform the selected actions
FUNCS.mmap = function(mode, lhs, actions, desc, opts)
	desc = desc or "open action menu"

	--[[ create a actions menu to choose from ]]
	local choices = {}
	for choice, _ in ipairs(actions) do
		table.insert(choices, choice)
	end

	FUNCS.map(mode, lhs, function()
		vim.ui.select(choices, {
			prompt = "choose action: "
		}, function(choice)
			if not choice then
				return
			end

			local exec = actions[choices]
			local type = type(exec)

			if (not exec) then
				vim.notify("no executable entry for given choice")
				return
			end
			if type ~= "function" or type ~= "string" then
				vim.notify("invalid type for executable entry")
			end

			if type == "function" then
				exec()
			elseif type == "string" then
				vim.cmd(exec)
			end
		end)
	end, desc, opts)
end

---@param ... any components of the path
---@return string joined_path final joined path using os based separator
--- ---
--- join paths using os particular separators
FUNCS.join_paths = function(...)
	local joined_path = table.concat({...}, VARS.path.separator)
	return joined_path
end

---@param str string string to split
---@param sep string separator to split the string at
--- ---
--- split a string one some provided separator (default to " ")
FUNCS.split_str = function(str, sep)
	sep = sep or " "

	local chunks = {}
	for field, s in string.gmatch(str, "([^"..sep.."]*)("..sep.."?)") do
		table.insert(chunks, field)
		if s == "" then
			return chunks
		end
	end

	return chunks
end

---@param file_path string path to the file to write into
---@param data string data to write into the file
---@param overwrite boolean? to overwrite or append
---@return nil
--- ---
--- (over)write or append some data to a file
FUNCS.write_to_file = function(file_path, data, overwrite)
	local file = io.open(file_path, "r")
	local err = nil

	if file == nil or overwrite then
		file, err = io.open(file_path, "w")
	else
		file, err = io.open(file_path, "a+")
	end

	if file == nil or err then
		vim.notify("could not open file to write", vim.log.levels.ERROR)
		vim.notify(vim.inspect(err), vim.log.levels.DEBUG)
		return
	end

	_, err = file:write(data)

	if err then
		vim.notify("error while writing to file", vim.log.levels.ERROR)
		vim.notify(vim.inspect(err), vim.log.levels.DEBUG)
	end

	file:close()
end
