--[[
--
-- nvim/lua/config-183/options/defaults.lua
--
-- default set of editable options
--
--]]

---@class DefaultOpts
--- default set of editable options
local defaults = {}

---@type "normal" | "minimal" | "min-plugins" | "no-plugin" mode in which to run the configuration
defaults.mode = "normal"

---@type UtilVars common variables mades to be globally available
defaults.util_vars = nil
---@type LogOpts options for the logging library
defaults.log_opts = nil

return defaults
