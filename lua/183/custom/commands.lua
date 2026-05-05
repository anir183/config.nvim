--[[ useful functionality mapped to commands ]]

---@module "183.custom.types"

---@type table<string, 183.custom.types.Command>
local M = {}

M["open [EDIT]able [OPTIONS] in a floating window"] = {
	name = "EditOptions",
	cmd = function()
		_G.LOG.info("opening or generating options file")

		local opts_path = _G.FUNCS.join_path(
			_G.CONSTS.path.config,
			"lua",
			"183",
			"config",
			"custom.lua"
		)
		local opts_file, opts_err = io.open(opts_path, "r")

		if opts_err then
			_G.LOG.debug(opts_err)
		end

		if opts_file == nil then
			_G.LOG.info("custom opts file is not yet generated")

			local default_path = _G.FUNCS.join_path(
				_G.CONSTS.path.config,
				"lua",
				"183",
				"config",
				"defaults.lua"
			)
			local default_file, default_err = io.open(default_path, "r")

			local default_data = "return {}"
			if default_err or not default_file then
				_G.LOG.warn("could not find or open template options file")
				_G.LOG.debug(default_err)
			else
				default_data = default_file:read("*a")
				default_file:close()
			end

			opts_file, opts_err = io.open(opts_path, "w")
			if opts_err or not opts_file then
				_G.LOG.warn("could not open options file to write")
				_G.LOG.debug(opts_err)
			else
				local _, write_err = opts_file:write(default_data)
				opts_file:flush()
				opts_file:close()

				if write_err then
					_G.LOG.warn("could not write template data to options file")
					_G.LOG.debug(write_err)
				else
					_G.LOG.info(
						"generated custom options file from template data"
					)
				end
			end
		end

		_G.LOG.info("creating ui buffer to edit options file")
		local ui = vim.api.nvim_list_uis()[1]
		local width = math.floor((ui.width * 0.7) + 0.5)
		local height = math.floor((ui.height * 0.75) + 0.5)

		vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
			relative = "editor",
			width = width,
			height = height,
			col = (ui.width - width) / 2,
			row = (ui.height - height) / 2,
			focusable = true,
			border = "single",
		})

		vim.cmd("e " .. opts_path)
		vim.defer_fn(function()
			_G.FUNCS.map(
				"n",
				"q",
				vim.cmd.wq,
				{ desc = "[custom] close editable options popup", buf = 0 }
			)
		end, 10)
	end,
}

M["change current buffer indentation"] = {
	name = "ChangeIndent",
	cmd = function()
		vim.ui.select({
			"tabs",
			"spaces",
		}, {
			prompt = "indentation type: ",
		}, function(indent_type)
			if not indent_type then
				return
			end

			--[[ setup buffer indentation setup and reindent ]]
			local old_tab_len = vim.opt_local.tabstop._value
			vim.ui.input({
				prompt = "tab length: ",
			}, function(new_tab_len)
				if not new_tab_len or not _G.FUNCS.is_num(new_tab_len) then
					---@diagnostic disable-next-line: undefined-field
					new_tab_len = vim.opt_local.tabstop._value
				end
				new_tab_len = tonumber(new_tab_len) or old_tab_len

				--[[ reindent ]]
				vim.ui.select({
					"yes",
					"no",
				}, {
					prompt = "reindent: ",
				}, function(reindent)
					if not reindent then
						reindent = "no"
					end

					--[[ convert indentation to tabs ]]
					-- if reindentation is requested, then convert all indentation
					-- to tabs which are easier to manipulate than individual spaces
					if reindent == "yes" then
						vim.opt_local.expandtab = false

						-- NOTE: retab command also replaces inline spaces, so we
						--        use a substitution command instead
						vim.cmd(
							"silent! %s/\\(^\\s*\\)\\@<="
								.. (" "):rep(old_tab_len)
								.. "/	/g"
						)

						if indent_type == "spaces" then
							vim.cmd(
								"silent! %s/\\(^\\s*\\)\\@<=	/"
									.. (" "):rep(new_tab_len)
									.. "/g"
							)
						end
					end

					--[[ set buffer options ]]
					vim.opt_local.expandtab = (indent_type == "spaces")
					vim.opt_local.tabstop = new_tab_len
					vim.opt_local.shiftwidth = 0 -- size of each level of indentation (0 -> tabstop)
					vim.opt_local.softtabstop = -1 -- size of tab character in insert mode (-1 -> shiftwidth)
					vim.opt_local.listchars:remove("leadmultispace")
					vim.opt_local.listchars:append({
						leadmultispace = "▎" .. ("∙"):rep(new_tab_len - 1),
					})
				end)
			end)
		end)
	end,
}

return M
