--[[
--
-- nvim/lua/config-183/plugin/config/essentials/treesitter.lua
--
-- treesitter syntax highlighting
--
--]]

---@module "lazy"
---@module "config-183.utils"
---@module "config-183.utils.logging"

---@type LazySpec
local plugin = {}

plugin[1] = "nvim-treesitter/nvim-treesitter"
plugin.name = "treesitter"
plugin.branch = "main"
plugin.build = ":TSUpdate"
plugin.opts = {}

---@param arg? string | integer language or buffer to install parser for
local install_parser = function(arg)
	arg = arg or 0
	local lang, ft = nil, nil

	if type(arg) == "string" then
		lang = arg
	elseif type(arg) == "number" then
		ft = vim.bo[arg].filetype
		lang = lang or vim.treesitter.language.get_lang(ft)
	end

	if vim.tbl_contains(OPTS.parsers.ignore.fts, ft) then
		LOG.info("ignoring as filetype is excluded: " .. ft)
		return
	end
	if vim.tbl_contains(OPTS.parsers.ignore.langs, lang) then
		LOG.info("ignoring as language is excluded: " .. lang)
		return
	end

	if not lang then
		LOG.warn("no language name for filetype: " .. ft)
		return
	end

	local loaded_parser, err = vim.treesitter.language.add(lang)
	if err then
		LOG.warn("could not load parser for language: " .. lang)
		LOG.debug(err)
	end
	if not loaded_parser then
		local available = vim.g.ts_available
			or require("nvim-treesitter").get_available()
		if not vim.g.ts_available then
			vim.g.ts_available = available
		end
		if vim.tbl_contains(available, lang) then
			LOG.info("installing parser for language: " .. lang)
			require("nvim-treesitter").install(lang)
		else
			LOG.warn("no treesitter parser for language: " .. lang)
		end
	else
		LOG.info("parser with name already available: " .. lang)
	end
end

---@param lang string?
---@param buf integer?
---@return boolean success
local start_treesitter = function(lang, buf)
	buf = buf or 0

	local ft = vim.bo[buf].filetype
	lang = lang or vim.treesitter.language.get_lang(ft)

	if vim.tbl_contains(OPTS.parsers.ignore.fts, ft) then
		LOG.info("ignoring as filetype is excluded: " .. ft)
		return true
	end
	if vim.tbl_contains(OPTS.parsers.ignore.langs, lang) then
		LOG.info("ignoring as language is excluded: " .. lang)
		return true
	end

	if not lang then
		LOG.warn("no language name for filetype: " .. ft)
		return false
	end

	local loaded_parser, err = vim.treesitter.language.add(lang)
	if err then
		LOG.warn("could not load parser for language: " .. lang)
		LOG.debug(err)
	end
	if loaded_parser then
		vim.treesitter.start(buf, lang)
		LOG.info("using parser for language: " .. lang)
		return true
	else
		LOG.warn("no parser to load for language: " .. lang)
	end

	return false
end

plugin.config = function(_, opts)
	require("nvim-treesitter").setup(opts)
	require("nvim-treesitter").install(OPTS.parsers.install)

	--[[ setup custom parsers ]]
	vim.api.nvim_create_autocmd("User", {
		pattern = "TSUpdate",
		callback = function()
			for name, conf in pairs(OPTS.parsers.custom) do
				LOG.info("setting up custom parser: " .. name)
				require("nvim-treesitter.parsers")[name] = conf
				LOG.debug(conf)

				if conf[0] and type(conf[0]) == "string" then
					LOG.info("registering parser to filetype: " .. conf[0])
					vim.treesitter.language.register(name, { conf[0] })
				end
			end
		end,
	})

	--[[ auto install parsers ]]
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "*" },
		callback = function()
			install_parser()

			LOG.info("tried activating treesitter parser once")
			local success = start_treesitter()

			if not success then
				vim.defer_fn(function()
					LOG.info("tried activating treesitter parser twice")
					success = start_treesitter()
				end, 5000)
			end

			if not success then
				vim.defer_fn(function()
					LOG.info("tried activating treesitter parser thrice")
					success = start_treesitter()
				end, 15000)
			end

			if not success then
				vim.defer_fn(function()
					LOG.info("tried activating treesitter parser four time")
					success = start_treesitter()
				end, 30000)
			end
		end,
	})
end
plugin.keys = {
	{
		mode = "n",
		"<leader>ts",
		function()
			vim.ui.input({
				prompt = "parser name: ",
			}, function(name)
				if not name then
					return
				end

				local loaded_parser, err = vim.treesitter.language.add(name)
				if loaded_parser and not err then
					LOG.warn("parser with name already available: " .. name)
					return
				end
				if not loaded_parser then
					local available = vim.g.ts_available
						or require("nvim-treesitter").get_available()
					if not vim.g.ts_available then
						vim.g.ts_available = available
					end
					if vim.tbl_contains(available, name) then
						LOG.info("installing parser for language: " .. name)
						require("nvim-treesitter").install(name)
					else
						LOG.warn("no treesitter parser for language: " .. name)
					end
				end
			end)
		end,
		desc = "[plugin/treesitter]: install input parser",
	},
	{
		mode = "n",
		"<leader>tS",
		function()
			install_parser()
		end,
		desc = "[plugin/treesitter]: install parser for current buffer",
	},
	{
		mode = "n",
		"<leader>TS",
		function()
			start_treesitter()
		end,
		desc = "[plugin/treesitter]: start treesitter for current buffer",
	},
}

return plugin
