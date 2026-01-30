--[[
--
-- nvim/lua/config-183/custom/commands.lua
--
-- create some useful functionality and assign them to commands
--
--]]

---@module "io"
---@module "math"
---@module "vim"
---@module "vim.ui"
---@module "config-183.utils"
---@module "config-183.utils.logging"
---@module "config-183.utils.functions"
---@module "config-183.utils.variables"

LOG.info("creating custom commands")

local cmd = function(cmd_name, ...)
	vim.api.nvim_create_user_command(VARS.strings.cmd_prefix .. cmd_name, ...)
	LOG.info("created custom command: " .. cmd_name)
	LOG.debug(...)
end

--[[ open editable options in floating buffer ]]
cmd("EditOptions", function()
	LOG.info("opening or generating options file")

	local opts_path = FUNCS.join_paths(
		VARS.path.config,
		"lua",
		"config-183",
		"options",
		"custom.lua"
	)
	local opts_file, opts_err = io.open(opts_path, "r")

	if opts_err then
		LOG.debug(opts_err)
	end

	if opts_file == nil then
		LOG.info("custom opts file is not yet generated")

		local template_path = FUNCS.join_paths(
			VARS.path.config,
			"lua",
			"config-183",
			"options",
			"template.lua"
		)
		local template_file, template_err = io.open(template_path, "r")

		local template_data = "return {}"
		if template_err or not template_file then
			LOG.warn("could not find or open template options file")
			LOG.debug(template_err)
		else
			template_data = template_file:read("*a")
			template_file:close()
		end

		opts_file, opts_err = io.open(opts_path, "w")
		if opts_err or not opts_file then
			LOG.warn("could not open options file to write")
			LOG.debug(opts_err)
		else
			local _, write_err = opts_file:write(template_data)
			opts_file:close()

			if write_err then
				LOG.warn("could not write template data to options file")
				LOG.debug(write_err)
			else
				LOG.info("generated custom options file from template data")
			end
		end
	end

	LOG.info("creating ui buffer to edit options file")
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
	FUNCS.nmap(
		"q",
		vim.cmd.wq,
		"[custom]: close editable options popup",
		{ buffer = true }
	)
end, { desc = "[custom]: open editable options in floating window" })

--[[ change indentation style ]]
cmd("ChangeIndent", function()
	vim.ui.select(FUNCS.auto_set_indents and {
		"auto",
		"tabs",
		"spaces",
	} or {
		"tabs",
		"spaces",
	}, {
		prompt = "indentation type: ",
	}, function(indent_type)
		if not indent_type then
			return
		end

		if indent_type == "auto" then
			FUNCS.auto_set_indents()
		end

		--[[ setup buffer indentation setup and reindent ]]
		local old_tab_len = vim.opt_local.tabstop._value
		vim.ui.input({
			prompt = "tab length: ",
		}, function(new_tab_len)
			if not new_tab_len or not FUNCS.str_isnum(new_tab_len) then
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

					-- NOTE : retab command also replaces inline spaces, so we
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
end, { desc = "[custom]: change indentation style in current buffer" })

--[[ substitute standalone or substring occurences of a string ]]
cmd("SubstituteStr", function()
	vim.ui.input({
		prompt = "target: ",
	}, function(target)
		if not target then
			return
		end

		--[[ get substitute ]]
		local substitute = nil
		vim.ui.input({
			prompt = "substitute: ",
		}, function(sbst)
			substitute = sbst
		end)
		if not substitute then
			return
		end

		--[[ perform standalone or substring substitution base on use choice ]]
		vim.ui.select({
			"standalone",
			"substring",
		}, {
			prompt = "replacement type: ",
		}, function(type)
			if not type then
				return
			end

			FUNCS.feedkeys(
				":%s/"
					.. (type == "substring" and "" or "\\<")
					.. target
					.. (type == "substring" and "/" or "\\>/")
					.. substitute
					.. "/gI"
			)
		end)
	end)
end, {
	desc = "[custom]: substitute standalone or substring occurences of a string",
})

LOG.info("custom commands created and loaded")
