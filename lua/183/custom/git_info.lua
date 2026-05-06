-- why not make a janky async git info module to display in the statusline
-- which will probably only be used when plugins are disabled or i uninstall
-- git-signs for whatever reason
--
-- why not

---@module "183.custom.types"

local uv = (vim.uv or vim.loop)

---@type 183.custom.types.GitInfo
local M = {}

-- state
M.initialized_aucmd = false
M.cache_version = 0

M.cached_info = {
	cwd = vim.fn.getcwd(),
	branch = "",
	ahead = 0,
	behind = 0,
	staged = 0,
	modified = 0,
	untracked = 0,
}

-- async runner
-- NOTE: chatgpt made this function... idek
function M.run_git(cmd, args, callback)
	local stdout = uv.new_pipe(false)
	local stderr = uv.new_pipe(false)

	local output = {}
	local handle

	---@diagnostic disable-next-line: missing-fields
	handle = uv.spawn(cmd, {
		args = args,
		cwd = M.cached_info.cwd,
		stdio = { nil, stdout, stderr },
	}, function()
		if stdout then
			stdout:close()
		end
		if stderr then
			stderr:close()
		end
		if handle then
			handle:close()
		end
		callback(table.concat(output))
	end)

	if not handle then
		return
	end

	if not stdout then
		return
	end

	stdout:read_start(function(_, data)
		if data then
			table.insert(output, data)
		end
	end)
end

-- git branch
function M.set_branch_cache(curr_cache_version)
	M.run_git("git", { "branch", "--show-current" }, function(out)
		if curr_cache_version < M.cache_version then
			return
		end

		local branch = out:gsub("%s+", "")
		if branch == "" then
			branch = "(detached)"
		end

		M.cached_info.branch = branch
	end)
end

-- commit ahead / behind
-- OPTIM: is there a better way?
function M.set_ahead_behind_cache(curr_cache_version)
	M.run_git(
		"git",
		{ "rev-parse", "--abbrev-ref", "--symbolic-full-name", "@{u}" },
		function(out1)
			if curr_cache_version < M.cache_version then
				return
			end

			local upstream = out1:gsub("%s+", "")

			if upstream == "" then
				M.cached_info.ahead = 0
				M.cached_info.behind = 0
				return
			end

			M.run_git(
				"git",
				{ "rev-list", "--left-right", "--count", "HEAD...@{u}" },
				function(out2)
					if curr_cache_version < M.cache_version then
						return
					end

					local a, b = out2:match("(%d+)%s+(%d+)")
					M.cached_info.ahead = tonumber(a) or 0
					M.cached_info.behind = tonumber(b) or 0
				end
			)
		end
	)
end

-- git status (untracked, staged, modified)
function M.set_status_cache(curr_cache_version)
	M.run_git("git", { "status", "--porcelain" }, function(out)
		if curr_cache_version < M.cache_version then
			return
		end

		local staged, modified, untracked = 0, 0, 0

		for line in out:gmatch("[^\r\n]+") do
			if line:match("^%?%?") then
				untracked = untracked + 1
			elseif line:match("^[MADRC]") then
				staged = staged + 1
			elseif line:match("^.M") then
				modified = modified + 1
			end
		end

		M.cached_info.staged = staged
		M.cached_info.modified = modified
		M.cached_info.untracked = untracked
	end)
end

-- update cache
function M.update_cache()
	M.cache_version = M.cache_version + 1
	local curr_cache_version = M.cache_version or 0

	if vim.fn.finddir(".git", ".;") == "" then
		-- reset state
		M.cached_info.branch = ""
		M.cached_info.ahead = 0
		M.cached_info.behind = 0
		M.cached_info.staged = 0
		M.cached_info.modified = 0
		M.cached_info.untracked = 0

		return
	end

	M.cached_info.cwd = vim.fn.getcwd()
	M.set_branch_cache(curr_cache_version)
	M.set_status_cache(curr_cache_version)
	M.set_ahead_behind_cache(curr_cache_version)
end

-- setup
function M.setup()
	if M.initialized_aucmd then
		return
	end

	vim.api.nvim_create_autocmd({
		"BufEnter",
		"BufWritePost",
		"FocusGained",
		"DirChanged",
	}, {
		callback = M.update_cache,
	})

	M.update_cache()
	M.initialized_aucmd = true
end

return M
