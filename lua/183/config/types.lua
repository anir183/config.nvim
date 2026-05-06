--[[ configuration related types ]]

---@module "183.utils.types"
---@module "183.custom.types"
---@module "183.config.types"
---@module "183.plugins.types"

---@module "lazy"
---@class (exact) 183.config.types.ConfigSpec.PluginSpec
---@field additional? LazySpec
---@field overrides? 183.plugins.types.BaseSpec
---@field minimal_testing? LazySpec

---@module "dap"
---@class (exact) 183.config.types.ConfigSpec.Devtools.DapHandlerParam
---@field name string
---@field adapters dap.Adapter | dap.AdapterFactory
---@field configurations dap.Configuration[]
---@field filetypes string[]

---@module "conform"
---@module "lint"
---@class (exact) 183.config.types.ConfigSpec.DevtoolsSpec
---@field lsps? table<string, vim.lsp.Config | nil> different lsps and their configurations
---@field ft_formatters? table<string, conform.FiletypeFormatter> map filetypes to their corresponding formatters
---@field ft_linters? table<string, string[]> map filetypes to their corresponding linters
---@field dap_handlers? table<string, fun(config: 183.config.types.ConfigSpec.Devtools.DapHandlerParam): nil> handlers to manually setup dap adapters and configuration
---@field custom_formatters? table<string, conform.FormatterConfigOverride | fun(bufnr: integer): nil | conform.FormatterConfigOverride> custom formatters and their setup, or overrides to formatter setup
---@field custom_linters? table<string, fun(): lint.Linter | lint.Linter> custom linters and their setup, or overrides to linter setup

---@module "tree-sitter-manager"
---@class (exact) 183.config.types.ConfigSpec
---@field mode? "normal" | "no-plugin" | "minimal" | "minimal-plugin" | "minimal-dev"
---@field shell? string
---@field update_time? integer
---@field additional_fts? vim.filetype.add.filetypes[]
---@field run_before_config? fun(): nil
---@field run_after_config? fun(): nil
---@field plugins? 183.config.types.ConfigSpec.PluginSpec
---@field dev_tools? 183.config.types.ConfigSpec.DevtoolsSpec
---@field cloak_patterns? { file_pattern: string | string[], cloak_pattern: string | string[], replace?: string | string[] }[]
---@field additional_parsers? table<string, string | tree-sitter-manager.LanguageSpec>
---@field statusline? 183.custom.types.StatuslineOpts
---@field config_state? "default" | "default+custom" | "default+env" | "default+custom+env"
