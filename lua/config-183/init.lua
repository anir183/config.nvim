--[[
--
-- nvim/lua/config-183/init.lua
--
-- initiate and bootstrap configuration submodules
--
--]]

require("config-183.utils")
require("config-183.options")

OPTS.before()

if OPTS.mode == "minimal" or OPTS.mode == "min-plugins" then
	require("config-183.minimal")
	return
end

require("config-183.base")
require("config-183.custom")

if OPTS.mode == "no-plugins" then
	return
end
require("config-183.plugin")
