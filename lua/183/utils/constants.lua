--[[ useful constants ]]

---@module "183.utils.types"

---@type 183.utils.types.Constants
local M = {}

M.default_colorscheme = "catppuccin"

-- augrp related constants
M.augrp = {}
M.augrp.name = "augrp-183"
M.augrp.id = vim.api.nvim_create_augroup(M.augrp.name, {
	clear = true,
})

-- path constants and common paths
M.path = {}
M.path.separator = package.config:sub(1, 1) -- http://stackoverflow.com/questions/37949298/ddg#37953903
M.path.config = vim.fn.stdpath("config")
M.path.data = vim.fn.stdpath("data")
M.path.state = vim.fn.stdpath("state")

-- useful strings
M.strings = {}
M.strings.cmd_prefix = "CMD"
M.strings.hl_fmt = "%%#%s#%s%%*"
M.strings.pattern_num = "^%-?%d+$"

-- env keys
M.env_keys = {}
M.env_keys.mode = "183_NVIM_MODE"
M.env_keys.shell = "183_NVIM_SHELL"

-- lazy plugin manager opts
M.lazy = {}
M.lazy.install_path = M.path.data
	.. M.path.separator
	.. "lazy"
	.. M.path.separator
	.. "lazy.nvim"
M.lazy.lock_file_path = M.path.state .. M.path.separator .. "lazy-lock.json"
M.lazy.repo_url = "https://github.com/folke/lazy.nvim.git"
M.lazy.priorities = {}
M.lazy.priorities.highest = 200
M.lazy.priorities.high = 100
M.lazy.priorities.default = 50
M.lazy.priorities.low = 25

return M
