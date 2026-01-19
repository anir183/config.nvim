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

---@type "normal" | "minimal" | "min-plugins" | "no-plugins" mode in which to run the configuration
defaults.mode = "normal"
---@type string command execution shell for running host commands
defaults.shell = nil

---@type function? execute before config is started but after utilities and logging lib is loaded
defaults.before = function() end
---@type function? execute after the config is completely loaded
defaults.after = function() end

---@type UtilVars? common variables mades to be globally available
defaults.util_vars = nil
---@type LogOpts? options for the logging library
defaults.log_opts = nil
---@type StatuslineOpts? options for the statusline
defaults.stline_otps = nil
---@type LazyOpts? options for bootstrapping lazy.nvim plugin manager
defaults.lazy_opts = nil

return defaults
