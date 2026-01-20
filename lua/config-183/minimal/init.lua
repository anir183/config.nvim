--[[
--
-- nvim/lua/config-183/minimal/init.lua
--
-- bootstrap minimal submodules
-- this module sets up a comfortable editing environment with the least amount
-- of configuration possible
--
--]]

require("config-183.minimal.options")
require("config-183.minimal.keymaps")

if OPTS.mode ~= "min-plugins" then
	return
end
require("config-183.minimal.plugins")
