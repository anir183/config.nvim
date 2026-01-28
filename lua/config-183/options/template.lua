--[[
--
-- this file can be used to edit several configuration options on the go
-- it is expected to return a table of options which will be merged with
-- configuration options wherever applicable
--
-- for finding available options or looking into documentation the DefaultOpts
-- class made avilable via lua_ls annotations can be used
--
--]]

---@module "config-183.options.defaults"

---@type DefaultOpts
local options = {}

--[[ instance settings ]]

options.mode = "normal"
options.shell = nil

--[[ run functions ]]

options.before = function() end
options.after = function() end

--[[ plugins ]]

options.extra_plugins = {}
options.plugin_overrides = {}
options.test_plugins = nil

--[[ devtools ]]

options.lsps = {}
options.conform = {}
options.lint = {}
options.dap = {}
options.cmp_sources = {}

--[[ quality of life settings ]]

options.cloak_patterns = {}
options.additional_fts = {}
options.parsers = {}

--[[ configuration options ]]

options.util_vars = {}
options.log_opts = {}
options.stline_otps = {}
options.lazy_opts = {}

return options
