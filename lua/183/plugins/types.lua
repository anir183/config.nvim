--[[ plugins related types ]]

---@class (exact) 183.plugin.types.Category.Aesthetics
---@field fidget? LazySpec
---@field onedark? LazySpec

---@class (exact) 183.plugin.types.Category.Dependencies
---@field devicons? LazySpec
---@field plenary? LazySpec

---@class (exact) 183.plugin.types.Category.DevTools
---@field blink? LazySpec
---@field conform? LazySpec
---@field friendly_snippets? LazySpec
---@field lint? LazySpec
---@field lsp_signature? LazySpec
---@field lspconfig? LazySpec
---@field lua_snip? LazySpec
---@field mason? LazySpec

---@class (exact) 183.plugin.types.Category.Essentials
---@field oil? LazySpec
---@field snacks? LazySpec
---@field treesitter_manager? LazySpec
---@field undotree? LazySpec

---@class (exact) 183.plugin.types.Category.QualityOfLife
---@field ccc? LazySpec
---@field cloak? LazySpec
---@field comment? LazySpec
---@field git_signs? LazySpec
---@field harpoon? LazySpec
---@field sleuth? LazySpec
---@field tiny_inline_diagnostics? LazySpec
---@field todo_comments? LazySpec

---@class (exact) 183.plugin.types.Category.ToolChains
---@field lazydev? LazySpec

---@class (exact) 183.plugins.types.Category.Opts
---@field aesthetics boolean
---@field dependencies boolean
---@field dev_tools boolean
---@field essentials boolean
---@field quality_of_life boolean
---@field toolchains boolean

---@alias 183.plugins.types.BaseSpec 183.plugin.types.Category.Aesthetics | 183.plugin.types.Category.Dependencies | 183.plugin.types.Category.DevTools | 183.plugin.types.Category.Essentials | 183.plugin.types.Category.QualityOfLife | 183.plugin.types.Category.ToolChains

---@class (exact) 183.plugins.types.Module
---@field install_cmd? string[]
---@field category_opts? 183.plugins.types.Category.Opts
---@field check_and_install? fun(): nil
---@field get_base_spec? fun(): 183.plugins.types.BaseSpec
---@field get_lazy_spec? fun(): LazySpec
---@field init? fun(): nil
