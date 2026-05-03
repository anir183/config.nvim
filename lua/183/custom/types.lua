--[[ custom config related types ]]

---@class (exact) 183.custom.types.Netrw
---@field is_sidebar_open? boolean
---@field toggle_sidebar? fun(): nil
---@field toggle_fullscreen? fun(): nil
---@field create_commands? fun(): nil
---@field create_keymaps? fun(): nil

---@class (exact) 183.custom.types.StatuslineOpts
---@field bg_hl? vim.api.keyset.highlight
---@field mode_labels? table<string, string>
---@field arrangement? string[]

---@class (exact) 183.custom.types.Module
---@field init_netrw? fun(): nil
