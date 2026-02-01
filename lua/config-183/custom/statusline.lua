--[[
--
-- nvim/lua/config-183/custom/statusline.lua
--
-- create statusline component functionality and assemble them into a pretty
-- decent statusline
--
--]]

---@module "string"
---@module "vim"
---@module "vim.diagnostic"
---@module "config-183.utils"
---@module "config-183.utils.logging"

LOG.info("setting up and loading custom statusline")

--[[ remove statusline background ]]
local hl = vim.api.nvim_set_hl
hl(0, "StatusLine", { bg = "none" })
hl(0, "StatusLineNC", { bg = "none" })
hl(0, "StatusLineTerm", { bg = "none" })
hl(0, "StatusLineTermNC", { bg = "none" })

---@class StatuslineOpts
--- options used in the custom statusline
_G.STLINE = STLINE or {}

---@class StatuslineModeLabels
--- labels to show in the statusline corresponding to each mode
_G.STLINE.mode_labels = STLINE.mode_labels
	or {
		["n"] = "  normal  ",
		["niI"] = "  insert [normal]  ",
		["niR"] = "  replace [normal]  ",
		["nt"] = "  terminal [normal]  ",
		["i"] = "  insert  ",
		["R"] = "  replace  ",
		["v"] = "  visual  ",
		["V"] = "  visual [line]  ",
		[""] = "  visual [block]  ",
		["c"] = "  command  ",
		["!"] = "  command [external]  ",
		["t"] = "  terminal  ",
	}

---@type table<string, function> components that can be used in the statusline arrangement
_G.STLINE.components = STLINE.components or {}
---@return nil
--- vim logo
_G.STLINE.components.logo = function()
	return FUNCS.hl_fmt_str("@parameter", "   ")
end
--- get the name of the file open in the current buffer
_G.STLINE.components.filename = STLINE.components.filename
	or function()
		local filename = vim.fn.expand("%:t:r")
		filename = filename == "" and vim.fn.expand("%") or filename
		filename = filename == "" and "unnamed"
			or filename .. " : " .. vim.bo.filetype
		return FUNCS.hl_fmt_str("DiffFile", " " .. filename .. " ")
	end
---@return nil
--- get the position of the cursor in the current buffer
_G.STLINE.components.position = STLINE.components.position
	or function()
		return FUNCS.hl_fmt_str("DiffIndexLine", " %02l:%02c ~ %2p%% ")
	end
---@return nil
--- get the current mode in the buffer
_G.STLINE.components.mode = STLINE.components.mode
	or function()
		local mode = STLINE.mode_labels[vim.fn.mode()]
		return FUNCS.hl_fmt_str("IncSearch", mode)
	end
---@return nil
--- get the indentation style and value of the current buffer
_G.STLINE.components.indent = STLINE.components.indent
	or function()
		---@diagnostic disable-next-line: undefined-field
		local type = vim.opt_local.expandtab._value and "spaces" or "tabs"
		---@diagnostic disable-next-line: undefined-field
		local len = vim.opt_local.tabstop._value

		return FUNCS.hl_fmt_str("Label", " " .. type .. " : " .. len .. " ")
	end
---@return nil
--- get all lsp diagnostics in the current buffer
_G.STLINE.components.diagnostics = STLINE.components.diagnostics
	or function()
		local warns = vim.diagnostic.count(0)[vim.diagnostic.severity.WARN]
		local errors = vim.diagnostic.count(0)[vim.diagnostic.severity.ERROR]
		errors = FUNCS.hl_fmt_str(
			"DiagnosticSignError",
			-- NOTE: keep this before setting warns for correct formattign
			errors and (warns and ": " or " ") .. errors or ""
		)
		warns = FUNCS.hl_fmt_str(
			"DiagnosticSignWarn",
			warns and " " .. warns .. " " or ""
		)

		return warns .. errors
	end

---@type string[] arragement of statusline components ($<name> for custom components)
_G.STLINE.arrangement = STLINE.arrangement
	or {
		-- left
		"$logo",
		"$mode",
		"$diagnostics",
		" ",
		"%r",
		"%w",
		"%h",
		"%m",

		"%=", -- break

		-- right
		"$filename",
		" ",
		"$indent",
		" ",
		"$position",
	}

---@param cmp_name string name of the component to insert in statusline arragnement
--- ---
--- get statusline executable version of a component
_G.STLINE.get_component = function(cmp_name)
	if not STLINE.components[cmp_name] then
		LOG.warn("invalid component name: " .. cmp_name)
		LOG.debug(STLINE.components)
		return ""
	end

	return "%{%v:lua.STLINE.components." .. cmp_name .. "()%}"
end

---@return nil
--- ---
--- actually use the arragement as the current statusline
_G.STLINE.set_arrangment = function()
	local statusline_format = ""

	for _, component in ipairs(STLINE.arrangement) do
		if component:sub(1, 1) == "$" then
			statusline_format = statusline_format
				.. STLINE.get_component(component:sub(2, #component))
		else
			statusline_format = statusline_format .. component
		end
	end

	vim.opt_global.statusline = statusline_format
end

_G.STLINE.set_arrangment()

LOG.info("custom component and arrangement for statusline loaded")
LOG.debug(STLINE)
