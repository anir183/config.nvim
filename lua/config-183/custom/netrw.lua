--[[
--
-- nvim/lua/config-183/custom/netrw.lua
--
-- custom functionality to make netrw usable as a sidebar explorer
--
--]]

---@module "vim"
---@module "config-183.utils"
---@module "config-183.utils.variables"
---@module "config-183.utils.functions"
---@module "config-183.utils.logging"

LOG.info("setting up netrw sidebar and toggling functionality")

vim.g.netrw_winsize = VARS.win.netrw_size -- netrw sidebar width

--[[ create netrw toggling functionality ]]
local is_netrw_sidebar_open = false
local toggle_netrw_sidebar = function()
	if vim.bo.filetype == "netrw" and not is_netrw_sidebar_open then
		return
	end

	if not is_netrw_sidebar_open then
		vim.g.netrw_banner = 0
		vim.cmd("Lexplore %:p:h")
	else
		vim.cmd("Lexplore")
		vim.g.netrw_banner = 1

		-- NOTE: using lexplore changes this valuebut does not reset it, and so
		--       it needs to be manually reset
		vim.g.netrw_chgwin = -1
	end

	is_netrw_sidebar_open = not is_netrw_sidebar_open
end
local toggle_netrw_fullscreen = function()
	if is_netrw_sidebar_open then
		vim.cmd("Lexplore")
		vim.g.netrw_banner = 1
		vim.g.netrw_chgwin = -1
		is_netrw_sidebar_open = false
	end

	if vim.bo.filetype == "netrw" then
		vim.cmd("Rexplore")
	else
		vim.cmd("Explore")
	end
end

--[[ create commands to run netrw toggling ]]
vim.api.nvim_create_user_command(
	"Sbex",
	toggle_netrw_sidebar,
	{ desc = "[custom/netrw]: toggle netrw sidebar" }
)
vim.api.nvim_create_user_command(
	"Ex",
	toggle_netrw_fullscreen,
	{ desc = "[custom/netrw]: toggle netrw fullscreen" }
)

--[[ create keymaps to run netrw toggling ]]
FUNCS.nmap(
	"<leader>e",
	toggle_netrw_sidebar,
	"[custom/netrw]: toggle n[E]trw sidebar"
)
FUNCS.nmap(
	"<leader>E",
	toggle_netrw_fullscreen,
	"[custom/netrw]: toggle n[E]trw fullscreen"
)

LOG.info("netrw sidebar and toggling setup and loaded")
