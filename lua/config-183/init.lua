--[[
--
-- nvim/lua/config-183/init.lua
--
-- initiate and bootstrap configuration submodules
--
--]]

---@module "vim"
---@module "vim.filetype"
---@module "config-183.utils"
---@module "config-183.utils.logging"
---@module "config-183.options"
---@module "config-183.minimal"
---@module "config-183.base"
---@module "config-183.custom"
---@module "config-183.plugin"

require("config-183.utils")
require("config-183.options")

OPTS.before()

for _, ft in ipairs(OPTS.additional_fts) do
	LOG.info("adding new filetype: " .. (ft.extension.env or "---"))
	vim.filetype.add(ft)
	LOG.debug(ft)
end

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
