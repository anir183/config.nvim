--[[ setup plugin manager and install plugins ]]

---@module "183.plugins.types"

---@type 183.plugins.types.Module
local M = {}

M.install_cmd = {
	"git",
	"clone",
	"--filter=blob:none",
	"--branch=stable",
	_G.CONSTS.lazy.repo_url,
	_G.CONSTS.lazy.install_path,
}

function M.check_and_install()
	if not (vim.uv or vim.loop).fs_stat(_G.CONSTS.lazy.install_path) then
		local cmd_out = vim.fn.system(M.install_cmd)

		if vim.v.shell_error ~= 0 then
			LOG.error("failed to install lazy.nvim")
			LOG.debug(cmd_out)
			os.exit(1)
		end

		LOG.info("installed lazy.nvim successfully")
	end
end

function M.init()
	vim.opt.rtp:prepend(_G.CONSTS.lazy.install_path)

	require("lazy").setup({
		spec = require("183.plugins.spec").get_lazy_spec(),
		lockfile = _G.CONSTS.lazy.lock_file_path,
		defaults = {
			lazy = false,
			priority = _G.CONSTS.lazy.priorities.default,
		},
		rocks = {
			enabled = false,
		},
		checker = {
			enabled = true,
			notify = false,
		},
		change_detection = {
			enabled = true,
			notify = false,
		},
	})

	_G.FUNCS.map(
		"n",
		"<leader>lz",
		"<CMD>Lazy<CR>",
		{ desc = "[plugin.lazy] open [L]a[Z]y" }
	)
end

return M
