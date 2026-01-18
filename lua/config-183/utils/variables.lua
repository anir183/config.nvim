--[[
--
-- nvim/lua/config-183/utils/variables.lua
--
-- useful variables that can be used in the config and are made globally
-- available
--
--]]

---@class UtilVars
--- handly or commonly used variables made to be globally available
VARS = {}

---@class AugrpVars
--- variables related to auto-command groups
VARS.augrp = {}
---@type string name of auto-command groups
VARS.augrp.name = "augroup-183"
VARS.augrp.id = vim.api.nvim_create_augroup(VARS.augrp.name, {
	clear = true,
})

---@class PathVars
--- variables related to different common paths
VARS.path = {}
---@type string os specific path separator
VARS.path.separator = package.config:sub(1, 1)
---@type string directory where nvim config files are stored
VARS.path.data = vim.fn.stdpath("data")
---@type string directory where nvim data files are stored
VARS.path.state = vim.fn.stdpath("state")
---@type string directory where nvim state files are stored
VARS.path.config = vim.fn.stdpath("config")

---@class StringVars
--- string or patterns that are useful
VARS.strings = {}
---@type string can be used to format other strings
VARS.strings.format = "%%#%s#%s%%*"
---@type string can be used to match with string to identify numbers
VARS.strings.num_match = "^%-?%d+$"
