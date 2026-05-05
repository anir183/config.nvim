--[[ additional netrw funtionality ]]

---@module "183.custom.types"

---@type 183.custom.types.Netrw
local M = {}

M.is_sidebar_open = false

function M.toggle_sidebar()
	if vim.bo.filetype == "netrw" and not M.is_sidebar_open then
		return
	end

	if not M.is_sidebar_open then
		vim.g.netrw_banner = 0
		vim.cmd("Lexplore %:p:h")
		M.is_sidebar_open = true

		-- cleanup if user manually closed buffer :q
		vim.defer_fn(function()
			vim.api.nvim_create_autocmd("WinClosed", {
				buf = 0, -- specific to the sidebar buffer
				callback = function()
					vim.g.netrw_banner = 1
					vim.g.netrw_chgwin = -1 -- NOTE: using lexplore changes this... needs to be reset
					M.is_sidebar_open = false
				end,
			})
		end, 10)
	else
		vim.cmd("Lexplore")

		-- WARN: breaks if cleanup is left to autocommand even though
		--        autocommand gets triggered here
		-- TODO: figure it out
		vim.g.netrw_banner = 1
		M.is_sidebar_open = false
		vim.g.netrw_chgwin = -1
	end
end

function M.toggle_fullscreen()
	-- WARN: using M.toggle_sidebar() instead does not work
	-- TODO: figure it out
	if M.is_sidebar_open then
		vim.cmd("Lexplore")
		vim.g.netrw_banner = 1
		vim.g.netrw_chgwin = -1
		M.is_sidebar_open = false
	end

	if vim.bo.filetype == "netrw" then
		vim.cmd("Rexplore")
	else
		vim.cmd("Explore")
	end
end

function M.create_commands()
	vim.api.nvim_create_user_command(
		"Sbex",
		M.toggle_sidebar,
		{ desc = "[custom.netrw] toggle netrw [S]ide[B]ar [EX]plorer" }
	)
	vim.api.nvim_create_user_command(
		"Ex",
		M.toggle_fullscreen,
		{ desc = "[custom.netrw] toggle netrw fullscreen [EX]plorer" }
	)
end

function M.create_keymaps()
	_G.FUNCS.map(
		"n",
		"<leader>e",
		M.toggle_sidebar,
		{ desc = "[custom.netrw] toggle n[E]trw sidebar" }
	)
	_G.FUNCS.map(
		"n",
		"<leader>E",
		M.toggle_fullscreen,
		{ desc = "[custom.netrw] toggle n[E]trw fullscreen" }
	)
end

return M
