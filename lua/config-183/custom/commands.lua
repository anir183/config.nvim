--[[
--
-- nvim/lua/config-183/custom/commands.lua
--
-- create some useful functionality and assign them to commands
--
--]]

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
	local opts_file, err = io.open(opts_path, "r")

	if err then
		LOG.debug(err)
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
		local template_file
		template_file, err = io.open(template_path, "r")

		if err then
			LOG.warn("error while opening template options file")
			LOG.debug(err)
		end

		local template_data = "return {}"
		if not template_file then
			LOG.warn("could not find or open template options file")
		else
			template_data = template_file:read("*a")
			template_file:close()
		end

		FUNCS.write_to_file(opts_path, template_data)
		LOG.info("generated custom options file from template data")
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
	FUNCS.nmap("q", vim.cmd.wq, "[custom]: close editable options popup", { buffer = true })
end, { desc = "[custom]: open editable options in floating window" })

--[[ change indentation style ]]
cmd("ChangeIndent", function()
	vim.ui.select(FUNCS.auto_set_indents and {
		"auto", "tabs", "spaces",
	} or {
		"tabs", "spaces",
	}, {
		prompt = "indentation type: ",
	}, function(indent_type)
		if not indent_type then
			return
		end

		--[[ auto indent ]]
		if indent_type == "auto" then
			LOG.info("auto indentation started")
			FUNCS.auto_set_indents()
			return
		end

		--[[ set buffer indentation ]]
		local old_tab_len = vim.opt_local.tabstop._value
		LOG.info("changing buffer indentation values")
		vim.ui.input({
			prompt = "tab length: ",
		}, function(tl)
			local new_tab_len = old_tab_len
			if tl and tl:match(VARS.strings.num_match) then
				new_tab_len = tonumber(tl)
			end

			vim.opt_local.expandtab = (indent_type == "spaces")
			vim.opt_local.tabstop = new_tab_len
			vim.opt_local.listchars:remove("leadmultispace")
			vim.opt_local.listchars:append({
				leadmultispace = "▎" .. ("∙"):rep(new_tab_len - 1),
			})
			LOG.debug({
				---@diagnostic disable-next-line: undefined-field
				expandtab = vim.opt_local.expandtab._value,
				tabstop = vim.opt_local.tabstop._value,
				listchars = vim.opt_local.listchars._value,
				oldtabstop = old_tab_len,
				inputtabstop = tl,
			})
		end)

		--[[ reindent ]]
		vim.ui.select({
			"yes", "no",
		}, {
			prompt = "reindent: ",
		}, function(reindent)
			if (not reindent) or reindent == "no" then
				return
			end

			LOG.info("reindenting file")

			--- first we convert all indentation to tabs as they are easier to
			--- handle
			---  NOTE : retab command also replaces inline spaces, so we use a
			---         substitution command instead
			vim.cmd("silent! %s/\\(^\\s*\\)\\@<=" .. (" "):rep(old_tab_len) .. "/	/g")
			LOG.info("converted indentation to tabs")

			-- if redinentation to spaces is required then perform necessary
			-- action... otherwise indentations are already tabs by now
			if indent_type == "spaces" then
				vim.cmd("silent! %s/\\(^\\s*\\)\\@<=	/" .. (" "):rep(vim.opt_local.tabstop._value) .. "/g")
				LOG.info("reconverted indentation to spaces")
			end

			LOG.debug({
				indent_type = indent_type,
				reindent = reindent,
			})
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
				":%s/" ..
				(type == "substring" and "" or "\\<") ..
				target ..
				(type == "substring" and "/" or "\\>/") ..
				substitute ..
				"/gI"
			)
		end)
	end)
end, { desc = "[custom]: substitute standalone or substring occurences of a string" })

LOG.info("custom commands created and loaded")
