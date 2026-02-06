--[[
--
-- nvim/lua/config-183/options/defaults.lua
--
-- default set of editable options
--
--]]

---@module "vim"
---@module "vim.lsp"
---@module "vim.filetype"
---@module "config-183.utils"
---@module "config-183.utils.variables"
---@module "config-183.custom"
---@module "config-183.custom.statusline"
---@module "config-183.plugin"
---@module "config-183.plugin.spec"
---@module "lazy"
---@module "conform"
---@module "lint"
---@module "dap"
---@module "nvim-treesitter"
---@module "blink"
---@module "blink-cmp"

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

---@type table<string, LazySpec>? override plugins and config defined in the confiuration
defaults.plugin_overrides = {}

---@type LazySpec[]? plugins to test for by pausing all other plugins
defaults.test_plugins = nil

---@type table<string, vim.lsp.Config|nil>? setup for lsps and their configuration options
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
	---@type table<string, conform.FiletypeFormatterInternal|nil|fun(bufnr: integer):conform.FiletypeFormatterInternal>? map of filetype to formatters
	ft_formatters = {},
	---@type table<string, conform.FormatterConfigOverride|nil|fun(bufnr: integer):conform.FormatterConfigOverride|nil>? custom formatters and overrides for built-in formatters
	custom_formatters = {},
}

---@class LinterOpts
--- map built-in formatters to filetypes or setup available linters
defaults.lint = {
	---@type table<string, string[]?> map of filetype to linters to try using try_lint
	ft_linters = {},
	---@type table<string, nil|fun():lint.Linter|lint.Linter> table with available linters
	available_linters = {},
}

---@class DapOpts
--- dap adapters setup
defaults.dap = {
	---@type table<string, function?> setup dap adapters in mason dap
	mason_dap = {},
	---@type table<string, dap.Adapter|nil|fun(callback: fun(adapter: dap.Adapter), config: dap.Configuration, parent?: dap.Session)> adapter definitions
	adapters = {},
	---@type table<string, dap.Configuration[]|nil> configurations per adapter
	configuration = {},
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
			blink1 = "blink-cmp-menu",
			blink2 = "blink-cmp-documentation",
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
			lspsaga4 = "sagarename",
			mason = "mason",
			lazy = "lazy",
			lazygit = "lazygit",
			diff = "diff",
			man = "man",
			dap1 = "dap-repl",
			dap2 = "dap_repl",
			dapui1 = "dapui_console",
			dapui2 = "dapui_scopes",
			dapui3 = "dapui_breakpoints",
			dapui4 = "dapui_stacks",
			dapui5 = "dapui_watches",
			dapui6 = "dapui_hover",
			log = "log",
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
			blink1 = "blink-cmp-menu",
			blink2 = "blink-cmp-documentation",
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
			lspsaga4 = "sagarename",
			mason = "mason",
			lazy = "lazy",
			lazygit = "lazygit",
			diff = "diff",
			man = "man",
			dap1 = "dap-repl",
			dap2 = "dap_repl",
			dapui1 = "dapui_console",
			dapui2 = "dapui_scopes",
			dapui3 = "dapui_breakpoints",
			dapui4 = "dapui_stacks",
			dapui5 = "dapui_watches",
			dapui6 = "dapui_hover",
			log = "log",
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
