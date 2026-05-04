--[[ plugins related types ]]

---@class (exact) 183.plugin.types.Category.Aesthetics
---@field onedark? LazySpec

---@class (exact) 183.plugin.types.Category.Dependencies
---@field devicons? LazySpec
---@field plenary? LazySpec

---@class (exact) 183.plugin.types.Category.DevTools
---@field lspconfig? LazySpec
---@field mason? LazySpec

---@class (exact) 183.plugin.types.Category.Essentials
---@field snacks? LazySpec
---@field treesitter_manager? LazySpec

---@class (exact) 183.plugin.types.Category.QualityOfLife
---@field harpoon? LazySpec

---@class (exact) 183.plugin.types.Category.ToolChains

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
