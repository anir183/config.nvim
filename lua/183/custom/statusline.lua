--[[ custom statusline ]]

---@module "183.custom.types"

---@type 183.custom.types.Statusline
local M = {}

M.components = {}

function M.components.logo()
	return _G.FUNCS.fmt_str("@parameter", "   ")
end

function M.components.mode()
	local mode = _G.CONF.statusline.mode_labels[vim.fn.mode()]
	return _G.FUNCS.fmt_str("IncSearch", mode)
end

function M.components.diagnostics()
	local hints = vim.diagnostic.count(0)[vim.diagnostic.severity.HINT]
	local infos = vim.diagnostic.count(0)[vim.diagnostic.severity.INFO]
	local warns = vim.diagnostic.count(0)[vim.diagnostic.severity.WARN]
	local errors = vim.diagnostic.count(0)[vim.diagnostic.severity.ERROR]

	local error_out = _G.FUNCS.fmt_str(
		"DiagnosticError",
		errors and " [" .. errors .. "]" or ""
	)
	local warn_out =
		_G.FUNCS.fmt_str("DiagnosticWarn", warns and " [" .. warns .. "]" or "")
	local info_out =
		_G.FUNCS.fmt_str("DiagnosticInfo", infos and " [" .. infos .. "]" or "")
	local hint_out =
		_G.FUNCS.fmt_str("DiagnosticHint", hints and " [" .. hints .. "]" or "")

	return error_out .. warn_out .. info_out .. hint_out
end

function M.components.gitinfo()
	local branch = vim.fn.system("git branch --show-current")
	if vim.v.shell_error ~= 0 then
		branch = ""
	end

	return _G.FUNCS.fmt_str("Exception", branch)
end

function M.components.filename()
	local ft = vim.bo.filetype

	local filename = vim.fn.expand("%:t:r")
	filename = ft == "" and vim.fn.expand("%:t") or filename
	filename = filename == "" and vim.fn.expand("%") or filename
	filename = filename == "" and "unnamed" or filename
	filename = ft == "" and filename or filename .. " : " .. ft

	return _G.FUNCS.fmt_str("DiffFile", filename)
end

function M.components.indent()
	---@diagnostic disable-next-line: undefined-field
	local type = vim.opt_local.expandtab._value and "spaces" or "tabs"
	---@diagnostic disable-next-line: undefined-field
	local len = vim.opt_local.tabstop._value

	return _G.FUNCS.fmt_str("Label", type .. " : " .. len)
end

function M.components.position()
	return _G.FUNCS.fmt_str("DiffIndexLine", "%02l:%02c ~ %2p%%")
end

function M.get_component(name)
	if not _G.STLINE then
		_G.LOG.warn("statusline module not initialised")
	end

	if not _G.STLINE.components[name] then
		_G.LOG.warn("invalid component name: " .. name)
		_G.LOG.debug(STLINE.components)
		return ""
	end

	return "%{%v:lua.STLINE.components." .. name .. "()%}"
end

function M.set_arrangement()
	if not _G.STLINE then
		_G.LOG.warn("statusline module not initialised")
	end

	local statusline_format = ""

	for _, component in ipairs(_G.CONF.statusline.arrangement) do
		if component:sub(1, 1) == "$" then
			statusline_format = statusline_format
				.. _G.STLINE.get_component(component:sub(2, #component))
		else
			statusline_format = statusline_format .. component
		end
	end

	vim.opt_global.statusline = statusline_format
end

return M
