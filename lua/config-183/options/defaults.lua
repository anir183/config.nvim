--[[
--
-- nvim/lua/config-183/options/defaults.lua
--
-- default set of editable options
--
--]]

---@class DefaultOpts
--- default set of editable options
local defaults = {}

---@type "normal" | "minimal" | "min-plugins" | "no-plugins" mode in which to run the configuration
defaults.mode = "normal"
---@type string command execution shell for running host commands
defaults.shell = nil

---@type function? execute before config is started but after utilities and logging lib is loaded
defaults.before = function() end
---@type function? execute after the config is completely loaded
defaults.after = function() end

---@type LazySpec[]? extra plugins to install alongside configured ones
defaults.extra_plugins = {}

---@type ConfigSpec? override plugins and config defined in the confiuration
defaults.plugin_overrides = {}

---@type LazySpec[]? plugins to test for by pausing all other plugins
defaults.test_plugins = nil

---@type table<string, vim.lsp.Config>? setup for lsps and their configuration options
defaults.lsps = {
	lua_ls = {
		settings = {
			Lua = {
				callSnippet = "Replace",
			},
		},
	},
}

---@class FormatterOpts
--- map built-in formatters to filetypes or setup custom formatters and override defaults
defaults.conform = {
	---@type table<string, conform.FiletypeFormatterInternal|fun(bufnr: integer):conform.FiletypeFormatterInternal>? map of filetype to formatters
	ft_formatters = {},
	---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer):conform.FormatterConfigOverride|nil>? custom formatters and overrides for built-in formatters
	custom_formatters = {},
}

---@type blink.cmp.SourceConfigPartial
defaults.cmp_sources = {
	default = {
		"lsp",
		"path",
		"snippets",
		"buffer",
	},
}

---@type { file_pattern: string | string[], cloak_pattern: string | string[], replace?: string | string[] }[] cloak.nvim filetype and hiding patterns
defaults.cloak_patterns = {
	{
		file_pattern = { ".env", ".env.*" },
		cloak_pattern = { "=.+" },
		replace = nil,
	},
	{
		file_pattern = { "*secret.json", "secret*.json" },
		cloak_pattern = { ":.+" },
		replace = nil,
	},
}

---@type vim.filetype.add.filetypes[] make neovim recognize more custom or additional filetypes
defaults.additional_fts = {
	{
		extension = {
			env = "dotenv",
		},
		filename = {
			[".env"] = "dotenv",
		},
		pattern = {
			["%.env%.[%w_.-]+"] = "dotenv",
			["%.env"] = "dotenv",
			["%.env%..+"] = "dotenv",
		},
	},
}

---@class ParserOpts list of treesitter parsers to install or ignore or setup
defaults.parsers = {
	---@type string[] ensure these parsers are installed
	install = {},
	---@class ParserIgnore
	--- filtypes or languages to ignore automatic parser installation for
	ignore = {
		-- NOTE : dictionary format to avoid override by options injection
		--        unless explicitly wanted
		--        otherwise uses a string array
		--
		---@class ParserIgnoreFts
		fts = {
			oil1 = "oil",
			oil2 = "oil_preview",
			harpoon = "harpoon",
			fidget = "fidget",
			netrw = "netrw",
			help = "help",
			undotree = "undotree",
			blink = "blink-cmp-menu",
			snacks1 = "snacks_layout_box",
			snacks2 = "snacks_picker_input",
			snacks3 = "snacks_picker_list",
			snacks4 = "snacks_picker_preview",
			snacks5 = "snacks_input",
			snacks6 = "snacks_terminal",
			conf = "conf",
			rc = "rc",
			text = "text",
			nofile = "nofile",
			tutor = "tutor",
			terminal = "terminal",
			prompt = "prompt",
			trouble = "trouble",
			lspsaga1 = "sagafinder",
			lspsaga2 = "sagaoutline",
			lspsaga3 = "beacon",
			mason = "mason",
			lazy = "lazy",
		},
		-- NOTE : dictionary format to avoid override by options injection
		--        unless explicitly wanted
		--        otherwise uses a string array
		--
		---@class ParserIgnoreLang
		langs = {
			oil1 = "oil",
			oil2 = "oil_preview",
			harpoon = "harpoon",
			fidget = "fidget",
			netrw = "netrw",
			help = "help",
			undotree = "undotree",
			blink = "blink-cmp-menu",
			snacks1 = "snacks_layout_box",
			snacks2 = "snacks_picker_input",
			snacks3 = "snacks_picker_list",
			snacks4 = "snacks_picker_preview",
			snacks5 = "snacks_input",
			snacks6 = "snacks_terminal",
			conf = "conf",
			rc = "rc",
			text = "text",
			nofile = "nofile",
			tutor = "tutor",
			terminal = "terminal",
			prompt = "prompt",
			trouble = "trouble",
			lspsaga1 = "sagafinder",
			lspsaga2 = "sagaoutline",
			lspsaga3 = "beacon",
			mason = "mason",
			lazy = "lazy",
		},
	},
	---@type table<string, ParserInfo> parser name and configuration dictionary for custom parsers
	custom = {
		---@diagnostic disable-next-line: missing-fields
		dotenv = {
			---@diagnostic disable-next-line: missing-fields
			install_info = {
				url = "https://github.com/pnx/tree-sitter-dotenv",
				branch = "main",
				files = { "src/parser.c", "src/scanner.c" },
				queries = "queries/dotenv",
			},
			filetype = "dotenv",
		},
	},
}
---@type ParserIgnoreFts | string[]
defaults.parsers.ignore.fts = defaults.parsers.ignore.fts
---@type ParserIgnoreLang | string[]
defaults.parsers.ignore.langs = defaults.parsers.ignore.langs

---@type UtilVars? common variables mades to be globally available
defaults.util_vars = nil
---@type LogOpts? options for the logging library
defaults.log_opts = nil
---@type StatuslineOpts? options for the statusline
defaults.stline_otps = nil
---@type LazyOpts? options for bootstrapping lazy.nvim plugin manager
defaults.lazy_opts = nil

return defaults
