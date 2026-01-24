--[[
--
-- nvim/lua/config-183/utils/variables.lua
--
-- useful variables that can be used in the config and are made globally
-- available
--
--]]

---@module "vim"
---@module "package"
---@module "config-183.utils"

---@class UtilVars
--- handly or commonly used variables made to be globally available
_G.VARS = {}

--@class WindowVars
_G.VARS.win = {}
---@type integer size of the netrw sidebar window
_G.VARS.win.netrw_size = 17

---@class AugrpVars
--- variables related to auto-command groups
_G.VARS.augrp = {}
---@type string name of auto-command groups
_G.VARS.augrp.name = "augroup-183"
---@type integer id of the create custom auto-command group
_G.VARS.augrp.id = vim.api.nvim_create_augroup(VARS.augrp.name, {
	clear = true,
})

---@class PathVars
--- variables related to different common paths
_G.VARS.path = {}
---@type string os specific path separator
_G.VARS.path.separator = package.config:sub(1, 1)
---@type string directory where nvim config files are stored
_G.VARS.path.data = vim.fn.stdpath("data")
---@type string directory where nvim data files are stored
_G.VARS.path.state = vim.fn.stdpath("state")
---@type string directory where nvim state files are stored
_G.VARS.path.config = vim.fn.stdpath("config")

---@class StringVars
--- string or patterns that are useful
_G.VARS.strings = {}
---@type string prefix to be used in front of custom commands
_G.VARS.strings.cmd_prefix = "CMD"
---@type string can be used to format other strings
_G.VARS.strings.format = "%%#%s#%s%%*"
---@type string can be used to match with string to identify numbers
_G.VARS.strings.num_match = "^%-?%d+$"

---@type "unix" | "windows" os style in which the config is running
_G.VARS.os = VARS.path.separator == "/" and "unix" or "windows"

---@type boolean hack to ensure workspace indexing starts on lsp attach
_G.VARS.lsp_indexing_hack = false
