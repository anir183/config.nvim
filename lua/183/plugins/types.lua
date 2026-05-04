--[[ plugins related types ]]

---@class (exact) 183.plugin.types.Category.Aesthetics

---@class (exact) 183.plugin.types.Category.Dependencies

---@class (exact) 183.plugin.types.Category.DevTools

---@class (exact) 183.plugin.types.Category.Essentials

---@class (exact) 183.plugin.types.Category.QualityOfLife

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
