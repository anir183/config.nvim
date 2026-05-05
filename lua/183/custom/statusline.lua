--[[ custom statusline ]]

---@module "183.custom.types"

---@type 183.custom.types.Statusline
local M = {}

M.components = {}

function M.components.logo()
	return _G.FUNCS.fmt_str("@parameter", "   ")
end

function M.components.mode()
	local mode = _G.CONF.statusline.mode_labels[vim.fn.mode()]
	return _G.FUNCS.fmt_str("IncSearch", mode)
end

function M.components.diagnostics()
	local hints = vim.diagnostic.count(0)[vim.diagnostic.severity.HINT]
	local infos = vim.diagnostic.count(0)[vim.diagnostic.severity.INFO]
	local warns = vim.diagnostic.count(0)[vim.diagnostic.severity.WARN]
	local errors = vim.diagnostic.count(0)[vim.diagnostic.severity.ERROR]

	local error_out = _G.FUNCS.fmt_str(
		"DiagnosticError",
		errors and " [" .. errors .. "]" or ""
	)
	local warn_out =
		_G.FUNCS.fmt_str("DiagnosticWarn", warns and " [" .. warns .. "]" or "")
	local info_out =
		_G.FUNCS.fmt_str("DiagnosticInfo", infos and " [" .. infos .. "]" or "")
	local hint_out =
		_G.FUNCS.fmt_str("DiagnosticHint", hints and " [" .. hints .. "]" or "")

	return error_out .. warn_out .. info_out .. hint_out
end

local git_cache = ""
local git_autocmd_set = false
function M.components.gitinfo()
	-- persistent cache
	if not git_cache then
		git_cache = ""
	end

	-- setup autocmd only once
	if not git_autocmd_set then
		git_autocmd_set = true

		local uv = vim.loop

		local function run_git(cmd, args, cwd, cb)
			local stdout = uv.new_pipe(false)
			local stderr = uv.new_pipe(false)

			local output = {}
			local handle

			handle = uv.spawn(cmd, {
				args = args,
				cwd = cwd,
				stdio = { nil, stdout, stderr },
			}, function()
				stdout:close()
				stderr:close()
				if handle then
					handle:close()
				end
				cb(table.concat(output))
			end)

			stdout:read_start(function(_, data)
				if data then
					table.insert(output, data)
				end
			end)
		end

		local function update()
			local git_dir = vim.fn.finddir(".git", ".;")
			if git_dir == "" then
				git_cache = ""
				return
			end

			local cwd = vim.fn.getcwd()

			-- branch
			run_git(
				"git",
				{ "branch", "--show-current" },
				cwd,
				function(branch_out)
					local branch = branch_out:gsub("%s+", "")
					if branch == "" then
						branch = "(detached)"
					end

					-- upstream + ahead/behind
					run_git(
						"git",
						{
							"rev-parse",
							"--abbrev-ref",
							"--symbolic-full-name",
							"@{u}",
						},
						cwd,
						function(upstream_out)
							local upstream = upstream_out:gsub("%s+", "")
							local ahead, behind = 0, 0

							local function finalize(
								ahead,
								behind,
								staged,
								modified,
								untracked
							)
								local parts = { branch }

								if ahead > 0 then
									table.insert(parts, "↑" .. ahead)
								end
								if behind > 0 then
									table.insert(parts, "↓" .. behind)
								end
								if staged > 0 then
									table.insert(parts, "+" .. staged)
								end
								if modified > 0 then
									table.insert(parts, "~" .. modified)
								end
								if untracked > 0 then
									table.insert(parts, "?" .. untracked)
								end

								git_cache = table.concat(parts, " ")
							end

							local function get_status(ahead, behind)
								run_git(
									"git",
									{ "status", "--porcelain" },
									cwd,
									function(status_out)
										local staged, modified, untracked =
											0, 0, 0

										for line in
											status_out:gmatch("[^\r\n]+")
										do
											if line:match("^%?%?") then
												untracked = untracked + 1
											elseif line:match("^[MADRC]") then
												staged = staged + 1
											elseif line:match("^.M") then
												modified = modified + 1
											end
										end

										finalize(
											ahead,
											behind,
											staged,
											modified,
											untracked
										)
									end
								)
							end

							-- if upstream exists then compute ahead/behind
							if upstream ~= "" then
								run_git(
									"git",
									{
										"rev-list",
										"--left-right",
										"--count",
										"HEAD...@{u}",
									},
									cwd,
									function(counts_out)
										local a, b =
											counts_out:match("(%d+)%s+(%d+)")
										ahead = tonumber(a) or 0
										behind = tonumber(b) or 0
										get_status(ahead, behind)
									end
								)
							else
								-- no upstream, skip ahead/behind
								get_status(0, 0)
							end
						end
					)
				end
			)
		end

		vim.api.nvim_create_autocmd({
			"BufEnter",
			"BufWritePost",
			"FocusGained",
			"DirChanged",
		}, {
			callback = update,
		})

		update()
	end

	return git_cache
end

function M.components.filename()
	local ft = vim.bo.filetype

	local filename = vim.fn.expand("%:t:r")
	filename = ft == "" and vim.fn.expand("%:t") or filename
	filename = filename == "" and vim.fn.expand("%") or filename
	filename = filename == "" and "unnamed" or filename
	filename = ft == "" and filename or filename .. " : " .. ft

	return _G.FUNCS.fmt_str("DiffFile", filename)
end

---@source https://github.com/tpope/vim-sleuth/blob/be69bff86754b1aa5adcbb527d7fcd1635a84080/plugin/sleuth.vim#L647
function M.components.indent()
	local sw = vim.bo.shiftwidth ~= 0 and vim.bo.shiftwidth or vim.bo.tabstop
	local ts = vim.bo.tabstop

	local ind
	if vim.bo.expandtab then
		ind = "sw = " .. sw
	elseif ts == sw then
		ind = "ts = " .. ts
	else
		ind = "sw = " .. sw .. ",ts = " .. ts
	end

	ind = vim.bo.expandtab and "spaces" or "tabs" .. "(" .. ind

	if vim.bo.textwidth ~= 0 then
		ind = ind .. ", tw = " .. vim.bo.textwidth
	end

	if vim.bo.fixendofline == false and vim.bo.endofline == false then
		ind = ind .. ", noeol"
	end

	return _G.FUNCS.fmt_str("Label", ind .. ")")
end

function M.components.position()
	return _G.FUNCS.fmt_str("DiffIndexLine", "%02l:%02c ~ %2p%%")
end

function M.get_component(name)
	if not _G.STLINE then
		_G.LOG.warn("statusline module not initialised")
	end

	if not _G.STLINE.components[name] then
		_G.LOG.warn("invalid component name: " .. name)
		_G.LOG.debug(STLINE.components)
		return ""
	end

	return "%{%v:lua.STLINE.components." .. name .. "()%}"
end

function M.set_arrangement()
	if not _G.STLINE then
		_G.LOG.warn("statusline module not initialised")
	end

	local statusline_format = ""

	for _, component in ipairs(_G.CONF.statusline.arrangement) do
		if component:sub(1, 1) == "$" then
			statusline_format = statusline_format
				.. _G.STLINE.get_component(component:sub(2, #component))
		else
			statusline_format = statusline_format .. component
		end
	end

	vim.opt_global.statusline = statusline_format
end

return M
