--[[ plugins related types ]]

---@class (exact) 183.plugin.types.Category.Aesthetics
---@field fidget? LazySpec
---@field onedark? LazySpec

---@class (exact) 183.plugin.types.Category.Dependencies
---@field devicons? LazySpec
---@field fzf? LazySpec
---@field nio? LazySpec
---@field plenary? LazySpec

---@class (exact) 183.plugin.types.Category.DevTools
---@field blink? LazySpec
---@field conform? LazySpec
---@field dap? LazySpec
---@field dapui? LazySpec
---@field dap_mason? LazySpec
---@field dap_virtual_text? LazySpec
---@field friendly_snippets? LazySpec
---@field lint? LazySpec
---@field lsp_signature? LazySpec
---@field lspconfig? LazySpec
---@field lua_snip? LazySpec
---@field mason? LazySpec

---@class (exact) 183.plugin.types.Category.Essentials
---@field oil? LazySpec
---@field quicker? LazySpec
---@field snacks? LazySpec
---@field treesitter_manager? LazySpec
---@field undotree? LazySpec

---@class (exact) 183.plugin.types.Category.QualityOfLife
---@field bqf? LazySpec
---@field ccc? LazySpec
---@field cloak? LazySpec
---@field comment? LazySpec
---@field git_signs? LazySpec
---@field harpoon? LazySpec
---@field sleuth? LazySpec
---@field tiny_inline_diagnostics? LazySpec
---@field todo_comments? LazySpec
---@field treesitter_context? LazySpec

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

---@class (exact) 183.plugins.types.Spec
---@field category_opts? 183.plugins.types.Category.Opts
---@field get_base_spec? fun(): 183.plugins.types.BaseSpec
---@field get_lazy_spec? fun(): LazySpec

---@class (exact) 183.plugins.types.Module
---@field install_cmd? string[]
---@field check_and_install? fun(): nil
---@field init? fun(): nil
